class Node(object):
    def __init__(self, value, next_pointer=None):
        self.data = value
        self.next_pointer = next_pointer

    def value(self):
        return self.data

    def next(self):
        return self.next_pointer


class LinkedList(object):
    def __init__(self, values=[]):
        self.first = None
        for value in values:
            self.push(value)

    def __len__(self):
        count = 0
        node = self.first
        while node:
            count += 1
            node = node.next()
        return count

    def __iter__(self):
        node = self.first
        while node:
            yield node.value()
            node = node.next()

    def head(self):
        if not self.first:
            raise EmptyListException('Empty list.')
        return self.first

    def push(self, value):
        new_value = Node(value)
        new_value.next_pointer = self.first
        self.first = new_value

    def pop(self):
        if not self.first:
            raise EmptyListException('Empty list.')
        pop_value = self.first.value()
        self.first = self.first.next()
        return pop_value

    def reversed(self):
        return list(self)[::-1]


class EmptyListException(Exception):
    pass
