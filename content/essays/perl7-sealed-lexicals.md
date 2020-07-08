Title: Perl 7 Feature Request- sealed typed lexicals

##  The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.


## The initial solution: Doug MacEachern's method lookup optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forte.  One of his many contributions to p5p was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@ISA` heirarchy cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.  Look at this little test script:

```perl
use strict;
use Benchmark ':all';
use B::Deparse;
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
  sub foo { shift }
  use sealed;
}

BEGIN{our @ISA=('Foo')}
my main $y = $x;

sub sealed :sealed {
    $y->foo();
}

sub also_sealed :sealed {
    my main $a = bless {};
    $a->foo();
}
my %tests = (
    func => \&func,
    method => \&method,
    sealed => \&sealed,
    class => \&class,
    anon => \&anon,
);
print B::Deparse->new->coderef2text(\&sealed), "\n";
print B::Deparse->new->coderef2text(\&also_sealed), "\n";
print sealed(), "\n";
print also_sealed(), "\n";
no sealed; # below line requires this
cmpthese 10_000_000, \%tests;
```

Here's the results of a run:

```
{
    use strict;
    $y->;
}
{
    use strict;
    my main $a = bless({});
    $a->;
}
Foo=HASH(0x415fb0)
main=HASH(0xceaec0)
            Rate  class method   func sealed   anon
class  1745201/s     --    -2%   -35%   -40%   -41%
method 1782531/s     2%     --   -34%   -38%   -39%
func   2695418/s    54%    51%     --    -7%    -8%
sealed 2890173/s    66%    62%     7%     --    -2%
anon   2941176/s    69%    65%     9%     2%     --
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