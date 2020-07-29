#!/usr/local/bin/perl

use APR::Request::CGI;
use APR::Pool;

sub get {


}


sub post {
    my $pool = APR::Pool->new;
    my $apreq = APR::Request::CGI->handle($pool);

}
