#!/usr/local/bin/perl -I/x1/cms/build/lib -I/x1/cms/webgui/lib

use APR::Request::CGI;
use APR::Pool;
use Dotiac::DTL qw/Template *TEMPLATE_DIRS/;
use Dotiac::DTL::Addon::markup;

use strict;
use warnings;

my $DOMAIN = q/sunstarsys.com/;
my $to     = q/joe@sunstarsys.com/;
my $pool   = APR::Pool->new;
my $body   = APR::Request::CGI->handle($pool)->body || {};
my $date   = gmtime;

sub render {
    my $template = shift;
    my %args = (%$body, @_);
    local our @TEMPLATE_DIRS = qw(/x1/cms/wcbuild/www.sunstarsys.com/trunk/templates);
    print "Content-Type: text/html; charset='utf-8'\n\n";
    print Template($template)->render(\%args);
    exit 0;
}

if ($ENV{REQUEST_METHOD} eq "POST") {
    my ($name, $email, $subject, $content) = @$body{qw/name email subject content/};
    s/\r//g for $name, $email, $subject, $content;
    s/\n//g for $name, $email, $subject;

    my ($cn, $srs_sender) = ($name, $email);

    for ($cn, $subject) {
        if (s/([^^A-Za-z0-9\-_.,!~*' ])/sprintf "=%02X", ord $1/ge) {
            tr/ /_/;
            $_ = "=?utf-8?Q?$_?=";
        }
    }

    s/^(.*)\@(.*)$/SRS0=999=99=$2=$1/, y/A-Za-z0-9._=-//dc for $srs_sender;

    local %ENV;
    open my $sendmail, "|-", "/usr/sbin/sendmail -oi -t -f '$srs_sender\@$DOMAIN'"
        or die "Can't open sendmail: $!";
    print $sendmail <<EOT;
To: $to
From: $cn <$srs_sender\@$DOMAIN>
Reply-To: $cn <$email>
Subject: $subject
Date: $date +0000
Content-Type: text/plain; charset="utf-8"

$content
EOT
    close $sendmail or die "Sendmail failed: " . ($! || $? >> 8) . "\n";

    render "inquiry_post.html",
        content => "## Thank You!\n\nOur Sales Team will get back to you shortly.\n",
        headers => { title => "CMS Sales Inquiry" };
}

render "inquiry_get.html";
