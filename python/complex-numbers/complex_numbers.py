from math import sqrt, cos, sin, exp


class ComplexNumber(object):
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __eq__(self, other):
        eq_real = (self.real == other.real)
        eq_imaginary = (self.imaginary == other.imaginary)
        return eq_real == eq_imaginary

    def __add__(self, other):
        real = (self.real + other.real)
        imaginary = (self.imaginary + other.imaginary)
        return ComplexNumber(real, imaginary)

    def __mul__(self, other):
        real = (self.real * other.real) - (self.imaginary * other.imaginary)
        imaginary = (self.imaginary * other.real) + (self.real * other.imaginary)
        return ComplexNumber(real, imaginary)

    def __sub__(self, other):
        real = (self.real - other.real)
        imaginary = (self.imaginary - other.imaginary)
        return ComplexNumber(real, imaginary)

    def __truediv__(self, other):
        divisor = (other.real ** 2 + other.imaginary ** 2)
        real = ((self.real * other.real) + (self.imaginary * other.imaginary)) / divisor
        imaginary = ((self.imaginary * other.real) - (self.real * other.imaginary)) / divisor
        return ComplexNumber(real, imaginary)

    def __abs__(self):
        real = self.real ** 2
        imaginary = self.imaginary ** 2
        return sqrt(real + imaginary)

    def conjugate(self):
        return ComplexNumber(self.real, -1 * self.imaginary)

    def exp(self):
        real = exp(self.real) * cos(self.imaginary)
        imaginary = round(exp(self.real) * sin(self.imaginary))
        return ComplexNumber(real, imaginary)

    def __repr__(self):
        return f'{self.real} + {self.imaginary} * i'
