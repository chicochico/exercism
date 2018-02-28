def rebase(input_base, digits, output_base):
    if input_base < 2 or output_base < 2:
        raise ValueError('Invalid base.')
    check_number(digits, input_base)
    number = to_base_10(input_base, digits)
    return from_base_10(output_base, number)


def to_base_10(from_base, digits):
    digits = zip(digits, range(len(digits)-1, -1, -1))
    return sum(n*from_base**pos for n, pos in digits)


def from_base_10(to_base, n):
    result = []
    while n:
        result.append(n % to_base)
        n //= to_base
    return result[::-1]


def check_number(digits, base):
    for digit in digits:
        if digit < 0 or digit > base-1:
            raise ValueError('Invalid digit.')
