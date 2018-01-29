def nth_prime(count):
    primes = [2]

    if count == 1:
        return 2
    elif count < 1:
        raise ValueError('Minimum of one.')

    current = 3
    while len(primes) < count:
        for p in primes:
            if current % p == 0:
                current += 1
                break
        else:
            # if for terminates without break
            primes.append(current)
            current += 1

    return primes[-1]
