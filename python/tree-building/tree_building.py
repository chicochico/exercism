class Record():
    def __init__(self, record_id, parent_id):
        self.record_id = record_id
        self.parent_id = parent_id


class Node():
    def __init__(self, node_id, parent_id):
        if node_id <= parent_id != 0:
            raise ValueError('Invalid tree.')
        self.node_id = node_id
        self.parent_id = parent_id
        self.children = []


def BuildTree(records):
    records.sort(key=lambda r: r.record_id)

    try:
        if records[-1].record_id != len(records) - 1:
            raise ValueError('Invalid tree.')
    except IndexError:
        return None

    tree = [Node(r.record_id, r.parent_id) for r in records]
    for child in tree[1:]:
        parent = tree[child.parent_id]
        parent.children.append(child)
    return tree[0]
