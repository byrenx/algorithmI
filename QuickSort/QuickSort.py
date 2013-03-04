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
    
    
# numbers= open("QuickSort_hw2.txt").read().split("\r\n")
# numbers.pop()
# a = [int(number) for number in numbers]
    

