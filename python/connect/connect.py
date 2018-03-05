class ConnectGame:
    def __init__(self, board):
        self.board = [row.split() for row in board.split('\n')]

    @property
    def height(self):
        return len(self.board)

    @property
    def width(self):
        return len(self.board[0])

    def transpose(self):
        self.board = [list(row) for row in zip(*self.board)]

    def get_winner(self):
        if self.is_connected('O'):
            return 'O'
        self.transpose()
        if self.is_connected('X'):
            return 'X'
        return ''

    def is_connected(self, player):
        for pos in self._get_starting_points(player):
            if self._search(player, 0, pos, []):
                return True
        return False

    def _search(self, player, i=0, j=0, visited=[]):
        if i == self.height-1:
            return True

        visited.append((i, j))
        neighbors = self._get_neighbors(player, i, j, visited)

        for neighbor in neighbors:
            if self._search(player, *neighbor, visited):
                return True
        return False

    def _get_starting_points(self, player):
        return (j for j, p in enumerate(self.board[0])
                if p == player)

    def _get_neighbors(self, player, i, j, visited):
        neighbors = [
            (i-1, j),    # top left
            (i-1, j+1),  # top right
            (i, j-1),    # left
            (i, j+1),    # right
            (i+1, j-1),  # bottom left
            (i+1, j)     # bottom right
        ]
        return ((i, j) for i, j in neighbors
                if 0 <= i < self.height
                and 0 <= j < self.width
                and (i, j) not in visited
                and self.board[i][j] == player)
