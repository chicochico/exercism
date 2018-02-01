def board(white_position, black_position):
    check_positions(white_position, black_position)
    wi, wj = white_position
    bi, bj = black_position
    game_board = [['_' for _ in range(8)] for _ in range(8)]
    game_board[wi][wj] = 'W'
    game_board[bi][bj] = 'B'
    return [''.join(row) for row in game_board]


def can_attack(white_position, black_position):
    check_positions(white_position, black_position)
    wi, wj = white_position
    bi, bj = black_position
    if (wi == bi or wj == bj or  # same column
            abs(wi-bi) == abs(wj-bj)):  # same diagonal
        return True
    return False


def check_positions(white, black):
    if white == black:
        raise ValueError('Cant be in the same position.')

    wi, wj = white
    bi, bj = black

    if not (0 <= wi <= 7 and 0 <= wj <= 7):
        raise ValueError('Invalid position.')

    if not (0 <= bi <= 7 and 0 <= bj <= 7):
        raise ValueError('Invalid position.')
