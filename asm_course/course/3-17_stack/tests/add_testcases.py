#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-17 Stack - Test Case Adder Script.

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


    # ; 1. Return Argument.
    # ; 
    # ; long long studentFunction1(long long a);
    # ;
    # ; @brief    Function returns `a` without using a `mov` operation.
    Case( func_id=1, args=(0,), ret_val=0 ),
    Case( func_id=1, args=(1,), ret_val=1 ),
    Case( func_id=1, args=(-1,), ret_val=-1 ),
    Case( func_id=1, args=(0x123456789,), ret_val=0x123456789 ),
    Case( func_id=1, args=(0xbaddecafbaddecaf,), ret_val=0xbaddecafbaddecaf ),


    # ; 2. Return EFlags Register.
    # ; 
    # ; long long studentFunction2(long long a, long long b);
    # ;
    # ; @brief    Function returns `flags` value after adding `a` and `b`. 
    # ;
    # ;           This may be slightly tricky with different processors, so use the 
    # ;           `pushf` instruction and `or` it with `0x2` to ensure the second 
    # ;           bit is set. Debuggers and traps may set the `IF` and/or the `TF`, 
    # ;           so `and` the value with `0xfcff` if you want to negate those 
    # ;           values.
    # ;
    # ;           Pseudocode: `a + b; return flags`.
    # Uh, weird thing, bit 1 (not bit 0) is cleared when no debugger.
    Case( func_id=2, args=(0, 0), ret_val=0x046),
    Case( func_id=2, args=(0, 1), ret_val=0x002),
    Case( func_id=2, args=(1, 1), ret_val=0x002),
    Case( func_id=2, args=(1, -1), ret_val=0x057),
    Case( func_id=2, args=(1, 2), ret_val=0x006),
    Case( func_id=2, args=(-1, -1), ret_val=0x093),
    Case( func_id=2, args=(9223372036854775807, 1), ret_val=0x896),


    # ; 3. Call a Function.
    # ; 
    # ; long long studentFunction3(long long a, size_t num);
    # ;
    # ; @brief    Function calls `weirdFunction` on `a`, `num` times. To do this,
    # ;           load `rdi` with `a` (which will already be loaded into `rdi` when 
    # ;           you start) and use `call weirdFunction`. `weirdFunction` will 
    # ;           produce a value that you will use as input into `weirdFunction` 
    # ;           again `num` times. Note that `weirdFunction` clobbers registers, 
    # ;           so you will have to save and restore them if needed.
    # ;
    # ;           Pseudocode: `for i in range(num): a = weirdFunction(a)
    # ;                       return a`.
    Case ( func_id=3, args=(0, 0), ret_val=0 ),
    Case ( func_id=3, args=(1234560, 0), ret_val=1234560 ),
    Case ( func_id=3, args=(0, 1), ret_val=0x5adca7badca7 ),
    Case ( func_id=3, args=(1, 1), ret_val=0x5adca7badca6 ),
    Case ( func_id=3, args=(2, 1), ret_val=0x5adca7badca5 ),
    Case ( func_id=3, args=(4, 1), ret_val=0x5adca7badca3 ),
    Case ( func_id=3, args=(8, 1),  ret_val=0x5adca7badcaf ),
    Case ( func_id=3, args=(-1, 1), ret_val=0xffffa52358452358 ),
    Case ( func_id=3, args=(1, 2), ret_val=0x1 ),
    Case ( func_id=3, args=(0xf0f0f0f0, 1), ret_val=0x5adc574a2c57 ),
    Case ( func_id=3, args=(0xf0f0f0f0, 2), ret_val=0x0000f0f0f0f0 ),
    Case ( func_id=3, args=(0xf0f0f0f0, 3), ret_val=0x5adc574a2c57 ),
    Case ( func_id=3, args=(0xf0f0f0f0, 113), ret_val=0x5adc574a2c57 ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
