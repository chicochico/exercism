class Tree():
    def __init__(self, value=None, left=None, right=None, parent=None):
        self.value = value
        self.left = Tree.from_tree_dict(left, parent=self)
        self.right = Tree.from_tree_dict(right, parent=self)
        self.parent = parent

    @staticmethod
    def from_tree_dict(tree, parent=None):
        if tree:
            node = Tree(tree['value'],
                        tree['left'],
                        tree['right'],
                        parent)
            return node

    @staticmethod
    def to_dict(root, tree={}):
        if root:
            return {'value': root.value,
                    'left': Tree.to_dict(root.left),
                    'right': Tree.to_dict(root.right)}


class Zipper(object):
    def __init__(self, focus=None):
        self.focus = focus

    @staticmethod
    def from_tree(tree):
        tree = Tree.from_tree_dict(tree)
        return Zipper(tree)

    def value(self):
        return self.focus.value

    def set_value(self, val):
        self.focus.value = val
        return self

    def left(self):
        if self.focus.left:
            self.focus = self.focus.left
            return self

    def set_left(self, val):
        if val:
            if self.focus.left:
                self.focus.left.value = val['value']
            else:
                self.focus.left = Tree(val['value'], parent=self.focus)
        else:
            self.focus.left = val
        return self

    def right(self):
        if self.focus.right:
            self.focus = self.focus.right
            return self

    def set_right(self, val):
        if val:
            if self.focus.right:
                self.focus.right.value = val['value']
            else:
                self.focus.right = Tree(val['value'], parent=self.focus)
        else:
            self.focus.right = val
        return self

    def up(self):
        if self.focus.parent:
            self.focus = self.focus.parent
            return self

    def root(self):
        while self.focus.parent:
            self.focus = self.focus.parent
        return self

    def to_tree(self):
        self.root()
        return Tree.to_dict(self.focus)
