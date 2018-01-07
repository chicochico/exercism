var DnaTranscriber = function () {};


DnaTranscriber.prototype.toRna = function (dna) {
  var dictionary = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U',
  }
  var rna = '';

  for (nucleotide in dna) {
    transcribed_nucleotide = dictionary[dna[nucleotide]]
    if (transcribed_nucleotide != undefined) {
      rna += transcribed_nucleotide;
    } else {
      throw Error('Invalid input');
    }
  }

  return rna;
};


module.exports = DnaTranscriber;
