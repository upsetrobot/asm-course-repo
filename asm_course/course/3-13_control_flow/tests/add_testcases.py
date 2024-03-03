#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-13 Control Flow - Test Case Adder Script.

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
Date:       14 Feb 2024

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
from ast import arg
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

def f1(a, b):
    return a + b - 1 if a >= 0 else a + b

def f2(a, b):
    return 1 if a < b else 0

def f3(a):
    return abs(a)

def f4(a, b):
    return a*b if a+b > 100 else (a & 0xffffffffffffffff) >> 4 if a-b < 0 else 0

def f5(a, b, c):
    if a == ord('+'): return b + c
    elif a == ord('-'): return b - c
    elif a == ord('*'): return b * c
    elif a == ord('/') and c == 0: return 0x6469766572726f72
    elif a == ord('/') and c != 0: return b // c
    elif a == ord('%') and c == 0: return 0x6469766572726f72
    elif a == ord('%') and c != 0: return b % c
    elif a == ord('^'): return b ^ c
    else: return 0xbaddda7abaddda7a

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. Conditional Subtraction.
    # ;
    # ; long long studentFunction1(long long a, long long b);
    # ;
    # ; @brief    Function sums `a` and `b` and subtracts `1` from sum if `a` is 
    # ;           positive.
    Case( func_id=1, args=(a:=0, b:=0), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=0, b:=-1), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=-1, b:=0), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=1, b:=0), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=0, b:=1), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=1, b:=1), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=10, b:=5), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=10, b:=9), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=5, b:=10), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=9, b:=10), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=15463, b:=21000), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=-46545450, b:=45540), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=-10000000, b:=-11000000), ret_val=f1(a, b)),
    Case( func_id=1, args=(a:=1581815515150, b:=-4454540), ret_val=f1(a, b)),


    # ; 2. Return 1 or 0.
    # ; 
    # ; long long studentFunction2(long long a, long long b);
    # ;
    # ; @brief    Function returns `1` if `a` is less than `b`. Otherwise returns `0`.
    Case( func_id=2, args=(a:=0, b:=0), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=0, b:=-1), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=-1, b:=0), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=1, b:=0), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=0, b:=1), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=1, b:=1), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=10, b:=5), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=10, b:=9), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=5, b:=10), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=9, b:=10), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=15463, b:=21000), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=-46545450, b:=45540), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=-10000000, b:=-11000000), ret_val=f2(a, b)),
    Case( func_id=2, args=(a:=1581815515150, b:=-4454540), ret_val=f2(a, b)),


    # ; 3. Absolute Value.
    # ;
    # ; unsigned int studentFunction3(int a);
    # ;
    # ; @brief    Function returns the absolute value of `a`.
    Case( func_id=3, args=(a:=0,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=1,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=-1,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=1000000000,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=-1000000000,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=15618461,), ret_val=CaseArg(f3(a), UINT32)),
    Case( func_id=3, args=(a:=-415415545,), ret_val=CaseArg(f3(a), UINT32)),


    # ; 4. If-Then-Else.
    # ;
    # ; long long studentFunction4(long long a, long long b);
    # ;
    # ; @brief    Function returns product of `a` and `b` if the sum of `a` and `b` 
    # ;           is greater than 100, `a` shifted right by 4 bits if the difference 
    # ;           between `a` and `b` is less than `0`, otherwise returns `0`.
    Case( func_id=4, args=(a:=0, b:=0), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=1, b:=0), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=0, b:=1), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=1, b:=1), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=-1, b:=0), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=0, b:=-1), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=-1, b:=-1), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=99, b:=1), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=99, b:=2), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=1, b:=99), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=2, b:=99), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=105, b:=-4), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=-4, b:=105), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=50, b:=50), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=50, b:=51), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=51, b:=50), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=-51, b:=-50), ret_val=f4(a, b)),
    Case( func_id=4, args=(a:=-500, b:=-500), ret_val=f4(a, b)),


    # ; 5. Switch.
    # ; 
    # ; long long studentFunction5(char a, long long b, long long c);
    # ;
    # ; @brief    Function check character `a` for operation to perform on `b` and 
    # ;           `c`. Accepted operators are '+', '-', '*' (multiply), '/' (integer 
    # ;           division), '%' (modulo), or '^' (XOR addition). If an invalid 
    # ;           operator is given, function returns special error code 
    # ;           `0xbaddda7abaddda7a`. Returns error code `0x6469766572726f72` upon 
    # ;           division by zero.
    Case( func_id=5, args=(a:=ord('a'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('a'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('a'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('+'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('+'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('+'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('-'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('-'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('-'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('*'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('*'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('*'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('/'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('/'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('/'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('%'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('%'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('%'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('^'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('^'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('^'), b:=1150, c:=-50), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('b'), b:=0, c:=0), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('b'), b:=10, c:=10), ret_val=f5(a, b, c)),
    Case( func_id=5, args=(a:=ord('b'), b:=1150, c:=-50), ret_val=f5(a, b, c)),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
