def make_diamond(letter):
    letters = [chr(c) for c in range(65, ord(letter)+1)]
    spaces = [' ' * (n*2-1) for n in range(len(letters))]
    width = len(letters) * 2 - 1
    rows = [''.join(row).center(width)
            for row in zip(letters, spaces, letters)]
    rows[0] = 'A'.center(width)
    return '\n'.join(rows + rows[::-1][1:]) + '\n'
