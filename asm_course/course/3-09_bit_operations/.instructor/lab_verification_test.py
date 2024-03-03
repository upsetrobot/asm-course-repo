#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-09 Bit Operations - Application Test Verifier

This file is specific to this module (just the digest for the 
`add_testcases.py` file; everything else is the same for every module).

Prevents tampering of application test and checks results of student function 
tests.

File:       lab_verification_test.py
Author:     upsetrobot
Brief:      Checks that the test files were not altered (to prevent 
            cheating or manipulation), then runs the application test.
Version:    1.0.1
Date:       11 Feb 2024

Copyright:  Copyright (c) 2024

Expected Output for good test should look similar to this:

    ```
    ================================ PROGRAM OUTPUT ================================

    ==327409== Memcheck, a memory error detector
    ==327409== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
    ==327409== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
    ==327409== Command: ./lab_tester
    ==327409== 
    ==327409== 
    ==327409== HEAP SUMMARY:
    ==327409==     in use at exit: 0 bytes in 0 blocks
    ==327409==   total heap usage: 10 allocs, 10 frees, 17,210 bytes allocated
    ==327409== 
    ==327409== All heap blocks were freed -- no leaks are possible
    ==327409== 
    ==327409== For lists of detected and suppressed errors, rerun with: -s
    ==327409== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
    rm -fr *.o lab_tester test_data.dat __pycache__ .pytest_cache
    nasm -f elf64 5_lab.nasm -o 5_lab.o
    gcc -g -Wall -Wextra -no-pie 5_lab.o lab_tester.c -o lab_tester
    /bin/python3 test_cases.py
    rm -fr *.o __pycache__ .pytest_cache
    valgrind ./lab_tester
    ====================== Welcome to the Application Tester! ======================

    Please only use instructions covered up until this point.
    Testing functions...

        Case 1   	studentFunction1 	PASSED
        Case 2   	studentFunction1 	PASSED
        Case 3   	studentFunction2 	PASSED
        Case 4   	studentFunction2 	PASSED

    Application test complete.

    CONGRATULATIONS! ALL TESTS PASSED!

    ================================================================================
    rm -f *.o lab_tester test_data.dat


    ================================ VERIFIER OUTPUT ===============================

    File hashes for `test_cases.py` match.

    ============================= test session starts ==============================
    platform linux -- Python 3.10.12, pytest-7.4.0, pluggy-1.3.0 -- /bin/python3
    rootdir: /asm_course/3-TEMP_templates/module_template/.instructor
    plugins: web3-5.31.3
    collected 2 items                                                              

    lab_verification_test.py::test_file_hash PASSED                          [ 50%]
    lab_verification_test.py::test_check_output PASSED                       [100%]

    ============================== 2 passed in 0.42s ===============================
    ```
"""

## Standard libraries.
import hashlib as hl
from pathlib import Path
import os
import shutil
import subprocess as sp
import pytest
import time
import sys

## Other libraries.
# None.

## Local libraries.
sys.path.append(str(Path(__file__).resolve().parent.parent.joinpath('tests/')))
from add_testcases import INPUT

## Global constants.
TEST_CASES_NAME = 'tests/add_testcases.py'
TEST_CASES_DIGEST = 'd53aa4f2b614e40f55059db260da78b8' # *** <-- This line is mod specific
TEST_CASE_GEN_NAME = 'tests/test_case_generator.py'
TEST_CASE_GEN_DIGEST = '24bbcf6d542f8628882e9d1aee578742'

## Global variables.
# None.

## Classes.
# None.


## Static functions.

def main():
    """Checks that application test was not altered, runs the program, and 
    tests the program.
    """

    wd = os.get_terminal_size()[0]
    prog_out = " PROGRAM OUTPUT "
    veri_out = " VERIFIER OUTPUT "
    p_left = (wd-len(prog_out))//2 if wd%2 == 0 else (wd-len(prog_out))//2 + 1
    p_right = (wd-len(prog_out))//2
    v_left = (wd-len(veri_out))//2 if wd%2 == 1 else (wd-len(veri_out))//2 + 1
    v_right = (wd-len(veri_out))//2
    yellow = "\x1b[38;2;255;255;102m"
    red = "\x1b[38;2;255;33;33m"
    reset = "\x1b[0m"

    # Run program.
    print(yellow, "="*p_left, prog_out, "="*p_right, "\n", reset, sep='')
    os.chdir(Path(__file__).parent.parent)
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

    print(output.decode() + '\n')
    print(yellow, "="*v_left, veri_out, "="*v_right, "\n", reset, sep='')

    # Check file hash.
    hash = hl.md5()

    with open(TEST_CASES_NAME, 'rb') as f:
        hash.update(f.read())

    if hash.hexdigest() != TEST_CASES_DIGEST:
        print(
            red,
            f"File hashes for `{TEST_CASES_NAME}` did not match. File may "
            "have been altered. Please talk to the student about this.\n",
            reset,
            sep=''
        )
    
    else:
        print(f"File hashes for `{TEST_CASES_NAME}` match.\n")

    hash = hl.md5()

    with open(TEST_CASE_GEN_NAME, 'rb') as f:
        hash.update(f.read())

    if hash.hexdigest() != TEST_CASE_GEN_DIGEST:
        print(
            red,
            f"File hashes for `{TEST_CASE_GEN_NAME}` did not match. File may "
            "have been altered. Please talk to the student about this.\n",
            reset,
            sep=''
        )
    
    else:
        print(f"File hashes for `{TEST_CASE_GEN_NAME}` match.\n")

    # Run tests.
    os.chdir(Path(__file__).parent)
    pytest.main(['-v', '-p no:cacheprovider', '--tb=line'])

    try:
        shutil.rmtree('__pycache__')

    except Exception as e:
        print(e)

    try:
        shutil.rmtree('.pytest_cache')

    except Exception as e:
        print(e)



## Helper functions.
# None.


## Tests.

def test_file_hash():
    """Checks that file hash for match.
    """

    hash = hl.md5()
    os.chdir(Path(__file__).parent.parent)

    with open(TEST_CASES_NAME, 'rb') as f:
        hash.update(f.read())

    assert hash.hexdigest() == TEST_CASES_DIGEST, f"File `{TEST_CASES_NAME}` may have been altered"
    
    hash = hl.md5()

    with open(TEST_CASE_GEN_NAME, 'rb') as f:
        hash.update(f.read())

    assert hash.hexdigest() == TEST_CASE_GEN_DIGEST, f"File `{TEST_CASE_GEN_NAME}` may have been altered"



def test_check_output():
    """Calls application test to check output of runme file.
    """

    os.chdir(Path(__file__).parent.parent)
    assert pytest.main(['-v', '-p no:cacheprovider']) == pytest.ExitCode.OK



## Scripts.
if __name__ == '__main__':
	main()


# End of file.
