# finds reversals of words
# if there's a search string, only words that are reversals of that will be output. otherwise, all input will be output reversed
# usage: awk -f reversals.awk -v search=<search>

function reverse_string(input) {
  num_chars = split(input, chars, "")
  return_string = ""
  for (i = num_chars; i >= 1; i--) {
    return_string = (return_string chars[i])
  }
  return return_string
}

BEGIN {
	if (search != "") {
	   matching_regex = "^" reverse_string(search) "$"
	   reverse_output = 0
	} else {
	   matching_regex = ".*"
       reverse_output = 1
	}
}

$0 ~ matching_regex {
  if (reverse_output == 1) {
    print reverse_string($0)
  } else {
    print $0
  }
}