from functools import reduce


def largest_product(series, size):
    if len(series) < size or size < 0:
        raise ValueError
    elif size == 0 or len(series) == 0:
        return 1

    series = [int(n) for n in series]
    chunks = chunk(series, size)
    products = [list_product(l) for l in chunks]
    return max(products)


def chunk(iterable, size, step=1):
    """
    Chunks a iterable
    """
    stop = len(iterable) - size + 1
    chunks = [iterable[i:i+size] for i in range(0, stop, step)]
    return chunks


def list_product(iterable):
    """
    Takes a list of integers an multiply the elements
    """
    return reduce(lambda a, b: a * b, iterable)
