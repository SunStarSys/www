Title: CMS Features

## Fast

- runs on NVMe
- Solaris 11.4 for ZFS stability
- node.js for markdown rendering with CPU clustering
- Quick Commit now the default setting for most circumstances.

## Better support for Mailing Diffs and Creating Clones

- DMARC-protected
- Uses SRS and Reply-To for ezmlm-compatibility
- All users are Authenticated via Google's OpenID-Connect Service

## Not the ugly duckling it used to be

- Bootstrap (Solarized) styling
- Editor.md is amazing: by using relative href urls, your linked images will render in the editor preview.

## Consistent Common Markdown (gfm) rendering with Editor.md

- WYSIWYG: Same javascript code rendering engine in both your browser and in the markdown.js build script ensures 100% structural consistency between the Editor.md Markdown preview window and the production site.

- YAML headers in source (markdown) files now fully supported

- Flowcharts (coming soon)

- TeX: $$ E = mc^2 $$

## Full support for branch builds

- No more staging/publishing: replaced with per-resource branch Promotion
- Rollback and Sync Merge fully supported

## Live code search engine

- PCRE based
- Global search and replace functionality as well (unique given PCRE support), supports regex captures.

## Dropped `ASF::CMS` Features

- all mdx_elementid.py features (new implementation is node.js based)
- Only the perl-based build system is available.
- New editor treates newlines within markdown text blocks as hard breaks.
- Common Markdown (GFM) uses a different delimiter for code blocks.
- extpaths.txt is no longer supported: select individuals from each project will be granted write access to the production website tree in subversion for uploading externally produced material (javadocs, etc.).
- Uses ezmlm-compatible SRS scheme to bypass moderation for sending diffs with clone URLs to mailing lists, instead of relying on `apache.org` domain whitelists.
