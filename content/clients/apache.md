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
upgrade `qpsmtpd` to `Apache::Qpsmtpd`, the mod_perl experimental variant that converts `httpd`
into an inbound mail server.

`Apache::Qpsmtpd` needed a few patches to make it suitable for enterprise service, which I
provided.  That took care of the immediate concerns revolving around the crushing load on
the service, but if the growth trends continued it would mean continual investments in more
and better hardware and software, primarily to service all the spam connection growth.

Enter the second part of my approach: an attempt to dissuade spammers from hitting Apache's
mail servers in the first place.  That involved patching `qpsmtpd`'s earlytalker plugin to
run in the DATA phase, combined with ratcheting up the delay to 20 seconds- a high but
tolerable amount for all RFC-complaint message delivery agents.  It was a delicate balance
as the spam levels rose to 2 million then 2.5 million, because the `earlytalker` delay
increased concurrency levels 3-4 times above "normal" levels and the spam continued to grow.
We were pushing `httpd`'s MaxClients settings during that period, but after a few months we
started seeing measurable improvements.

Over an 8 year span, the ecological impact of my earlytalker adjustments were clear: we had
dropped the number of daily inbound spam connections **ten-fold**, down to around 150K per
day, spead across two servers.  Spammers were simply **opting out** of sending messages to
apache.org, which was the best anti-spam solution possible.
