from __future__ import division


class Rational(object):
    def __init__(self, numer, denom):
        self.numer = numer
        self.denom = denom
        self._simplify()

    def __eq__(self, other):
        return self.numer == other.numer and self.denom == other.denom

    def __repr__(self):
        return '{}/{}'.format(self.numer, self.denom)

    def __add__(self, other):
        num = self.numer * other.denom + other.numer * self.denom
        den = self.denom * other.denom
        return Rational(num, den)

    def __sub__(self, other):
        num = self.numer * other.denom - other.numer * self.denom
        den = self.denom * other.denom
        return Rational(num, den)

    def __mul__(self, other):
        num = self.numer * other.numer
        den = self.denom * other.denom
        return Rational(num, den)

    def __truediv__(self, other):
        num = self.numer * other.denom
        den = other.numer * self.denom
        return Rational(num, den)

    def __abs__(self):
        return Rational(abs(self.numer), abs(self.denom))

    def __pow__(self, power):
        power = abs(power)
        num = self.numer ** power
        den = self.denom ** power
        return Rational(num, den)

    def __rpow__(self, base):
        return (base ** self.numer) ** (1/self.denom)

    def _gcd(self, a, b):
        if 0 in [a, b]:
            return max(a, b)
        a = abs(a)
        b = abs(b)
        for n in range(min(a, b), 0, -1):
            if (a % n == 0) and (b % n) == 0:
                return n
        return 1

    def _simplify(self):
        gcd = self._gcd(self.numer, self.denom)
        num = self.numer // gcd
        den = self.denom // gcd
        self.numer = -num if (num * den < 0) and (num > 0) else num
        self.denom = abs(den)
        if (num < 0) and (den < 0):
            self.numer = abs(num)
