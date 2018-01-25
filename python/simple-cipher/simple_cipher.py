import secrets
import itertools
import re


class Cipher(object):
    def __init__(self, key=None):
        if key:
            self.key = key
            self._check_key(key)
        else:
            self.key = self._generate_key()

    def encode(self, text):
        encoded = zip(itertools.cycle(self.key), text)
        return ''.join([self._shift(char) for char in encoded])

    def decode(self, text):
        encoded = zip(itertools.cycle(self.key), text)
        return ''.join([self._shift(char, False) for char in encoded])

    def _shift(self, char, forward=True):
        (amount, char) = char
        amount = ord(amount) - 97
        char = ord(char) - 97

        if forward:
            return chr(((char + amount) % 26) + 97)
        else:
            return chr(((char - amount + 26) % 26) + 97)

    def _generate_key(self, length=100):
        letters = 'abcdefghijklmnopqrstuvwxyz'
        return ''.join(secrets.choice(letters) for _ in range(length))

    def _check_key(self, key):
        if re.search(r'[^a-z]', key):
            raise ValueError('Invalid characters in key use only lowercase letters')



class Caesar(object):

    def encode(self, text):
        text = re.findall(r'[a-z]', text.lower())
        return ''.join([self._shift(c) for c in text])

    def decode(self, text):
        text = re.findall(r'[a-z]', text.lower())
        return ''.join([self._shift(c, -3) for c in text])

    def _shift(self, char, amount=3):
        char = ord(char) - 97
        return chr(((char + amount) % 26) + 97)
