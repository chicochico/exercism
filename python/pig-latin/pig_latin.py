def translate(text):
    return ' '.join([translate_word(word) for word in text.split()])


def translate_word(word):
    vowels = ['a', 'e', 'i', 'o', 'u', 'xr', 'yt']
    consonants = ['ch', 'qu', 'rh', 'th', 'squ', 'thr', 'sch']

    if word[0] in vowels or word[:2] in vowels:
        return word + 'ay'
    elif word[:3] in consonants:
        return word[3:] + word[:3] + 'ay'
    elif word[:2] in consonants:
        return word[2:] + word[:2] + 'ay'
    else:
        return word[1:] + word[0] + 'ay'
