class School(object):
    def __init__(self, name):
        self.name = name
        self.grades = {}

    def add(self, student_name, grade):
        try:
            self.grades[grade].append(student_name)
        except KeyError:
            self.grades[grade] = [student_name]

    def grade(self, grade):
        try:
            return self.grades[grade]
        except KeyError:
            return []

    def sort(self):
        result = []
        for k in sorted(self.grades.keys()):
            students = sorted(self.grades[k])
            result.append((k, tuple(students)))
        return result
