//
// This is only a SKELETON file for the "Leap" exercise. It's been provided as a
// convenience to get you started writing code faster.
//

var Year = function (input) {
  this.year = input;
};

Year.prototype.isLeap = function () {
  div_4 = this.year % 4 == 0;
  div_100 = this.year % 100 == 0;
  div_400 = this.year % 400 == 0;
  return (div_4 && !div_100) || div_400
};

module.exports = Year;
