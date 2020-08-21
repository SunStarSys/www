#!/usr/local/bin/perl -T -I/x1/cms/build/lib
use APR::Pool;
use APR::Request::CGI;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;

use strict;
use warnings;

my $DOMAIN = q/sunstarsys.com/;
my $to          = q/sales@sunstarsys.com/;
my $date       = gmtime;

my $pool       = APR::Pool->new;
my $apreq     = APR::Request::CGI->handle($pool);
my $body;

sub render {
	my $template = shift;
    my %args      = (%$body, @_);
    local our @TEMPLATE_DIRS = qw(/x1/cms/wcbuild/public/www.sunstarsys.com/trunk/templates);
    print "Content-Type: text/html; charset='utf-8'\n\n";
    print "JOADS\n\n";#Template($template)->render(\%args);
    exit 0;
}

if ($ENV{REQUEST_METHOD} eq "POST") {
    $body = $apreq->body;
    my ($name, $email, $subject, $content, $site, $hosting, $lang) = @{$body}{qw/name email subject content site hosting lang/};
    s/\r//g for $name, $email, $subject, $content, $site, $hosting, $lang;
    s/\n//g for $name, $email, $subject, $hosting, $site, $lang;

    my ($cn, $srs_sender) = ($name, $email);

    for ($cn, $subject) {
        if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
            tr/ /_/;
            $_ = "=?utf-8?Q?$_?=";
        }
    }

    s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;
	$srs_sender =~ /(.*)/;
	length $1 or die "BAD EMAIL: $email";
    %ENV = ();
	open my $sendmail, "|-", "/usr/sbin/sendmail", qw/-v -t -oi -odq -f/, "$1\@$DOMAIN";
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

   	close $sendmail or die "sendmail failed: " . ($! || $? >> 8) . "\n";
    print "Content-Type: text/plain\n\nFOOBAR\n" and exit $?;
    render "enquiry_post.html",
        content => "## Thank You!\n\nOur Sales Team will get back to you shortly.\n",
        headers => { title => "CMS Sales Enquiry" };
}

render "enquiry_get.html";
