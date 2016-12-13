## The Union-Find Data Structure  

Honestly, I don't think you can get a better explanation of how this works than you in [these youtube videos](https://www.youtube.com/watch?v=8mYfZeHtdNc&list=PLe-ggMe31CTexoNYnMhbHaWhQ0dvcy43t&index=1) from the lectures of an algorithms course that princeton put up on the internet for free.  Come back here when you're done there if you think you need to.  

Here's a [link](https://www.youtube.com/channel/UCirCLaGiw_zT6vJNI_At6ag) to the entire set of lectures they put online.  You can always google it if these links are broken.  

## Find/Connected operation

The `find(ei,ej)` operation will take two elements $e_i$ and $e_j$ and determine if they are connected in the union-find data structure.  
`find(ei,ej)` has $T(n) \in O(\lg(n))$ where $n$ is the number of elements in the data structure so far.  

## Union operation

The `union(ei,ej)` operation will take two elements and connected them so that the sets to which they belong will become one combined set.  
`union(ei,ij)` has $T(n) \in O(\lg(n))$ where $n$ is the number of elements in the data structure so far.  

## Speed with Optimizations  

As discussed in the videos linked to above, the data structure can be optimized such that M union-find operations on N object is $O(N + M \lg^{*}(N))$ which, since $\lg^{*}$ is a special function that is less than 5 up to the stupidly large number $2^{65536}$, is more or less the same as $O(N + M)$, linear time for linear operations!  
