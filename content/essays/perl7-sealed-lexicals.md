Title: Perl 7 Feature Request: sealed subs for typed lexicals

<div class="float-lg-right">
 <img src="../images/sunstarstaronly.png" style="height:200px"></img>
</div>

## The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.

## The initial solution: Doug MacEachern's method lookup optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forté.  One of his many contributions to [p5p](https://lists.perl.org/list/perl5-porters.html) was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@::ISA` heirarchy cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

This isn't a trifling issue with calls to `C struct` get-set accessor methods &mdash; the common situation with many mod_perl APIs.  Perl's runtime method-call lookup penalty on httpd's `struct request_rec *`, that mod_perl exposes via the `Apache2::RequestRec` module, is on the same order of magnitude of the full execution of the call.  For mod_perl backed sites making millions of XS method calls a second, this is an awful waste of precious CPU cycles.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.  Every time Doug tried, he hit roadblocks of either a social or technical nature.  Perhaps it's time to make another pass at this idea with the advent of Perl 7.

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
  use sealed 'deparse';
  use base 'sealed';
  sub foo  { shift }
  sub bar  { shift . "->::Foo::bar" }
}

sub func   {Foo::foo($x)}

BEGIN{@::ISA=('Foo')}

my main $y = $x;

sub sealed :sealed {
    $y->foo();
}

sub also_sealed :sealed {
    my main $a = shift;
    if ($a) {
        my Benchmark $bench;
        my $inner;
        return sub :sealed {
            my Foo $b = $a;
            $b->foo($bench->cmpthese, $inner);
            $a->foo;
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
sealed: compiling Benchmark->cmpthese lookup.
sealed: compiling Foo->foo lookup.
sealed: compiling main->foo lookup.
{
    use strict;
    my Foo $b = $a;
    $b->($bench->, $inner);
    $a->;
}
sealed: compiling main->bar lookup.
{
    use strict;
    my main $a = shift();
    if ($a) {
        my($bench, $inner);
        return sub {
            my Foo $b = $a;
            $b->($bench->, $inner);
            $a->;
        }
        ;
    }
    $a->;
}
Foo=HASH(0x415fb0)
CODE(0x4b73c0)
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
	use v7.0;
	use Apache2::RequestRec;

	sub handler :sealed {
		my Apache2::RequestRec $r = shift;
		$r->content_type("text/html"); #compile time method lookup
	}
```

## Production-Quality Perl 5 Prototype: sealed.pm v1.0.1

See <https://github.com/joesuf4/cms/blob/master/lib/sealed.pm>.

This will allow Perl 5 to do the `content_type` method-lookup at compile time, without causing any back-compat issues or aggrieved CPAN coders, since this feature would target application developers, not OO-module authors.

This idea is gratuitously stolen from [Dylan](https://jim.studt.net/dirm/interim-5.html).

$Date :$