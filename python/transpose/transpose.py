from itertools import zip_longest


def transpose(input_lines):
    zipped = zip_longest(*input_lines.split('\n'), fillvalue='$')
    zipped = [''.join(row).rstrip('$').replace('$', ' ') for row in zipped]
    return '\n'.join(zipped)
