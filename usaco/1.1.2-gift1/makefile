CFLAGS  = -std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror


test: tests.out
	@./tests.out

clean:
	rm -f *.o *.out

tests.out: test_gift1.c gift1.c
	@echo Compiling $@
	@cc $(CFLAGS) ../test/unity.c test_gift1.c -o tests.out
