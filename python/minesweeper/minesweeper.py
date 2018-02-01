def board(board_array):
    if not board_is_valid(board_array):
        raise ValueError('Invalid board.')

    matrix = [[0 if cell == ' ' else cell for cell in row] for row in board_array]

    for i, row in enumerate(matrix):
        for j, cell in enumerate(row):
            if cell == '*':
                update_adjacent(matrix, i, j)

    return [''.join(row) for row in accumulators_to_str(matrix)]


def accumulators_to_str(matrix):
    return [[' ' if cell == 0 else str(cell) for cell in row] for row in matrix]


def update_adjacent(matrix, row, col):
    for i in range(row-1, row+2):
        for j in range(col-1, col+2):
            try:
                if i >= 0 and j >= 0:
                    matrix[i][j] += 1
            except (TypeError, IndexError):
                pass


def board_is_valid(matrix):
    if len(set([len(row) for row in matrix])) > 1:
        return False
    for c in ''.join(matrix):
        if c not in [' ', '*']:
            return False
    return True
