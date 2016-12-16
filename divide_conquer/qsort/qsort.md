## MergeSort vs. QuickSort

Both Mergesort and Quicksort are divide-and-conquer algorithms for sorting arrays.  But,  
the strategies used by the two algorithms are quite different.  In Mergesort, the idea  
was to break the array up into two halves, recursively sorting the two halves.  When the  
two halves were sorted, you could then combine them in linear time.  Though Quicksort is  
also divide-and-conquer and so also works by recurisively sorting subarrays of the original  
array, the idea is a little different.  

## How does Quicksort work?  

In Quicksort, you first choose some elemenent to be the 'pivot' element.  Then, you  
rearrange the array so that all the elements less than the pivot are to the left of  
it and all elements greater than it are to its right.  

I can already here you saying, "but - but, just because all the elements to the left of  
the pivot are less than it and those to the right are greater than it does not mean that the  
array is sorted!".  You're absolutely right.  However, you must recall that we are using  
this 'choose pivot and rearrange' strategy *recursively*.  So, for our two subarrays  
where the first has only elements less than the pivot and the second has only elements  
greater than it, we then pick a pivot *within each subarray* and apply the strategy once  
more *to each subarray*.  And so on until we're at subarrays of size 1.  So, by the end, our  
first pivot is to the right of and greater than a sorted left-subarray, and is to the left  
and less than a sorted right-subarray.  Thus, the array is sorted.  

## How is it so fast?  

If you continuously pick the largest element as the pivot, then clearly Quicksort will run  
in $O(n^2)$.  This is because you'll be repeatedly taking the largest element in the array  
and putting it at the far right of the (soon-to-be) left subarray - and then repeating this  
recursively for the left subarray.  This looks just like Selection Sort!  

So, the speed of Quicksort depends on the quality of the choice of pivot.  If we can just pick  
a pivot that is roughly the median, then Quicksort will split the array into two subarrays of  
roughly the same size, kinda like Mergesort.  If we do that, Quicksort runs in $O(n\ log(n))$  
time.  So, we now understand the idea of quicksort and how we can get it to be fast.  We're  
left with only one issue:  

## How to choose a good pivot quickly  

As we saw, to get Quicksort to run in $O(n\ log(n))$ time, all we need is to pick pivots that  
*almost always* are *almost the median*.  How do we do that?  

If the array is in random order, we can just choose any element, conventionally the rightmost or  
leftmost element is chosen.  It turns out that picking a random element in a randomly  
ordered array ends up being close enough to the median enough of the time that Quicksort will  
run in $O(n\ log(n))$ time.

Of course if you pick the rightmost or leftmost element and the array is already sorted, then  
Quicksort degrades to $O(n^2)$ time.  The easiest way to get around this is to pick the middle  
element, so that for a sorted array Quicksort still runs $O(n\ log(n))$ time.  

The problem with choosing the middle element is that it's easy for someone to construct an  
array by hand that will cause Quicksort to degrade to $O(n^2)$ time.  To make it harder to  
construct such an array while keeping quicksort Big-O fast *and* practically fast, we can choose  
the pivot by using a builtin random function.  Of course, if you don't think that someone will  
do this or if your program doesn't give someone the opportunity to manually create this large  
array, then picking the middle element is fine.  It's also important to consider that the  
'perfectly bad array' can still be constructed if we use a builtin random function (though  
this requires more skill, time and effort) since builtin random functions are pseudorandom  
and known to the public.  

So, what can we do to completely avoid the possibility of sorting a 'perfectly bad array' that  
degrades our Quicksort to $O(n^2)$?  Well, we can write a custom random function so that no  
malicious user can know how to make the 'perfectly bad array', but this array could still  
technically occurr by chance (though very unlikely) -- and worse, our custom function will  
take long to execute which will slow down our Quicksort even though the Big-O is the same.  

The other option is to use the Median of Medians algorithm to pick the exact median every time.  
Just like the custom random function, MoM will also slow down our Quicksort despite being able  
to maintain the $O(n\ log(n))$.  However, using MoM can **guarantee** that the running time is  
$O(n\ log(n))$ -- in other words, MoM guarantees that no 'perfectly bad array' can be built to  
degrade the Big-O of Quicksort.  

*note: the Median of Medians algorithm is covered in the [QuickSelect](../qselect/qselect.html) notes*  

## Implementation  

We all know this had to be done.  Let's take a look at some pseudocode to get a hands-on look at  
this algorithm.  

~~~
Algorithm Quicksort(array A, index L, index R):
    If L is less than R
        Find the pivot element and swap it with the last element
        Partition the array into two subarrays with the pivot at index P
         such that elements to the left of the pivot are less than it and
         those to the right of it are greater than it.
        Quicksort(A,L,P-1)
        Quicksort(A,P+1,R)
    Endif
 EndAlgorithm
~~~

Everything inside the 'If' should be obvious.  We're finding the pivot and then putting it at the  
back so that we can do the partitioning.  When the partitioning is done, we have our pivot in between  
the two subarrays so we end by calling quicksort recursively on them both.  

Why do we have 'If L is less than R'?  It's to handle the case where the pivot is at the far left  
or far right of the array after partitioning.  If the pivot is at either end after partitioning, then  
for the recursive calls either `P-1 < L` or `P+1 > R`.  Why would the pivot be at either end?  If the  
array is of size 2 then this is guaranteed but we also might have chosen a pivot that was the smallest  
or largest element in the array.  The 'If' is also there to handle the base case where the array is of  
size 1 and `L == R`.  

We already discussed methods for finding the pivot, so assuming we can find one then the only  
unanswered question about Quicksort is how the partitioning works.  First, you assume that the  
pivot is at the far right.  Then, you take all elements that are less than the pivot push them  
as far left as they can go.  Then, swap the pivot (which is on the far right) with the element  
that is just to right of all those elements we just pushed to the left.  Now, all the elements  
to the left of the pivot are less than it  and all the elements to the right of it are greater  
than it.  Here's some pseudocode to accomplish that:  

~~~
Function PivotPartition(array A, index L, index R):
    Set index S equal to L
    For (index I = L; I < R; I++)
        If A[I] < A[R]
            Swap A[I] with A[S]
            Increment S
        Endif
    Endfor
    Swap A[S] with A[R]
Endfunction
~~~

[Alright we're done congratulations.](https://www.youtube.com/watch?v=JeimE8Wz6e4)
