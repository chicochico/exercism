# Globals for the bearings
EAST = 3
SOUTH = 6
WEST = 9
NORTH = 12

BEARINGS = [EAST, SOUTH, WEST, NORTH]


class Robot(object):
    def __init__(self, bearing=NORTH, x=0, y=0):
        self.bearing = bearing
        self.coordinates = (x, y)

    def turn_right(self):
        new_bearing_index = (BEARINGS.index(self.bearing)+1) % len(BEARINGS)
        self.bearing = BEARINGS[new_bearing_index]

    def turn_left(self):
        new_bearing_index = (BEARINGS.index(self.bearing)-1) % len(BEARINGS)
        self.bearing = BEARINGS[new_bearing_index]

    def advance(self):
        (x, y) = self.coordinates

        if self.bearing == EAST:
            new_pos = (x + 1, y)
        elif self.bearing == SOUTH:
            new_pos = (x, y - 1)
        elif self.bearing == WEST:
            new_pos = (x - 1, y)
        else:
            new_pos = (x, y + 1)

        self.coordinates = new_pos

    def simulate(self, instructions):
        for i in instructions:
            if i == 'R':
                self.turn_right()
            elif i == 'L':
                self.turn_left()
            elif i == 'A':
                self.advance()
