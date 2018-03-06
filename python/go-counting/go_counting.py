BLACK = 'B'
WHITE = 'W'
NONE = None


class Board:
    """Count territories of each player in a Go game
    Args:
        board (list[str]): A two-dimensional Go board
    """

    def __init__(self, board):
        self.board = board.split('\n')
        self.height = len(self.board)
        self.width = len(self.board[0])

    def territoryFor(self, coord):
        """Find the owner and the territories given a coordinate on
           the board
        Args:
            coord ((int,int)): Coordinate on the board
        Returns:
            (str, set): A tuple, the first element being the owner
                        of that area.  One of "W", "B", "".  The
                        second being a set of coordinates, representing
                        the owner's territories.
        """
        j, i = coord
        if not self.is_valid_coordinate(i, j):
            return (None, set())
        if self.board[i][j] in ['B', 'W']:
            return (None, set())

        territory = self.expand(i, j, visited=[])
        liberties = [(j, i) for i, j in territory if self.board[i][j] == ' ']
        stones = [self.board[i][j] for i, j in territory
                  if self.board[i][j] in ['B', 'W']]

        if len(set(stones)) == 1:
            return (stones[0], set(liberties))
        return (None, set(liberties))

    def territories(self):
        """Find the owners and the territories of the whole board
        Args:
            none
        Returns:
            dict(str, set): A dictionary whose key being the owner
                        , i.e. "W", "B", "".  The value being a set
                        of coordinates owned by the owner.
        """
        black_territories = []
        white_territories = []
        not_territory = []
        visited = []

        for i in range(self.height):
            for j in range(self.width):
                if (self.board[i][j] in ['B', 'W'] or
                        (i, j) in visited):
                    continue
                color, coordinates = self.territoryFor((j, i))
                visited += coordinates  # avoid visiting already visited
                if color == 'B':
                    black_territories += coordinates
                elif color == 'W':
                    white_territories += coordinates
                else:
                    not_territory += coordinates

        return {'B': set(black_territories),
                'W': set(white_territories),
                None: set(not_territory)}

    def expand(self, i, j, visited=[]):
        if (i, j) in visited:
            return visited
        visited.append((i, j))
        neighbors = self.get_neighbors(i, j, visited)
        for y, x in neighbors:
            value = self.board[y][x]
            if value == ' ':
                self.expand(y, x, visited)
            elif value in ['B', 'W']:
                if (y, x) not in visited:
                    visited.append((y, x))
        return visited

    def get_neighbors(self, i, j, visited):
        neighbors = [
            (i-1, j),  # up
            (i, j+1),  # right
            (i+1, j),  # down
            (i, j-1),  # left
        ]
        return ((i, j) for i, j in neighbors
                if self.is_valid_coordinate(i, j)
                and (i, j) not in visited)

    def is_valid_coordinate(self, i, j):
        return (0 <= i < self.height) and (0 <= j < self.width)
