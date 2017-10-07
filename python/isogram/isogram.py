import re

def is_isogram(string):
    s = re.sub(r'\W+', '', string.lower())  # remove non letters, and lowercase string
    return len(set(s)) == len(s)

