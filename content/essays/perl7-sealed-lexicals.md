Title: Perl 7 Feature Request- sealed typed lexicals

##  The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.


## The initial solution: Doug MacEachern's method lookup optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forte.  One of his many contributions to p5p was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@ISA` heirarchy cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.  Look at this little test script:

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
  sub foo { shift }
  sub bar { shift() . "->::Foo::bar" }
}

sub func   {Foo::foo($x)}

BEGIN{our @ISA=('Foo')}
my main $y = $x;

use sealed;

sub sealed :sealed {
    $y->foo();
}

sub also_sealed :sealed {
    my main $a = shift;
    if ($a) {
        my $inner;
        return $a->foo($inner);
    }
    $a->bar();
}

no sealed;

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

Here's the results of a run:

```
{
    use strict;
    $y->foo;
}
{
    use strict;
    my main $a = shift();
    if ($a) {
        my $inner;
        return $a->foo($inner);
    }
    $a->bar;
}
Foo=HASH(0x415fb0)
Foo=HASH(0x415fb0)
             Rate  class method   anon sealed   func
class  1851852/s     --    -4%   -36%   -45%   -46%
method 1919386/s     4%     --   -34%   -43%   -44%
anon   2890173/s    56%    51%     --   -15%   -15%
sealed 3389831/s    83%    77%    17%     --    -0%
func   3401361/s    84%    77%    18%     0%     --
```


## Proposed Perl 7 solution: `:sealed`  subroutines for typed lexicals

Sample code:

```perl
use sealed;
sub handler :sealed {
	my Apache2::RequestRec $r = shift;
	$r->content_type();
}
no sealed;
```

## Prototype sealed.pm module on github

<https://github.com/joesuf4/cms/blob/master/lib/sealed.pm>

This would allow perl to do the `content_type` method-lookup at compile time, without causing any back-compat issues or aggrieved CPAN coders, since this feature would target application developers, not OO-module authors.

This idea is gratuitously stolen from [Dylan](https://jim.studt.net/dirm/interim-5.html).