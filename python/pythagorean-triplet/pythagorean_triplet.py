import itertools
import math


def primitive_triplets(number_in_triplet):
    if (number_in_triplet % 4) != 0:
        raise ValueError('Not multiple of 4.')
    limit = number_in_triplet // 2
    combinations = itertools.combinations(range(1, limit+1), 2)
    factors = [(m, n) for (n, m) in combinations if m * n == limit]
    coprimes = [(m, n) for (m, n) in factors if are_coprime(m, n)]
    return set([make_triple(m, n) for (m, n) in coprimes])


def triplets_in_range(range_start, range_end):
    combinations = itertools.combinations(range(range_start, range_end+1), 3)
    return set([triplet for triplet in combinations if is_triplet(triplet)])


def is_triplet(triplet):
    a, b, c = sorted(triplet)
    return a**2 + b**2 == c**2


def are_coprime(a, b):
    return math.gcd(a, b) == 1


def make_triple(m, n):
    return tuple(sorted((m**2-n**2, 2*m*n, m**2+n**2)))
