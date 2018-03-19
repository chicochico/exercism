class CustomSet(object):
    def __init__(self, elements=[]):
        self.elements = set(elements)

    def isempty(self):
        return len(self.elements) == 0

    def __contains__(self, element):
        return element in self.elements

    def issubset(self, other):
        return self.elements.issubset(other.elements)

    def isdisjoint(self, other):
        return self.elements.isdisjoint(other.elements)

    def __eq__(self, other):
        return self.elements == other

    def __add__(self, other):
        return self.union(other)

    def __sub__(self, other):
        return self.elements.difference(other.elements)

    def add(self, element):
        return self.elements.add(element)

    def intersection(self, other):
        return self.elements.intersection(other.elements)

    def difference(self, other):
        return self.elements.difference(other.elements)

    def union(self, other):
        return self.elements.union(other.elements)
