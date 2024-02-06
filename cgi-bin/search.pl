#!/usr/local/bin/perl -T
# Copyright 2023 SunStar Systems, Inc.  All rights reserved.

use utf8;
use strict;
use locale ':time';
use warnings;
use base 'sealed';
use Text::Balanced ();
use Apache2::Const qw/HTTP_OK OK HTTP_BAD_REQUEST/;
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
use Dotiac::DTL::Addon::json;
use SunStarSys::Util qw/read_text_file parse_filename/;
use SunStarSys::SVN::Client;
use File::Basename;
use List::Util qw/sum/;
use IO::Uncompress::Gunzip qw/gunzip/;
use DB_File;
use POSIX qw/:fcntl_h strftime :locale_h/;
use Digest::SHA1;
use Time::timegm 'timegm';
no warnings 'uninitialized';

local $@;

local our %LANG = (
  ".de" => "de_DE",
  ".en" => "en_US",
  ".es" => "es_ES",
  ".fr" => "fr_FR",
);

local our $LANG_RE = eval "qr/" . join("|", map "\Q$_\E\\b", keys %LANG) . "/";
die $@ if $@;

my Apache2::RequestRec $r = shift;
my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
my APR::Request $apreq = $apreq_class->handle($r);

local our $USERNAME = $r->user;
local our $PASSWORD;
$PASSWORD = ($r->get_basic_auth_pw)[1] if $r->user;
$r->pnotes("svnuser", $USERNAME);
$r->pnotes("svnpassword", $PASSWORD);
my SunStarSys::SVN::Client $svn = SunStarSys::SVN::Client->new($r);

my $specials_re = qr/^(friends=|watch=|like=|diff=|log=|notify=|build=|acl=|deps=|svnauthz=)/i;

