class Matrix(object):
    def __init__(self, matrix_string):
        self.rows = self._parse(matrix_string)
        self.columns = self._transpose(self.rows)

    def _parse(self, matrix_string):
        return [[int(n) for n in row.split()] for row in matrix_string.split('\n')]

    def _transpose(self, rows):
        return [list(col) for col in zip(*rows)]
