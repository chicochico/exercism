def on_square(integer_number):
    if integer_number < 1 or integer_number > 64:
        raise ValueError('Squares are between 1 and 64 (inclusive)')

    return pow(2, integer_number-1)


def total_after(integer_number):
    if integer_number < 1 or integer_number > 64:
        raise ValueError('Squares are between 1 and 64 (inclusive)')

    return sum([on_square(n) for n in range(1, integer_number+1)])
