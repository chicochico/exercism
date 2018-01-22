def flatten(iterable):
    result = []
    for e in iterable:
        if type(e) == list:
            result += flatten(e)
        else:
            if e is not None and e is not ():
                result.append(e)
    return result
