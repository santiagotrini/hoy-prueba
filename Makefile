factorial: factorial.c
	@gcc -o factorial factorial.c

clean:
	@rm factorial

test: factorial
	@bash tests.sh
