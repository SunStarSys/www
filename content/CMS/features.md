Title: Features

## Fast

- runs on NVMe
- Solaris 11.4 for ZFS stability
- node.js for markdown rendering with CPU clustering
- Quick Commit now the default setting for most circumstances.

## Not the ugly duckling it used to be

- Bootstrap (Solarized) styling

## Consistent Common Markdown (gfm) rendering with Editor.md

- TeX $$ E = mc^2 $$

- Flowcharts (coming soon)

## Full support for branch builds

- No more staging/publishing: replaced with per-resource branch promotion
- Rollback functionality available

## Live code search engine

- PCRE based
- Global search and replace functionality as well (unique given PCRE support), supports regex captures.

## Dropped ASF::CMS Features

- all mdx_elementid.py features (new implementation is node.js based)
- Only the perl-based build system is available.
- New editor treates newlines within markdown text blocks as hard breaks.
- Common Markdown (GFM) uses a different delimiter for code blocks.
- extpaths.txt is no longer supported: select individuals from each project will be granted write access to the production website tree in subversion for uploading externally produced material (javadocs, etc.).

