CODON = {
    'AUG': 'Methionine',
    'UUU': 'Phenylalanine',
    'UUC': 'Phenylalanine',
    'UUA': 'Leucine',
    'UUG': 'Leucine',
    'UCU': 'Serine',
    'UCC': 'Serine',
    'UCA': 'Serine',
    'UCG': 'Serine',
    'UAU': 'Tyrosine',
    'UAC': 'Tyrosine',
    'UGU': 'Cysteine',
    'UGC': 'Cysteine',
    'UGG': 'Tryptophan',
}


def proteins(strand):
    codons = [strand[i:i+3] for i in range(0, len(strand), 3)]
    return list(translate(codons))


def translate(codons):
    for codon in codons:
        try:
            yield CODON[codon]
        except KeyError:
            break
