#!/usr/local/bin/perl -T -I/x1/cms/build/lib
use Apache2::RequestUtil;
use APR::Request::Apache2;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;

use strict;
use warnings;

my $DOMAIN = q/sunstarsys.com/;
my $to          = q/sales@sunstarsys.com/;
my $date       = gmtime;

sub render {
 	my $r            = Apache2::RequestUtil->request;
	my $body       = APR::Request::Apache2->handle($r)->body || {};
	my $template = shift;
    my %args      = (%$body, @_);
    local our @TEMPLATE_DIRS = qw(/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates);
    $r->content_type("text/html; charset='utf-8'");
    $r->print(Template($template)->render(\%args));
}

my $r = Apache2::RequestUtil->request;
my $body  = APR::Request::Apache2->handle($r)->body || {};

if ($r->method eq "POST") {
    my ($name, $email, $subject, $content, $site, $hosting, $lang) = @$body{qw/name email subject content site hosting lang/};
    s/\r//g for $name, $email, $subject, $content, $site, $hosting, $lang;
    s/\n//g for $name, $email, $subject, $hosting, $site, $lang;

    my ($cn, $srs_sender) = ($name, $email);

    for ($cn, $subject) {
        if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
            tr/ /_/;
            $_ = "=?utf-8?Q?$_?=";
        }
    }
	%ENV = ();
    s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;
	$srs_sender =~ /(.*)/;

    open my $sendmail, "|-", "/usr/sbin/sendmail -oi -t -f '$1\@$DOMAIN'"
        or die "Can't open sendmail: $!";
    print $sendmail <<EOT;
To: $to
From: $cn <$srs_sender\@$DOMAIN>
Reply-To: $cn <$email>
Subject: $subject
Date: $date +0000
Content-Type: text/plain; charset="utf-8"

$content

WEBSITE: $site
HOSTING: $hosting
LANGUAGE: $lang
EOT
    close $sendmail or die "Sendmail failed: " . ($! || $? >> 8) . "\n";

    return render "inquiry_post.html",
        content => "## Thank You!\n\nOur Sales Team will get back to you shortly.\n",
        headers => { title => "CMS Sales Enquiry" };
}

render "inquiry_get.html";
