import unittest

from food_chain import recite, verse


# Tests adapted from `problem-specifications//canonical-data.json` @ v2.1.0

v1 = ["I know an old lady who swallowed a fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v2 = ["I know an old lady who swallowed a spider.",
      "It wriggled and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v3 = ["I know an old lady who swallowed a bird.",
      "How absurd to swallow a bird!",
      "She swallowed the bird to catch the spider that "
      "wriggled and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v4 = ["I know an old lady who swallowed a cat.",
      "Imagine that, to swallow a cat!",
      "She swallowed the cat to catch the bird.",
      "She swallowed the bird to catch the spider that "
      "wriggled and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v5 = ["I know an old lady who swallowed a dog.",
      "What a hog, to swallow a dog!",
      "She swallowed the dog to catch the cat.",
      "She swallowed the cat to catch the bird.",
      "She swallowed the bird to catch the spider that wriggled "
      "and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v6 = ["I know an old lady who swallowed a goat.",
      "Just opened her throat and swallowed a goat!",
      "She swallowed the goat to catch the dog.",
      "She swallowed the dog to catch the cat.",
      "She swallowed the cat to catch the bird.",
      "She swallowed the bird to catch the spider that "
      "wriggled and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v7 = ["I know an old lady who swallowed a cow.",
      "I don't know how she swallowed a cow!",
      "She swallowed the cow to catch the goat.",
      "She swallowed the goat to catch the dog.",
      "She swallowed the dog to catch the cat.",
      "She swallowed the cat to catch the bird.",
      "She swallowed the bird to catch the spider that "
      "wriggled and jiggled and tickled inside her.",
      "She swallowed the spider to catch the fly.",
      "I don't know why she swallowed the fly. Perhaps she'll die."]
v8 = ["I know an old lady who swallowed a horse.",
      "She's dead, of course!"]


class FoodChainTest(unittest.TestCase):
    def test_fly(self):
        self.assertEqual(recite(1, 1), '\n'.join(v1))

    def test_spider(self):
        self.assertEqual(recite(2, 2), '\n'.join(v2))

    def test_bird(self):
        self.assertEqual(recite(3, 3), '\n'.join(v3))

    def test_cat(self):
        self.assertEqual(recite(4, 4), '\n'.join(v4))

    def test_dog(self):
        self.assertEqual(recite(5, 5), '\n'.join(v5))

    def test_goat(self):
        self.assertEqual(recite(6, 6), '\n'.join(v6))

    def test_cow(self):
        self.assertEqual(recite(7, 7), '\n'.join(v7))

    def test_horse(self):
        self.assertEqual(recite(8, 8), '\n'.join(v8))

    def test_multiple_verses(self):
        expected = '\n\n'.join(verse(n) for n in range(1, 4))
        self.assertEqual(recite(1, 3), expected)

    def test_full_song(self):
        expected = '\n\n'.join(verse(n) for n in range(1, 9))
        self.assertEqual(recite(1, 8), expected)


if __name__ == '__main__':
    unittest.main()
