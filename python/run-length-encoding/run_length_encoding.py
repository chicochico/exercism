import re


def decode(string):
    word_count = re.findall(r'\d+[a-zA-Z\s]|[a-zA-Z\s]', string)
    result = ''

    for count in word_count:
        char_count = re.findall(r'\d+|[a-zA-Z\s]', count)
        if len(char_count) > 1:
            result += int(char_count[0]) * char_count[1]
        else:
            result += char_count[0]

    return result


def encode(string):
    if not string: return ''

    words = split_repeating_characters(string)
    result = ''

    for word in words:
        if len(word) > 1:
            result += str(len(word)) + word[0]
        else:
            result += word[0]

    return result


def split_repeating_characters(string):
    count = []
    word = string[0]

    for i in range(1, len(string)):
        if string[i] == word[-1]:
            word += string[i]
        else:
            count.append(word)
            word = string[i]

    count.append(word)

    return count
