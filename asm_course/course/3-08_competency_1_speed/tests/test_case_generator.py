#!/usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

Test Case Generator

This file is NOT module specific (the same copy is in all modules).

This file generates a binary file of the test cases from `add_testcases.py` 
for testing of `4_lab.asm`. This file also house `pytest` cases for monitoring 
integrity of files and for checking student lab success.

File:       test_case_generator.py
Author:     upsetrobot
Brief:      Generates new test case data file.
Version:    1.0.1
Date:       11 Feb 2024

Copyright:  Copyright (c) 2024
"""

## Standard libraries.
import subprocess as sp
import hashlib as hl
from pathlib import Path
import os
import sys
import time

## Other libraries.
# None.

## Local libraries.
sys.path.append(str(Path(__file__).resolve().parent))
from testcaselib import *
from add_testcases import case_list, INPUT

## Global constants.
# None.

## Global variables.
# None.

## Classes.
# None.



## Static functions.

def main():
    """Use this function to write and generate test cases for student 
    functions.
    """

    os.chdir(Path(__file__).resolve().parent)

    # Generate a new test data file.
    try:
        case_list.generate_data_file("../test_data.dat")

    except Exception as e:
        print(e)



## Helper functions.
# None.



## Tests.

def test_file_hashes():
    """Checks that file hashes match.
    """

    os.chdir(Path(__file__).resolve().parent)

    # *********** For Developers, Change Hashes if You Make Edits *************
    TESTCASE_LIB_NAME = 'testcaselib.py'
    TESTCASE_LIB_DIGEST = 'cedabbfd82a38fc00932bb6ba92e2609'
    MAKEFILE_NAME = '../Makefile'
    MAKEFILE_DIGEST = '59459d1775bb2d763f721de117924739'
    LAB_TESTER_NAME = '../lab_tester.c'
    LAB_TESTER_DIGEST = '8ed90118a794284c8721daba491af8fc'

    Case_lib_hash = hl.md5()
    makefile_hash = hl.md5()
    lab_tester_hash = hl.md5()

    with open(TESTCASE_LIB_NAME, 'rb') as f:
        Case_lib_hash.update(f.read())

    if 'structs' not in os.path.basename(Path.cwd().parent):
        with open(MAKEFILE_NAME, 'rb') as f:
            makefile_hash.update(f.read())

    with open(LAB_TESTER_NAME, 'rb') as f:
        lab_tester_hash.update(f.read())

    assert Case_lib_hash.hexdigest() == TESTCASE_LIB_DIGEST, f"File `{TESTCASE_LIB_NAME}` was altered."
    if 'structs' not in os.path.basename(Path.cwd().parent):
        assert makefile_hash.hexdigest() == MAKEFILE_DIGEST, f"File `{MAKEFILE_NAME}` was altered."
    assert lab_tester_hash.hexdigest() == LAB_TESTER_DIGEST, f"File `{LAB_TESTER_NAME}` was altered."



def test_check_output():
    """Runs makefile and tests output for positive results.
    """

    os.chdir(Path(__file__).resolve().parent.parent)
    output = b''

    try:
        p = sp.Popen(['make'], stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.PIPE)

        for i in INPUT:
            p.stdin.write(i.encode() + b'\n')
            p.stdin.flush()
            time.sleep(0.5)

        output = p.communicate()[0]

    except FileNotFoundError:
        print("File was not found. Please try again.")

    except Exception as e:
        print(e)

    assert b"CONGRATULATIONS!" in output



## Scripts.
if __name__ == '__main__':
    main()


# End of file.
