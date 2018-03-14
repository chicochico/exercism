from copy import deepcopy


class Zipper(object):
    @staticmethod
    def from_tree(tree):
        return Zipper(deepcopy(tree), [])  # make a copy

    def __init__(self, tree, ancestors):
        self.focus = tree
        self.ancestors = ancestors

    def value(self):
        return self.focus['value']

    def set_value(self, val):
        self.focus['value'] = val
        return self

    def left(self):
        if self.focus['left']:
            self.ancestors.append(self.focus)
            return Zipper(self.focus['left'], self.ancestors)

    def set_left(self, val):
        self.focus['left'] = val
        return self

    def right(self):
        if self.focus['right']:
            self.ancestors.append(self.focus)
            return Zipper(self.focus['right'], self.ancestors)

    def set_right(self, val):
        self.focus['right'] = val
        return self

    def up(self):
        if self.ancestors:
            return Zipper(self.ancestors.pop(), self.ancestors)

    def to_tree(self):
        if self.ancestors:
            return self.ancestors[0]
        return self.focus
