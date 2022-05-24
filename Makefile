fibonacci: fibonacci.c
	@gcc -o fibonacci fibonacci.c

pintas: pintas.c
	@gcc -o pintas pintas.c

clean:
	@rm fibonacci pintas

test: fibonacci pintas
	@bash tests.sh
