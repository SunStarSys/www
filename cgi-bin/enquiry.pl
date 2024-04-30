#!/usr/local/bin/perl -T -I /x1/cms/build/lib

use Apache2::RequestRec;
use Apache2::RequestUtil;
use Apache2::RequestIO;
use APR::Request::Apache2;
use APR::Request::Param;
use APR::Request::Cookie;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;
use strict;
use warnings;
use base 'sealed';
use sealed 'deparse';

my Apache2::RequestRec $r = shift;

my $DOMAIN = q/sunstarsys.com/;
local our $date   = gmtime;
local our ($host) = map /^([\w.-]+)$/, $r->headers_in->get("Host");

local our $to = $r->dir_config->get("to") // q/sales@sunstarsys.com/;
local our $validator = $r->dir_config->get("validator") // "orion";
local our $lang = get_client_lang($r);

local our %LANG = (
  ".de" => "de_DE",
  ".en" => "en_US",
  ".es" => "es_ES",
  ".fr" => "fr_FR",
  ".ru" => "ru_RU",
  ".sv" => "sv_SV",
  ".he" => "he_IL",
  ".zh-TW" => "zh_TW"
);

local our $LANG_RE = eval "qr/" . join("|", map "\Q$_\E\\b", keys %LANG) . "/";

sub get_client_lang :Sealed {
  my Apache2::RequestRec $r = shift;
  my APR::Request::Apache2 $apreq;
  $apreq = $apreq->handle($r);
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
  local @TEMPLATE_DIRS = map /^(.*)$/, </x1/cms/wcbuild/*/$host/trunk/templates>,
    "/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates";
  $r->content_type("text/html; charset='utf-8'");
  my Dotiac::DTL::Template $dtl = Template($template);
  $r->print($dtl->render(\%args));
  exit 0;
}

if ($r->method eq "POST") {
  my APR::Request::Apache2 $apreq_class;
  my APR::Request $apreq = $apreq_class->handle($r);
  my APR::Request::Param::Table $body = $apreq->body;
  my APR::Request::Cookie::Table $jar = $apreq->jar;

  my %vars = %$body;
  my $content = delete $vars{content};
  defined $content or return;
  s/[\r\n]//g for values %vars;

  my ($cn, $srs_sender) = @vars{qw/name email/};

  for ($cn, $vars{subject}) {
    if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
      tr/ /_/;
      $_ = "=?utf-8?Q?$_?=";
    }
  }

  if ($vars{subject} =~ /$validator/i and defined $jar->get("nonce")) {
    s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;
    $srs_sender =~ /^(.*)$/ and length $1 or die "BAD EMAIL: $vars{email}";
    %ENV = ();

    open my $sendmail, "|-", "/usr/sbin/sendmail", qw/-t -oi -f/, "$1\@$DOMAIN";
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
    headers => { title => "Sales Enquiry" },
	lang    => $lang;
}

render $r, "enquiry_get.html.en", nonce => rand, lang => $lang;
