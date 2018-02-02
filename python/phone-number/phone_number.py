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
        number = ''.join(filter(str.isdigit, number))

        if (not 9 < len(number) < 12 or
                len(number) == 11 and number[0] != '1' or
                int(number[-10]) < 2 or
                int(number[-7]) < 2):

            raise ValueError('Invalid number.')

        area_code = number[-10:-7]
        exchange_code = number[-7:-4]
        unique = number[-4:]
        return area_code, exchange_code, unique
