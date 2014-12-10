# find lines in the input that are transposals of the argument string (or, because of how it's written, transadditions)
# this script will strip spaces, but will assume that any other transforms
# (such as upper case to lower case) are done outside of it

# usage: awk -f transposals.awk -v search="search"


function regex_for_letters(letter, count) {
    ret_string = "/"
    if (count == 1) {
      ret_string = ret_string letter
    } else {
		for (i = 1; i <= count; i++) {
	      ret_string = (ret_string ".*" letter ".*")
		}
	}
	ret_string = ret_string "/"
	return ret_string
}
# This script actually works by building up an && regex and passing that to another instance of awk
BEGIN {
  # build up the regex to use 
  #   split the search string up
  #   count instances of each letter
  #   build up regex

  string_length = split(search, search_chars, "")
  for (i = 1; i <= string_length; i++) {
    letter_counts[search_chars[i]] = letter_counts[search_chars[i]] + 1
  }

  final_regex = ""
  for (cur_letter in letter_counts) {
    if (final_regex == "") {
       final_regex = regex_for_letters(cur_letter, letter_counts[cur_letter])
    } else {
       final_regex = (final_regex " && " regex_for_letters(cur_letter, letter_counts[cur_letter]))
    }
  }
}

# for each line, invoke a sub-process of awk to check the && regex against the string 
# (ands aren't part of regexes because of the need to backtrack on a string)
length($0) >= string_length {
   # remove spaces
   cleaned_string = $0
   gsub(" ", "", cleaned_string)

   cmd = "echo " cleaned_string "| awk '" final_regex "'"
   cmd | getline line
   close(cmd)

   if (length(line) > 0) {
      print $0
   }

   # reset line because if there's no output from cmd |, line isn't updated
   line = "" 
}