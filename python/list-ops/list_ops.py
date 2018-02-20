def append(xs, ys):
    return concat([xs, ys])


def concat(lists):
    return [e for l in lists for e in l]


def filter_clone(function, xs):
    return [e for e in xs if function(e)]


def length(xs):
    return foldl(lambda a, b: a + b, [1 for e in xs], 0)


def map_clone(function, xs):
    return [function(e) for e in xs]


def foldl(function, xs, acc):
    for e in xs:
        acc = function(acc, e)
    return acc


def foldr(function, xs, acc):
    for e in reverse(xs):
        acc = function(e, acc)
    return acc


def reverse(xs):
    return xs[::-1]
