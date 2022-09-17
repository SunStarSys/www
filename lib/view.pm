package view;
use base 'SunStarSys::View';

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
