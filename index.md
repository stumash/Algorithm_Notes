## Foreword  

These notes assume an understanding of Asymptotic Time Complexity Analysis (Big O).  Namely, that $O(f(n))$ is the set of functions that are asymptotically upper-bound by $f(n)$ -- that is to say the set of functions for which we can choose some input value $n_0$ beyond which all functions in the set can be guaranteed to be less than some constant multiple of $f(n)$.  

$$
O(f(n))=\{x(n):x(n) \le k \cdot f(n)\ \land n_0 \ge 0 \land n \ge n_0 \land k \lt \infty\}
$$

These notes also assume a basic familiarity with algorithms and data structures.  For example, a decent understanding of the time complexity of mergesort, hashmaps, stacks, queues and binary trees are all taken for granted in any explanations found in these notes.  

These notes are presented below in the order that they were written.  Though it is not necessary to read them in the suggested order, pages in the following list may rely on information that can be found in pages that appear earlier in the list.  

These notes were made possible by the great explanations of certain educators whose content is readily available on the internet.  In particular, Princeton's Roger Sedgewick's series of videos form his Coursera course *Algorithms (Part 1 and 2)* is one of the most complete set of clear explanations of the algoriths discussed in these notes that can be found anywhere.  

## Divide and Conquer  

[QuickSort](divide_conquer/qsort/qsort.html)  

[QuickSelect](divide_conquer/qselect/qselect.html)  

## Trees and Graphs  

[Breadth First Search Tree](trees_graphs/bfs/bfs.html)  

[Red-Black Trees](trees_graphs/rbtree/rbtree.html)  

[Topological Sorting](trees_graphs/topsort/topsort.html)  

[Union-Find](trees_graphs/union-find/union-find.html)  

## Greedy Algorithms  

[Interval Scheduling](greedy/intervals/intervals.html)  

[Dijkstra's Shortest Path](greedy/shortestDijkstra/shortestDijkstra.html)  

[Minimum Spanning Tree](greedy/mst/mst.html)  

## Dynamic Programming  

[Weighted Interval Scheduling](dynamic/weighted_intervals/weighted_interval.html)  

[Bellman-Ford-ish](dynamic/shortest_paths/shortest_paths.html)  

## Max Flow  

[Maximum Flow and Minimum Cut](trees_graphs/maxflow/flows.html)  
