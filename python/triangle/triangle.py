def is_equilateral(sides):
    if not is_valid(sides): return False
    a, b, c = sides
    return a == b == c


def is_isosceles(sides):
    if not is_valid(sides): return False
    return len(set(sides)) < 3


def is_scalene(sides):
    if not is_valid(sides): return False
    a, b, c = sides
    return a != b != c


def is_valid(sides):
    a, b, c = sorted(sides)
    return (a + b >= c) and (a, b) != (0, 0)
