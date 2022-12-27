#!/usr/local/bin/perl -T
use utf8;
use strict;
use warnings;
use base 'sealed';
use Text::Balanced ();
use Apache2::RequestRec;
use Apache2::RequestUtil;
use Apache2::RequestIO;
use Apache2::SubRequest;
use HTML::Escape qw/escape_html/;
use HTML::Parser;
use APR::Request::Apache2;
use APR::Request::Param;
use APR::Request qw/encode/;
use Cpanel::JSON::XS;

use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;
use SunStarSys::Util qw/read_text_file/;
use SunStarSys::SVN::Client;
use File::Basename;
use List::Util qw/sum/;
use IO::Uncompress::Gunzip qw/gunzip/;

my Apache2::RequestRec $r = shift;
my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
my APR::Request $apreq = $apreq_class->handle($r);

local our $USERNAME = $r->user;
local our $PASSWORD;
$PASSWORD = ($r->get_basic_auth_pw)[1] if $r->user;
$r->pnotes("svnuser", $USERNAME);
$r->pnotes("svnpassword", $PASSWORD);
my SunStarSys::SVN::Client $svn = SunStarSys::SVN::Client->new($r);

sub parser :Sealed {
  my @text;
  my (undef, $dirname, undef, $paths) = (@_, {});
  my HTML::Parser $p = "HTML::Parser";
  $p = $p->new(
    api_version => 3,
    handlers => {
      text => [\@text, '@{text}'],
    }
  );

  for my $pffxg ($_[0]) {
    while ($pffxg =~ m{^([^:]+):([^:]+):(.+)$}mg) {
      my ($file, $line, $match) = ($1, $2, $3);
      s!\x1b\[[\d;]*m!!g, s!\x1b\[[Km]!!g for $file, $line;
      my $count = 0;
      $match =~ s{(.*?)(?:\x1b\[01;31m(.+?)\x1b\[[Km]|$)}{
        my ($pre, $m) = ($1, $2 // "");
        ++$count if $m;
        my ($first, $last) = ("") x 2;
        $last = escape_html($1) if $pre =~ /([\s<\/]+)$/;
        s!\x1b\[[\d;]*m!!g, s!\x1b\[[Km]!!g, s!\{[\{%][^[\}%]+[\}%]\}!!g for $pre, $m;
        my @words;
        $p->parse($pre), $p->eof;
        push @words, split /\s+/, shift @text while @text;
        if ($m) {
          if (@words < 5) {
            unshift @words , "" until @words > 5;
          }
          else {
            @words = ("...", @words[-4 .. -1]);
          }
          $pre = join " ", grep {length} @words[-5 .. -1];
        } else {
          my $extra = @words > 5 ? "..." : undef;
          $pre = join " ", grep {defined} @words[0 .. 4], $extra if length $pre;
        }
        @words = ();
        $p->parse($m), $p->eof;
        push @words, split /\s+/, shift @text while @text;
        $m = qq(<span class="text-danger">) . join(" ", grep {defined} @words[0 .. 4]) . q(</span>);
        $pre . $last . $m
      }ge;
      push @{$$paths{$file}}, {count => $count, match => $match};
    }
  }
}

sub client_wants_json :Sealed {
    my Apache2::RequestRec $r     = shift;
    my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
    my APR::Request $apreq = $apreq_class->handle($r);

    return 1 if $apreq->args("as_json");

    no warnings 'uninitialized';
    my %accept;
    for (split /,\s*/, $r->headers_in->get("Accept")) {
        /([^;]+)(?:;\s*q=([\d.]+))?/ or next;
        $accept{$1} = $2 // 1;
    }
    for (sort {$accept{$b} <=> $accept{$a} || $a cmp $b} keys %accept) {
        return 1 if $_ eq "application/json" or $_ eq "application/*";
        return 0 if $_ eq "text/html"        or $_ eq "text/*";
    }
    return 0;
}

sub run_shell_command {
    my ($cmd, $args, @filenames) = @_;
    $args = [ @$args ];
    local %ENV = (
        PATH => "/usr/local/bin:/usr/bin",
        HOME => "/x1/home/joe",
        LANG => "en_US.UTF-8",
    );
    no warnings 'uninitialized';
    for (@filenames, @$args) {
      s/[^[:print:]]+//g;
      s/'/'\\''/g;
      "'$_'" =~ /^(.*)$/ms and $_ = $1
        or die "Can't detaint '$_'\n";
    }
    my @rv = qx($cmd @$args @filenames 2>&1);
    utf8::decode($_) for @rv;
    return wantarray ? @rv : join "", @rv;
}

sub breadcrumbs {
    my @path = split m!/!, shift, -1;
    my $tail = pop @path;
    my @rv;
    my $relpath = "../" x @path;
    push @path, $tail if length $tail;
    my $regex  = @_ ? encode(shift) : "";
    my $lang = @_ ? shift : "en";
    my $markdown = shift;
    $tail = pop @path;
    for (@path) {
        $relpath =~ s!\.?\./$!!;
        $relpath ||= './';
        push @rv, qq(<a href="$relpath?regex=$regex;lang=$lang;markdown_search=$markdown">) . (escape_html("\u$_") || "Home") . q(</a>);
      }
    return join "&nbsp;&raquo;&nbsp;", @rv, escape_html("\u$tail") || "Home";
}

my $markdown = $apreq->args("markdown_search") ? "Markdown" : "";
my $lang     = encode($apreq->args("lang") || ".en");
my $re       = $apreq->args("regex") || return 400;
my $host     = $r->headers_in->{host};

utf8::decode($re);

my $dirname;

if ($markdown) {
  $dirname = (</x1/cms/wcbuild/*/$host/trunk/content>)[0] . $r->path_info;
}
else {
  $dirname = "/x1/httpd/websites/$host/content" . $r->path_info;
}

my $d = $dirname;
for ($d) {
  s/'/'\\''/g;
  "'$_'" =~ /^(.*)$/ms and $_ = $1
    or die "Can't detaint '$_'\n";
}

$re =~ s/\s+/|/g unless index($re, "|") >= 0 or index($re, '"') >= 0 or index($re, "\\") >= 0;
my $wflag = ($re =~ s/(?:"|\\[Q])([^"]+?)(?:"|\\[E])/\\Q$1\\E/g) ? "" : "-w";
my @unzip = $markdown ? () : "--unzip";
$re =~ s/\#(\[w.@-]+)/\^Keywords: .*\\b$1\\b/g if $markdown;

my $pffxg = run_shell_command "cd $d && timeout 10 pffxg.sh" => [qw/--no-exclusions --no-cache/, @unzip, qw/--args 100 --html --markdown -- -P -e/], $re;

if ($?) {
  ($? == 124 or index($pffxg, "Terminated") == 0) and sleep 60;
  die $pffxg;
}

parser $pffxg, $dirname, undef, \ my %matches;

my (@matches, @keywords, %title_cache, %keyword_cache);

while (my ($k, $v) = each %matches) {
  my $link = $r->path_info . $k;
  $link =~ s/\.md(?:text)?/.html/ if $markdown;
  if ($markdown) {
    eval {
      my $url;
      $svn->info("$dirname$k", sub {$url = $_[1]->URL});
      s/:4433//, s/-internal// for $url;
      $svn->info($url, sub {shift}, "HEAD");
   };
    warn "$@" and next if $@;
  }
  else {
    my $subr = $r->lookup_file("$dirname$k");
    index($subr->status, "4") == 0 and next;
  }
  my $filename = "$dirname$k";
  my $uncompressed;
  utf8::encode my $f = $filename;
  gunzip $f, \$uncompressed and $filename = \$uncompressed if $filename =~m#\.gz[^/]*$#;
  read_text_file $filename, \ my %data, $markdown ? 0 : undef;
  my ($title) = $data{headers}{title} // $data{content} =~ m/<h1>(.*?)<\/h1>/;
  next unless $title;
  my $total = sum map $_->{count}, @$v;
  push @matches, [$data{mtime}, $total, qq(<a href="$link">$title</a>), [map $_->{match}, @$v]]
    unless $title_cache{$title}++;
  push @keywords, grep !$keyword_cache{$_}++,  @{ref $data{headers}{keywords} ? $data{headers}{keywords} : [split(/[;,]\s*/, $data{headers}{keywords} // ""), $data{content} =~ m/>#(\w+)</g]};
}

@matches = grep {shift(@$_),shift(@$_)} sort {no warnings 'uninitialized'; $b->[1] <=> $a->[1] || $b->[0] <=> $a->[0]} @matches;

@keywords = sort {$a cmp $b} @keywords;


my %title = (
  ".en" => "Search Results for $markdown ",
  ".es" => "resultados de búsqued para \l$markdown ",
  ".de" => "Suchergebnisse für $markdown ",
  ".fr" => "Résultats de recherche pour \l$markdown ",
);

my $args = {
  path        => $r->path_info ne "/" ? $r->path_info . "placeholder" : "",
  title       => $title{$lang},
  markdown_search => !!$markdown,
  matches     => \@matches,
  lang        => $lang,
  regex       => $re,
  breadcrumbs => breadcrumbs($r->path_info, $re, $lang, $markdown),
  keywords    => \@keywords,
};


if (client_wants_json $r) {
  $r->content_type("application/json; charset='utf-8'");
  $r->print(Cpanel::JSON::XS->new->utf8->pretty->encode($args));
  return 0;
}

local @TEMPLATE_DIRS = map /(.*)/, </x1/cms/wcbuild/*/$host/trunk/templates>;
$r->content_type("text/html; charset='utf-8'");
$r->print(Template("search.html")->render($args);
return 0;
