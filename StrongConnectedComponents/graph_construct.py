import itertools
import operator
import collections
from collections import Counter

g = [edge.split(' ')[:2] for edge in open("SCC.txt").read().split("\n")]
#g = [edge.split(' ')[:2] for edge in open("test3.txt").read().split("\n")]
#g.pop()
g = [map(int, edge) for edge in g]


graph = {}
for key, grp in itertools.groupby(sorted(g), key=operator.itemgetter(0)):
    graph[key] = map(operator.itemgetter(1), grp)

## reverse g
g1 = zip(*g)
g1 = [g1[1], g1[0]]
g_rev = zip(*g1)

graph_rev = {}
for key, grp in itertools.groupby(sorted(g_rev), key=operator.itemgetter(0)):
    graph_rev[key] = map(operator.itemgetter(1), grp)
