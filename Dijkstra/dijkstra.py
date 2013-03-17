import operator
from sys import argv
# graph is a dictionary of dictionaries
def dijkstra(graph, s):
    n = len(graph)
    A = {}
    A[s] = 0
    X = []
    X.append(s)
    while len(X) < n:
        V = graph.keys()
        D = {}
        for head in graph.keys():
            if head in X:
                for tail in graph[head].keys():
                    if not tail in X:
                        D[(head, tail)] = A[head] + graph[head][tail]
        edge = min(D.iteritems(), key=operator.itemgetter(1))[0] # argmin
        A[edge[1]] = D[edge]
        X.append(edge[1])
    return A

if __name__=='__main__':
    
    script, input_file, s = argv
    s = int(s)
    graph = {}
    for vertex_list in open(input_file).read().split('\r\n'):
        if not vertex_list == '':
            vertex_list = vertex_list.split("\t")
            vertex_list.pop() # remove trailing empty item
            vertex = vertex_list[0]
            del vertex_list[0]
            graph[int(vertex)] = {int(edge.split(',')[0]):int(edge.split(',')[1]) for edge in vertex_list}
    short_distance =  dijkstra(graph, s)
##    print short_distance
    print [short_distance[key] for key in short_distance.keys() if key in [7, 37, 59, 82, 99, 115, 133, 165, 188, 197]]
    
    
