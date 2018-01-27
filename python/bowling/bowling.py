class BowlingGame(object):
    def __init__(self):
        self.frames = []

    def roll(self, pins):
        if pins < 0 or pins > 10:
            raise ValueError('Invalid score.')

        if (len(self.frames) > 0 and
                self.frames[-1][0] < 10 and
                len(self.frames[-1]) < 2):
            self.frames[-1].append(pins)
            if sum(self.frames[-1]) > 10:
                raise ValueError('Invalid score.')
        elif not self.game_is_complete():
            self.frames.append([pins])
        else:
            raise IndexError('The game is already complete.')

    def score(self):
        score = 0
        for i in range(10):
            current_frame = self.frames[i]
            frame_score = sum(current_frame)
            # strike or spare
            if frame_score == 10:
                if current_frame == [10]:  # strike
                    try:
                        frame_score += self.frames[i+1][1]
                    except IndexError:
                        frame_score += self.frames[i+2][0]
                frame_score += self.frames[i+1][0]
            score += frame_score
        return score

    def game_is_complete(self):
        if len(self.frames) == 10:
            if sum(self.frames[-1]) < 10:
                return True
        return False
