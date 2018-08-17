BEGIN {
        ## 'f' variable is the function to search, set a regexp with it.
        f_regex = "^" f "[^a-zA-Z0-9]"

        ## When set, print line. Otherwise omit line.
        ## It is set when found the function searched.
        ## It is unset when found any character different from '#' with less
        ## spaces before it.
        in_func = 0
}

## Found function.
$1 == "func" && ($2 ~ f_regex || ($2 ~ "^\(" && $4 ~ f_regex)) {
        ## Set variable, print line and read next one.
        in_func = 1
        print
        next
}

in_func == 1 {
	print

	if ( $0 ~ "^\}" ) {
		in_func = 0
	}
}
