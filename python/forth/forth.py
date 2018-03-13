import re
from collections import deque


class StackUnderflowError(Exception):
    pass


def evaluate(input_data):
    ops = {
        '*': lambda a, b: (a * b,),
        '/': lambda a, b: (a // b,),  # integer division
        '+': lambda a, b: (a + b,),
        '-': lambda a, b: (a - b,),
        'dup': lambda a: (a, a),
        'swap': lambda a, b: (b, a),
        'over': lambda a, b: (a, b, a),
        'drop': lambda _: (),
    }

    binary_ops = ['*', '/', '+', '-', 'swap', 'over']

    tokens = redefine(input_data)
    stack = deque()

    try:
        for token in tokens:
            if token in ops:
                right_op = stack.pop()
                if token in binary_ops:
                    left_op = stack.pop()
                    result = ops[token](left_op, right_op)
                else:
                    result = ops[token](right_op)
                for r in result:
                    stack.append(r)
            elif type(token) is int:
                stack.append(token)
            else:
                raise ValueError('Invalid operator.')
    except IndexError:
        raise StackUnderflowError('Empty stack.')

    return list(stack)


def redefine(input_data):
    '''
    Perform substitution of operators by redefinitions
    '''
    definitions = {}
    statements = ''.join(s for s in input_data if not re.match(r':.+;', s)).lower()
    redefinitions = [s for s in input_data if re.match(r':.+;', s)]

    for redefinition in redefinitions:
        redefinition = redefinition[1:-1].lower().split()
        operation = redefinition[0]
        # cannot redefine numbers
        if operation.isnumeric():
            raise ValueError('Cannot redefine numbers')
        definition = ' '.join(redefinition[1:])
        definitions[operation] = definition

    for op, definition in definitions.items():
        statements = statements.replace(op, definition)

    return [int(token) if re.match(r'\d+', token) else token
            for token in statements.lower().split()]


