CFLAGS  = -std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror


test: tests.out
	@./tests.out

run: friday.c
	@cc $(CFLAGS) friday.c
	./a.out && cat friday.out

clean:
	rm -f *.o *.out

tests.out: test_friday.c friday.c
	@echo Compiling $@
	@cc $(CFLAGS) ../test/unity.c test_friday.c -o tests.out -D TEST
