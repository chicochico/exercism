function reverseString(str) {
  var reversed = ''
  for (i = str.length-1; i >= 0; i--) {
    reversed += str[i];
  }
  return reversed;
}

module.exports = reverseString
