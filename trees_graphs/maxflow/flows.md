## Flow Network

A flow network is a plain-old weighted directed acyclic graph where the edge weight for any edge can be thought of as the capacity of that edge to transport value from the parent node of the edge to the child node of the edge.  

![](flow_network.png)  

Some quick notation: $c(e)$ is the capacity of an edge $e$.  The above graph $G$ consists of two sets $V$ and $E$, a set of vertices and edges respectively.  Note that node $s$ and node $t$ are special in that $s$ is the source node and $t$ is the target node.  The source node $s$ has no ingoing edges and the target node $t$ has no outgoing edges.  Since the target node is sometimes also called the 'sink' since flow goes in but not out.  

Note that throughout this page I refer to flow networks as "s-t graphs".  

## Cuts and Flows  

Let's define another term: an *s-t cut*.  An s-t cut is a special cut of a graph $G$ with source node $s$ and target node $t$ where $s$ is in the cut and $t$ is not.  And here's another term: an *outcutset*.  An outcutset is the set of outgoing edges of a cut.  Using these two definitions, let's define one more term: the *capacity* of an s-t cut.  The capacity of any s-t cut is simply the sum of the capacities of the edges in the s-t cut's outcutset.  Simple, right?  Here are two images for reference.  

![](cutcap1.png)  

![](cutcap2.png)  

Before we go on to talking about flows, let's take note of the problem that we'll be using all this terminology to define and solve: the minimum cut problem.  The minimum cut problem is the problem of finding an s-t cut with the minimum capacity for any flow network with source $s$ and target $t$.  

Now we're ready for flows.  Just like every edge has a capacity, every edge also has a flow.  The flow of an edge is simply how much of the edge's capacity is actually in use.  Clearly the flow of an edge can't be greater than its capacity and it also can't be less than zero.  If the flow of some edge $e$ si $f(e)$, then we have $0 \le f(e) \le c(e)\ \forall e \in G$.  

Now let's talk about a special kind of flow, an *s-t flow*.  An s-t flow is a set of edge flows for the whole graph such that for all vertices other than $s$ and $t$, the sum of the flows of a vertex's ingoing edges is equal to the sum of the flows of that vertex's outgoing edges.  Basically an s-t flow is just a set of flows for the whole graph where, besides nodes $s$ and $t$, all nodes' inflow is equal to outflow (all nodes have net zero flow).  Here's a picture of an s-t flow:  

![](st_flow.png)  

As shown in the picture, there's an important idea we must discuss about s-t flows: the *value* of s-t flows.  As shown above, the value of an s-t flow is the sum of node $s$'s outflows.  But why does that number characterize the entire s-t flow?  Well, if you think about it, the total outflow of node $s$ is actually going to be the net flow of any s-t cut!  This also implies that node $t$'s total inflow is this same value, the value of the s-t flow.  This property is shown in the picture below:  

![](st_flow_value.png)  

For a quick recap, remember that an s-t cut is a particular cut of a flow network where $s$ is in and $t$ is not and an s-t flow is just a set of flows for the whole graph where all nodes except for $s$ and $t$ have zero net flow (which causes some special properties to hold as discussed).  

## Max Flows  

Let's take note of an interesting property of s-t flows: for any s-t cut of a graph, no s-t flow can have a value greater than the capacity of the cut.  It follows naturally from this that the minimum s-t cut capacity of a graph is equal to the max s-t flow value of the graph.  This is basically just the idea of the minimum s-t cut capacity being a bottleneck for all flows.  

We can phrase this one more way: for any s-t flow and any s-t cut, if the value of the s-t flow is equal to the capacity of the cut then for that graph with those edge capacities the s-t flow is a max flow and the s-t cut is a min cut.  This is true because clearly if the s-t flow is as big as some s-t cut capacity then you can't make the flow any bigger but also if the flow is a valid flow then the max flow isn't any smaller -- this is clearly the smallest flow for which you've maxed out some s-t cut's capacity.  

## Attempts at MaxFlow-finding Algorithm  

Maybe we can try a simple greedy algorithm to find the max flow for some pair of nodes $s$ and $t$ in a graph?  For example, let's pick some $s \rightarrow t$ path for which all edges have capacities greater than their flows.  Our strategy will be to just increase the flow on all the edges of the path by the same amount until we can't.  Then we'll just move to another path with un-maxed-out capacities all along it and repeat.  The idea is that if we do this for every path that we can, we will have maxed-out to capacity all the flows in our s-t graph.  Unfortunately, this won't work.  Here's a counter-example where we apply the strategy:  

![](greedy_fails.png)  

![](greedy_opt.png)  

We can see that we'll get stuck if we apply that strategy.  We'll max out certain edges and then won't be able to find any $s \rightarrow t$ paths whose every edge has room for more flow -- even though there will be many paths where *many* of the edges have much more room for flow.  Clearly, as shown in the optimal solution, we will need to somehow take into account that the distribution of flows in the max flow is not so simple that our basic greedy algorithm can find it without screwing itself over.  

Most importantly, notice that what we seem to be missing is some kind of way to backtrack and decide to reditribute flow in some way so as to make room for adding more flow in total.  

## Augmenting Paths  

The failed strategy we just described involved finding a certain kind of $s \rightarrow t$ path -- an augmenting path.  As it was described above, it's a path along which every single edge has not been maxed out.  In other words, an $s \rightarrow t$ path along which we can **augment** the flow of each edge by at least some amount.

