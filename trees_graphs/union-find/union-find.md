## The Union-Find Data Structure  

Honestly, I don't think you can get a better explanation of how this works than you in [these youtube videos](https://www.youtube.com/watch?v=8mYfZeHtdNc&list=PLe-ggMe31CTexoNYnMhbHaWhQ0dvcy43t&index=1) which are lectures from the series by Roger Sedgewick that I mentioned at the top of the home page of these notes.  

## Find operation

The `find(ei,ej)` operation will take two elements $e_i$ and $e_j$ and determine if they are connected in the union-find data structure.  The union-find data structure works by storing mutiple disjoint sets so the find operation really just amounts to checking if the two elements are in the same set.  

`find(ei,ej)` has $T(n) \in O(\log_{2}(n))$ where $n$ is the number of elements in the data structure so far.  

## Union operation

The `union(ei,ij)` operation takes two elements in the data structure and connects them.  Since the union-find data is all about keeping track of multiple disjoint sets, the connect operation actually amounts to *uniting the two sets to which the two elements belong*.  In other words the `union(ei,ej)` operation replaces `ei`'s set and `ej`'s set with the union of the two sets.  

`union(ei,ij)` has $T(n) \in O(\log_{2}(n))$ where $n$ is the number of elements in the data structure so far.  

Now that we have united each element's set, the `find(ei,ej)` operation will return that the two elements do belong to the same set.  

## Speed with Optimizations  

As discussed in the videos linked to above, the data structure can be optimized such that M union-find operations on N object is $O(N + M \lg^{*}(N))$ which, since $\lg^{*}$ is a special function that is less than 5 up to the stupidly large number $2^{65536}$, is more or less the same as $O(N + M)$, linear time!  
