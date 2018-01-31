import re


open_bracket = {
    ']': '[',
    ')': '(',
    '}': '{',
    '>': '<',
}


def check_brackets(string):
    brackets = re.findall(r'[()[\]<>{}]', string)
    stack = []
    for bracket in brackets:
        if bracket in '[(<{':
            stack.append(bracket)
        else:
            try:
                if stack.pop() != open_bracket[bracket]:
                    return False
            except IndexError:
                return False
    return stack == []
