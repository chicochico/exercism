def detect_anagrams(word, candidates):
    result = []
    word_chars = sorted(list(word.lower()))

    for w in candidates:
        if (sorted(list(w.lower())) == word_chars and
            word.lower() != w.lower()):
            result.append(w)

    return result

