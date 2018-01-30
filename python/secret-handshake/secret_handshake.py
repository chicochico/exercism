ACTIONS = {
    1: 'wink',
    2: 'double blink',
    4: 'close your eyes',
    8: 'jump',
}

CODES = {
    'wink': 1,
    'double blink': 2,
    'close your eyes': 4,
    'jump': 8,
}


def handshake(code):
    actions = [ACTIONS[c] for c in ACTIONS if code & c]
    if code & 16:
        return list(reversed(actions))
    return actions


def secret_code(actions):
    code = sum([CODES[action] for action in actions])
    if len(actions) > 1:
        if (CODES[actions[0]] - CODES[actions[1]]) > 0:  # reversed?
            code += 16
    return code
