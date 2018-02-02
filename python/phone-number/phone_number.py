import re


class Phone(object):
    def __init__(self, phone_number):
        (self.area_code,
         self.exchange_code,
         self.unique) = self.parse(phone_number)

    @property
    def number(self):
        return self.area_code + self.exchange_code + self.unique

    def pretty(self):
        return f'({self.area_code}) {self.exchange_code}-{self.unique}'

    def parse(self, number):
        number = re.findall(r'\d', number)
        country_code = '1'
        if not 9 < len(number) < 12:
            raise ValueError('Invalid number.')
        if len(number) == 11:
            country_code = number[0]
            number = number[1:]
        area_code = ''.join(number[:3])
        exchange_code = ''.join(number[3:6])
        unique = ''.join(number[6:])
        if (int(area_code[0]) < 2 or
                int(exchange_code[0]) < 2 or
                country_code != '1'):
            raise ValueError('Invalid number.')
        return area_code, exchange_code, unique
