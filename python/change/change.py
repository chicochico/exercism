from math import inf


def find_minimum_coins(change, coins):
    if change < 0:
        raise ValueError('Invalid change.')

    coin_count = [0] + [inf] * change
    coin_used = [0] + [inf] * change

    for i in range(1, change+1):
        counts = [(coin_count[i-coin] + 1, coin)
                  for coin in coins
                  if coin <= i]

        try:
            count = min(counts, key=lambda c: c[0])
        except ValueError:
            continue

        coin_count[i] = count[0]
        coin_used[i] = count[1]

    try:
        return list(extract_coins(coin_used))
    except TypeError:
        raise ValueError('Cannot make change.')


def extract_coins(coins):
    coins = coins[::-1]
    i = 0
    coin = coins[i]
    while coin:
        yield coin
        i += coin
        coin = coins[i]
