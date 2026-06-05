#!/usr/local/bin/perl -T -I /x1/cms/build/lib
use APR::Error;
use Apache2::RequestRec;
use Apache2::RequestUtil;
use Apache2::RequestIO;
use Apache2::SubRequest;
use APR::Request qw/encode/;
use APR::Request::Apache2;
use APR::Request::Param;
use APR::Request::Cookie;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;
use strict;
use warnings;
use base 'sealed';
use sealed 'deparse';
use Apache2::Const -compile => qw/HTTP_OK OK HTTP_BAD_REQUEST/;

my Apache2::RequestRec $r = shift;

my $DOMAIN = q/sunstarsys.com/;
our $date   = gmtime;
our ($host) = map /^([\w.-]+)$/, $r->headers_in->get("Host");

our $to = $r->dir_config->get("to") // q/sales@sunstarsys.com/;
our $validator = $r->dir_config->get("validator") // "orion";
our $lang = get_client_lang($r);

our %LANG = (
  ".de" => "de_DE",
  ".en" => "en_US",
  ".es" => "es_ES",
  ".fr" => "fr_FR",
  ".ru" => "ru_RU",
  ".sv" => "sv_SV",
  ".he" => "he_IL",
  ".zh-TW" => "zh_TW"
);

our $LANG_RE = eval "qr/" . join("|", map "\\Q$_\\E\\b", keys %LANG) . "/";
warn $@ if $@;

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
  my Apache2::SubRequest $subr = $s->lookup_uri($file1);
  return $subr->filename
    if $subr->status == Apache2::Const::HTTP_OK or not $file2;
  return $s->lookup_uri($file2)->filename;
}

sub get_client_lang :Sealed {
  my Apache2::RequestRec $r = shift;
  my APR::Request::Apache2 $apreq;
  $apreq = $apreq->handle($r);
  our $LANG_RE;
  my ($cdata) = negotiate_file($r, "/sitemap", "/index") =~ /($LANG_RE)[^\/]*$/;
  my $lang = $apreq->args("lang") // $cdata;
  $lang =~ s/[_-].*$//;
  $lang .= "-TW" if $lang eq ".zh";
  return encode($lang);
}

sub render :Sealed {
  my Apache2::RequestRec $r = shift;
  my $template = shift;
  my APR::Request::Apache2 $apreq_class;
  my APR::Request $apreq = $apreq_class->handle($r);
  my $params = $apreq->param // {};
  my %args = (%$params, @_);
  local @TEMPLATE_DIRS = map /^(.*)$/, "/x1/httpd/websites/$host/templates",
    "/x1/httpd/websites/www.sunstarsys.com/templates";
  $r->content_type("text/html; charset='utf-8'");
  my Dotiac::DTL::Template $dtl = Template($template);
  $r->print($dtl->render(\%args));
  exit Apache2::Const::OK;
}

if ($r->method eq "POST") {
  my APR::Request::Apache2 $apreq_class;
  my APR::Request $apreq = $apreq_class->handle($r);
  my APR::Request::Param::Table $body = $apreq->body;
  my APR::Request::Cookie::Table $jar = $apreq->jar;

  my %vars = %$body;
  my $content = delete $vars{content};
  s/[\r\n]//g for values %vars;

  my ($cn, $srs_sender) = @vars{qw/name email/};

  for ($cn, $vars{subject}) {
    if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
      tr/ /_/;
      $_ = "=?utf-8?Q?$_?=";
    }
  }

  if ($vars{subject} =~ /$validator/i and defined $jar->get("nonce") and $jar->get("nonce") eq $body->get("nonce")) {
    s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;
    $srs_sender =~ /^(.*)$/ and length $1 or die "BAD EMAIL: $vars{email}";
    %ENV = ();

    open my $sendmail, "|-", "/usr/sbin/sendmail", qw/-t -oi -odq -f/, "$1\@$DOMAIN";

    my $msg =<<EOT;
To: $to
From: $cn <$srs_sender\@$DOMAIN>
Reply-To: $cn <$vars{email}>
Subject: $vars{subject}
Date: $date +0000
Content-Type: text/plain; charset="utf-8"

$vars{content}

---

EOT
    while (my ($k, $v) = each %vars) {
      $msg .= "$k: $v\n"
    }
    print $sendmail $msg;
    close $sendmail or die "sendmail failed: " . ($! || $? >> 8) . "\n";
  }

  render $r, "enquiry_post.html",
    content => "## Thank You!\n\nOur Sales Team will get back to you shortly.\n",
    headers => { title => "Sales Enquiry" };
}

render $r, "enquiry_get.html.en", nonce => rand;
