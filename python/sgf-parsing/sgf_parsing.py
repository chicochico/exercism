import re


class SgfTree(object):
    def __init__(self, properties={}, children=[]):
        self.properties = properties
        self.children = children

    def __eq__(self, other):
        if not isinstance(other, SgfTree):
            return False
        for k, v in self.properties.items():
            if k not in other.properties:
                return False
            if other.properties[k] != v:
                return False
        for k in other.properties.keys():
            if k not in self.properties:
                return False
        if len(self.children) != len(other.children):
            return False
        for a, b in zip(self.children, other.children):
            if a != b:
                return False
        return True


def parse(input_str):
    if input_str == '(;)':
        return SgfTree()

    input_str = escape_characters(input_str)
    nodes = split_nodes(input_str)
    return build_tree(nodes)


def split_nodes(input_str):
    tokens = re.split(r'(\(|\)|;)', input_str)
    tokens = [node for node in tokens if node not in ['', '(', ')', ';']]
    return [make_node(token) for token in tokens]


def build_tree(nodes):
    try:
        root = nodes[0]
        if len(nodes) > 1:
            root.children = nodes[1:]
        return root
    except IndexError:
        raise ValueError('Invalid input string!')


def make_node(str_slice):
    key = re.match(r'([A-Z]+)(?=\[)', str_slice)

    if key:
        vals = str_slice[key.end()+1:-1].split('][')
        return SgfTree({key.group(0): vals})

    raise ValueError('Invalid SGF string!')


def escape_characters(input_str):
    return (input_str.replace('\[', '[')
            .replace('\]', ']')
            .replace('\n', ' ')
            .replace('\t', ' '))
