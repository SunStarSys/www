#!/usr/local/bin/perl -T -I/x1/cms/build/lib
use utf8;
use strict;
use warnings;
use base 'sealed';
use Text::Balanced ();
use Apache2::RequestRec;
use Apache2::RequestUtil;
use Apache2::RequestIO;
use HTML::Escape qw/escape_html/;
use HTML::Parser;
use APR::Request::Apache2;
use APR::Request::Param;
use APR::Request qw/encode/;

use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;
use SunStarSys::Util qw/read_text_file/;

my Apache2::RequestRec $r = shift;
my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
my APR::Request $apreq = $apreq_class->handle($r);

my $parser = sub :Sealed {
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
      $match =~ s{(.*?)(?:\x1b\[01;31m(.+?)\x1b\[[Km]|$)}{
        my ($pre, $m) = ($1, $2 // "");
        my ($first, $last) = ("") x 2;
        $last = $1 if $pre =~ /(\s+)$/;
        s!\x1b\[[\d;]*m!!g, s!\x1b\[[Km]!!g, s!\{[\{%][^[\}%]+[\}%]\}!!g for $pre, $m;
        my @words;
        $p->parse($pre), $p->eof;
        push @words, split /\s+/, shift @text while @text;
        if ($m) {
          unshift @words , "" until @words > 5;
          $pre = escape_html join " ", grep {length} @words[-5 .. -1];
        } else {
          $pre = escape_html join " ", grep {defined} @words[0 .. 4], "..." if length $pre;
        }
        @words = ();
        $p->parse($m), $p->eof;
        push @words, split /\s+/, shift @text while @text;
        $m = qq(<span class="text-success">) . escape_html(join " ", grep {defined} @words[0 .. 4]) . q(</span>);
        $pre . $last . $m
      }ge;
      push @{$$paths{$file}}, $match;
    }
  }
};

sub run_shell_command {
    my ($cmd, $args, @filenames) = @_;
    $args = [ @$args ];
    local %ENV = (
        PATH => "/usr/local/bin:/usr/bin",
        HOME => "/x1/home/httpd",
        LANG => "en_US.UTF-8",
    );
    no warnings 'uninitialized';
    for (@filenames, @$args) {
        s/'/'\\''/g;
        "'$_'" =~ /^(.*)$/ms and $_ = $1
            or die "Can't detaint '$_'\n";
    }
    unshift @filenames, "--" if grep /^-/, @filenames;
    my @rv = qx($cmd @$args @filenames 2>&1);
    utf8::decode($_) for @rv;
    return wantarray ? @rv : join "", @rv;
}

my $dirname  = "/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/content";
my $re       = $apreq->args("regex") || return 400;
my $lang     = $apreq->args("lang") || ".en";
my $pffxg = run_shell_command "cd $dirname && timeout 5 pffxg.sh" => [qw/--no-exclusions --no-cache --markdown -- -P -e/], $re;
return 400 if $?;

$parser->($pffxg, $dirname, undef, \ my %matches);

my @matches;
while (my ($k, $v) = each %matches) {
  s/\.md(?:text)?/.html/ for my $link = "/$k";
  read_text_file "$dirname/$k", \ my %data;
  push @matches, [$data{mtime}, qq(<a href="$link">$data{headers}{title}</a>), $v];
}

@matches = grep shift @$_, sort {@{$b->[-1]} <=> @{$a->[-1]} || $b->[0] <=> $a->[0]} @matches;

local @TEMPLATE_DIRS = qw(/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates);
$r->print(Template("search.html")->render({headers => {title => "Search Results"}, matches => \@matches, lang => $lang}));

return 0;
