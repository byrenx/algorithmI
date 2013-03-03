import itertools
import operator
import collections
from collections import Counter

## stack (non-recursive) implementation of DFS
def DFS(g, i):
    num = max(map(max, g.values()))
    explored = [0]*num
    Q = [i]
    while len(Q) > 0:
        v = Q.pop()
        if not explored[v-1]:
            explored[v-1] = 1
            try:
                W = g[v]
            except KeyError:
                W = []
            for w in W:
                if not explored[w-1]:
                    Q.append(w)
    return explored

## stack version is a little awkward when we also want finish times
def DFS_1st(graph, i):
    global t
    global ftime
    global dtime
    global explored
    Q = [i]
    while len(Q)>0:
        v = Q.pop()
        if not explored[v-1]:
            explored[v-1] = 1
            t = t + 1
            dtime[v-1] = t  
            Q.append(v)
            try:
                W = graph[v]         
            except KeyError:
                pass 
            else:
                for w in W:
                    if not explored[w-1]:
                        Q.append(w)  
        elif  explored[v-1] == 1:
            t = t + 1
            ftime[v-1] = t
            explored[v-1] = 2

def DFS_2nd(graph, i):
    global leaders
    global s
    Q = [i]
    while len(Q)>0:
        v = Q.pop()
        if not leaders[v-1]:
            leaders[v-1] = s
            try:
                W = graph[v]                   
            except KeyError:
                pass
            else:
                for w in W:
                    if not leaders[w-1]:
                        Q.append(w)
           
    
def SCC(graph, graph_rev):
    num = max(map(max, graph.values())+graph.keys())
    global explored
    global ftime
    global dtime
    global t
    global s
    global leaders
    explored = [0]*num
    ftime = [0]*num
    dtime = [0]*num
    t = 0
    for i in range(num, 0, -1):
        if not explored[i-1]:
            DFS_1st(graph_rev, i)
    leaders = [0]*num
    s = None
    reorder = [i[0]+1 for i in sorted(enumerate(ftime), key=operator.itemgetter(1), reverse = True)]
    for i in reorder:
        if not leaders[i-1]:
            s = i
            DFS_2nd(graph, i)
    return  Counter(leaders).most_common(5)
    
