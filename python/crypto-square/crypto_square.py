import re
import math


def encode(plain_text):
    if plain_text == '':
        return ''

    normalized = normalize(plain_text)
    word_size = math.ceil(len(normalized) ** 0.5)
    chunks = chunk(normalized, word_size)

    # add padding spaces for zipping
    if len(chunks[-1]) < word_size:
        chunks[-1] += (' ' * (word_size - len(chunks[-1])))

    encoded = list(zip(*chunks))
    return ' '.join([''.join(word) for word in encoded])


def normalize(text):
    return ''.join(re.findall(r'[a-z1-9]', text.lower()))


def chunk(text, size):
    return [text[i:i+size] for i in range(0, len(text), size)]
