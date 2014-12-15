# Provides letter banks for a given search string from the input
# usage: awk -f letter_banks.awk -v search=needles <input lines> -> lends, needles, needless, and so on

BEGIN {
  # first construct the unique string
  regex = "^[" search " ]+$"

  num_chars = split(search, chars, "")

  # todo: to make this more efficient, one could trim this to unique characters
  # but that would add a lot of code for non-appreciable performance gains
  print regex
}

$0 ~ regex {
  # this gives us any line that has a subset of the characters. We only want ones where
  # _all_ the letters are present
  for (cur_char in chars) {
    # if character isn't in the source, we can exit
    if ($0 !~ chars[cur_char]) {
       next
    }
  }
  print $0
}