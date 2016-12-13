## The Shortest Path Problem  

Given a edge-weighted and directed graph, find the shortest path between any two nodes `s` and `t`.  We should all be well aquainted with this problem from the [notes on Dijkstra's shortest path algorithm](../../greedy/dijkstra/shortestDijkstra.html).  

## Negative Cycles  

We already saw that Dijkstra's Algorithm fails on graphs with negative edge weights, but this time we're going to show some dynamic programming solutions to the Shortest Path problem that allow the graph to contain negative edge weights.  However, we first need to discuss a case that can arise in a graph with negative edge weights that **no shortest path algorithm can handle**: the case of negative cycles.  

The idea is simple: somewhere in the graph, there exists a cycle for which the sum of its component edges' weights **is negative**.  This means that if we had some path between two nodes $s$ and $t$ not on the cycle, if the path chose to go around the cycle as many times as it wanted it could hypothetically have a path length of **negative infinity**.  This is clearly not valid.  The issue here is not so much that no algorithm can come up with ways to combat this issue, but rather than there is no good way to define path length when one of these negative cycles exists.  So, we come to the following conclusion:

> If some path from $s$ to $t$ contains a negative weight cycle, there does not exist a shortest $s \rightarrow t$ path.  Otherwise, there does exist such a path and it is 'simple' (no repeated vertices).  

Something to note: a simple path can visit at most $|V|$ number of vertices, and that path will therefore necessarily have $|V| - 1$ edges.  Therefore, the max number of edges in any shortest $s \rightarrow t$ path is $|V| - 1$.  

## Recursive Definition of Optimal Solution  

This is the general strategy of dynamic programming as discussed in [the notes on weighted interval scheduling](../weighted_intervals/weighted_interval.html), which was the first dynamic programming problem that we looked at.  

**INCOMPLETE**
