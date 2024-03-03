#!/usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-01 Tools - Application Test

This file is specific to this module. It checks for the student-built assembly 
program.

File:         5_application_test.py
Author:       upsetrobot
Brief:        Checks for the executable file called 'runme', runs the file, 
              checks that the output matches expected output. Prints message 
              for testing success or failure.             
Version:      1.0.1
Date:         11 Feb 2024

Copyright:    Copyright (c) 2024
"""

## Standard libraries.
import hashlib as hl
from pathlib import Path
import subprocess as sp
import textwrap as tw

## Other libraries.
# None.

## Local libraries.
# None.

## Global constants.
DIGEST = '5eb1d37fc65f37aa11470484536f2abf252f2825f2ca0ef403cc0f67f1578dc1'

## Global variables.
# None.

## Classes.
# None.

## Static functions.

def main():
    """Checks output of runme program if found.
    """

    check_runme_output()


## Helper functions.

def check_runme_output() -> str:
    """Looks for the program "runme".  If found, runs the program and checks 
    the output.

    Returns:
        str: SHA256 hash digest of expected program output.
    """
    
    # Variables.
    output = None
    hash = hl.sha256()
    output_digest = None
    
    # Look for and run program and get output.
    try:
        program_path = Path(__file__).parent.resolve().joinpath('runme')
        output = sp.check_output([program_path])

    except FileNotFoundError:
        print(tw.dedent("""\
            File was not found.  Executable must be named 'runme'.
            Executable must be same directory as this test program.
            Please try again.
            If you continue to have problems, please ask a training """ + 
            "officer for help."
        ))
        return None

    # Check that hash matches correct hash.
    hash.update(output)
    output_digest = hash.hexdigest()

    if DIGEST == output_digest:
        print("CONGRATULATIONS! TEST PASSED!")

    else:
        print(tw.dedent(f"""\
            Output did not match test case.
            Output given: {output}
            Please try again.
            If you continue to have problems, please ask a training """ + 
            "officer for help."
        ))
        
    return output_digest


## Tests.

def test_runme():
    """Tests that hash of runme output matches expected output.
    """

    assert check_runme_output() == DIGEST, "Output was incorrect. Sorry, " \
        "Please try again."


# Scripts.
if __name__ == '__main__':
	main()


# End of file.