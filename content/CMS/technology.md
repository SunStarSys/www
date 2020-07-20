Title: CMS Technology

## Solaris 11.4

- DTrace &mdash; the kitchen sink approach: all dyamic programming language tooling.

- ZFS &mdash; better with Solaris, backed by Oracle Support.

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

- We would need Perl bindings for `libgit2` (which is **not provided by the actual git development team**) in order to match svn's httpd-compatible memory management regime and POSIX thread safety, in a persistent runtime, and across multiple client on-disk checkouts.  The maturity of that open-source infrastructure is not bankable for 2020 in our estimation, but we will keep tabs on the developments moving forward.

