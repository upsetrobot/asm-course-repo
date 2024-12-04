
################################################################################
# DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATION MAKEFILES.
################################################################################
#
# 3-27 Structs - Application Test Makefile
#
# This file IS module specific for the structs module due to valgrind having 
# problems by messing with addresses and the struct testcases set up as static. 
#
# @file         makefile
# @author       upsetrobot
# @brief        Builds application test program.
# @version      1.0.0
# @date         25 Feb 2024
#
# @copyright    Copyright (c) 2024
#
################################################################################

PROGRAM = 		lab_tester
LAB = 			4_lab
TEST_DATA =     test_data.dat
TESTING = 		testing_*
OBJECTS = 		$(LAB).o $(PROGRAM).c

CC = 			gcc
CFLAGS = 		-g -Wall -Wextra -no-pie
ASM = 			nasm
AFLAGS = 		-f elf64
TEST_GEN = 		./tests/test_case_generator.py

run: rebuild clean
# Change is on this line below.
	./$(PROGRAM)
	rm -f *.o $(PROGRAM) $(TEST_DATA) $(TESTING)

rebuild : clean_all build

build: $(PROGRAM) $(TEST_DATA)

$(PROGRAM): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@

$(LAB).o: $(LAB).asm
	$(ASM) $(AFLAGS) $^ -o $@

$(TEST_DATA):
	$(TEST_GEN)

clean_all:
	rm -fr *.o $(PROGRAM) $(TEST_DATA) $(TESTING) __pycache__ .pytest_cache */__pycache__ */.pytest_cache

clean:
	rm -fr *.o __pycache__ .pytest_cache */__pycache__ */.pytest_cache

.PHONY: run rebuild build clean_all clean


# End of file.
