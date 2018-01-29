def verse(number):
    if number > 1:
        bottle = 'bottles' if (number-1) > 1 else 'bottle'
        return (f'{number} bottles of beer on the wall, {number} bottles of beer.\n'
                 'Take one down and pass it around, '
                f'{number-1} {bottle} of beer on the wall.\n')
    elif number == 1:
        return ('1 bottle of beer on the wall, 1 bottle of beer.\n'
                'Take it down and pass it around, '
                'no more bottles of beer on the wall.\n')
    else:
        return ('No more bottles of beer on the wall, no more bottles of beer.\n'
                'Go to the store and buy some more, '
                '99 bottles of beer on the wall.\n')


def song(start, stop=0):
    return '\n'.join([verse(n) for n in range(start, stop-1, -1)]) + '\n'
