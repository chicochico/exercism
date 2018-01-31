def largest_palindrome(min_factor, max_factor):
    if min_factor > max_factor:
        raise ValueError('Invalid factors.')

    # reduce the search space
    if max_factor < 10:
        factors = [(a, b) for a in range(max_factor, min_factor-1, -1)
                   for b in range(a, min_factor-1, -1)
                   if is_palindrome(a * b)]
        palindrome = max(a * b for (a, b) in factors)
        factors = {(a, b) for (a, b) in factors if a * b == palindrome}
        return (palindrome, factors)

    min_factor = int(max_factor * 0.8) if max_factor < 100 else int(max_factor * 0.9)

    for a in range(max_factor, min_factor, -1):
        for b in range(a, min_factor, -1):
            if is_palindrome(a * b):
                return (a * b, {(a, b)})

    raise ValueError('No palindrome products in range.')


def smallest_palindrome(min_factor, max_factor):
    if min_factor > max_factor:
        raise ValueError('Invalid factors.')

    for a in range(min_factor, max_factor-1):
        for b in range(a, max_factor-1):
            if is_palindrome(a * b):
                return (a * b, {(a, b)})

    raise ValueError('No palindrome products in range.')


def is_palindrome(n):
    return str(n)[::-1] == str(n)
