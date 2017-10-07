from datetime import datetime, timedelta

def add_gigasecond(birthday):
    one_gigasecond = 1_000_000_000
    return birthday + timedelta(seconds=one_gigasecond)


