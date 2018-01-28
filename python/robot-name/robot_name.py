from secrets import choice


class Robot(object):
    def __init__(self):
        self.name = self._generate_random_name()

    def _generate_random_name(self):
        letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        alpha = ''.join(choice(letters) for _ in range(2))
        digits = ''.join(str(choice(range(10))) for _ in range(3))
        return alpha + digits

    def reset(self):
        self.name = self._generate_random_name()