sub filtermd {
  for (@_) {
    s/[\`{}\[\]!*]+//g;
    s/#+ //g;
    s/^\.{3} .*\$\$.*?\$\$|.*\$\$.*?\$\$ \.{3}$//g;
    s!https?://\S+!!g;
  }
}

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
      my (@w, @p);
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
        if (length $m) {
          if (@words < 5) {
            unshift @words , "" until @words > 5;
          }
          else {
            @words = ("...", @words[-4 .. -1]);
          }
          $pre = join " ", @words[-5 .. -1];
        } else {
          my $extra = @words > 5 ? "..." : undef;
          $pre = join " ", @words[0 .. 4], $extra if length $pre;
        }
        @words = ();
        $p->parse($m), $p->eof;
        push @words, split /\s+/, shift @text while @text;
        my $extra = @words > 5 ? "..." : undef;
        $m = qq(<span class="text-danger">) . join(" ", grep defined, @words[0 .. 4], $extra) . q(</span>);
        utf8::encode($_) for @words;
        push @w, length($m) ? (join ' ', grep length, @words) : undef;

        push @p, $pre . $last;
        utf8::encode $p[-1];
        filtermd($p[-1], $w[-1]);
        $pre . $last . $m

      }ge;
      push @{$$paths{$file}}, {count => $count, match => $match, pre => \@p, words => \@w};
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
        LANG => "$LANG{our $lang}.UTF-8",
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
    my ($regex)  = map encode($_),grep {utf8::encode(my $x=$_)||1} @_ ? shift : "";
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

sub negotiate_file :Sealed {
  my Apache2::RequestRec $r = shift;
  my ($file1, $file2) = @_;
    # The reason we take an intermediate subreq here is to
    # avoid any funky lookup optimizations which would trigger
    # the subrequest's uri to be filled in with a reasonable guess,
    # which would trigger the SunStarSys::Orion::MapToStorage handler to
    # perform the lookup instead of the default maptostorage handler.
    # We want that lookup to fail so mod_negotiation can kick in.
    # The funky lookup optimizations only happen when the subrequest
    # is an immediate directory entry of the parent request, which we can
    # avoid by doing a lookup of "/", which will resolve to
    # the docroot, not the base dir of the working copies.

  my Apache2::SubRequest $s = $r->lookup_uri("/");
  my $subr = $s->lookup_uri($file1);
  return $subr->filename
    if $subr->status == Apache2::Const::HTTP_OK or not $file2;
  return $s->lookup_uri($file2)->filename;
}

sub get_client_lang :Sealed {
  my Apache2::RequestRec $r = shift;
  my $repos = shift;
  my APR::Request::Apache2 $apreq = APR::Request::Apache2->handle($r);
  my ($cdata) = negotiate_file($r, "/sitemap", "/index") =~ /($LANG_RE)[^\/]*$/;
  my $lang = $apreq->args("lang") // $cdata;
  $lang =~ s/[_-].*$//;
  return encode($lang);
}

my $markdown = $apreq->args("markdown_search") ? "Markdown" : "";
local our $lang  = get_client_lang $r;
my $re       = $apreq->args("regex") // ($r->status(Apache2::Const::HTTP_BAD_REQUEST) && return -1);
my $filter   = $apreq->param("filter") // "";
my $hash     = $apreq->body("hash") // "";
my $host     = $r->headers_in->{host};
my $js;

utf8::decode($_) for $re, $filter;

my $dirname;
my $repos;

if ($markdown) {
  $dirname = (</x1/cms/wcbuild/*/$host/trunk/content>)[0] . $r->path_info;
  ($repos) = $dirname =~ m#^/x1/cms/wcbuild/([^/]+)/#;
}
else {
  $dirname = "/x1/httpd/websites/$host/content" . $r->path_info;
}

my $path_info = (parse_filename($r->path_info))[1];

my $d = (parse_filename($dirname))[1];
for ($d) {
  s/'/'\\''/g;
  "'$_'" =~ /^(.*)$/ms and $_ = $1
    or die "Can't detaint '$_'\n";
}

# convenience preprocessing for the PCRE fearful

$re =~ s/\s+/|/g unless index($re, "|") >= 0 or index($re, '"') >= 0 or index($re, "\\") >= 0 or index($re, '=') >= 0;
$filter =~ s/\s+/|/g unless index($filter, "|") >= 0 or index($filter, '"') >= 0 or index($filter, "\\") >= 0 or index($filter, '=') >= 0;
$re =~ s/^"(.*)"$/\\Q$1\\E/;

my @unzip = $markdown ? "--markdown" : "--unzip";
s/#([\w.@-]+)/Keywords\\b.*\\K\\b$1\\b/g for $re, $filter;

my (@friends, @dlog, $revision, $yaml, $blog, $diff, $author, $date, $log, $graphviz, @watch, @matches, @keywords, %title_cache, %keyword_cache);

if ($repos and $re =~ /^([@\w.-]+=[@\w. -]*)$/i) {
  tie my %pw, DB_File => "/x1/repos/svn-auth/$repos/user+group", O_RDONLY or die "Can't open $repos database: $!";
  my $svnuser = $r->pnotes("svnuser");
  if (exists $pw{$svnuser}) {
    if ($re =~ /^build=/i and $pw{$svnuser} =~ /\bsvnadmin\b/) {
      no warnings 'uninitialized';
      ($revision) = $re =~ /(\d+)$/;
      if (open my $fh, "<:encoding(UTF-8)", "/x1/httpd/websites/$host/.build-log/$revision.log") {
        read $fh, $blog, -s $fh;
        $diff = $svn->diff($dirname, 1, $revision);
      }
      else {
        open my $fh, "<:encoding(UTF-8)", "/x1/httpd/websites/$host/.build-duration-log" or die "can't open build-duration-log: $!";
          @dlog = map {chomp; [split /:/]} <$fh>;
        close $fh;
      }
    }
    elsif ($pw{$svnuser} =~ /\bsvnadmin\b/ and $re =~ /^(acl|deps)=/i) {
      if (open my $fh, "<:encoding(UTF-8)", "/x1/httpd/websites/$host/.$1") {
        read $fh, $yaml, -s $fh;
      }
    }
    elsif ($pw{$svnuser} =~ /\bsvnadmin\b/ and $re =~ /^svnauthz=/i) {
      if (open my $fh, "<:encoding(UTF-8)", "/x1/repos/svn-auth/$repos/authz-svn.conf") {
        read $fh, $blog, -s $fh;
      }
    }
    elsif ($re =~ /^diff=/i) {
      ($revision) = $re =~ /(\d+)$/;
      if (open my $fh, "<:encoding(UTF-8)", "/x1/httpd/websites/$host/.build-log/$revision.log") {
        read $fh, $blog, -s $fh;
        $diff = $svn->diff($dirname, 1, $revision);
        $log = $svn->log($dirname, $revision)->[-1];
        my @d_fmt = split /\D/, $$log[4];
        $d_fmt[0] -= 1900;
        $d_fmt[1] -= 1;
        setlocale LC_TIME, "$LANG{$lang}.UTF-8";
        ($date) = grep utf8::decode($_), strftime "%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime timegm reverse @d_fmt[0..5];
        setlocale LC_TIME, "$LANG{'.en'}.UTF-8";
        $author = $$log[3];
        $log = $$log[2];
      }
    }
    elsif ($re =~ /^log=/i) {
      ($revision) = $re =~ /(\d+)$/;
      $log = $svn->log($dirname, $revision);
      for (@$log) {
        my @d_fmt = split /\D/, $$_[4];
        $d_fmt[0] -= 1900;
        $d_fmt[1] -= 1;
        setlocale LC_TIME, "$LANG{$lang}.UTF-8";
        my ($date) = grep utf8::decode($_), strftime '%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)', localtime timegm reverse @d_fmt[0..5];
        setlocale LC_TIME, "$LANG{'.en'}.UTF-8";
        splice @$_, 3, $#$_, "\$Author: $$_[3] \$ \$Date: $date \$";
      }
    }
    else {
      open my $fh, "<:encoding(UTF-8)", "/x1/repos/svn-auth/$repos/group-svn.conf";
      local $_;
      my %group;
      while (<$fh>) {
        /(^[\w.@-]+)\s+=\s+(.*)$/ or next;
        $group{'@'.$1} = $2;
      }
      my %seen;
      my (undef, $groups, $comment) = split /:/, $pw{$svnuser};

      for (map '@'.$_, sort split /,/, $groups) {
        push @friends, {text => "$_=", displayText=>$_}, map {my $c = (split /:/, $pw{$_})[2] // ""; $c =~ s/</&lt;/g, $c =~ s/>/&gt;/g if $c; my $d = (split /:/, $pw{$_})[3] // ""; $c = qq(<img src="data:$d" alt="picture of $_"> $c) if $d; {text => "$_=", displayText => "$_: $c"}} grep !$seen{$_}++, split /,/, $group{$_};
        $seen{$_}++;
      }

      for (grep $_->{text} !~ /^@/, @friends) {
        push @friends, map {{text => "$_=", displayText=>$_}} grep !$seen{$_}++, map '@'.$_, split /,/, (split /:/, $pw{substr $_->{text}, 0, -1})[1];
        push @{$_->{groups}}, map {my @gm = grep !$seen{$_}++, split /,/, $group{$_}; {text => "$_=", displayText=>$_, members=>[map {my $c = (split /:/, $pw{$_})[2] // ""; $c =~ s/</&lt;/g, $c =~ s/>/&gt;/g if $c; my $d = (split /:/, $pw{$_})[3] // ""; $c = qq(<img src="data:$d" alt="picture of $_"> $c) if $d; {text=>"$_=",displayText=>"$_: $c"}} @gm]}} map '@'.$_, split ',', (split /:/, $pw{substr $_->{text}, 0, -1})[1];
      }

      for (grep $_->{text} =~ /^@/, @friends) {
        push @{$_->{members}}, map {my $c = (split /:/, $pw{$_})[2] // "";  $c =~ s/</&lt;/g, $c =~ s/>/&gt;/g if $c;my $d = (split /:/, $pw{$_})[3] // ""; $c = qq(<img src="data:$d" alt="picture of $_"> $c) if $d; {text => "$_=", displayText=> "$_: $c"}} split /,/, $group{substr($_->{text}, 0, -1)};
      }

      @friends = sort {$a->{text} cmp $b->{text}} @friends;

      if ($re =~ /^friends=$/i) {
        $graphviz="\"$svnuser\" [name=\"$svnuser\",fontcolor=green,URL=\"./?regex=$svnuser=;lang=$lang;markdown_search=1\",tooltip=\"$comment\"];\n";
        my %seen = ($svnuser => 1);
        for (@friends) {
          no warnings 'uninitialized';
          my $dt = substr $_->{text}, 0, -1;
          next if $dt eq $svnuser;
          if ($$_{members}) {
            $graphviz .= "\"$dt\" [name=\"$dt\",fontcolor=red,URL=\"./?regex=$_->{text};lang=$lang;markdown_search=1\",tooltip=\"$$_{displayText}\"];\n" unless $seen{$dt}++;
            $graphviz .= "\"$svnuser\" -> \"$dt\" [color=green];\n";
            for my $m (@{$$_{members}}) {
              my $mdt = substr $m->{text}, 0 , -1;
              $graphviz .= "\"$mdt\" [name=\"$mdt\",fontcolor=blue,URL=\"?regex=$m->{text};lang=$lang;markdown_search=1\",tooltip=\"$$m{displayText}\"];\n" unless $seen{$mdt}++;
              $graphviz .= "\"$dt\" -> \"$mdt\" [color=red];\n";
            }
          }
          elsif ($$_{groups}) {
            $graphviz .= "\$dt\" [name=\"$dt\",fontcolor=blue,URL=\"./?regex=$_->{text};lang=$lang;markdown_search=1\",tooltip=\"$$_{displayText}\"];\n" unless $seen{$dt}++;
            $graphviz .= "\"$svnuser\" -> \"$dt\" [color=green];\n";
            for my $g (@{$$_{groups}}) {
              my $gdt = substr $g->{text}, 0, -1;
              $graphviz .= "\"$gdt\" [name=\"$gdt\",fontcolor=blue,URL=\"?regex=$g->{text};lang=$lang;markdown_search=1\",tooltip=\"$$g{displayText}\"];\n" unless $seen{$gdt}++;
              $graphviz .= "\"$dt\" -> \"$gdt\" [color=black];\n";
              for my $m (@{$$g{members}}) {
                my $mdt = substr $m->{text}, 0 , -1;
                $graphviz .= "\"$mdt\" [name=\"$mdt\",fontcolor=blue,URL=\"?regex=$m->{text};lang=$lang;markdown_search=1\",tooltip=\"$$m{displayText}\"];\n" unless $seen{$mdt}++;
                $graphviz .= "\"$dt\" -> \"$mdt\";\n";
              }
            }
          }
        }
        $graphviz = escape_html $graphviz;
        $graphviz = "<div class=\"graphviz\">digraph {\n$graphviz};\n</div>";
      }
    }
    if ($re !~ $specials_re) {
      my @rv;
      for (map [split /=/], split /\b[;,]+\b/, $re) {
        my %seen;
        my ($key, $value) = @$_;
        if ($key =~ /^\@/ or not $value or $value =~ /^[rw]+$/) {
          push @rv, grep !$seen{$$_{text}}++ && $_->{text} eq "$key=", map {$_, ($key !~ /^@/ && /^@/) ? @{$$_{members}} : ()} map {$_, $$_{groups} ? @{$$_{groups}} : ()} @friends;
          $re .= "|\Q\$Author: $key \$\E" if $key !~ /^@/;
        }
        else {
          $value = '@'.$value if $key eq "group";
          $value = "<$value>" if $key eq "email";
          push @rv, grep index(lc $_->{displayText}, lc $value) >= 0, map {$_, ($key ne "group" && /^@/) ? @{$$_{members}}:()} @friends;
          $re = "\Q$value\E";
          $re .= '=' if grep $key eq $_, qw/user group/;
          $re .= "|\Q\$Author: $value \$\E" if $key eq "user";
        }
      }
      @friends = @rv;
    }
    elsif ($re =~ /watch=|notify=/i) {
      my $url;
      $svn->info(substr($dirname, 0 , -1), sub {$url = $_[1]->URL});
      s/:4433//, s/-internal// for $url;
      my $watchers = $svn->propget("orion:watchers", $url, "HEAD", 1);
      $_ = {map {$_=>1} split /[, ]+/} for values %$watchers;
      my ($base, $prefix) = $dirname =~ m!^(.*?)(/content.*)/$!;
      while (my ($k, $v) = each %$watchers) {
        $k =~ s/^.*?\Q$prefix//;
        if (exists $$v{$svnuser}) {
          eval {$svn->info("$url$k", sub {shift}, "HEAD")};
          warn "$@" and next if $@;
          push @watch, -f "$base$prefix$k" ? {name=>$k, type=>"file"} : -d "$base$prefix$k" ? {name=>"$k/", type=>"directory"} : ();
          $watch[-1]{watchers} = [map {my $c = (split /:/, $pw{$_})[2] // ""; $c =~ s/</&lt;/g, $c =~ s/>/&gt;/g if $c; my $d = (split /:/, $pw{$_})[3] // ""; $c = qq(<img src="data:$d" alt="picture of $_"> $c) if $d; {text=>"$_=",displayText=>"$_: $c"}} sort keys %$v];
        }
      }
      @friends = ();
    }
    if ($re =~ /^notify=/i) {
      my (%file_seen, %dir_seen);
      undef @file_seen{map $_->{name}, grep $$_{type} eq "file", @watch};
      undef @dir_seen{map $_->{name}, grep $$_{type} eq "directory", @watch};
      @watch=();
      my $tokens = join '|', ("@"."\Q$svnuser=\E", map "@@"."\Q$_=\E", split ',', (split /:/, $pw{$svnuser})[1]);
      ($revision) = $re =~ /(\d+)$/;
      $log = $svn->log($dirname, "HEAD", $revision+1);
      my ($base, $prefix) = $dirname =~ m!^(.*?)(/content.*)/$!;
      @$log = grep { my $rv; $rv = /^[+][^\n]*(?:$tokens)/ms && !/^[-][^\n]*(?:$tokens)/ms for $svn->diff($dirname, 1, $$_[0]);
                     $rv || scalar grep {s/^.*?\Q$prefix//; my $k=$_; exists $file_seen{$k} || scalar grep index($k, $_) == 0, keys %dir_seen} keys %{$$_[1]}
                   } grep $svnuser ne $$_[3], @$log;
      for (@$log) {
        setlocale LC_TIME, "$LANG{$lang}.UTF-8";
        my ($date) = grep utf8::decode($_), strftime '%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)', localtime $$_[4] / 1000000;
        setlocale LC_TIME, "$LANG{'.en'}.UTF-8";
        splice @$_, 3, $#$_, "\$Author: $$_[3] \$ \$Date: $date \$";
      }
    }
  }
}

if ($re !~ $specials_re) {
  my $sha1 = Digest::SHA1->new;
  $sha1->add(join ":", $r->dir_config("CookieSecret"), $apreq->body("files"));
  $sha1->add(join ":", $r->dir_config("CookieSecret"), $sha1->hexdigest);
  my $pffxg;

  if ($sha1->hexdigest ne $hash) {
    undef $filter;
    $pffxg = run_shell_command "cd $d && timeout 30 pffxg.sh" => [qw/--no-exclusions --no-cache --args 100 --html/, @unzip, qw/-- -P -e/], $re;
  }
  else {
    my $grep = $unzip[0] eq "--markdown" ? "grep" : "xzgrep";
    my @files = map $grep eq "grep" ? $_ : "$_.gz", $apreq->body("files");
    $pffxg = run_shell_command "cd $d && timeout 30 $grep" => [qw/--color=always --with-filename --line-number --ignore-case -P -e/], $filter, @files;
  }

  if ($? > 0 && $? < 256) {
    ($? == 124 or index($pffxg, "Terminated") == 0) and sleep 60;
    die "status=$?:$pffxg";
  }

  parser $pffxg, $dirname, undef, \ my %matches;

  while (my ($k, $v) = each %matches) {
    my $link = $path_info . $k;
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
    read_text_file $filename, \ my %data;
    my ($title) = $data{headers}{title} // $data{content} =~ m/<h1>(.*?)<\/h1>/;
    next unless $title;
    my $status = uc($data{headers}{status} // "draft");
    my ($rev) = $data{content} =~ /\$Revision: (\d+) \$/;
    if ($rev and $markdown) {
      $rev = qq(&nbsp; <a href="./?regex=diff=$rev;lang=$lang;markdown_search=1"><span class="text-success">r$rev</span></a>);
    }
    else {
      $rev= "";
    }
    $status =~ s/[^A-Z]//g;
    my $total = sum map $_->{count}, @$v;
    my $words = join '&amp;text=', map { my @rv; for my $idx (0..$#{$$_{words}}) { next unless  $$_{words}[$idx] =~ /\S/; push @rv, map {length and $_.= '-,' for $$_[0]; length and $_=",-$_" for $$_[2]; "$$_[0]$$_[1]$$_[2]"} [map {s/-/%2D/g; s/^(?i:%2b|[.]){3}[+]|[+](?i:%2b|[.]){3}$//g; $_} encode($$_{pre}[$idx] !~ / \.{3}$/ ? $$_{pre}[$idx] =~ /^ *(.*)$/ && $1 : ""), encode($$_{words}[$idx]), encode($$_{pre}[$idx+1]  !~ /^\.{3} / ? $$_{pre}[$idx+1] =~ /^(.*?) *$/ && $1 : "")]; } @rv } @$v;
    $words =~ s/[+]+/%20/g;
    $words =~ s/%20(&amp;|$)/$1/g;
    my @w = "text=$words" =~ /text=[^&]+/g;
    push @matches, [$data{mtime}, $total, qq([<a href="./?regex=^Status:\\s$status;lang=$lang;markdown_search=1"><span class="text-warning">$status</span></a>] <a href="$link#:~:text=$words">$title</a> $rev), $k, [map {s/(<span class="text-danger">[^<]+<\/span>)/qq(<a href="$link#:~:) . shift(@w) . qq(">$1<\/a>)/ge; $_} map $_->{match}, @$v]]
      unless $title_cache{$title}++;

    push @keywords, grep !$keyword_cache{$_}++,  @{ref $data{headers}{keywords} ? $data{headers}{keywords} : [split/[;,]\s*/, $data{headers}{keywords} // ($data{content} =~ m/name="keywords" content="([^"]+)"/i)[0] // ""]};
  }

  @matches = grep {shift(@$_),shift(@$_)} sort {no warnings 'uninitialized'; $b->[1] <=> $a->[1] || $b->[0] <=> $a->[0]} @matches;

  @keywords = sort {$a cmp $b} @keywords;
}

my %title = (
  ".en" => "Search Results for $markdown ",
  ".es" => "resultados de búsqued para \l$markdown ",
  ".de" => "Suchergebnisse für $markdown ",
  ".fr" => "Résultats de recherche pour \l$markdown ",
);

$hash =  Digest::SHA1->new;
$hash->add(join ":", $r->dir_config("CookieSecret"), map $$_[1], @matches);
$hash->add(join ":", $r->dir_config("CookieSecret"), $hash->hexdigest);

my $args = {
  path        => $r->path_info,
  title       => $title{$lang},
  markdown_search => !!$markdown,
  matches     => \@matches,
  lang        => $lang,
  regex       => $re,
  breadcrumbs => breadcrumbs($path_info, $re, $lang, !!$markdown),
  keywords    => \@keywords,
  friends     => \@friends,
  watch       => [sort {$a->{name} cmp $b->{name}} @watch],
  graphviz    => $graphviz,
  duration    => (@dlog ? \@dlog : undef),
  blog        => $blog,
  diff        => $diff,
  meta        => "\$Author: $author \$ \$Date: $date \$",
  log         => $log,
  yaml        => $yaml,
  r           => $r,
  revision    => $revision,
  repos       => $repos,
  website     => $host,
  hash        => $hash->hexdigest,
  filter      => $filter,
  specials    => $re =~ $specials_re && $1,
  specials_re => grep s/^.*?(\w+=)/$1/, $specials_re
};

if (client_wants_json $r) {
  $r->content_type("application/json; charset='utf-8'");
  delete $$args{r};
  $r->print(Cpanel::JSON::XS->new->utf8->pretty->encode($args));
  return Apache2::Const::OK;
}

local @TEMPLATE_DIRS = map /(.*)/, </x1/cms/wcbuild/*/$host/trunk/templates>, "/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates";
local @ENV{qw/REPOS WEBSITE/} = ($repos, $host);
$r->content_type("text/html; charset='utf-8'");
my $rv = Template("search.html")->render($args);
die $rv if $rv =~ /^.* cycle detected/;
$r->print($rv);
return Apache2::Const::OK;
