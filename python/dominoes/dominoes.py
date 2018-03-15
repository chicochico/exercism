def chain(dominoes):
    return search_chain(tuple(dominoes))


def search_chain(dominoes, path=()):
    # if dominoes set is empty
    # they have been chained
    if not dominoes:
        if not path:
            return ()
        elif chain_ends_match(path):
            return path

    # go thru each avaliable domino trying to connect
    for i, domino in enumerate(dominoes):
        # remove the current domino from unused list
        unused = dominoes[:i] + dominoes[i+1:]
        try:
            prev_domino = path[-1]
            connected = connect(prev_domino, domino)
            if connected:
                search_result = search_chain(unused, path + (connected,))
                if search_result:
                    return search_result
        except IndexError:
            search_left = search_chain(unused, (domino,))
            if search_left:
                return search_left
            search_right = search_chain(unused, (flip(domino),))
            if search_right:
                return search_right


def flip(domino):
    return domino[::-1]


def connect(d1, d2):
    '''
    Can d2 connect to d1?
    in which position?
    '''
    if d1[1] == d2[0]:
        return d2
    elif d1[1] == d2[1]:
        return flip(d2)


def chain_ends_match(chain):
    return chain[0][0] == chain[-1][-1]
