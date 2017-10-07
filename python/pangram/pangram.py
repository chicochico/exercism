import re

def is_pangram(s):
    s = re.sub('\W+|\d+', '', s.lower())  # remove non letters
    return len(set(s)) >= 26
