from collections import Counter


# Score categories
# Change the values as you see fit
YACHT = 0
ONES = 1
TWOS = 2
THREES = 3
FOURS = 4
FIVES = 5
SIXES = 6
FULL_HOUSE = 7
FOUR_OF_A_KIND = 8
LITTLE_STRAIGHT = 9
BIG_STRAIGHT = 10
CHOICE = 11
TIMES = [ONES,
         TWOS,
         THREES,
         FOURS,
         FIVES,
         SIXES]


def score(dice, category):
    if category == YACHT:
        return yacht(dice)
    elif category in TIMES:
        return times(dice, category)
    elif category == FULL_HOUSE:
        return full_house(dice)
    elif category == FOUR_OF_A_KIND:
        return four_of_a_kind(dice)
    elif category == LITTLE_STRAIGHT:
        return little(dice)
    elif category == BIG_STRAIGHT:
        return big(dice)
    return choice(dice)


def yacht(dice):
    if len(set(dice)) == 1:
        return 50
    return 0


def times(dice, n):
    return n * dice.count(n)


def full_house(dice):
    values = Counter(dice).values()
    if list(values) == [2, 3]:
        return sum(dice)
    return 0


def four_of_a_kind(dice):
    (n, count) = Counter(dice).most_common()[0]
    if count >= 4:
        return n * 4
    return 0


def little(dice):
    if sorted(dice) == [1, 2, 3, 4, 5]:
        return 30
    return 0


def big(dice):
    if sorted(dice) == [2, 3, 4, 5, 6]:
        return 30
    return 0


def choice(dice):
    return sum(dice)
