Title: The DevOps Movement
Keywords: devops

### More than just giving developers root access!

Or not even that.  The big idea behind the "movement" is not giving developers
more rope; it's about ensuring better lines of communications between the developers
and the *sysadmins* in the enterprise.  Much of this is not new, in fact its a
rehash of the "agile" movement within traditional industrial supply chains
during the prior century.  Kanban boards are just the latest rehash of birds-eye
dashboards covering the collective daily effort to ship quality products that delight
customers and business partners alike.

Constraint management is key to the process.  By first identifying any and
all bottlenecks in the system, you can refocus your efforts on optimizing
those resources to perform to maximum effect.  Optimizations beyond those
areas are almost always not worth the bother- the workflow will still be
constrained by those resources.

Encouraging incremental changes with automated promotion and release processes
on a scheduled cadence is a great way to get the ball rolling, but a big part
of quality control in SaaS/PaaS deployments involves adopting
*[trunk based development](https://trunkbaseddevelopment.com)*
and its *branch by abstraction* concepts.

Basically, the multiverses of long-term`git` branches creates the psychological fiction
that the combined merging of all of that local development work will lead to a whole
that is at least as great as the sum of its parts.  Experience is the better judge, which
indicates that extensive-new-feature-sets should be engineered *in-situ* with the existing
production codebase.  Basically, you engineer your development strategies with the
limitations of the laws of the natural world, which says surgery on a patient must result in
good outcomes for *that* patient, not just for siblings or future generations.

One of the other key things to recognize is to distinguish between *planned*
and *unplanned* work in any of your productivity tracking metrics, and how
resources are allocated to those tasks.  Unplanned work amounts
to firefighting, and if too much time is spent on these tasks, the planned
work, which is the real business need for the enterprise, gets backlogged.
The bottlenecks in the system rarely can cope with unplanned work, so it
is important to have enough additional resources to cope with the load.

At the management level, a global change management perspective between 
both devs and ops changes is vital. Both sets of teams need to be aware
of each other's changes, ideally with planning details made available
along the way.  **Great things can happen** when the teams are a healthy mix
of devs and ops personnel.

$Date$
