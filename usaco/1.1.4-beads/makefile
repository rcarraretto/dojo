CFLAGS  = -std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror


test: tests.out
	@./tests.out

run: beads.c
	@cc $(CFLAGS) beads.c
	./a.out && cat beads.out

clean:
	rm -f *.o *.out

tests.out: test_beads.c beads.c
	@echo Compiling $@
	@cc $(CFLAGS) ../test/unity.c test_beads.c -o tests.out -D TEST
