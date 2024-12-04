#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-22 Competency 5 Locked Up - Test Case Adder Script.

This file is specific to this module. 

Instructors may add test cases to the main function for this module.

Function IDs correspond to the assembly function numbers. If type for return 
value or arguments is not specified, then they will default to `UINT64` 
(positive `int`s), `INT64` (negative `int`s), `FLOAT64` (`float`s), or `STR` 
(`str`s) based on Python type.

File:       add_testcases.py
Author:     upsetrobot
Brief:      Generates new test case data file.
Version:    1.0.0
Date:       11 Feb 2024

Copyright:  Copyright (c) 2024

API:

    `CaseList` -- This is base class for holding all the test cases to be 
    generated. This is already created in the template and is imported by the 
    `test_case_generator.py` script. Show no action is need if you are just 
    trying to add more test cases.

        `CaseList.add(Case)` -- You can use this function to add one case. Or 
        you can add cases to the `CaseList.cases` list (which is what the 
        `add` function does).

        `CaseList.generate_data_file(str)` -- This function produces a binary 
        file with all test cases encoded so that the `lab_tester.c` file can 
        pick up the test cases and run them on the assembly code from 
        `4_lab.asm` on the student functions. This is already done and no 
        action is needed if you are just adding test cases.

    `CaseArg` -- This class allows for typing conversion of Python values to 
    the assembly functions (works using `CaseArg(val, type)`). It takes a value
    and a type. `CaseArg` can be used for the `ret_val` or elements of the 
    `args` arguments of a `Case`.  The type may be one of the constants
    provided by the library:

        `0`: INT32 -- 32-bit signed integer.
        `1`: UINT32 -- 32-bit unsigned integer.
        `2`: INT64 -- 64-bit signed integer.
        `3`: UINT64 -- 64-bit unsigned integer.
        `4`: FLOAT32 -- 32-bit float.
        `5`: FLOAT64 -- 64-bit float.
        `6`: STR -- String or byte array (can be used structs as well).
        `7`: HEX -- 64-bit value that will be printed as hex.

        `value` -- Python value of the argument to be exported for testing.

        `value_type` -- Type. 

    `Case` -- Use `Case` to create a new test case.

        `func_id` -- `func_id` is a number (e.g., `1`, `2`, etc.) that
        corresponds to the `studentFunction` number in the assembly lab file.
        For example, if you want to add a test case for `studentFunction1`, add
        a `Case` with a `func_id` of `1`.

        `args` -- ** Must be a tuple **. Is a tuple of values or a tuple of 
        `CaseArgs`. If the element is just a Python typed value, the library 
        will convert it to a C type in a sensible manner. Integers will be 
        saved as `unsigned long long`s (uint64) unless they are negative in 
        which case they will be saved as `long long`s (int64). Strings and 
        bytes objects will be saved as byte-strings. floats will be saved as 
        64-bit floats. `args` is in C/assembly order (first arg is the first 
        element of the tuple). 

        `ret_val` -- May be a value or a `CaseArg`. This is the expected 
        return value of the function given the `args` arguments. If the type 
        `ret_val` is `CaseArg`, then `ret_val_type` will be ignored.

        `ret_val_type` -- May be used to specify a type for `ret_val` if 
        `ret_val` does not have `CaseArg` type. May be one of the constants 
        above to represent types (`INT32`, `UINT32`, `INT64`, etc.).

"""


## Standard libraries.
from pathlib import Path
import sys

## Other libraries.
# None.

## Local libraries.
sys.path.append(str(Path(__file__).resolve().parent))
from testcaselib import *


# Use this for programs with user input. Each line without the newline.
# INPUT = ['hello', 'what'] # represents 'hello' followed by an `ENTER` and 
# then 'what' followed by an `ENTER`.
INPUT = [

]


# You can add functions here if you want or after the list.
# ------------- Add Functions Here If Desired To Use in List. -----------------

def getN(v, t, n):
    min_N = 9999
    min_x = 65
    for i in range(65):
        N = (i - (3*(v + n) % 67))**2 + (i - (5*(t + n) % 67))**2
        if N < min_N:
            min_N = N
            min_x = i
    return min_x, min_N

def f1(v_1, v_2, v_3, t_1, t_2, t_3):
    l = []
    x_1, n_1 = getN(v_1, t_1, 0)
    x_2, n_2 = getN(v_1, t_1, n_1)
    x_3, n_3 = getN(v_1, t_1, n_2)
    x_4, _ = getN(v_1, t_1, n_3)
    l.append(x_1)
    l.append(x_2)
    l.append(x_3)
    l.append(x_4)

    x_1, n_1 = getN(v_2, t_2, 0)
    x_2, n_2 = getN(v_2, t_2, n_1)
    x_3, n_3 = getN(v_2, t_2, n_2)
    x_4, _ = getN(v_2, t_2, n_3)
    l.append(x_1)
    l.append(x_2)
    l.append(x_3)
    l.append(x_4)

    x_1, n_1 = getN(v_3, t_3, 0)
    x_2, n_2 = getN(v_3, t_3, n_1)
    x_3, n_3 = getN(v_3, t_3, n_2)
    x_4, _ = getN(v_3, t_3, n_3)
    l.append(x_1)
    l.append(x_2)
    l.append(x_3)
    l.append(x_4)
    return b''.join([i.to_bytes(1, "little") for i in l])

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------
    
    # ; 1. Competency 5 Locked Up.
    # ;
    # ; char* studentFunction1(
    # ;   unsigned int volume_1,
    # ;   unsigned int volume_2, 
    # ;   unsigned int volume_3, 
    # ;   unsigned int tension_1,
    # ;   unsigned int tension_2,
    # ;   unsigned int tension_3
    # ; );
    # ;
    # ; @brief    Function returns a pointer to a `char` array global called `arr`.
    # ;           Function takes values for the volume constant and the tension 
    # ;           constant for three dials of the vault and calculates the 
    # ;           combinations to each of the three locks and returns a pointer to 
    # ;           the array with the first four elements as the combination to the 
    # ;           first lock in order, then the second for four elements as the 
    # ;           combination to the second lock, and finally the last four elements 
    # ;           as the combination to the last lock.
    Case( func_id=1, args=(args:=(1, 1, 1, 1, 1, 1)), ret_val=CaseArg(f1(*args), STR) ),
    Case( func_id=1, args=(args:=(99, 99, 99, 99, 99, 99)), ret_val=CaseArg(f1(*args), STR) ),
    Case( func_id=1, args=(args:=(0, 0, 0, 0, 0, 0)), ret_val=CaseArg(f1(*args), STR) ),
    Case( func_id=1, args=(args:=(100, 100, 100, 100, 100, 100)), ret_val=CaseArg(f1(*args), STR) ),
    Case( func_id=1, args=(args:=(88, 13, 78, 81, 39, 20)), ret_val=CaseArg(f1(*args), STR) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------



# -----------------------------------------------------------------------------



# End file.
