# find lines in the input that are transposals of the argument string (or, because of how it's written, transadditions)
# this script will strip spaces, but will assume that any other transforms
# (such as upper case to lower case) are done outside of it

# usage: awk -f transposals.awk -v search="search"


function regex_for_letters(letter, count) {
    ret_string = ""
    if (count == 1) {
      ret_string = letter
    } else {
		for (i = 1; i <= count; i++) {
	      ret_string = (ret_string ".*" letter ".*")
		}
	}
	return ret_string
}

BEGIN {
  if (search == "") {
    print "You must specify a search string."
    exit
  }

  # build up the regex to use 
  #   split the search string up
  #   count instances of each letter
  #   build up regex

  string_length = split(search, search_chars, "")
  for (i = 1; i <= string_length; i++) {
    letter_counts[search_chars[i]] = letter_counts[search_chars[i]] + 1
  }

  regex_count = 0
  for (cur_letter in letter_counts) {
    regex_count = regex_count + 1
    regexes[regex_count] = regex_for_letters(cur_letter, letter_counts[cur_letter])
  }
}

# for each line that's at least as long as the search string, check the input against
# the set of regexes. If they all match, print the line.
length($0) >= string_length {
   # remove spaces
   cleaned_string = $0
   gsub(" ", "", cleaned_string)

   # see if all the regexes matches
   for (cur_regex in regexes) {

      if (cleaned_string !~ regexes[cur_regex]) {
        next
      }
   }
   print $0

}