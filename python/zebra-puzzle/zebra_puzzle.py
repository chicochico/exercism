from itertools import permutations


# 1. There are five houses.
# 2. The Englishman lives in the red house.
# 3. The Spaniard owns the dog.
# 4. Coffee is drunk in the green house.
# 5. The Ukrainian drinks tea.
# 6. The green house is immediately to the right of the ivory house.
# 7. The Old Gold smoker owns snails.
# 8. Kools are smoked in the yellow house.
# 9. Milk is drunk in the middle house.
# 10. The Norwegian lives in the first house.
# 11. The man who smokes Chesterfields lives in the house next to the man with the fox.
# 12. Kools are smoked in the house next to the house where the horse is kept.
# 13. The Lucky Strike smoker drinks orange juice.
# 14. The Japanese smokes Parliaments.
# 15. The Norwegian lives next to the blue house.


HOUSES = list(range(5))
COLORS = ['blue', 'red', 'green', 'ivory', 'yellow']
NATIONALITIES = ['norwegian', 'japanese', 'englishman', 'spaniard', 'ukrainian']
PETS = ['dog', 'snail', 'fox', 'horse', 'zebra']
DRINKS = ['coffee', 'tea', 'orange_juice', 'milk', 'water']
SMOKES = ['old_gold', 'kools', 'lucky_strike', 'parliaments', 'chesterfields']


def solution():
    colors = [
        c for c in permutations(COLORS)
        if second_house_is_blue(c)  # 10, 15
        and green_ivory_right(c)  # 6
        and green_is_fourth_or_fith(c)
        and first_is_not_red(c)  # 10, 15
    ]
    nationalities = [
        n for n in permutations(NATIONALITIES)
        if norwegian_lives_in_first_house(n)  # 10
        and englishman_lives_in_red(n, colors)  # 2
        and second_is_not_spaniard(n)  # 3, 12
    ]
    drinks = [
        d for d in permutations(DRINKS)
        if milk_in_the_middle(d)  # 9
        and coffee_in_green(d, colors)  # 4
        and ukrainian_drinks_tea(d, nationalities)  # 5
        and first_is_not_orange(d)  # 13 the lucky_strike smoker drinks orange juice and first house smokes kools
        and no_tea_in_green(d, colors)  # 4
    ]
    smokes = [
        s for s in permutations(SMOKES)
        if kools_in_yellow(s)  # 8
        and japanese_smokes_parliaments(s, nationalities)  # 14
        and lucky_strike_smoker_drinks_orange(s, drinks)  # 13
    ]
    pets = [
        p for p in permutations(PETS)
        if horse_in_second_house(p)  # 8, 12
        and spaniard_owns_dog(p, nationalities)  # 3
        and old_gold_smoker_own_snail(p, smokes)  # 7
        and fox_not_in_fourth_neither_in_last(p)  # horse in second, fox is in first or third
    ]
    smokes = [
        s for s in smokes
        if second_is_not_old_gold(s)  # 7
        and parliaments_not_in_second(s)  # second house lives the ukrainian
    ]
    nationalities = [
        n for n in nationalities
        if ukrainian_in_second(n)  # 5
    ]
    # using assumption
    # if all constraints pass the solution is found
    colors = [
        c for c in colors
        if red_in_middle(c)  # assumption
    ]
    nationalities = [
        n for n in nationalities
        if englishman_lives_in_red(n, colors)
    ]
    drinks = [
        d for d in drinks
        if coffee_in_green(d, colors)
    ]
    smokes = [
        s for s in smokes
        if lucky_strike_smoker_drinks_orange(s, drinks)
        and japanese_smokes_parliaments(s, nationalities)
    ]
    nationalities = [
        n for n in nationalities
        if japanese_drinks_coffee(n, drinks)  # assumption
    ]
    pets = [
        p for p in pets
        if spaniard_owns_dog(p, nationalities)
        and old_gold_smoker_own_snail(p, smokes)
    ]

    colors = colors[0]
    nationalities = nationalities[0]
    drinks = drinks[0]
    smokes = smokes[0]
    pets = pets[0]

    return format_answer(colors, nationalities, drinks, smokes, pets)


def format_answer(colors, nationalities, drinks, smokes, pets):
    who_drinks_water = nationalities[drinks.index('water')].capitalize()
    who_owns_the_zebra = nationalities[pets.index('zebra')].capitalize()

    return (f'It is the {who_drinks_water} who drinks the water.\n'
            f'The {who_owns_the_zebra} keeps the zebra.')


def second_house_is_blue(colors):
    return colors[1] == 'blue'


def green_ivory_right(c):
    return c[c.index('green')-1] == 'ivory'


def green_is_fourth_or_fith(c):
    return c.index('green') in [3, 4]


def first_is_not_red(c):
    return c[0] != 'red'


def norwegian_lives_in_first_house(n):
    return n[0] == 'norwegian'


def englishman_lives_in_red(n, colors):
    red = set(c.index('red') for c in colors)
    return n.index('englishman') in red


def milk_in_the_middle(d):
    return d[2] == 'milk'


def coffee_in_green(d, colors):
    green = set(c.index('green') for c in colors)
    return d.index('coffee') in green


def ukrainian_drinks_tea(d, nationalities):
    ukrainian = set(n.index('ukrainian') for n in nationalities)
    return d.index('tea') in ukrainian


def no_tea_in_green(d, colors):
    green = set(c.index('green') for c in colors)
    return d.index('tea') not in green


def first_is_not_orange(d):
    return d[0] != 'orange_juice'


def kools_in_yellow(s):
    return s[0] == 'kools'


def japanese_smokes_parliaments(s, nationalities):
    japanese = set(n.index('japanese') for n in nationalities)
    return s.index('parliaments') in japanese


def lucky_strike_smoker_drinks_orange(s, drinks):
    orange = set(d.index('orange_juice') for d in drinks)
    return s.index('lucky_strike') in orange


def horse_in_second_house(p):
    return p[1] == 'horse'


def spaniard_owns_dog(p, nationalities):
    spaniard = set(n.index('spaniard') for n in nationalities)
    return p.index('dog') in spaniard


def old_gold_smoker_own_snail(p, smokes):
    old_gold = set(s.index('old_gold') for s in smokes)
    return p.index('snail') in old_gold


def fox_not_in_fourth_neither_in_last(p):
    return p[3] != 'fox' and p[-1] != 'fox'


def second_is_not_old_gold(s):
    return s[1] != 'old_gold'


def second_is_not_spaniard(n):
    return n[1] != 'spaniard'


def ukrainian_in_second(n):
    return n[1] == 'ukrainian'


def parliaments_not_in_second(s):
    return s[1] != 'parliaments'


def red_in_middle(c):
    return c[2] == 'red'


def japanese_drinks_coffee(n, drinks):
    coffee = set(d.index('coffee') for d in drinks)
    return n.index('japanese') in coffee
