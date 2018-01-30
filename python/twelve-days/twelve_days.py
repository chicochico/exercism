DAYS = [
    'first',
    'second',
    'third',
    'fourth',
    'fifth',
    'sixth',
    'seventh',
    'eighth',
    'ninth',
    'tenth',
    'eleventh',
    'twelfth',
]

PRESENTS = [
    'a Partridge in a Pear Tree',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming'
]


def verse(day_number):
    first_verse = f'On the {DAYS[day_number-1]} day of Christmas my true love gave to me'
    presents = [PRESENTS[n] for n in range(day_number-1, 0, -1)]
    first_present = f'and {PRESENTS[0]}' if day_number > 1 else PRESENTS[0]
    return ', '.join([first_verse, *presents, first_present]) + '.\n'


def verses(start, end):
    return '\n'.join([verse(day) for day in range(start, end+1)]) + '\n'


def sing():
    return verses(1, 12)
