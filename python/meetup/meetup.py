import calendar
from datetime import date, timedelta
from itertools import filterfalse

# weekday returned by datetime.date.weekday()
weekday = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursday": 3,
    "Friday": 4,
    "Saturday": 5,
    "Sunday": 6,
}

ordinal = {
    "1st": 0,
    "2nd": 1,
    "3rd": 2,
    "4th": 3,
    "5th": 4,
}

def meetup_day(year, month, day_of_the_week, which):
    month_calendar = calendar.monthcalendar(year, month)
    day_of_week = weekday[day_of_the_week]
    # get only the weekday column
    possible_dates = [row[day_of_week] for row in month_calendar]
    # remove dates that are 0
    possible_dates = list(filterfalse(lambda x: x==0, possible_dates))

    try:
        if which is 'last':
            meetup_day = possible_dates[len(possible_dates) - 1]
        elif which is 'teenth':
            for d in possible_dates:
                if d >= 13 and d <= 19:
                    meetup_day = d
                    break
        else:
            meetup_day = possible_dates[ordinal[which]]

        return date(year, month, meetup_day)
    except IndexError:
        raise MeetupDayException


class MeetupDayException(Exception):
    pass
