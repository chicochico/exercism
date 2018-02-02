digits = {
    ' _ | ||_|   ': '0',
    '     |  |   ': '1',
    ' _  _||_    ': '2',
    ' _  _| _|   ': '3',
    '   |_|  |   ': '4',
    ' _ |_  _|   ': '5',
    ' _ |_ |_|   ': '6',
    ' _   |  |   ': '7',
    ' _ |_||_|   ': '8',
    ' _ |_| _|   ': '9',
}


def convert(input_grid):
    cols = len(input_grid[0])
    rows = len(input_grid)

    if (cols % 3 != 0) or (rows % 4 != 0):
        raise ValueError('Invalid input.')

    if rows > 4:
        splited = [horizontal_split(row) for row in vertical_split(input_grid)]
        return ','.join(''.join(recognize(digit) for digit in row) for row in splited)
    elif cols > 3:
        splited = horizontal_split(input_grid)
        return ''.join(recognize(digit) for digit in splited)
    return recognize(''.join(input_grid))


def recognize(digit):
    try:
        return digits[digit]
    except KeyError:
        return '?'


def horizontal_split(grid):
    grid = [horizontal_chunk(row) for row in grid]
    return [''.join(n) for n in list(zip(*grid))]


def vertical_split(grid):
    return [grid[i:i+4] for i in range(0, len(grid), 4)]


def horizontal_chunk(row):
    return [row[i:i+3] for i in range(0, len(row), 3)]
