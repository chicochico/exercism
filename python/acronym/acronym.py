import re


def abbreviate(words):
    acronym = re.findall(r'[A-Z]+', words.title())
    return ''.join(acronym)
