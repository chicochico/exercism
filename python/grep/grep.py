def grep(pattern, files, flags=''):
    flags = process_flags(flags)
    files = read_files(files)
    result = {}
    for f in files:
        result[f] = filter_lines(pattern, f, files[f], flags)
    return format(result, flags)


def process_flags(flags):
    return {
        'n': 'n' in flags,
        'l': 'l' in flags,
        'i': 'i' in flags,
        'v': 'v' in flags,
        'x': 'x' in flags,
    }


def filter_lines(pattern, filename, lines, flags):
    return [line for line in lines if match(pattern, line, flags)]


def match(pattern, line, flags):
    line = line[1].rstrip('\n')
    if flags['i'] and flags['x']:
        match = pattern.lower() == line.lower()
    elif flags['x']:
        match = pattern == line
    elif flags['i']:
        match = pattern.lower() in line.lower()
    else:
        match = pattern in line
    return match ^ flags['v']


def format(result, flags):
    if flags['l'] and not flags['n']:
        return '\n'.join(filename for filename in result.keys()
                         if result[filename]) + '\n'
    for filename in result:
        result[filename] = [f'{lineno}:{line}' if flags['n']
                            else line
                            for lineno, line in result[filename]]
    if flags['l'] or len(result) > 2:
        for filename in result:
            result[filename] = [f'{filename}:{line}' for line in result[filename]]
    output = ''
    for filename in result:
        output += ''.join(line for line in result[filename])
    return output


def read_files(files):
    result = {}
    for f in files:
        result[f] = enumerate(open(f).readlines(), start=1)
    return result
