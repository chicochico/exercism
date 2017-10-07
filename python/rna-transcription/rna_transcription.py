def to_rna(dna):
    t = {'G': 'C',
        'C': 'G',
        'T': 'A',
        'A': 'U'}

    try:
        return ''.join([t[n] for n in dna])
    except KeyError:
        return ''

