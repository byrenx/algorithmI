def partition(a):
    p = a[0]
    i = 1
    for j in range(1, len(a)):
        if p > a[j]:
            temp = a[i]
            a[i] = a[j]
            a[j] = temp
            i = i + 1
    temp = a[i-1]
    a[i-1] = a[0]
    a[0] = temp
    return (a, i-1)

def QuickSort(a):
    n = len(a)
    if n > 1:
        a, pivot = partition(a)
        if(pivot > 0):
            a[0:pivot] = QuickSort(a[0:pivot])
        if(pivot < n-1):
            a[(pivot+1):n] = QuickSort(a[(pivot+1):n])
    return a
    
    
numbers= open("QuickSort_hw2.txt").read().rsplit("\r\n")
numbers.pop()
a = [int(number) for number in numbers]
    

## functional way of quicksort
import random

def choose_and_remove( items ):
    # pick an item index
    if items:
        index = random.randrange( len(items) )
        return items.pop(index)
    return None

def QuickSortF(a):
    if len(a) ==0:
        return []
    # pivot = choose_and_remove(a)
    pivot = a.pop()
    left = QuickSortF([x for x in a if x <= pivot])
    right = QuickSortF([x for x in a if x > pivot])
    return left + [pivot] + right
