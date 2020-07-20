Title: CMS Technology

## Solaris 11.4

- DTrace &mdash; we took the kitchen sink approach: all of our dyamic programming language tooling integrates with it.

- ZFS &mdash; better with Solaris, backed by Oracle Support.  Accept no substitutes.

## node.js v12.18.0

- Editor.md &mdash; WYSIWYG.

## Perl 7 (coming soon)

- Now w/ Perl v5.30.2, mod_perl v2.0 w/ ithreads and httpd v2.4.43 w/ event mpm.

## Subversion v1.14.0-dev

- custom ithread-safe `SVN::Client` bindings w/ per-request memory pools.

- python3 support (v3.8.3)

- threaded python3 ports of svnpubsub and svnwcsub &mdash; the whole kit and caboodle for distributed enterprise/CDN site deployment using Subversion.

## Why not Git?

- The `git svn` bridge already exists if you prefer to work with git yourself, instead of using the online IDE for the CMS.  You have options!

- Website source trees aren't quite like software source trees, in terms of how you alter and manage them.  It's more aligned with devops / `trunk-based development` than it is with `gitflow`.

- If you need to distribute and deal with resulting build trees using version control, you will not like git at large scale. Especially when integrating binary artifacts, built using this system or using a third party builder that you just provide those build results to our repositories.

- Subversion lets you do partial/sparse checkouts of `HEAD`; with Git it's the entire branch (which includes history) or nothing.

- We would need Perl bindings for `libgit2` (which is **not provided by the actual git development team**) in order to match svn's httpd-compatible memory management regime and POSIX thread safety, in a persistent runtime, and across multiple server-side on-disk checkouts of client website source trees.  The maturity of that open-source infrastructure is not bankable for 2020 in our estimation, but we will keep tabs on the developments moving forward.

## Why not Python or Ruby or Javascript or Go?

- `mod_python` still has a way to go before it reaches the maturity of `mod_perl` in a threaded mpm, and this system is fully integrated with the Apache http server's full API, which only mod_perl provides.  

- `mod_ruby` was largely abandoned by the Ruby community for various quality control reasons.  Porting the custom 5K LOC Perl 5 sources of the CMS to a different programming environment would result in roughly a 10-100 fold ballooning of the implementation's line count, and consequently a major performance degradation in any other dynamic programming language.

- `mod_js` never made the cut for httpd v2, much less threaded mpm's.

- Trying to embed `Go` into httpd would be a fun challenge, just not for me personally.  Good language with interesting tradeoffs when it comes to dynamic linking, but a definite maybe for future investigation.

- As far as the Perl 5 build system is concerned, stay tuned.  No reason it can't be ported to any other programming language, and the build system is completely isolated from the CMS's online IDE (outside of the markdown renderer daemon based on `node.js`, which is a stand-alone system itself) for a million security/architectural design reasons ...

## Why not with something based on the JVM?

-  Just worked out that way, given my 20 year history with the LAMP stack and constructive contributions to the extended Apache HTTPd webserver community.  Doable, but again a massive undertaking with lots of hard engineering problems to solve along the way.
