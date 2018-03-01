from itertools import repeat


class Point(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __repr__(self):
        return f'({self.x}, {self.y})'


class WordSearch(object):
    def __init__(self, puzzle):
        self.board = puzzle
        self.directions = [
            self.seekn,
            self.seekne,
            self.seeke,
            self.seekse,
            self.seeks,
            self.seeksw,
            self.seekw,
            self.seeknw,
        ]

    def search(self, word):
        first_char = word[0]
        size = len(word)
        seek_positions = [(i, j) for i, row in enumerate(self.board)
                          for j, c in enumerate(row)
                          if c == first_char]

        for seek_position in seek_positions:
            for direction in self.directions:
                try:
                    result, ending_point = direction(size, *seek_position)
                    if result == word:
                        return Point(*seek_position[::-1]), Point(*ending_point)
                except IndexError:
                    pass
        return None

    def seekn(self, size, i, j):
        coordinates = zip(range(i, i-size, -1), repeat(j, size))
        return self.seek(coordinates), (j, i-size+1)

    def seekne(self, size, i, j):
        coordinates = zip(range(i, i-size, -1), range(j, j+size))
        return self.seek(coordinates), (j+size-1, i-size+1)

    def seeke(self, size, i, j):
        coordinates = zip(repeat(i, size), range(j, j+size))
        return self.seek(coordinates), (j+size-1, i)

    def seekse(self, size, i, j):
        coordinates = zip(range(i, i+size), range(j, j+size))
        return self.seek(coordinates), (j+size-1, i+size-1)

    def seeks(self, size, i, j):
        coordinates = zip(range(i, i+size), repeat(j, size))
        return self.seek(coordinates), (j, i+size-1)

    def seeksw(self, size, i, j):
        coordinates = zip(range(i, i+size), range(j, j-size, -1))
        return self.seek(coordinates), (j-size+1, i+size-1)

    def seekw(self, size, i, j):
        coordinates = zip(repeat(i, size), range(j, j-size, -1))
        return self.seek(coordinates), (j-size+1, i)

    def seeknw(self, size, i, j):
        coordinates = zip(range(i, i-size, -1), range(j, j-size, -1))
        return self.seek(coordinates), (j-size+1, i-size+1)

    def seek(self, coordinates):
        return ''.join(self.board[i][j] for i, j in coordinates)
