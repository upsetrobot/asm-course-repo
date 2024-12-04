
################################################################################
# DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATION MAKEFILES.
################################################################################
#
# 3-01 Tools - Application Test Makefile
#
# This file is module specific to 3-01 Tools module and cleans up after the 
# student manually builds an assembly program. 
#
# @file         makefile
# @author       upsetrobot
# @brief        Builds application test program.
# @version      1.0.1
# @date         11 Feb 2024
#
# @copyright    Copyright (c) 2024
#
################################################################################

PROGRAM = 		runme

run: 
	./5_application_test.py
	rm -fr *.o __pycache__ .pytest_cache

clean:
	rm -fr *.o $(PROGRAM) __pycache__ .pytest_cache

.PHONY: run clean


# End of file.