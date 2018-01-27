SUBLIST = 'sublist'
SUPERLIST = 'superlist'
EQUAL = 'equal'
UNEQUAL = 'unequal'


def check_lists(first_list, second_list):
    if first_list == second_list:
        return EQUAL
    elif first_list == []:
        return SUBLIST
    elif second_list == []:
        return SUPERLIST
    elif contains(second_list, first_list):
        return SUBLIST
    elif contains(first_list, second_list):
        return SUPERLIST
    else:
        return UNEQUAL


def contains(l1, l2):
    try:
        # starting element of l2
        start_element = l2[0]
        while len(l1) > len(l2):
            # index if starting element in l1
            index = l1.index(start_element)
            l1_slice = l1[index:index+len(l2)]
            if l1_slice == l2:
                return True
            # slice l1 to remove not matching part
            l1 = l1[l1.index(start_element)+1:]
    except (ValueError, IndexError):
        return False
