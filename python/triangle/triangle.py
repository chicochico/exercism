def is_equilateral(sides):
    a, b, c = sides
    return is_valid(sides) and (a == b == c)


def is_isosceles(sides):
    return is_valid(sides) and (len(set(sides)) < 3)


def is_scalene(sides):
    a, b, c = sides
    return is_valid(sides) and (a != b != c)


def is_valid(sides):
    a, b, c = sorted(sides)
    return (a + b >= c) and (a, b) != (0, 0)
