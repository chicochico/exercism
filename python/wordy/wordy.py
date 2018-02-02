import re


operation = {
    'plus': lambda a, b: a + b,
    'minus': lambda a, b: a - b,
    'multiplied': lambda a, b: a * b,
    'divided': lambda a, b: a / b,
}


def calculate(question):
    operands = re.findall(r'-*\d+', question)
    operands = list(reversed([int(n) for n in operands]))
    operations = re.findall(r'plus|minus|multiplied|divided', question)
    try:
        result = operation[operations[0]](operands.pop(), operands.pop())
        for op in operations[1:]:
            result = operation[op](result, operands.pop())
        if len(operands) > 0:
            raise ValueError('Invalid question.')
        return result
    except IndexError:
        raise ValueError('Invalid question.')
