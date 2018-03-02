import re
from itertools import permutations


def solve(puzzle):
    letters = ''.join(set(re.findall('\w', puzzle)))
    perms = permutations('0123456789', len(letters))
    first_digits = re.findall(r'\b\w', puzzle)
    first_digits_index = [letters.index(digit) for digit in first_digits]

    # brute force
    for perm in perms:
        if '0' in [perm[i] for i in first_digits_index]:
            continue
        table = str.maketrans(letters, ''.join(perm))
        if is_solution(puzzle.translate(table)):
            return dict(zip(letters, [int(n) for n in perm]))
    return {}


def is_solution(puzzle):
    eq = [int(n) for n in puzzle.split() if str.isnumeric(n)]
    return sum(eq[:-1]) == eq[-1]
