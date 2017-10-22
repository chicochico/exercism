def square_of_sum(rng):
    return sum(n for n in range(1, rng+1)) ** 2


def sum_of_squares(rng):
    return sum(n*n for n in range(1, rng+1))


def difference(rng):
    return square_of_sum(rng) - sum_of_squares(rng)
