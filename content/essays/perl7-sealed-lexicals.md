Title: Perl 7 Feature Request- sealed typed lexicals

##  The Problem

Perl 5's OO runtime method lookup has 50% more performance overhead than a direct, named subroutine invocation.


## The initial solution: Doug MacEachern's typed lexical optimizations.

Doug was the creator of the mod_perl project back in the mid-90s, so obviously writing high performance Perl was his forte.  One of his many contributions to p5p was to cut the performance penalty of OO method lookup overhead in half, by using a method + `@ISA` cache to make the runtime object method lookup for mod_perl objects like `Apache2::RequestRec` as streamlined as possible.  But it only gets us half-way there.

What Doug was looking for was a way to tell perl to perform the method lookup at compile time, the way it does with named subroutine calls.  Look at this little test script:

```perl
{
  package Foo;
  sub foo { shift }
}
use Benchmark ':all';

my $x = bless {}, "Foo";
my Foo $y = $x;

sub func   { Foo::foo($x) }

sub method { $x->foo }

sub typed  { $y->foo }

cmpthese 10_000_000, { func => \&func, method => \&method, typed => \&typed };
```

Here's the results of a run:

```
           Rate method  typed   func
method 1869159/s     --    -4%   -43%
typed  1937984/s     4%     --   -41%
func   3300330/s    77%    70%     --
```

The delta between `typed` and `method` is statistical noise.


## Proposed Perl 7 solution: typed, `:sealed` lexicals.

Sample code:

```perl
my Apache2::RequestRec :sealed $r = shift;
$r->content_type();
```

What `:sealed` should cause is to ensure `$r` is **not** a subtype, but its type class exactly equals `Apache2::RequestRec`.  This would allow perl to do the `content_type` method-lookup at compile time, without causing any back-compat issues or aggrieved CPAN coders, since this feature would target application developers, not OO-module authors. CPAN authors can be given an `:virtual` keyword that results in the default (unadorned) typed lexical behavior.

This idea is gratuitously stolen from Dylan.