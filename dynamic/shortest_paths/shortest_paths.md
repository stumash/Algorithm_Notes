## The Shortest Path Problem  

Given a edge-weighted and directed graph, find the shortest path between any two nodes `s` and `t`.  We should all be well aquainted with this problem from the [notes on Dijkstra's shortest path algorithm](../../greedy/dijkstra/shortestDijkstra.html).  

## Negative Cycles  

We already saw that Dijkstra's Algorithm fails on graphs with negative edge weights, but this time we're going to show some dynamic programming solutions to the Shortest Path problem that allow the graph to contain negative edge weights.  However, we first need to discuss a case that can arise in a graph with negative edge weights that **no shortest path algorithm can handle**: the case of negative cycles.  

The idea is simple: somewhere in the graph, there exists a cycle whose edge-weights sum to a negative number.  This means that if we had some path between two nodes $s$ and $t$ not on the cycle, if the path chose to go around the cycle as many times as it wanted it could hypothetically have a path length of **negative infinity**.  This is clearly not valid.  The issue here is not so much that no algorithm can come up with ways to combat this issue, but rather than there is no good way to define path length when one of these negative cycles exists.  So, we come to the following conclusion:

> If some path from $s$ to $t$ contains a negative cycle, there does not exist a shortest $s \rightarrow t$ path (by the standard definition -- of course you might be able to write some custom algorithm that still finds the shortest path ignoring negative cycles).  Otherwise, there does exist such a path and it is 'simple' (no repeated vertices).  

Something to note: a simple path can visit at most $|V|$ number of vertices, and that path will therefore necessarily have $|V| - 1$ edges.  Therefore, the max number of edges in any shortest $s \rightarrow t$ path is $|V| - 1$.  

## Recursive Definition of Optimal Solution  

As discussed in [the notes on weighted interval scheduling](../weighted_intervals/weighted_interval.html), the general strategy of dynamic programming is to first make a recursive definition of the optimal solution and then to implement it either bottom-up or top-down.  Before reading on, recall that the length of the shortest path between two nodes is not defined by the number of edges in the shortest path but rather the sum of their weights.  

The Bellman-Ford algorithm relies on two principles to justify its dynamic programming recurrence:  

1.  For any node $v$, the shortest $s \rightarrow v$ path cannot consist of more than $|V|-1$ edges.  
2.  Though we cannot define a recurrence for any shortest $s \rightarrow v$ path, **we can** define the recurrence for length of the shortest $s \rightarrow v$ path consisting of $i$ edges or less.  That recurrence is:  

![](def_opt0.png)  

![](def_opt1.png)  

![](def_opt2.png)  

The interesting part of the recurrence is the "otherwise" case, which is defined as the minimum of two cases:  

1.  The shortest path from $s$ to $v$ in at most $i$ edges is actually the shortest path from $s$ to $v$ in at most $i-1$ edges.  
2.  The shortest path from $s$ to $v$ uses exactly $i$ edges, so we can therefore define the length of the shortest $s \rightarrow v$ path  as the minimum of, for all of $v$'s neighbours $u$, the sum of the shortest-path-length to $u$ in $i-1$ edges plus the edge weight of edge $(u,v)$.  We can obviously only apply this minimization to nodes $u$ that are adjacent to $v$.  

## The Bellman-Ford Algorithm  

![](bf_alg.png)  

The algorithm returns the last row that it fills in.  Here's a demo of its execution on a simple example:  

![](bf_demo.png)  

## Big O of Space and Time  



**INCOMPLETE**
