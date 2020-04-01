CFLAGS  = -std=c99
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror


test: tests.out
	@./tests.out

clean:
	rm -f *.o *.out

tests.out: test_ride.c ride.c ride.h
	@echo Compiling $@
	@cc $(CFLAGS) ride.c ../test/unity.c test_ride.c -o tests.out
