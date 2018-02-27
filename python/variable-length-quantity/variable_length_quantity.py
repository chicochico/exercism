def encode(numbers):
    chunks = [chunk(n) for n in numbers]
    return [n for l in chunks for n in l]  # flatten


def decode(bytes_):
    split_j = [i + 1 for i, byte in enumerate(bytes_) if not (byte & 128)]
    split_i = [0] + split_j[:-1]
    indexes = zip(split_i, split_j)
    result = [join(bytes_[i:j]) for i, j in indexes]
    if not result:
        raise ValueError('Incomplete sequence.')
    return result


def chunk(number):
    bits = format(number, 'b')[::-1]
    byts = [bits[i:i+7].ljust(7, '0') for i in range(0, len(bits), 7)]
    chunks = [int(byte[::-1], 2) for byte in byts][::-1]
    return [n | 128 for n in chunks[:-1]] + [chunks[-1]]


def join(bytes_):
    chunks = [byte & 127 for byte in bytes_]
    chunks = [format(chunk, 'b').rjust(7, '0') for chunk in chunks]
    return int(''.join(chunks), 2)
