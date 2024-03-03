#!/usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-26 ASM Programming - Application Test

This file is specific to this module. It checks for the student-built assembly 
program.

File:         5_application_test.py
Author:       upsetrobot
Brief:        Checks for the executable file called 'runme', runs the file, 
              checks that the output matches expected output. Prints message 
              for testing success or failure.             
Version:      1.0.0
Date:         25 Feb 2024

Copyright:    Copyright (c) 2024
"""

## Standard libraries.
from pathlib import Path
import subprocess as sp
import textwrap as tw
import os

## Other libraries.
# None.

## Local libraries.
# None.

## Global constants.
PROGRAM = './4_lab'
RESET   = "\x1b[0m"
LT_RED  = "\x1b[38;2;255;80;80m"
RED     = "\x1b[91m"
GREEN   = "\x1b[38;2;0;223;80m"

## Global variables.
# None.

## Classes.
# None.

## Static functions.

def main():
    """Checks output of program if found.
    """
    
    # Change directory to local directory.
    os.chdir(Path(__file__).resolve().parent)

    try:
        check_program_output()

    except Exception as e:
        print(e)

    # Clean up.
    os.system("rm -r testing_* __pycache__ .pytest_cache *.o")



## Helper functions.

def check_program_output() -> bool:
    """Looks for the program "4_lab".  If found, runs the program and checks 
    the output.

    Returns:
        bool:   `True` if all tests passed, else `False`.
    """

    # Print banner.
    try: 
        cols = os.get_terminal_size()[0]
    except:
        cols = 80
    banner = ' Welcome to the Application Tester! '
    sides = cols - len(banner)

    if sides % 2 == 0:
        print(LT_RED, '='*(sides//2), banner, '='*(sides//2), RESET, sep='')

    else:
        print(LT_RED, '='*(sides//2), banner, '='*(sides//2+1), RESET, sep='')

    print("\nTesting program...\n")

    
    # Test Case 1.
    filename = 'testing_a.txt'
    contents = None

    with open(filename, 'w') as f:
        f.write("hello")

    with open(filename, 'r') as f:
        contents = f.read()

    print("\tCase 1\t", end='')
    
    try:
        output = sp.check_output([PROGRAM, filename], text=True)

    except FileNotFoundError:
        print(tw.dedent("""\
            Program was not found.  Executable must be named '4_lab'.
            Executable must be same directory as this test program.
            Please try again.
            If you continue to have problems, please ask a instructor """ + 
            "for help."
        ))
        print("\nApplication test complete.\n")
        print(RED, "Sorry, the test did not pass. Please try again.\n", RESET, sep='')
        print(LT_RED, "=" *cols, RESET, sep='')
        return False

    if output != contents:
        print(RED, "FAILED\n", RESET, sep='')
        print("Test failed.")
        print("Expected:", contents)
        print("Got:     ", output)
        print("\nApplication test complete.\n")
        print(RED, "Sorry, the test did not pass. Please try again.\n", RESET, sep='')
        print(LT_RED, "=" *cols, RESET, sep='')
        return False

    print(GREEN,"PASSED", RESET, sep='')


    # Test Case 2.
    filename = 'testing_b.txt'
    contents = None

    with open(filename, 'w') as f:
        f.write("What is your problem?")

    with open(filename, 'r') as f:
        contents = f.read()

    print("\tCase 2\t", end='')
    
    try:
        output = sp.check_output([PROGRAM, filename], text=True)

    except FileNotFoundError:
        print(tw.dedent("""\
            Program was not found.  Executable must be named '4_lab'.
            Executable must be same directory as this test program.
            Please try again.
            If you continue to have problems, please ask a instructor """ + 
            "for help."
        ))
        print("\nApplication test complete.\n")
        print(RED, "Sorry, the test did not pass. Please try again.\n", RESET, sep='')
        print(LT_RED, "=" *cols, RESET, sep='')
        return False

    if output != contents:
        print(RED, "FAILED\n", RESET, sep='')
        print("Test failed.")
        print("Expected:", contents)
        print("Got:     ", output)
        print("\nApplication test complete.\n")
        print(RED, "Sorry, the test did not pass. Please try again.\n", RESET, sep='')
        print(LT_RED, "=" *cols, RESET, sep='')
        return False

    print(GREEN,"PASSED", RESET, sep='')


    # Closing.
    print("\nApplication test complete.\n")
    print(GREEN, "CONGRATULATIONS! ALL TESTS PASSED\n", RESET, sep='')
    print(LT_RED, "=" *cols, RESET, sep='')
    return True



## Tests.

def test_program():
    """Tests that program passes all test cases.
    """

    # Change directory to local directory.
    os.chdir(Path(__file__).resolve().parent)
    output = False

    try:
        output = check_program_output()

    except Exception as e:
        print(e)

    # Clean up.
    os.system("rm -r testing_* __pycache__ .pytest_cache *.o")

    assert output, "Output was incorrect. Sorry, please try again."


# Scripts.
if __name__ == '__main__':
	main()


# End of file.