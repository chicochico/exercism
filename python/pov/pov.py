from copy import deepcopy
from json import dumps


class Tree(object):
    def __init__(self, label, children=[]):
        self.label = label
        self.children = children

    def __dict__(self):
        return {self.label: [c.__dict__() for c in sorted(self.children)]}

    def __repr__(self):
        return dumps(self.__dict__(), indent=2)

    def __lt__(self, other):
        return self.label < other.label

    def __eq__(self, other):
        return self.__dict__() == other.__dict__()

    def __deepcopy__(self, memo):
        return type(self)(self.label, deepcopy(self.children, memo))

    def from_pov(self, from_node):
        path_to_pov = self.find_node(from_node)
        child = deepcopy(path_to_pov.pop())
        while path_to_pov:
            parent = deepcopy(path_to_pov.pop())
            child.children.remove(parent)
            parent.children.append(child)
            child = parent
        return child  # new object, self is unchanged

    def find_node(self, child):
        result = self.find(child, [])
        if result:
            return result
        else:
            raise ValueError('Not found.')

    def find(self, child, path=[]):
        if self.label == child:
            path.append(self)
            return path
        for c in self.children:
            if c.find(child, path):
                path.append(self)
                return path

    def path_to(self, from_node, to_node, path=()):
        path_to_root = self.find_node(from_node)
        path_from_root = self.find_node(to_node)
        path = path_to_root[:-1] + path_from_root[::-1]
        return [node.label for node in path]
