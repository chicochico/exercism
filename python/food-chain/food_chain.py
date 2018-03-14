creatures = ['fly',
             'spider',
             'bird',
             'cat',
             'dog',
             'goat',
             'cow',
             'horse']

remarks = ["",
           "It wriggled and jiggled and tickled inside her.",
           "How absurd to swallow a bird!",
           "Imagine that, to swallow a cat!",
           "What a hog, to swallow a dog!",
           "Just opened her throat and swallowed a goat!",
           "I don't know how she swallowed a cow!",
           "She's dead, of course!"]


def recite(start_verse, end_verse):
    return '\n\n'.join(verse(n) for n in range(start_verse, end_verse+1))


def verse(n):
    if not 1 <= n <= 8:
        raise ValueError('Invalid verse.')
    n -= 1
    lines = []
    lines.append(f"I know an old lady who swallowed a {creatures[n]}.")
    if n > 0:
        lines.append(remarks[n])
    if n == 7:
        return '\n'.join(lines)
    elif n > 0:
        for i in range(n, 0, -1):
            if n > 1 and i == 2:
                lines.append(f"She swallowed the {creatures[i]} "
                             f"to catch the {creatures[i-1]} "
                              "that wriggled and jiggled and tickled inside her.")
            else:
                lines.append(f"She swallowed the {creatures[i]} "
                             f"to catch the {creatures[i-1]}.")
    lines.append("I don't know why she swallowed the fly. Perhaps she'll die.")
    return '\n'.join(lines)
