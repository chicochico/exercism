NUMERALS = {
    1000: 'M',
    900: 'CM',
    500: 'D',
    400: 'CD',
    100: 'C',
    90: 'XC',
    50: 'L',
    40: 'XL',
    10: 'X',
    9: 'IX',
    8: 'VIII',
    7: 'VII',
    6: 'VI',
    5: 'V',
    4: 'IV',
    3: 'III',
    2: 'II',
    1: 'I',
}


def numeral(number):
    result = []
    while number > 0:
        for n in NUMERALS:
            if number >= n:
                result.append(NUMERALS[n] * (number // n))
                number = number % n
    return ''.join(result)
