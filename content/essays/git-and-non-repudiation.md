Title: Git and Non Repudiation

This essay really pertains to DVCS in general, not just git per se.  But I will focus
attention on git because it remains the most popular DVCS around today.

[Non repudiation](http://en.wikipedia.org/wiki/Non-repudiation) is an important concept
in security circles.  What it amounts to is satisfying an enterprise's need for acquiring
activity records that "cannot be walked away from after the fact".

With a traditional centralized version control tool, such records are readily available
from the commit history.  Each commit to the system goes through an authorization mechanism
to ensure the person who made the change is authorized to upload it.  Those records are
vital to the enterprise to ensure that accurate records are kept which indicates who
is responsible for uploading each line of code to the software in question.

With git, or distributed version control in general, there is a clear distinction between
the "commit" history and the "upload" history- which I will hereto refer to as "push records".
Commits in git are not authenticated, because they happen locally, with local, unverified
metadata added to the history.  The upload step, aka `git push` is a separate step, and it 
is here that the push records come into play.

With [The Apache Software Foundation](http://www.apache.org/)'s rollout of git, we baked into
the system a way of recording those push records in a way that brings parallel levels of
non repudiatable records that the org enjoys with its longstanding subversion service.
For the system to work properly, it is imperative that committers push their changes directly
to The ASF's git repo.

Why is this important?  Well for starters let me address a common misconception about the
need for Contributor License Agreements (ICLAs) for Apache committers.  Many people don't
seem to understand that as far as a committer's individual works of authorship, there is
no difference between the applicable language in the ICLA and the Apache License 2.0.
The distinction lies in the fact that the org needs a contractual agreement between committers
and The ASF to handle the proper process for dealing with third-party contributions.
It is these forms of contributions that necessitate the ICLA, not some bizarre 
belt-and-suspenders penchant for contracting with others.

What push records provide then is a way of tracing back, to each line of code in a release,
the individual committer responsible for pushing that code to The ASF's git repository.
Without such things we'd need to mandate at least PGP-signing of each contributor's commit,
which is onerous for many projects.  This is a transparent process that does not impact
a project's workflow, other than to ensure The ASF's git repo is the true master repo.

