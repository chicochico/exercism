SUBLIST = 0
SUPERLIST = 1
EQUAL = 2
UNEQUAL = 3


def check_lists(l1, l2):
    l1 = str(l1).replace('[', '').replace(']', '')
    l2 = str(l2).replace('[', '').replace(']', '')

    if l1 == l2:
        return EQUAL
    elif l1 in l2:
        return SUBLIST
    elif l2 in l1:
        return SUPERLIST
    return UNEQUAL
