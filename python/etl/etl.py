def transform(legacy_data):
    result = {}
    for score in legacy_data:
        for letter in legacy_data[score]:
            result[letter.lower()] = score
    return result
