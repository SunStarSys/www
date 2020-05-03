Title: The DevOps Movement
Keywords: devops

### More than Just Giving Developers Root Access!

Or not even that.  The big idea behind the "movement" is not simply giving developers
more rope; it's about ensuring better lines of communication between the developers
and the *operations* teams in the enterprise.  Much of this is not new, in fact it's a
rehash of the "agile" movement within traditional industrial supply chains
during the prior century.  Kanban boards are just the latest rehash of birds-eye
dashboards covering the collective daily effort to ship quality products that delight
customers and business partners alike.

Constraint management is key to the process.  By first identifying any and
all bottlenecks in the system, you can refocus your efforts on optimizing
those resources to perform to maximum effect.  Optimizations beyond those
areas are almost always not worth the bother-- the workflow will still be
constrained by those resources.

### Trunk Based Development

Encouraging incremental changes with automated promotion and release processes
on a scheduled cadence is a great way to get the ball rolling, but a big part
of quality control in SaaS/PaaS deployments involves adopting
*[trunk based development](https://trunkbaseddevelopment.com)*
and its *branch by abstraction* concepts.  (Please visit the link for a thorough
discussion of the features and drawbacks).

Basically, the multiverse of long-term `git` branches creates the psychological fiction
that the combined merging of all of that local development work (and testing!) will lead
to a whole that is at least as great as the sum of its parts.  Experience is the better judge,
which indicates that extensive-new-feature-sets should be engineered *incrementally*, *in-situ*,
on the existing production/release branch source code.  Basically, you engineer your
development strategies within the limitations of the physics of the biological world, which says:

    Surgery on a patient must result in good outcomes (at all times) for
    that patient, not just for siblings or future generations.

### Measure, Curb and Control Firefighting Efforts

One of the other key things to recognize is to distinguish between *planned*
and *unplanned* work in any of your productivity tracking metrics, and how
resources are allocated to those tasks.  Unplanned work amounts
to **firefighting**, and if too much time (more than ~20%) is spent on these tasks,
the planned work, which is the real business need for the enterprise, gets backlogged.
The bottlenecks in the system rarely can cope with unplanned work, so it
is important to have enough additional resources to handle the increased load and
consequent backlog.

### Getting with the Program

At the management level, a global change management perspective between 
both devs and ops changes is vital. Both sets of teams need to be aware
of each other's changes. Ideally with planning details made available
along the way.  **Great things can happen** when the teams are a healthy mix
of devs and ops personnel, in a data-driven, transparent culture of collaborative work.

The philosophy of inclusion of manifold stakeholders into the creation, and **evolution**,
of a tangible work product has implications well beyond just *dev* and *ops* teams sharing
control and responsibility for a server engineering effort. This lesson keeps being
repeated throughout the modern corporate world, as new domains for creative
human expression take form in the business sector, as well as in reinventing old
ways of doing business together.
 
$Date$
