def sieve(limit):
    candidates = list(range(2, limit+1))

    for i in range(len(candidates) - 1):
        if candidates[i]:
            for j in range(i+1, len(candidates)):
                if candidates[j] and divisible(candidates[j], candidates[i]):
                    candidates[j] = None

    return [prime for prime in candidates if prime]


def divisible(a, b):
    return a % b == 0
