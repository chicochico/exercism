class Cypher {
  constructor(key=null) {
    if (key == null) {
      this.key = this.generateRandomKey();
    } else if (key == '') {
      // invalid empty key
      throw Error('Bad key');
    } else {
      // check if key content is valid
      for (let c in key) {
        let key_char_code = key[c].charCodeAt(0)
        if (key_char_code < 97 || key_char_code > 122) {
          throw Error('Bad key');
        }
      }
      this.key = key;
    }
  }

  generateRandomKey(length=100) {
    var random_characters = [...Array(length).keys()];
    random_characters = random_characters.map(_ => this.getRandomCharCode());
    random_characters = random_characters.map(c => String.fromCharCode(c));
    return random_characters.join('');
  }

  getRandomCharCode() {
    return Math.floor(Math.random() * (122-97+1)+97);
  }

  shiftChar(char, key, backwards=false) {
    var char_code = char.charCodeAt(0) - 97;
    var key_code = key.charCodeAt(0) - 97;
    if (!backwards) {
      var shifted_char = ((char_code + key_code) % 26) + 97
    } else {
      var shifted_char = ((char_code - key_code + 26) % 26) + 97
    }
    return String.fromCharCode(shifted_char)
  }

  encode(text) {
    var key = this.key
    if (text.length > key.length) {
      [...Array(Math.floor(text.length/key.length))].forEach(_ => key += this.key)
    }
    key = key.split('');
    var encoded = '';
    text = text.split('');

    for (let char in text) {
      encoded += this.shiftChar(text[char], key[char]);
    }

    return encoded;
  }

  decode(text) {
    var key = this.key
    if (text.length > key.length) {
      [...Array(Math.floor(text.length/key.length))].forEach(_ => key += this.key)
    }
    key = key.split('');
    var decoded = '';
    text = text.split('');

    for (let char in text) {
      decoded += this.shiftChar(text[char], key[char], true);
    }

    return decoded;
  }
}

module.exports = Cypher;
