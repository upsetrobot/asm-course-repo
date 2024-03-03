#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-01 Tools - Application Test Verifier

This file is specific to this module. It runs the student's compilation of a 
file called 'runme' if present.

File:       verification_test.py
Author:     upsetrobot
Brief:      Checks that the application_test was not altered (to prevent 
            cheating or manipulation), then runs the application test.
Version:    1.0.1
Date:       11 Feb 2024

Copyright:  Copyright (c) 2024

Expected Output for good test should look similar to this:

    ```
    ------------------------------- VERIFIER OUTPUT --------------------------------
    The file hash for `5_application_test.py` matches.
    The file hash for `Makefile` matches.

    -------------------------------- PROGRAM OUTPUT --------------------------------

    ./5_application_test.py
    CONGRATULATIONS! TEST PASSED!
    rm -fr *.o __pycache__ .pytest_cache


    ============================= test session starts ==============================
    platform linux -- Python 3.10.12, pytest-7.4.0, pluggy-1.3.0 -- /bin/python3
    rootdir: /home/dell/Desktop/asm-course-repo/asm_course/3-01_tools
    plugins: web3-5.31.3
    collected 2 items                                                              

    .instructor/application_test_verifier.py::test_file_hash PASSED          [ 50%]
    .instructor/application_test_verifier.py::test_check_output PASSED       [100%]

    ============================== 2 passed in 0.03s ===============================
    ```
"""

## Standard libraries.
import hashlib as hl
from pathlib import Path
import os
import shutil
import subprocess as sp
import pytest

## Other libraries.
# None.

## Local libraries.
# None.

## Global constants.
MAKEFILE_NAME = 'makefile'
MAKEFILE_DIGEST = '6d236949fddf1180c5b42dcf77ef527c'
APPTEST_PY_FILE_NAME = '5_application_test.py'
APPTEST_PY_FILE_DIGEST = 'c1d4ee6ee2bffd629d5def1b76620e6c'

## Global variables.
# None.

## Classes.
# None.

## Static functions.

def main():
    ''' 
    Checks that application test was not altered, runs the program, and 
    tests the program.
    '''

    # Variables.
    output = ''

    print("------------------------------- VERIFIER OUTPUT --------------------------------")

    check_file_hash(APPTEST_PY_FILE_NAME, APPTEST_PY_FILE_DIGEST)
    check_file_hash(MAKEFILE_NAME, MAKEFILE_DIGEST)

    # Run program.
    print("\n-------------------------------- PROGRAM OUTPUT --------------------------------\n")

    output = run_test_file(MAKEFILE_NAME)
    print(output + '\n')

    if output == '':
        print("There was no output.")

    pytest.main(['-v', '-p no:cacheprovider', Path(__file__)])

    try:
        shutil.rmtree(Path(__file__).parent.joinpath('__pycache__'))
        shutil.rmtree(Path(__file__).parent.joinpath('.pytest_cache'))

    except Exception as e:
        print(e)



## Helper functions.

def check_file_hash(file_path: str, digest: str) -> bool:
    """Checks the MD5 hash of the application test file. If the file was 
    altered, prints and error statement and returns False. Else prints message 
    and returns True.

    @param  file_path   File path to file to check.
    @param  digest      Digest to check hash against.
    @return bool        Returns True if check passed. Else returns False.
    """

    # Check hash of file.
    hash = hl.md5()
    path = None
    
    try:
        path = Path(__file__).parent.parent.joinpath(file_path)
        
    except FileNotFoundError:
        print("File was not found. Please try again.")
        return False

    with open(path, 'rb') as f:
        buf = f.read()
        hash.update(buf)

    if hash.hexdigest() != digest:
        print(
            f"File hash for `{file_path}` does not match. This indicates that "
            "the file may have been altered. Please talk to the student about "
            "this."
        )
        return False
        
    else: 
        print(f"The file hash for `{file_path}` matches.")
        return True



def run_test_file(file_path: str) -> bytes:
    """Runs the application test file and returns the output.

    @return bytes   The byte string output of the program if it ran 
                    successfully. If it was not found or there was an error, 
                    will return a blank byte string.     
    """

    # Variables.
    output = ''

     # Run make file program and get output.
    try:
        program_path = Path(__file__).parent.parent.joinpath(file_path)
        os.chdir(program_path.parent)
        output = sp.check_output(["make"]).decode()

    except FileNotFoundError:
        print("File was not found. Please try again.")
        
    return output



## Tests.

def test_file_hash():
    """Checks that file hash for match.
    """

    assert check_file_hash(APPTEST_PY_FILE_NAME, APPTEST_PY_FILE_DIGEST) == True, "File was altered."
    assert check_file_hash(MAKEFILE_NAME, MAKEFILE_DIGEST) == True, "File was altered."



def test_check_output():
    """Calls application test to check output of runme file.
    """

    assert "CONGRATULATIONS!" in run_test_file(MAKEFILE_NAME)



# Scripts.

if __name__ == '__main__':
	main()



# End of file.