def sieve(limit):
    candidates = list(range(2, limit+1))
    limit = len(candidates)

    for i in range(limit - 1):
        current_prime = candidates[i]
        if current_prime:
            for j in range(i+1, limit):
                if candidates[j] and divisible(candidates[j], current_prime):
                    candidates[j] = False

    # remove the elements marked as not prime
    return [prime for prime in candidates if prime]


def divisible(a, b):
    return a % b == 0
