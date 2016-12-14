## Regular BFS Using a Queue

The usual implementation of BFS uses a Queue data structure.  To visit every node in the tree  
breadth-first, the algorithm is simple.  First, you put the root node in the Queue.  Then, dequeue  
one element from the queue and name it mynode.  Enqueue all of mynode's undiscovered children.  
Repeat until the Queue is empty.  
  
This algorithm works fine for simply traversing the tree/graph in a breadth-first way, but what  
if you want to be able to access the nodes by level? Or what if you want to access them by  
level while also knowing who each node's parent was in the previous level?  Clearly, the Queue  
will not suffice.
  
## BFS Using an Array of Lists - One List per Level  
  
So, what would be better?  Well, if we built up an array of lists during the BFS so that each list  
corresponds to a level, we would be able to access nodes by level.  The speudo-code for doing that  
is shown below:

~~~
Algorithm BFS:
Let every node have an isDiscovered boolean property
Let A[] be an array of lists, one list for every level of BFS tree
Set the level counter lcount=0
Initialize A[0] to consist of the single root node
While A[lcount] is not an empty list:
    Initialize an empty list A[lcount + 1]
    For each node N in A[lcount]
        Set N isDiscovered=true
        For each node N' adjacent to N
            If N' !isDiscovered
                Add N' to A[lcount + 1]  //Similar to use of queue
            Endif
        Endfor
    Endfor
    Increment lcount by one
Endwhile
~~~

This approach is good, no doubt.  With `A[]` we can definitely access the levels of the BFS tree  
directly.  The only drawback is that we can't know which node `N` in the level above any given  
node `N'` is the parent in the BFS tree of the node `N'`.  For example, we can go to A[n]  
and go pick the ith element in the list.  We know that this element is n levels below the root  
node, and since it is a node we have its list of edges.  However, if more than one of the nodes  
it's connected to are in the level n-1, we can't know which node is its parent in the tree.  

It should be noted that this knowledge is rarely needed and will come at the cost of more memory  
usage as demonstrated in the next section.  

## BFS that Does It All - BFS Tree Adjacency List

So how can we do our breadth-first traversal while storing the enountered nodes in the most  
convenient data structure -- a data structure that lets us both access the nodes by level and  
access the nodes' BFS tree parent and children by node?  We build an adjacency list  
representation of the BFS tree on top of the array of lists (one per level) from the last section.  

Our adjacency list representation, a hashmap of lists `H[]`, will have one list for each node we  
encounter.  The first element of the list will be that node's parent node in the BFS tree.  The  
rest of list will be all the node's children in the BFS tree.  We'll still have `A[]` to access  
nodes by their depth in the BFS tree but now we'll also be able to see a node's parent and  
children in the BFS tree by checking `H[node]`.  

~~~
Algorithm BFS:
Let every node have an isDiscovered boolean property  
Let A[] be an array of lists, one list for every level of BFS tree
Let H[] be an array of lists, one list for every node in the graph
Set the level counter lcount=0
Initialize A[0] to consist of the single root node
While A[lcount] is not empty
    Initialize the empty list A[lcount + 1]
    For each node N in A[lcount]
        Set N isDiscovered=true
        For each node N' adjacent to N
            If N' !isDiscovered
                Add N' to A[lcount + 1]
                Add N' to H[N] //N adjlist gets child N'
                Add N to H[N'] //N' adjlist gets parent N
                Increment ncount by one
            Endif
        Endfor
    Endfor
    Increment lcount by one
Endwhile
~~~
