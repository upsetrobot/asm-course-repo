#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-18 Memory - Test Case Adder Script.

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



# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. Sum of Global.
    # ;
    # ; int studentFunction1(int a); 
    # ;
    # ; @brief    Function adds `a` and the global `g_val` and returns the sum.
    Case( func_id=1, args=(CaseArg(0, INT32),), ret_val=CaseArg(15264253, INT32) ),
    Case( func_id=1, args=(CaseArg(1, INT32),), ret_val=CaseArg(15264254, INT32) ),
    Case( func_id=1, args=(CaseArg(4256441, INT32),), ret_val=CaseArg(19520694, INT32) ),
    Case( func_id=1, args=(CaseArg(4279703043, UINT32),), ret_val=CaseArg(0, INT32) ),
    Case( func_id=1, args=(CaseArg(-1, INT32),), ret_val=CaseArg(15264252, INT32) ),


    # ; 2. Array Index.
    # ; 
    # ; long long studentFunction2(unsigned int index); 
    # ;
    # ; @brief    Function returns the value from the global array `g_arr` with the 
    # ;           array size `g_arr_sz` at the specified index `index`. If the index
    # ;           is out of bounds, function returns `-1`. 
    Case( func_id=2, args=(0,), ret_val=124523 ),
    Case( func_id=2, args=(1,), ret_val=186654 ),
    Case( func_id=2, args=(2,), ret_val=452588 ),
    Case( func_id=2, args=(3,), ret_val=156467886784233 ),
    Case( func_id=2, args=(4,), ret_val=1538180001 ),
    Case( func_id=2, args=(5,), ret_val=165448548648 ),
    Case( func_id=2, args=(6,), ret_val=486445422 ),
    Case( func_id=2, args=(7,), ret_val=4424148454645 ),
    Case( func_id=2, args=(8,), ret_val=12345678 ),
    Case( func_id=2, args=(9,), ret_val=-1 ),
    Case( func_id=2, args=(13434242,), ret_val=-1 ),


    # ; 3. Sum Array.
    # ;
    # ; long long studentFunction3()
    # ;
    # ; @brief    Function returns the sum of all elements in the global long long 
    # ;           array `g_arr` which has `g_arr_sz` elements.
    Case( func_id=3, args=(), ret_val= 161059521522392),


    # ; 4. Overwrite String.
    # ; 
    # ; char* studentFunction4()
    # ;
    # ; @brief    Function changes the contents of the global string `g_str` with 
    # ;           length `g_str_len` to all 'e's and returns a pointer to the global
    # ;           string.
    # ;
    # ;           Example: If string was "hello", string should become "eeeee".
    Case( func_id=4, args=(), ret_val="e"*201),


    # ; 5. Copy String to Buffer.
    # ; 
    # ; char* studentFunction5(char* str)
    # ;
    # ; @brief    Function copies string given by pointer `str` to a global buffer 
    # ;           called `buffer` and returns to pointer to `buffer`. Assumes string 
    # ;           given is less than buffer size (255 bytes) and that string is 
    # ;           null-terminated. This function also null-terminates the buffer 
    # ;           after copying the string.
    Case( func_id=5, args=("hello",), ret_val= "hello"),
    Case( func_id=5, args=("",), ret_val= ""),
    Case( func_id=5, args=("This is a Test",), ret_val= "This is a Test"),
    Case( 
        func_id=5, 
        args=(
            "Fill up the buffer with a whole bunch of stuff - like elves, "
            "orcs, wizards, goblins, wolves, witchers, dragons, bears, "
            "shadows, ships, pirates, laser cannons, radar systems, buckets, "
            "and lamps.",
        ), 
        ret_val=
            "Fill up the buffer with a whole bunch of stuff - like elves, "
            "orcs, wizards, goblins, wolves, witchers, dragons, bears, "
            "shadows, ships, pirates, laser cannons, radar systems, buckets, "
            "and lamps.",
    ),
    Case( func_id=5, args=("A"*255,), ret_val= "A"*255),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
