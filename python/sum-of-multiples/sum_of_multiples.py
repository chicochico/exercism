def sum_of_multiples(limit, multiples):
    multiples = [n for n in range(1, limit) if is_multiple_of(n, multiples)]
    return sum(multiples)


def is_multiple_of(n, multiples):
    for m in multiples:
        if n % m  == 0:
            return True
    return False
