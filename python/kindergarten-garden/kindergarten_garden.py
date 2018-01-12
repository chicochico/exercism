STUDENTS = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Fred',
    'Ginny',
    'Harriet',
    'Ileana',
    'Joseph',
    'Kincaid',
    'Larry'
]


class Garden(object):
    def __init__(self, diagram, students=STUDENTS):
        self.garden = {}
        students = sorted(students)
        diagram = self.process_diagram(diagram)
        for i, garden in enumerate(diagram):
            self.garden[students[i]] = garden

    def plants(self, student):
        return self.garden[student]

    def process_diagram(self, diagram):
        diagram = diagram.split()
        upper_row = [diagram[0][i:i+2] for i in range(0, len(diagram[0]), 2)]
        lower_row = [diagram[1][i:i+2] for i in range(0, len(diagram[1]), 2)]
        garden = [u+l for (u, l) in zip(upper_row, lower_row)]
        return [self.parse_garden(g) for g in garden]

    def parse_garden(self, garden):
        plants = {'G': 'Grass', 'C': 'Clover', 'R': 'Radishes', 'V': 'Violets'}
        return [plants[p] for p in garden]
