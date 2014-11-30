# This script will give you the nth character for each line of input. It can actually handle getting a different character
# for each line.
#
# usage: awk -f nth_character.awk -v cuts="cut string"
# where "cut string" is either a single number or a space-delimited sequence of numbers. The appropriate field will be used
# for the appropriate line, and then it will cycle. Default is "1"
# in other words, a cut string of "2" will give you the second character of each line. A cut string of "1 2 3" will produce
# the first character from line 1, the second character from line two, the third character from line 3, and the first character
# from line 4

BEGIN {
	if(cuts == "") {
	  cuts = "1"
	}

	num_cut_fields = split(cuts, cut_fields, " ");
}

{

    # there's probably a more elegant way to do this, but I'm blanking right now.
    if (FNR % num_cut_fields == 0) {
      cut_field_index = num_cut_fields
    } else {
      cut_field_index = FNR % num_cut_fields
    }


	print substr($0, cut_fields[cut_field_index], 1)
}