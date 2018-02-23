from collections import Counter


price = {
    1: 8,
    2: 15.2,
    3: 21.6,
    4: 25.6,
    5: 30,
}


def calculate_total(books):
    return min(package5(books), package4(books))


def package5(books):
    '''
    Price including all discount packages
    '''
    cart = Counter(books)
    total = 0
    for i in range(5, 0, -1):
        while len(cart) >= i:
            total += price[i]
            cart -= Counter(list(cart.keys())[:i])
    return total


def package4(books):
    '''
    Price including only packages below 5 different books
    '''
    cart = Counter(books)
    total = 0
    while len(cart) >= 4:
        total += price[4]
        cart -= Counter(list(cart.keys())[:4])
    return total + package5(cart.elements())
