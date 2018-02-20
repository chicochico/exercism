import re
from collections import Counter
from itertools import combinations


def count(diagram):
    '''
    Count the number of rectangles, flip the diagram
    and count again, return the min of the two values
    '''
    squares = count_rectangles(diagram)
    # flip the diagram and count again
    flipped = count_rectangles(flip(diagram))
    # return the smaller value, this eliminates invalid rectangles
    return min(squares, flipped)


def count_rectangles(diagram):
    '''
    1. get the combinations of different possible horizontal lines length,
    2. for each row in the diagram count the number of valid lines
    3. count the lines of equal length
    4. count the rectangles that can be assembled with the different lengths lines
    5. sum all the rectangles
    '''
    horizontal_lines = edges(diagram)
    diagram = indexed(diagram)
    lines = [(row[a:b+1][0], row[a:b+1][-1])
             for row in diagram
             for a, b in horizontal_lines
             if is_edge(''.join(row[a:b+1]))]
    return sum([squares(l) for l in Counter(lines).values()])


def edges(diagram):
    '''
    Get the combinations of possible horizontal_lines
    '''
    edges = {j for row in diagram for j, c in enumerate(row) if c == '+'}
    return list(combinations(edges, r=2))


def indexed(diagram):
    '''
    Put indexes in rectangles corners

      2-4
      | |
    0-2-4
    | | |
    0-2-4
    '''
    return [[str(j) if c == '+' else c for j, c in enumerate(row)] for row in diagram]


def is_edge(line):
    '''
    Check if a horizontal line is valid in the form of:
    i = corner index
    i----i----i
    '''
    return re.match(r'^\d+[-\d]*\d+$', line)


def squares(lines):
    '''
    Count the number of rectangles that can be assembled
    with n horizontal lines
    '''
    return int(lines * (lines-1)/2)


def flip(diagram):
    rotated = [''.join(r) for r in zip(*diagram)]
    return [r.replace('|', '*').replace('-', '|').replace('*', '-')
            for r in rotated]
