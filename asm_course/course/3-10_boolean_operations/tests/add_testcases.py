#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-10 Boolean Operations - Test Case Adder Script.

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

def f1(a):
    return a & 0xffffffffff000000

def f2(a, b):
    return a | b

def f3(a):
    return a & 0xffffff

def f4(a):
    return 0 - a if a > 0 else abs(a)

def f6(a):
    return a | 0xdfff

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. Byte Masking.
    # ;
    # ; int studentFunction1(int a, int b);
    # ;
    # ; @brief    Function returns a number with the three lowest bytes masked. For 
    # ;           example, if `a` is `0xaabbccdd11223344`, then `0xaabbccdd11000000` 
    # ;           would be returned.
    Case( func_id=1, args=(a:=0, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=10, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=100, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=1000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=10000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=100000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=1000000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=10000000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=100000000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=1000000000, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=65635, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=16777216, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=16777217, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=1546325, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=885533, ), ret_val=f1(a) ),
    Case( func_id=1, args=(a:=846523155, ), ret_val=f1(a) ),


    # ; 2. Bitwise OR.
    # ;
    # ; long long studentFunction2(long long a, long long b);
    # ;
    # ; @brief    Function calculates bitwise or.
    # Test Case 1
    Case(func_id=2, args=(0, 0), ret_val=0),
    # Test Case 2
    Case(func_id=2, args=(0, 1), ret_val=1),
    # Test Case 3
    Case(func_id=2, args=(1, 0), ret_val=1),
    # Test Case 4
    Case(func_id=2, args=(1, 1), ret_val=1),
    # Test Case 5
    Case(func_id=2, args=(3, 5), ret_val=7),
    # Test Case 6
    Case(func_id=2, args=(10, 20), ret_val=30),
    # Test Case 7
    Case(func_id=2, args=(255, 0), ret_val=255),
    # Test Case 8
    Case(func_id=2, args=(255, 255), ret_val=255),
    # Test Case 9
    Case(func_id=2, args=(127, 128), ret_val=255),
    # Test Case 10
    Case(func_id=2, args=(100, 50), ret_val=118),

    Case( func_id=2, args=(a:=846523155, b:=2389344), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:=445455, b:=100000), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:=1212121212, b:=1111111111), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:=183154531, b:=15354843), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:=846523155, b:=1), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:=846523155, b:=2), ret_val=f2(a, b) ),


    # ; 3. Byte Stripping.
    # ;
    # ; int studentFunction3(long long a);
    # ;
    # ; @brief    Function returns the lower 3 bytes.
    Case( func_id=3, args=(a:=0, ), ret_val=f3(a) ),
    Case(func_id=3, args=(a:=16777217,), ret_val=f3(a) ),

    # Test Case 1
    Case(func_id=3, args=(0,), ret_val=0),
    # Test Case 2
    Case(func_id=3, args=(1,), ret_val=1),
    # Test Case 3
    Case(func_id=3, args=(255,), ret_val=255),
    # Test Case 4
    Case(func_id=3, args=(65535,), ret_val=65535),
    # Test Case 5
    Case(func_id=3, args=(16777215,), ret_val=16777215),
    # Test Case 6
    Case(func_id=3, args=(16777216,), ret_val=0),
    # Test Case 7
    Case(func_id=3, args=(33554432,), ret_val=0),
    # Test Case 8
    Case(func_id=3, args=(4294967295,), ret_val=16777215),
    # Test Case 9
    Case(func_id=3, args=(100, ), ret_val=100),
    # Test Case 10
    Case(func_id=3, args=(16777214,), ret_val=16777214),


    # ; 4. Reverse Sign.
    # ;
    # ; long long studentFunction4(long long a);
    # ;
    # ; @brief    Function returns reverse sign of `a`.
    Case( func_id=4, args=(a:=0, ), ret_val=f4(a) ),

    # Test Case 1
    Case(func_id=4, args=(0,), ret_val=0),
    # Test Case 2
    Case(func_id=4, args=(1,), ret_val=-1),
    # Test Case 3
    Case(func_id=4, args=(-1,), ret_val=1),
    # Test Case 4
    Case(func_id=4, args=(100,), ret_val=-100),
    # Test Case 5
    Case(func_id=4, args=(-100,), ret_val=100),
    # Test Case 6
    Case(func_id=4, args=(2147483647,), ret_val=-2147483647),
    # Test Case 7
    Case(func_id=4, args=(-2147483647,), ret_val=2147483647),
    # Test Case 8
    Case(func_id=4, args=(2147483648,), ret_val=-2147483648),
    # Test Case 9
    Case(func_id=4, args=(-2147483648,), ret_val=2147483648),
    # Test Case 10
    Case(func_id=4, args=(9223372036854775807,), ret_val=-9223372036854775807),


    # ; 5. Return 0.
    # ;
    # ; long long studentFunction5(unsigned long long a, long long b, long long c);
    # ;
    # ; @brief    Function returns 0.
    Case( func_id=5, args=(0, 0, 0), ret_val=0 ),
    Case( func_id=5, args=(0, 0, 1), ret_val=0 ),
    Case( func_id=5, args=(0, 1, 0), ret_val=0 ),
    Case( func_id=5, args=(1, 0, 0), ret_val=0 ),
    Case( func_id=5, args=(1, 1, 1), ret_val=0 ),
    Case( func_id=5, args=(-1, 4, 0), ret_val=0 ),
    Case( func_id=5, args=(-125151513, 551515, 85852), ret_val=0 ),
    Case( func_id=5, args=(656361, 54534354, 8545425), ret_val=0 ),


    # ; 6. Setting Bits.
    # ; 
    # ; long long studentFunction6(long long a);
    # ;
    # ; @brief    Function returns `a` with the lower 14 bits set.
    Case( func_id=6, args=(a:=0, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=1, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=4, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=334, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=16384, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=16385, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=5650, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=954565990, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=44455450, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=111111110, ), ret_val=f6(a) ),
    Case( func_id=6, args=(a:=111111111110, ), ret_val=f6(a) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
