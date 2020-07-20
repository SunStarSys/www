Title: CMS Reference

<div class="float-lg-right">
	<img src="/images/sunstarstaronly.png"></img>
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

## Source Directory Layout

- trunk/
	- cgi-bin/
	- content/
	- templates/
	- lib/
		- path.pm
		- view.pm
- branches/
	.. each branch follows trunk layout above ...

See <https://vcs.sunstarsys.com/repos/svn/public/site/> for a live example.

## Dynamic Content

### Example script to regenerate a source page with changing content, even when the sources do not.

Basic idea is that some or your high-profile source pages build with "dynamic" content (build incorporates ever-changing snippets from other online sites, like Jira waterfalls or current mailing list threads).
A good example of this is [The ASF Home Page](https://www.apache.org/).

```shell
% cp $file $file.tmp
% svn rm $file
% mv $file.tmp $file
% svn add $file
% svn commit -m "rebuild $file"
```

Incorporate this into a little shell script that will use your cached svn credentials on your own PC, and have cron execute it for you on a fixed schedule.  No need for server-side tooling on our end; you have full control of your own password security, scheduling, and dynamic page targets.  If you are using your own svnpubsub-enabled Subversion service, none of that transaction directly involves any of our hardware. Your commit will trigger our svnwcsub client, always listening to your svnpubsub server, to build and deploy those changes on demand &mdash; pronto.

## Exceptions

## Search

## Quick Commit

## Add Resource
