BLOCKS = {
    0: 'zero',
    1: 'one',
    2: 'two',
    3: 'three',
    4: 'four',
    5: 'five',
    6: 'six',
    7: 'seven',
    8: 'eight',
    9: 'nine',
    10: 'ten',
    11: 'eleven',
    12: 'twelve',
    13: 'thirteen',
    14: 'fourteen',
    15: 'fifhteen',
    16: 'sixteen',
    17: 'seventeen',
    18: 'eighteen',
    19: 'nineteen',
    20: 'twenty',
    30: 'thirty',
    40: 'forty',
    50: 'fifty',
    60: 'sixty',
    70: 'seventy',
    80: 'eighty',
    90: 'ninety',
    100: 'hundred',
    1_000: 'thousand',
    1_000_000: 'million',
    1_000_000_000: 'billion',
    1_000_000_000_000: 'trillion',
}


def say(number):
    # too big or too small
    if number > 999_999_999_999 or number < 0:
        raise AttributeError
    # already a building block
    if number in BLOCKS and number < 100:
        return BLOCKS[number]

    parts = split(number)
    result = []

    size = len(parts)
    for i, n in enumerate(parts):
        if (n == 100 and i < size-1) or (n == 1_000_000 and i == size-2):
            result.append(number_to_word(n) + ' and')
        else:
            result.append(number_to_word(n))

    return ' '.join(result)


def split(n):
    scales = [
        1_000_000_000_000,
        1_000_000_000,
        1_000_000,
        1_000,
        100,
    ]
    result = []

    for b in scales:
        rem = n % b
        if rem < n:
            div = n // b
            n = rem
            if div > 100:
                for number in split(div):
                    result.append(number)
            else:
                result.append(div)
            result.append(b)
    if rem > 0:
        result.append(rem)

    return result


def number_to_word(n):
    if n in BLOCKS:
        return BLOCKS[n]
    elif n < 100:
        hecto = n % 10
        deca = n - hecto
        return '-'.join([BLOCKS[deca], BLOCKS[hecto]])
