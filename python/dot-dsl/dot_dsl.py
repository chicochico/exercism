NODE, EDGE, ATTR = range(3)


class Node(object):
    def __init__(self, name, attrs={}):
        self.name = name
        self.attrs = attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge(object):
    def __init__(self, src, dst, attrs={}):
        self.src = src
        self.dst = dst
        self.attrs = attrs

    def __eq__(self, other):
        return (self.src == other.src and
                self.dst == other.dst and
                self.attrs == other.attrs)


class Graph(object):
    def __init__(self, data=[]):
        self.nodes = []
        self.edges = []
        self.attrs = {}
        self.parse(data)

    def parse(self, data):
        if type(data) != list:
            raise TypeError('Unknown command.')
        for statement in data:
            if len(statement) < 3:
                raise TypeError('Unknown command.')
            stype = statement[0]
            if stype == NODE:
                name, attrs = statement[1:]
                self.nodes.append(Node(name, attrs))
            elif stype == EDGE:
                edge1, edge2, attrs = statement[1:]
                self.edges.append(Edge(edge1, edge2, attrs))
            elif stype == ATTR:
                name, attrs = statement[1:]
                self.attrs[name] = attrs
            else:
                raise ValueError('Unknown command.')
