package view;
use base 'ASF::View';
sub set_template {
    my %args = @_;
    my $view = ASF::View::next_view \%args;
    $args{template} = "$1.html";
    return view->can($view)->(%args);
}

1;
