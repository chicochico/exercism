from operator import and_


class Allergies(object):

    def __init__(self, score):
        self.score = score
        self.alergen_scores = {
            'eggs': 1,
            'peanuts': 2,
            'shellfish': 4,
            'strawberries': 8,
            'tomatoes': 16,
            'chocolate': 32,
            'pollen': 64,
            'cats': 128,
        }

    def is_allergic_to(self, item):
        return and_(self.score, self.alergen_scores[item]) != 0

    @property
    def lst(self):
        alergens = []

        for k, v in self.alergen_scores.items():
            if and_(self.score, v) != 0:
                alergens.append(k)

        return alergens


