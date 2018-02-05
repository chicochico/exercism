from itertools import zip_longest


def transpose(input_lines):
    zipped = zip_longest(*input_lines.split('\n'))
    zipped = [[e for e in row] for row in zipped]

    # replace trailing fillvalues with empty string
    for i in range(len(zipped)):
        for j in range(len(zipped[0])-1, -1, -1):
            if zipped[i][j] is None:
                zipped[i][j] = ''
            else:
                break

    # replace fillvalues in the middle with space
    zipped = [[c if c is not None else ' ' for c in row] for row in zipped]
    zipped = [''.join(row) for row in zipped]
    return '\n'.join(zipped)
