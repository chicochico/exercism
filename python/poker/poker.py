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
    ranked = [rank_hand(hand) for hand in hands]
    highest_rank = get_highest_rank(ranked)
    contenders = [hand for hand in ranked if hand['rank'] == highest_rank]
    if len(contenders) > 1:
        return break_ties(contenders, highest_rank)
    return [contenders[0]['hand']]


def break_ties(contenders, rank):
    if rank == HIGH_CARD:
        contenders = best_by('card_ranks', contenders)
    elif rank == TWO_PAIR:
        contenders = best_by('high_pair', contenders)
        contenders = best_by('low_pair', contenders)
        contenders = best_by('kicker', contenders)
    else:
        contenders = best_by('card_ranks', contenders)
    return [h['hand'] for h in contenders]


def best_by(attribute, hands):
    best = max(hands, key=lambda hand: hand[attribute])[attribute]
    return [h for h in hands if h[attribute] == best]


def get_highest_rank(ranked):
    return max(ranked, key=lambda hand: hand['rank'])['rank']


def serialize(hand):
    hand = zip(*[(ranks[card[:-1]], card[-1]) for card in hand])
    return [sorted(element) for element in hand]


def rank_hand(hand):
    ranks, suits = serialize(hand)
    hand = {'hand': hand, 'card_ranks': ranks}
    counter = Counter(ranks)
    rank_count = sorted(list(counter.values()))[::-1]
    most_common = counter.most_common()
    if is_straight(ranks):
        if len(set(suits)) == 1:
            hand['rank'] = STRAIGHT_FLUSH
        else:
            hand['rank'] = STRAIGHT
        if 2 and 14 in ranks:  # ace starts straight
            hand['card_ranks'] = list(range(1, 6))  # ace value is 1
    elif len(set(suits)) == 1:
        hand['rank'] = FLUSH
    elif rank_count[0] == 4:
        hand['rank'] = FOUR_OF_A_KIND
        hand['quadruple'] = most_common[0][0]
    elif rank_count[:2] == [3, 2]:
        hand['rank'] = FULL_HOUSE
        hand['triple'] = most_common[0][0]
    elif rank_count[0] == 3:
        hand['rank'] = THREE_OF_A_KIND
        hand['triple'] = most_common[0][0]
    elif rank_count[:2] == [2, 2]:
        hand['rank'] = TWO_PAIR
        hand['high_pair'] = max(most_common[:2])[0]
        hand['low_pair'] = min(most_common[:2])[0]
        hand['kicker'] = most_common[2][0]
    elif rank_count[0] == 2:
        hand['rank'] = ONE_PAIR
        hand['pair'] = most_common[0][0]
        hand['kickers'] = [r for (r, _) in most_common[1:]]
    else:
        hand['rank'] = HIGH_CARD
    return hand


def is_straight(ranks):
    if 14 in ranks:
        if [2, 3, 4, 5, 14] == ranks:
            return True
    straight = list(range(ranks[0], ranks[-1]+1))
    return straight == ranks
