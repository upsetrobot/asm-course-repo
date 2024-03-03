#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-16 Competency 3 FizzBuzz - Test Case Adder Script.

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
import struct

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

def f1(b_arr):
    count = 0

    for i in range(len(b_arr) // 4):
        a, = struct.unpack('<i', b_arr[i*4:i*4+4])

        if a % 3 == 0:
            count += 1

        if a % 5 == 0:
            count += 1

    return count

l1 = b''.join(struct.pack('<i', i) for i in [0])
l2 = b''.join(struct.pack('<i', i) for i in [1])
l3 = b''.join(struct.pack('<i', i) for i in [3])
l4 = b''.join(struct.pack('<i', i) for i in [5])
l5 = b''.join(struct.pack('<i', i) for i in [15])
l6 = b''.join(struct.pack('<i', i) for i in [1, 3, 5, 15])
l7 = b''.join(struct.pack('<i', i) for i in [0, 234, 4412, 34, 22, 46, 665])
l8 = b''.join(struct.pack('<i', i) for i in [0, 40, 46, 49, 702, 825, 660, 645, 1024, 1055])
l9 = b''.join(struct.pack('<i', i) for i in [0, 4352, 1528, 4652, 333, 1500, 8692, 9761, 9763, 6050])

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. FizzBuzz.
    # ;
    # ; unsigned int* studentFunction1(int* int_arr, unsigned int arr_len);
    # ;
    # ; @brief    Function iterates `int_arr`, an array of integers, and tests each
    # ;           one. If the integer is divisible by `3`, the function prints 
    # ;           "FIZZ" (by calling the provided print function and passing a code 
    # ;           to it), if number is divisible by `5`, the function prints 
    # ;           "BUZZ", and if the integer is divisible by `3` and divisible by 
    # ;           `5`, the function prints "FIZZBUZZ"). The function returns the 
    # ;           number of "FIZZ"s or "BUZZ"s printed (e.g, "FIZZBUZZ" counts as 2 
    # ;           (one for "FIZZ" and one for "BUZZ")).
    Case( func_id=1, args=(CaseArg(l1, STR), CaseArg(len(l1) // 4, UINT32)), ret_val=f1(l1) ),
    Case( func_id=1, args=(CaseArg(l2, STR), CaseArg(len(l2) // 4, UINT32)), ret_val=f1(l2) ),
    Case( func_id=1, args=(CaseArg(l3, STR), CaseArg(len(l3) // 4, UINT32)), ret_val=f1(l3) ),
    Case( func_id=1, args=(CaseArg(l4, STR), CaseArg(len(l4) // 4, UINT32)), ret_val=f1(l4) ),
    Case( func_id=1, args=(CaseArg(l5, STR), CaseArg(len(l5) // 4, UINT32)), ret_val=f1(l5) ),
    Case( func_id=1, args=(CaseArg(l6, STR), CaseArg(len(l6) // 4, UINT32)), ret_val=f1(l6) ),
    Case( func_id=1, args=(CaseArg(l7, STR), CaseArg(len(l7) // 4, UINT32)), ret_val=f1(l7) ),
    Case( func_id=1, args=(CaseArg(l8, STR), CaseArg(len(l8) // 4, UINT32)), ret_val=f1(l8) ),
    Case( func_id=1, args=(CaseArg(l9, STR), CaseArg(len(l9) // 4, UINT32)), ret_val=f1(l9) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
