def collatz_steps(n):
    if n < 1:
        raise ValueError('Invalid number.')
    return sum(count(n))


def count(n):
    while n > 1:
        if n % 2 == 0:
            n //= 2
        else:
            n = (3 * n) + 1
        yield 1
