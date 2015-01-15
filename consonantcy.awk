# finds consonantcies of a given word in the input
# usage: awk -f consonantcy.awk -v search=<string> -v y=(vowel|consonant)
# y defaults to vowel

BEGIN {
  if (y == "") {
    y = "vowel"
  }

  vowel_regex = "[aeiouy]*"
  if (y == "consonant") {
    gsub("y","",vowel_regex)
  }

  devoweled_search = search
  vowels[1] = "a"
  vowels[2] = "e"
  vowels[3] = "i"
  vowels[4] = "o"
  vowels[5] = "u"
  if (y != "consonant") {
    vowels[6] = "y"
  }

  for (i = 1; i <= 6; i++) {
     if (vowels[i] != "") {
       gsub(vowels[i], vowel_regex, devoweled_search)
     }
  }

  regex = "^" vowel_regex devoweled_search vowel_regex "$"
}

$0 ~ regex