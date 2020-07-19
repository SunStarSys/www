Title: CMS Features
Keywords: jamstack,markdown,cms,ide,node.js,node,oracle,dtrace,zfs,cloud,cdn,http

<div class="float-lg-right" style="margin-left: 20px">
	<iframe width="560" height="315" src="https://www.youtube.com/embed/nNzXg-iO98g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Blazing Fast

- runs on NVMe
- Solaris 11.4 for ZFS stability, backed by Full Oracle Customer Support
- node.js for markdown rendering with CPU clustering
- Quick Commit now the default setting for most circumstances.
- Apache httpd 2.4 based IDE:
	- HTTP/2
	- event mpm
	- mod_perl w/ ithreads
	- mod_apreq2
	- TLS 1.2
    - Custom `SVN::Client` module w/ ithread support for per-request pools

## Better support for Mailing Diffs and Creating Clones

- DMARC-protected
- Uses SRS and Reply-To for ezmlm-compatibility
- All users are Authenticated via Google's OpenID-Connect Service

## The curious-looking duckling is now an elegant swan

- Bootstrap (Solarized) styling.
- Editor.md is amazing: by using relative `src` urls, your linked images will render in the editor preview pane.

## Consistent Github-Flavored Markdown (GFM) rendering with Editor.md

- **WYSIWYG:** Same javascript code rendering engine in both your browser and in the (node.js-based) markdown.js build script ensures 100% structural consistency between the Editor.md Markdown preview window and the production site.

- YAML headers in source (markdown) files now fully supported.

- Coming as soon as [jsdom](https://github.com/jsdom/jsdom) finishes their SVG implementation: Flowcharts!

- Don Knuth's [TeX](https://en.wikipedia.org/wiki/TeX) support (for mathematical expressions): $$ E = mc^2 $$

- Electric! Editor will autocomplete and autoindent; has full screen mode.

## Full support for branch builds

- No more staging/publishing: replaced with per-resource branch Promotion.
- Rollback and Sync Merge fully supported.

## Live source tree search engine

- Perl Compatible Regular Expression (PCRE) based.
- Global search and replace functionality as well (unique given PCRE support); supports regex captures.

## Deltas from <span class='text-warning'>Apache CMS</span> Features

- Dropped `mdx_elementid.py` features (new implementation is javascript, not python, and GFM based, so only [TOC] from the py-markdown module carries across).  A problem tailor-made for the above Search and Replace Feature of the IDE.
- Only the Perl-based build system is available.
- New editor treats newlines within markdown text blocks as hard breaks.
- GFM uses a different delimiter for code blocks.
- `extpaths.txt` is no longer supported: select individuals from each project will be granted write access to the production website tree in our subversion repos for uploading externally produced material (javadocs, software release artifacts, etc.)
