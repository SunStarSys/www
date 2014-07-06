package view;
use base 'ASF::View';

# template set from first capture in regex in @path::patterns
sub set_template_from_capture {
    my %args = @_;
    $args{template} = "$1.html";
    my $view = view->next_view(\%args);
    return view->can($view)->(%args);
}

1;
