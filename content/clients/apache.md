Title: The Apache Software Foundation

[The Apache Software Foundation](http://www.apache.org/) (The ASF) is a 501(c)(3) public
charity dedicated to the promotion and development of open source software.  In the 8 years
I served as a (contracted) System Administrator for The ASF, the foundation tripled in both
size and scope.  We went from a half-cabinet's worth of machines in 2006 to over 4 cabinets
worth in 2014, and were starting the process of expanding into the cloud.

When I started working at Apache in 2006 the most pressing issue was the overloaded inbound
mail services.  The organization was drowning in spam, and at 1.5 million inbound connections
per day it was exceeding the org's outbound delivery and overwhelming the software.  My first
task was to resolve this situation, so what I came up with was a two-fold approach: first
upgrade `qpsmtpd` to `Apache::Qpsmtpd`, the `mod_perl` experimental variant that converts `httpd`
into an inbound mail server.

`Apache::Qpsmtpd` needed a few patches to make it suitable for enterprise service, which I
provided.  That took care of the immediate concerns revolving around the crushing load on
the service, but if the growth trends continued it would mean continual investments in more
and better hardware and software, primarily to service all the spam connection growth. We
even attempted an abortive effort to deploy `ecelerity`, which on Apple gear wasn't quite
stable enough for us to migrate to in 2006.  `Ecelerity` (now known as `Momentum` from
[Message Systems](http://www.messagesystems.com)) is a beautifully engineered piece of software,
with an impressive balance of event loops, worker threads, and extension points, but ultimately
overkill for The ASF.  Open source solutions were "good enough".

Enter the second part of my approach: an attempt to dissuade spammers from hitting The ASF's
mail servers in the first place.  That involved patching `qpsmtpd`'s `earlytalker` plugin to
run in the `DATA` phase, combined with ratcheting up the delay to 20 seconds- a high but
tolerable amount for all RFC-compliant message delivery agents.  It was a delicate balance
as the spam levels rose to 2 million then 2.5 million per day, because the `earlytalker` delay
increased concurrency levels 4-5 times above "normal" levels and the spam continued to grow.
We were pushing `httpd`'s `MaxClients` settings during that period, even to the point of having
to custom-compile `httpd` to raise the compiled-in limit, but after a few months we
started seeing measurable improvements.  Normally `earlytalker` runs before the banner is
delivered, which is suboptimal when your primary plugin for dealing with spammers revolves
around dns blacklists.  Running `earlytalker` as late as possible in the `SMTP` session
meant that other, faster-acting, anti-spam plugins could drop the connection as soon as
possible, before the delays started kicking in and tieing up `httpd` kids.

Over an 8 year span, the ecological impact of my `earlytalker` adjustments were clear: we had
dropped the number of daily inbound spam connections **ten-fold**, down to around 150K per
day, spread across two servers.  Spammers were simply **opting out** of sending messages to
apache.org, which was the best anti-spam solution possible.

Beyond the routine chores facing every System Administrator, my other chief accomplishment
at The ASF was the creation of the `Apache CMS`.  The reasons and rationale behind it are
[documented](http://www.apache.org/dev/cms), but it is important to note that this software
was rapidly developed over a 3 month period before being pressed into production for the
<http://www.apache.org/> website.  It has achieved a popularity within The ASF beyond my wildest
expectations: over 100 projects currently rely on it for their website needs.  It downscales
to small but intricate sites like [Apache Thrift](http://thrift.apache.org/), while also scaling
up to meet the needs of a 9GB website like [OpenOffice.org](http://www.openoffice.org/).

I enjoyed the bulk of my time serving the needs of the Apache community, but after 8 years
it was time for a change.  I will always look fondly on the many memories and friends I made
while there, and wish Apache all the best going forward.
