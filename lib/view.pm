package view;
use base 'SunStarSys::View';
use strict;
use warnings;

# the point of this __PACKAGE__ is to provide/implement view methods to fill into  @path::patterns.
# some view methods expect a "view" argument because they only operate as "proxies" that just modify the %args
# of the next_view.

# template set from first capture in regex in @path::patterns

sub set_template_from_capture {
    my %args = @_;
    $args{template} = "$1.html";
    my $view = view->next_view(\%args);
    return view->can($view)->(%args);
}

sub set_title_from_capture {
    my %args = @_;
    $args{headers}{title} = $args{choices}{$1};
    delete $args{choices};
    my $view = view->next_view(\%args);
    return view->can($view)->(%args);
}

1;
