def partition(a, l, r):
    p = a[l]
    i = l + 1
    for j in range((l+1), (r+1)):
        if p > a[j]:
            temp = a[i]
            a[i] = a[j]
            a[j] = temp
            i = i + 1
    temp = a[i-1]
    a[i-1] = a[l]
    a[l] = temp
    return i-1

def QuickSort(a):
    n = len(a)
    if n==1:
        return a
    pivot = partition(a, 0, n-1)
    if(pivot > 0):
        a[0:pivot] = QuickSort(a[0:pivot])
    if(pivot < n-1):
        a[(pivot+1):n] = QuickSort(a[(pivot+1):n])
    return a
    
    
    

