import re


def parse_markdown(markdown):
    lines = markdown.split('\n')
    result = [parse_line(line) for line in lines]
    result = ''.join(result)
    unordered_list = re.findall(r'<li>.*</li>', result)

    if unordered_list:
        return result.replace(unordered_list[0],
                              wrap(unordered_list[0], 'ul'))
    return result


def parse_line(line):
    header = re.findall(r'^#+(?=\s)', line)
    italics = re.findall(r'\b_[a-zA-Z0-9\s]+_\b', line)
    bolds = re.findall(r'\b__[a-zA-Z0-9\s]+__\b', line)
    list_item = re.match(r'^\*.*', line)
    result = line

    for italic in italics:
        result = result.replace(italic, wrap(italic[1:-1], 'em'))

    for bold in bolds:
        result = result.replace(bold, wrap(bold[2:-2], 'strong'))

    if header:
        header = len(header[0])
        return wrap(result[header+1:], f'h{header}')

    if list_item:
        return wrap(result[2:], 'li')

    return wrap(result, 'p')


def wrap(string, tag):
    return f'<{tag}>' + string + f'</{tag}>'

