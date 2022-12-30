#!/usr/local/bin/perl -T -I/x1/cms/build/lib
use Apache2::RequestRec;
use Apache2::RequestUtil;
use Apache2::RequestIO;
use APR::Request::Apache2;
use APR::Request::Param;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;
use strict;
use warnings;
use base 'sealed';

my Apache2::RequestRec $r = shift;

my $DOMAIN = q/sunstarsys.com/;
my $to     = q/sales@sunstarsys.com/;
my $date   = gmtime;

sub render :Sealed {
    my Apache2::RequestRec $r = shift;
    my $template = shift;
    my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
    my APR::Request $apreq = $apreq_class->handle($r);
    my $params = $apreq->param // {};
    my %args = (%$params, @_);
    local our @TEMPLATE_DIRS = qw(/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates);
    $r->content_type("text/html; charset='utf-8'");
    my Dotiac::DTL::Template $dtl = Template($template);
    $r->print($dtl->render(\%args));
    exit 0;
}

if ($r->method eq "POST") {
    my APR::Request::Apache2 $apreq_class = "APR::Request::Apache2";
    my APR::Request $apreq = $apreq_class->handle($r);
    my APR::Request::Param::Table $body = $apreq->body;
    my ($name, $email, $subject, $content, $site, $confluence, $plan) = @{$body}{qw/name email subject content site confluence plan/};
    $confluence = $confluence ? "yes" : "no";
    s/\r//g for $name, $email, $subject, $content, $site, $confluence, $plan;
    s/\n//g for $name, $email, $subject, $confluence, $site, $plan;

    my ($cn, $srs_sender) = ($name, $email);

    for ($cn, $subject) {
        if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
            tr/ /_/;
            $_ = "=?utf-8?Q?$_?=";
        }
    }

    if ($subject =~ /^cms/i) {
        s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;
        $srs_sender =~ /(.*)/;
        length $1 or die "BAD EMAIL: $email";
        %ENV = ();

        open my $sendmail, "|-", "/usr/sbin/sendmail", qw/-t -oi -odq -f/, "$1\@$DOMAIN";
        print $sendmail <<EOT;
To: $to
From: $cn <$srs_sender\@$DOMAIN>
Reply-To: $cn <$email>
Subject: $subject
Date: $date +0000
Content-Type: text/plain; charset="utf-8"

$content

WEBSITE: $site
CONFLUENCE: $confluence
Plan: $plan
EOT

        close $sendmail or die "sendmail failed: " . ($! || $? >> 8) . "\n";
    }

    render $r, "enquiry_post.html",
        content => "## Thank You!\n\nOur Sales Team will get back to you shortly.\n",
        headers => { title => "CMS Sales Enquiry" };
}

render $r, "enquiry_get.html";
