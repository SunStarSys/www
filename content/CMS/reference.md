Title: CMS Reference

<div class="float-lg-right">
	<img src="/images/sunstarstaronly.png" style="height:200px"></img>
</div>

## Recommended Bookmarklet

Please be sure to install the bookmarklet on your browser toolbar by opening a "New Bookmark" dialog screen from your browser's menu and typing the following into the Location/URL field:

```javascript
	javascript:void(location.href='https://cms.sunstarsys.com/redirect?uri='+escape(location.href))
```

Without this bookmarklet installed you will not be able to browse the live site and instantly edit pages in the CMS by clicking on the bookmarklet. This is an essential component of the CMS and is therefore strongly recommended.

To use the bookmarklet simply browse to your live production site (NOT in the CMS!), locate a page you'd like to edit, and click on the bookmarklet. You'll be taken to a page within this CMS that allows you to edit the content.

## Live Demo

For a demonstration of the CMS's IDE, visit <https://www.openoffice.org/> for a massive site, or <https://thrift.apache.org/> for an intricate one, and click on the above bookmarklet to view a live prototype in action.

## Onboarding Process

For most customers, the CMS service sits between your Subversion repository's website source tree and your live production webservers that deliver site content to your end users.  Onboarding is dead-simple for organizations already running their own svnpubsub-enabled Subversion service:

1. Provide us with the URL of your site's sources in Subversion.
2. Provide us with the (role, or mailing list) email address for discussing site development and maintenance issues, and ensure that address is [SRS](https://en.wikipedia.org/wiki/Sender_Rewriting_Scheme)-compliant in terms of moderation facilities.
3. Subscribe your production webservers' `svnwcsub` daemon to our public `svnpubsub` service.  These stand-alone software components are a part of each new Subversion source release, and are reasonably mature and well supported by the Subversion Development Team.

## Directory Layout

- trunk/
	- cgi-bin/
	- content/
	- templates/
	- lib/
		- path.pm
		- view.pm
- branches/
	.. each branch follows trunk layout above ...

## Exceptions

## Search

## Quick Commit

## Add Resource
