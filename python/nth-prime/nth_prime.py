import math


def nth_prime(count):
    if count < 1:
        raise ValueError('Minimum of one.')

    primes = [2]
    current = 3
    while len(primes) < count:
        if is_prime(current, primes):
            primes.append(current)
            current += 2
        else:
            current += 2

    return primes[-1]


def is_prime(number, primes):
    limit = math.floor(math.sqrt(number))
    for p in primes:
        if number % p == 0:
            return False
        if p > limit:
            break
    return True
