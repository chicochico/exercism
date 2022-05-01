# -*- coding: utf-8 -*-
from datetime import datetime


class LedgerEntry:
    def __init__(self):
        self.date = None
        self.description = None
        self.change = None

    def __lt__(self, other):
        return (
            (self.date < other.date)
            or (self.change < other.change)
            or (self.description < other.description)
        )


def format_description(description: str):
    description_len = len(description)
    if description_len > 24:
        return description[:22] + "..."
    else:
        return description + (" " * (25 - description_len))


def format_change(locale: str, currency: str, change: float):
    currency_symbol = {"USD": "$", "EUR": "€"}
    change_str_fmt = {
        "en_US": "{currency_symbol}{change}",
        "nl_NL": "{currency_symbol} {change}",
    }
    change_str = change_str_fmt[locale].format(
        currency_symbol=currency_symbol[currency], change=f"{change/100:,.2f}"
    )

    if locale == "en_US":
        if change < 0:
            change_str = f"({change_str})".replace("-", "")
            formated = change_str.rjust(13)
        else:
            formated = change_str.rjust(12).ljust(13)
    elif locale == "nl_NL":
        formated = (
            change_str.replace(",", "?")
            .replace(".", ",")
            .replace("?", ".")
            .rjust(12)
            .ljust(13)
        )
    return formated


def create_entry(date: str, description: str, change: str):
    entry = LedgerEntry()
    entry.date = datetime.strptime(date, "%Y-%m-%d")
    entry.description = description
    entry.change = change
    return entry


def format_entries(currency: str, locale: str, entries: list[LedgerEntry]):
    locale_header = {
        "en_US": "Date       | Description               | Change       ",
        "nl_NL": "Datum      | Omschrijving              | Verandering  ",
    }
    locale_date_format = {
        "en_US": "%m/%d/%Y",
        "nl_NL": "%d-%m-%Y",
    }

    entries = sorted(entries)
    table = locale_header[locale]

    for entry in entries:
        table += "\n"
        table += f"{entry.date.strftime(locale_date_format[locale])} | "
        table += f"{format_description(entry.description)} | "
        table += format_change(locale, currency, entry.change)

    return table
