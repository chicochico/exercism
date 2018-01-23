import re


class Luhn(object):
    def __init__(self, card_num):
        self.number = card_num

    def is_valid(self):
        digits = [int(n) for n in re.findall(r'\d', self.number)][::-1]

        if re.findall(r'[^0-9\s]', self.number):
            return False
        elif len(digits) < 2:
            return False

        check_digits = [n * 2 for n in digits[1::2]]
        check_digits = [n - 9 if n > 9 else n for n in check_digits]
        digits = [n for n in digits[::2]]

        return ((sum(digits) + sum(check_digits)) % 10) == 0
