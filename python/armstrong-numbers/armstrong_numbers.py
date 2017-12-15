def is_armstrong(number):
    digits = [int(n) for n in list(str(number))]
    return sum([n**len(digits) for n in digits]) == number
