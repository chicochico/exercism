from textwrap import wrap
from string import punctuation

CODE = {
    'a': 'z',
    'b': 'y',
    'c': 'x',
    'd': 'w',
    'e': 'v',
    'f': 'u',
    'g': 't',
    'h': 's',
    'i': 'r',
    'j': 'q',
    'k': 'p',
    'l': 'o',
    'm': 'n',
    'n': 'm',
    'o': 'l',
    'p': 'k',
    'q': 'j',
    'r': 'i',
    's': 'h',
    't': 'g',
    'u': 'f',
    'v': 'e',
    'w': 'd',
    'x': 'c',
    'y': 'b',
    'z': 'a',
}


def encode(plain_text):
    plain_text = plain_text.lower()
    stripped = ''.join(c for c in plain_text if c not in punctuation)
    stripped = stripped.replace(' ', '')

    result = ''
    for c in stripped:
        if c in CODE:
            result += CODE[c]
        else:
            result += c

    return ' '.join(wrap(result, 5))


def decode(ciphered_text):
    return encode(ciphered_text).replace(' ', '')
