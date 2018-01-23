def prime_factors(n):
    result = []
    f = 2  # starting factor

    while n != 1:
        while (n % f) == 0:
            result.append(f)
            n = n // f
        f += 1

    return result
