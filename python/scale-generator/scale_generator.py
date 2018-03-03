from itertools import cycle
from itertools import islice


CHROMATIC = 'C C# D D# E F F# G G# A A# B'.split()
CHROMATIC_FLATS = 'C Db D Eb E F Gb G Ab A Bb B'.split()
USE_SHARPS = 'G D A E B F# e b f# c# g# d#'.split()
USE_FLATS = 'F Bb Eb Ab Db Gb d g c f bb eb'.split()
VALID = ['MMmMMMm',
         'MMmMMMm',
         'MMmMMMm',
         'MmMMmMM',
         'MmMMmMM',
         'MmMMMmM',
         'MMmMMmM',
         'MMMmMMm',
         'mMMMmMM',
         'mMMmMMM',
         'MmMMmAm',
         'MmMmMmMm',
         'MMMMMM',
         'MMAMA',
         'mAMMMmm']


class Scale(object):
    def __init__(self, tonic, intervals=None):
        if intervals and intervals not in VALID:
            raise ValueError('Invalid scale.')
        self.tonic = tonic
        self.chromatic = self.gen_chromatic(tonic)
        self.intervals = intervals

    @property
    def pitches(self):
        if not self.intervals:
            return self.chromatic
        return [self.chromatic[i] for i in self.gen_intervals()]

    def gen_chromatic(self, tonic):
        chromatic = self.get_chromatic()
        tonic = chromatic.index(self.tonic.title())
        scale = islice(cycle(chromatic), tonic, tonic+12)
        return list(scale)

    def gen_intervals(self):
        distance = {'m': 1, 'M': 2, 'A': 3}
        start = 0
        yield start
        for interval in self.intervals[:-1]:
            start += distance[interval]
            yield start

    def get_chromatic(self):
        if self.tonic in USE_FLATS:
            return CHROMATIC_FLATS
        return CHROMATIC
