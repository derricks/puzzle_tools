# finds cryptograms of the search string within the input

# given a string, returns the pattern sequence of its letters
function make_cryptogram(string) {

  cur_offset = 1
  ret_string = ""
  num_chars = split(string,chars,"")

  for (i = 1; i <= num_chars; i++) {
    if (mapping[chars[i]] == "") {
      mapping[chars[i]] = cur_offset
      cur_offset = cur_offset + 1
    }
    ret_string = ret_string mapping[chars[i]]
  }

  # now clean up
  for (char in chars) {
    delete mapping[chars[char]]
  }

  return ret_string
}

BEGIN {
  search_crypt = make_cryptogram(search)
}

{
  if (make_cryptogram($0) == search_crypt) {
    print $0
  }
}