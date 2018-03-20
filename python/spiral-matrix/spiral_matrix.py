def spiral(size):
    spiral_matrix = get_square_matrix(size)
    n = 1
    for i, j in get_spiral_indexes(size):
        spiral_matrix[i][j] = n
        n += 1
    return spiral_matrix


def get_square_matrix(size):
    return [[None for _ in range(size)] for _ in range(size)]


def get_spiral_indexes(size):
    '''
    Get the sequence of indexes to insert numbers
    '''
    indexes = []
    index_matrix = get_index_matrix(size)
    # repeat untill the index_matrix is empty
    while index_matrix:
        # add top to indexes
        indexes += index_matrix[0]
        # remove the top
        index_matrix = index_matrix[1:]
        # rotate counterclockwise
        index_matrix = list(zip(*index_matrix))[::-1]
    return indexes


def get_index_matrix(size):
    return [[(i, j) for j in range(size)] for i in range(size)]
