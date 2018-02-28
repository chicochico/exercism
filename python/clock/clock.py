class Clock(object):
    def __init__(self, hour, minute):
        self.minutes = self._to_minutes(hour, minute)

    @property
    def hour(self):
        return (self.minutes // 60) % 24

    @property
    def minute(self):
        return self.minutes % 60

    def __repr__(self):
        return f'{"%02d" % self.hour}:{"%02d" % self.minute}'

    def __eq__(self, other):
        return (self.hour == other.hour) and (self.minute == other.minute)

    def __add__(self, minutes):
        self.minutes += minutes
        return self

    def __sub__(self, minutes):
        self.minutes -= minutes
        return self

    def _to_minutes(self, hours, minutes):
        hours %= 24
        total_minutes = (hours * 60) + minutes
        return 1440 + (total_minutes % 1440)
