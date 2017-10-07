import re
from collections import Counter

def word_count(phrase):
    phrase = re.sub('\W+|_', ' ', phrase.lower())
    word_list = phrase.split()

    return dict(Counter(word_list))

