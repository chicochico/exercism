subjects = [
    'house that Jack built.',
    'malt',
    'rat',
    'cat',
    'dog',
    'cow with the crumpled horn',
    'maiden all forlorn',
    'man all tattered and torn',
    'priest all shaven and shorn',
    'rooster that crowed in the morn',
    'farmer sowing his corn',
    'horse and the hound and the horn'
]


verbs = [
    'lay in',
    'ate',
    'killed',
    'worried',
    'tossed',
    'milked',
    'kissed',
    'married',
    'woke',
    'kept',
    'belonged to'
]


def verse(verse_num):
    def build_phrase(i):
        return f'that {verbs[i]} the {subjects[i]}'
    first_verse = f'This is the {subjects[verse_num]}'
    rest = (build_phrase(i) for i in range(verse_num-1, -1, -1))
    return '\n'.join([first_verse, *rest])


def rhyme():
    return '\n\n'.join(verse(i) for i in range(12))
