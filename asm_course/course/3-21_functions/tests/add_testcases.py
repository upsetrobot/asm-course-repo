#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-21 Functions - Test Case Adder Script.

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
from math import factorial

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

def f1(a, b):
    return a % b if b != 0 else -1

def f2(a, b):
    return a + sum([f1(a, n) for n in range(1, b + 1)]) if b != 0 else 0

def f3(a):
    return factorial(a) & 0xffffffffffffffff

def f4(s):
    return sum([f2(f3((ord(v) % 30) + 12), i + 1 + 10000) for i, v in enumerate(s)]) & 0xffffffffffffffff

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------

    # ; 1. Unsigned Modulus.
    # ;
    # ;  unsigned long long studentFunction1(unsigned long long a, unsigned long long b);
    # ;
    # ; @brief    Function returns the modulus of `a` modulo `b` where `a` and `b` 
    # ;           are positive unsigned long long integers. Division by zero results 
    # ;           in `-1`. 
    Case( func_id=1, args=(a:=0, b:=0), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=1, b:=0), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=0, b:=1), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=2, b:=0), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=3, b:=0), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=4, b:=0), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=0, b:=1), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=0, b:=2), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=0, b:=3), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=0, b:=4), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=10), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=9), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=8), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=7), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=6), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=5), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=4), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=3), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=2), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=10, b:=1), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=145550, b:=6), ret_val=f1(a, b) ),
    Case( func_id=1, args=(a:=145550, b:=3234), ret_val=f1(a, b) ),


    # ; 2. Sum of Decrementing Moduli.
    # ;
    # ; unsigned long long studentFunction2(unsgined long long a, unsigned long long b);
    # ;
    # ; @brief    Function returns the sum of `a` and the moduli of `a` divided by 
    # ;           `b` and all decrements of `b`. So, the function returns of `a` mod
    # ;           `b` added to `a` mod `b-1` for all `n` where `n = b` to `n = 1`. If
    # ;           `b` is `0`, function returns `0`.
    Case( func_id = 2, args=(a := 0, b := 0), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 1, b := 0), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 2, b := 0), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 4, b := 0), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 0, b := 1), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 0, b := 2), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 0, b := 3), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 1), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 2), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 3), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 4), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 5), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 6), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 7), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 8), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 9), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 10), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 453158, b := 7), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 453158, b := 74554), ret_val = f2(a, b) ),
    Case( func_id = 2, args=(a := 10, b := 100), ret_val = f2(a, b) ),


    # ; 3. Factorial.
    # ; 
    # ; unsigned long long studentFunction3(unsigned long long a);
    # ;
    # ; @brief    Function calculates the factorial of `a`. Assumes input is 
    # ;           positive and accepts unsigned long long values (64-bit). Returns 
    # ;           `1` if `a` is `0` (or `1` for that matter). 
    Case( func_id=3, args=(a := 0,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 1,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 2,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 3,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 0x41,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 101,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 1200,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 12,), ret_val=f3(a) ), 
    Case( func_id=3, args=(a := 30,), ret_val=f3(a) ), 


    # ; 4. Weird Hash Function.
    # ;
    # ; unsigned long long studentFunction4(char* str_to_hash);
    # ;
    # ; @brief    Function returns a weird 8-byte hash of given null-terminated 
    # ;           string. The hash is the sum of the following for each character in 
    # ;           the string: the algorithm finds the factorial of the modulus of 
    # ;           the value of the value of the character and `30` and adds `12`. 
    # ;           Then it calculates the looping decrementing modulus sum of that 
    # ;           value and the position of the character plus `10000`. After all 
    # ;           calculations have been summed for all characters, the result is 
    # ;           8-byte weird hash.
    Case( func_id=4, args=(a := '',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'a',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'b',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'aa',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'bb',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'aaab',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'hello',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'This is your hash function hashin',), ret_val=CaseArg(f4(a), HEX) ),
    Case( func_id=4, args=(a := 'HASH THIS 12323@#$@%&@#32}]}-=*/',), ret_val=CaseArg(f4(a), HEX) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------



# -----------------------------------------------------------------------------



# End file.
