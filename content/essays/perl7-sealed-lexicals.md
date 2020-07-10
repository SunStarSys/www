Title: Perl 7 Feature Request: sealed, typed lexicals

##  The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.

## The initial solution: Doug MacEachern's method lookup optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forte.  One of his many contributions to p5p was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@ISA` heirarchy cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.

## Benchmark Script

```perl
use strict;
use Benchmark ':all';
our ($x, $z);

$x = bless {}, "Foo";
$z = Foo->can("foo");

sub method {$x->foo}
sub class  {Foo->foo}
sub anon   {$z->($x)}

BEGIN {
  package Foo;
  use sealed 'debug';
  sub foo  { shift }
  sub bar  { shift . "->::Foo::bar" }
}

sub func   {Foo::foo($x)}

BEGIN{our @ISA=('Foo')}

my main $y = $x;

sub sealed :sealed {
    $y->foo();
}

sub also_sealed :sealed {
    my main $a = shift;
    if ($a) {
        my $inner;
        return sub :sealed {
			my Foo $b = $a;
			$b->foo($inner);
			$a->foo();
	    };
    }
    $a->bar();
}

my %tests = (
    func => \&func,
    method => \&method,
    sealed => \&sealed,
    class => \&class,
    anon => \&anon,
);

print sealed(), "\n", also_sealed($y), "\n";

cmpthese 10_000_000, \%tests;
```

## Benchmark Results

```
sealed: compiling main->foo lookup.
{
    use strict;
    $y->;
}
sealed: compiling Foo->foo lookup.
sealed: compiling main->foo lookup.
{
    use strict;
    my Foo $b = $a;
    $b->($inner);
    $a->;
}
sealed: compiling main->bar lookup.
{
    use strict;
    my main $a = shift();
    if ($a) {
        my $inner;
        return sub {
            my Foo $b = $a;
            $b->($inner);
            $a->;
        }
        ;
    }
    $a->;
}

Foo=HASH(0x415fb0)
CODE(0x4b73f0)

            Rate  class method   anon sealed   func
class  2028398/s     --    -4%   -30%   -34%   -36%
method 2118644/s     4%     --   -27%   -31%   -33%
anon   2906977/s    43%    37%     --    -5%    -8%
sealed 3058104/s    51%    44%     5%     --    -3%
func   3154574/s    56%    49%     9%     3%     --
```

## Proposed Perl 7 solution: `:sealed`  subroutines for typed lexicals

Sample code:

```perl
use Apache2::RequestRec;

sub handler :sealed {
	my Apache2::RequestRec $r = shift;
	$r->content_type(); #compile time method lookup
}
```

## Beta-Quality Perl 5 Prototype: sealed.pm

<https://github.com/joesuf4/cms/blob/master/lib/sealed.pm>

This would allow perl to do the `content_type` method-lookup at compile time, without causing any back-compat issues or aggrieved CPAN coders, since this feature would target application developers, not OO-module authors.

This idea is gratuitously stolen from [Dylan](https://jim.studt.net/dirm/interim-5.html).