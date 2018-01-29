from itertools import product


def saddle_points(matrix):
    transposed = list(zip(*matrix))
    indexes = product(range(len(matrix)), repeat=2)
    is_saddle = lambda i, j: matrix[i][j] == max(matrix[i]) == min(transposed[j])

    try:
        return set([(i, j) for (i, j) in indexes if is_saddle(i, j)])
    except IndexError:
        raise ValueError('Irregular matrix.')
