SHELL=/bin/bash

all:
	echo 123
	set
	env
	diff /etc/passwd /etc/passwd
