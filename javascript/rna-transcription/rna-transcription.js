var DnaTranscriber = function () {};


DnaTranscriber.prototype.toRna = function (dna) {
  var dictionary = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U',
  }
  dna = dna.split('')
  rna = dna.map(nucleotide => dictionary[nucleotide])

  if (rna.indexOf(undefined) != -1) {
    throw Error('Invalid input');
  } else {
    rna = rna.join('')
  }

  return rna;
};


module.exports = DnaTranscriber;
