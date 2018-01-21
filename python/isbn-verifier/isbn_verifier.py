def verify(isbn):
    isbn = isbn.replace('-', '')

    if len(isbn) != 10:
        return False

    try:
        isbn = [10 if n == 'X' else int(n) for n in list(isbn)]

        if 10 in isbn and isbn[-1] != 10:
            return False

        check_numbers = list(zip(isbn, list(range(10, 0, -1))))
        check = [n[0] * n[1] for n in check_numbers]
        return (sum(check) % 11) == 0
    except ValueError:
        return False
