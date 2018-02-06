from collections import Counter


ranks = {
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
    '10': 10,
    'J': 11,
    'Q': 12,
    'K': 13,
    'A': 14,
}


HIGH_CARD = 0
ONE_PAIR = 1
TWO_PAIR = 2
THREE_OF_A_KIND = 3
STRAIGHT = 4
FLUSH = 5
FULL_HOUSE = 6
FOUR_OF_A_KIND = 7
STRAIGHT_FLUSH = 8


def poker(hands):
    serialized = ((i, serialize(hand)) for i, hand in enumerate(hands))
    classified = [(i, hand, classify(hand)) for i, hand in serialized]
    winner, _, classification = max(classified, key=lambda k: k[-1])
    contenders = [contender for contender in classified if contender[-1] == classification]
    if len(contenders) > 1:
        return break_ties(contenders, classification, hands)
    return [hands[winner]]


def serialize(hand):
    hand = zip(*[(ranks[card[:-1]], card[-1]) for card in hand])
    return [sorted(element) for element in hand]


def classify(hand):
    ranks, suits = hand
    rank_count = sorted(list(Counter(ranks).values()))[::-1]

    if list(range(ranks[0], ranks[-1]+1)) == ranks:
        if len(set(suits)) == 1:
            return STRAIGHT_FLUSH
        return STRAIGHT

    if len(set(suits)) == 1:
        return FLUSH

    if rank_count[0] == 4:
        return FOUR_OF_A_KIND

    if rank_count[0] == 3 and rank_count[1] == 2:
        return FULL_HOUSE

    if rank_count[0] == 3:
        return THREE_OF_A_KIND

    if rank_count[0] == 2 and rank_count[1] == 2:
        return TWO_PAIR

    if rank_count[0] == 2:
        return ONE_PAIR

    return HIGH_CARD


def break_ties(contenders, classification, hands):
    best_hand = max(contenders, key=lambda h: h[1][0])[1][0]
    return [hands[hand[0]] for hand in contenders if hand[1][0] == best_hand]
