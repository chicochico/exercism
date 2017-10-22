from operator import and_


class Allergies(object):

    def __init__(self, score):
        self.score = score
        self.allergen_scores = {
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
        return and_(self.score, self.allergen_scores[item]) != 0

    @property
    def lst(self):
        return [item for item in self.allergen_scores.keys() if self.is_allergic_to(item)]

