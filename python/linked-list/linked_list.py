class Node(object):
    def __init__(self, value, next=None, previous=None):
        self.value = value
        self.next = next
        self.previous = previous


class LinkedList(object):
    def __init__(self):
        self.head = None
        self.tail = self.head

    def __len__(self):
        count = 0
        node = self.head
        while node:
            count += 1
            node = node.next
        return count

    def __iter__(self):
        # start at tail because the list is built backwards
        node = self.tail
        while node:
            yield node.value
            node = node.previous

    def push(self, value):
        if self.head:
            self.head.previous = Node(value, self.head)
            self.head = self.head.previous
        else:
            self.head = Node(value, self.head)
            self.tail = self.head

    def pop(self):
        try:
            val = self.head.value
            self.head = self.head.next
            return val
        except AttributeError:
            raise IndexError('Empty list.')

    def shift(self):
        try:
            val = self.tail.value
            self.tail = self.tail.previous
        except AttributeError:
            raise IndexError('Empty list.')
        try:
            self.tail.next = None
        except AttributeError:
            pass
        return val

    def unshift(self, value):
        try:
            self.tail.next = Node(value, None, self.tail)
            self.tail = self.tail.next
        except AttributeError:
            self.push(value)
