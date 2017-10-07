def distance(dna_a, dna_b):
    if dna_a == dna_b:
        return 0
    if len(dna_a) != len(dna_b):
        raise ValueError

    distance = 0

    for i in range(len(dna_a)):
        if dna_a[i] != dna_b[i]:
            distance += 1

    return distance

