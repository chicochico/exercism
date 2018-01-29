from itertools import cycle


def fence_pattern(message, rails):
    rails_indexes = cycle(list(range(rails)) + list(range(rails-2, 0, -1)))
    indexed_chars = zip(rails_indexes, message)
    fence = [[] for _ in range(rails)]
    for (i, c) in indexed_chars:
        fence[i].append(c)
    return fence


def encode(message, rails):
    fence = fence_pattern(message, rails)
    return ''.join([c for rail in fence for c in rail])


def decode(encoded_message, rails):
    msg_len = len(encoded_message)
    indexes = fence_pattern(range(msg_len), rails)
    indexes = [n for row in indexes for n in row]  # flatten
    indexes = zip(indexes, range(msg_len))
    read_sequence = [i for (_, i) in sorted(indexes)]
    return ''.join([encoded_message[i] for i in read_sequence])
