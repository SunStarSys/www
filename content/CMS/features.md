Title: CMS Features

## Blazing Fast

- runs on NVMe
- Solaris 11.4 for ZFS stability
- node.js for markdown rendering with CPU clustering
- Quick Commit now the default setting for most circumstances.

## Better support for Mailing Diffs and Creating Clones

- DMARC-protected
- Uses SRS and Reply-To for ezmlm-compatibility
- All users are Authenticated via Google's OpenID-Connect Service

## The curious-looking duckling is now an elegant swan

- Bootstrap (Solarized) styling.
- Editor.md is amazing: by using relative `src` urls, your linked images will render in the editor preview.

## Consistent Github-Flavored Markdown (GFM) rendering with Editor.md

- **WYSIWYG:** Same javascript code rendering engine in both your browser and in the (node.js-based) markdown.js build script ensures 100% structural consistency between the Editor.md Markdown preview window and the production site.

- YAML headers in source (markdown) files now fully supported.

- Flowcharts (coming soon).

- Don Knuth's TeX support (for Mathematical Expressions): $$ E = mc^2 $$

## Full support for branch builds

- No more staging/publishing: replaced with per-resource branch Promotion.
- Rollback and Sync Merge fully supported.

## Live code search engine

- Perl Compatible Regex Engine (PCRE) based.
- Global search and replace functionality as well (unique given PCRE support); supports regex captures.

## Dropped `ASF::CMS` Features

- all mdx_elementid.py features (new implementation is node.js based)
- Only the perl-based build system is available.
- New editor treates newlines within markdown text blocks as hard breaks.
- Common Markdown (GFM) uses a different delimiter for code blocks.
- extpaths.txt is no longer supported: select individuals from each project will be granted write access to the production website tree in our subversion repos for uploading externally produced material (javadocs, software release artifacts, etc.)
