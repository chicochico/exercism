def binary_search(list_of_numbers, number):
    middle = len(list_of_numbers) // 2
    left = 0
    right = len(list_of_numbers)

    while left < right+1:
        try:
            current = list_of_numbers[middle]
            if number == current:
                return middle
            elif number < current:
                right = middle - 1
            else:
                left = middle + 1
            middle = (left + right) // 2
        except IndexError:
            break

    raise ValueError('Not found.')
