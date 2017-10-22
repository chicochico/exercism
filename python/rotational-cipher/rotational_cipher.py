def rotate(text, key):
    result = ''
    for c in text:
        result += shift_char(c, key)
    return result

def shift_char(c, shift):
    c = ord(c)
    if c >= 65 and c <= 90:
        return chr((c-65+shift)%26 + 65)
    elif c >= 97 and c <= 122:
        return chr((c-97+shift)%26 + 97)
    else:
        return chr(c)

