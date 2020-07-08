Title: Perl 7 Feature Request- sealed typed lexicals

##  The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.


## The initial solution: Doug MacEachern's method lookup optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forte.  One of his many contributions to p5p was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@ISA` heirarchy cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.  Look at this little test script:

```perl
use strict;
use Benchmark ':all';
use B::Generate;
use B::Deparse;
use optimizer 'C';

our ($x, $z);

$x = bless {}, "Foo";
$z = Foo->can("foo");

sub Foo::foo;

sub method {$x->foo}
sub class  {Foo->foo}
sub func   {Foo::foo($x)}
sub anon   {$z->($x)}

BEGIN {
  package Foo;
  my @code;
  my %method;
  my %valid_attrs;
  BEGIN  {%valid_attrs = (sealed => 1)}

  sub foo { shift }

  sub MODIFY_CODE_ATTRIBUTES {
      my ($class, $rv, @attrs) = @_;
      if (grep exists $valid_attrs{$_}, @attrs) {
          my $cv_obj = B::svref_2object($rv);
          my $op = $cv_obj->START;
          my ($pad_names, @pads) = $cv_obj->PADLIST->ARRAY;
          my @lexical_names = $pad_names->ARRAY;
          while ($op->name ne "leavesub") {
              if ($op->name eq "pushmark" and $op->next->name eq "padsv") {
                  $op = $op->next;
                  my $lex = $lexical_names[$op->targ];
                  if ($lex->TYPE->isa("B::HV")) {
                      my $class = $lex->TYPE->NAME;
                      while ($op->next->name ne "entersub") {
                          if ($op->next->name eq "method_named" and exists $method{${$op->next}}) {
                              no strict 'refs';
                              my $method = $method{${$op->next}};
                              my $sym    = *{"$class\::$method"};
                              *$sym = $class->can($method) or die "WTF?: $method";
                              my $p_obj = B::svref_2object(my $s = eval "sub {&$class\::$method}");
                              push @code, $s;
                              my $methop = $op->next;
                              my $targ   = $methop->targ;
                              my $start = $p_obj->START->next->next;
                              my $avref = $pads[0]->object_2svref;
                              $avref->[$targ] = *$sym{CODE};
                              $start->padix($targ);
                              $op->next($start);
                              my $end = $start->next;
                              $end = $end->next unless $end->next->name eq "entersub";
                              $end->next($methop->next);
                          }
                          $op = $op->next;
                      }
                  }
              }
              $op = $op->next;
          }
      }
      return grep !$valid_attrs{$_}, @attrs;
  }

  use optimizer 'callback' => sub {
      my $op = shift;
      if ($op->can("name") and $op->name eq "method_named") {
          my $meth_sv = $op->meth_sv;
          $method{$$op} = ${$meth_sv->object_2svref}
            if $meth_sv->can("object_2svref");
      }
  };

}

BEGIN{@main::ISA=('Foo')}

my main $y = $x;
sub sealed :sealed {
    $y->foo();
}

print B::Deparse->new->coderef2text(\&sealed), "\n";

cmpthese 25_000_000, { func => \&func, method => \&method, sealed => \&sealed, class => \&class, anon => \&anon};

```

Here's the results of a run:

```
{
    use strict;
    $y->;
}
            Rate  class method   anon sealed   func
class  2024291/s     --    -4%   -23%   -26%   -32%
method 2102607/s     4%     --   -20%   -23%   -30%
anon   2626050/s    30%    25%     --    -4%   -12%
sealed 2738226/s    35%    30%     4%     --    -8%
func   2990431/s    48%    42%    14%     9%     --

```


## Proposed Perl 7 solution: `:sealed`  subroutines for typed lexicals

Sample code:

```perl

sub :sealed handler {
	my Apache2::RequestRec $r = shift;
	$r->content_type();
}
```

What `:sealed` should cause is to ensure `$r` is **not** a subtype, but its type class exactly equals `Apache2::RequestRec`.  This would allow perl to do the `content_type` method-lookup at compile time, without causing any back-compat issues or aggrieved CPAN coders, since this feature would target application developers, not OO-module authors. CPAN authors can be given a `:virtual` keyword that results in the default (unadorned) typed lexical behavior.

This idea is gratuitously stolen from [Dylan](https://jim.studt.net/dirm/interim-5.html).