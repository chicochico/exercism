from collections import deque


class BufferFullException(Exception):
    pass


class BufferEmptyException(Exception):
    pass


class CircularBuffer(object):
    def __init__(self, capacity):
        self.capacity = capacity
        self.buffer = deque(maxlen=capacity)

    def read(self):
        try:
            return self.buffer.pop()
        except IndexError:
            raise BufferEmptyException('The buffer is empy.')

    def write(self, data):
        if len(self.buffer) < self.capacity:
            self.buffer.appendleft(data)
        else:
            raise BufferFullException('The buffer is full.')

    def overwrite(self, data):
        self.buffer.appendleft(data)

    def clear(self):
        self.buffer.clear()
