Title: CMS Technology

## Solaris 11.4

- DTrace &mdash; the kitchen sink approach: all dyamic programming language tooling.

- ZFS &mdash; better with Solaris, backed by Oracle Support.

## node.js

- Editor.md &mdash; WYSIWYG.

## Perl 7 (coming soon)

- Perl v5.30.2 mod_perl w/ ithreads + httpd w/ event mpm.

## Subversion 1.14

- custom `SVN::Client` bindings.

- python3 support (v3.8)

- svnpubsub and svnwcsub &mdash; the whole kit and caboodle for distributed enterprise site deployment.

## Why not Git?

- The `git svn` bridge already exists if you prefer to work with git yourself, instead of using the online IDE.  You have options.

- Website source trees aren't quite like software source trees, in terms of how you alter and manage them.  It's more aligned with devops / trunk-based-development than it is with gitflow.

- If you need to distribute and deal with resulting build trees using version control, you will not like git at large scale. Especially when integrating binary artifacts, built using this system or using a third party builder that you just provide those build results to our repositories.

- Subversion lets you do partial/sparse checkouts of `HEAD`; with Git it's the entire branch (which includes history) or nothing.
