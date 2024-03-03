#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-11 Competency 2 Its a Bomb! - Test Case Adder Script.

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

def lrotate(a, n):
    return (a << n) | (a >> (64 - n)) & 0xffffffffffffffff

def rrotate(a, n):
    return (a >> n) | (a << (64 - n)) & 0xffffffffffffffff

def circuit_a(a, b, c):
    return (((a*b + a*c + b*c) & 0xffffffffffffffff) % c + 0xdeadbeef - 0x60a7 + 0xca7) & 0xffffffffffffffff

def circuit_b(a, b, c):
    x = rrotate((a << 8) & 0xffffffffffffffff, 22) // 8
    x += (b >> (c & 0xf)) & 0xffffffffffffffff
    x += (lrotate(c >> 3, 42) + 0x20d1ac) & 0xffffffffffffffff

    return x

def circuit_c(a, b, c):
    return ( (((b | c) ^ ((a & b) | c)) ^ 0xffffffffffffffff) ^ 0xca7dec0de57ac05 ) & 0xffffffffffffffff

def f(a, b, c):
    a = circuit_a(a, b, c)
    b = circuit_b(a, b, c)
    c = circuit_c(a, b, c)

    return a ^ b ^ c


# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------

    # ; 1. Timer Deactivation Code.
    # ; 
    # ; unsigned long long studentFunction1(
    # ;   unsigned long long a, 
    # ;   unsigned long long b,
    # ;   unsigned long long c
    # ; );
    # ;
    # ; @brief    Function calculates and returns the timer deactivation code given 
    # ;           three input combination codes (as `long long`s). The combinations 
    # ;           run through circuits that use arithmetic, bitwise, and boolean 
    # ;           operations where Circuit `A` executes first, then `B`, the `C`.
    # ;
    # ;           Circuit A executes the following:
    # ;               `A = ( (A*B + A*C + B*C) % C ) + 0xdeadbeef - 0x60a7 + 0xca7`.
    # ;       
    # ;           Circuit B executes the following:
    # ;               `B = ( ((A << 8) >>> 22) // 8 ) 
    # ;               + (B >> (C & 0xf))
    # ;               + ( (C >> 3) <<< 42 ) + 0x20d1ac`.
    # ;
    # ;           Circuit C executes the following:
    # ;               `C = !( (B | C) ^ ((A & B) | C) ) ^ 0xca7dec0de57ac05`.
    # ;
    # ;           Then the function returns `A ^ B ^ C`.
    Case(
        func_id=1, 
        args=(CaseArg(a:=1, HEX), CaseArg(b:=1, HEX), CaseArg(c:=1, HEX)), 
        ret_val=CaseArg(f(a, b, c), HEX)
    ),
    Case(
        func_id=1, 
        args=(CaseArg(a:=0, HEX), CaseArg(b:=0, HEX), CaseArg(c:=1, HEX)), 
        ret_val=CaseArg(f(a, b, c), HEX)
    ),
    Case(
        func_id=1, 
        args=(CaseArg(a:=10, HEX), CaseArg(b:=11, HEX), CaseArg(c:=12, HEX)), 
        ret_val=CaseArg(f(a, b, c), HEX)
    ),
    Case(
        func_id=1, 
        args=(CaseArg(a:=15422884, HEX), CaseArg(b:=4545454, HEX), CaseArg(c:=2453454, HEX)), 
        ret_val=CaseArg(f(a, b, c), HEX)
    ),
    Case(
        func_id=1, 
        args=(CaseArg(a:=9999999999999, HEX), CaseArg(b:=1000000000, HEX), CaseArg(c:=123456789123485, HEX)), 
        ret_val=CaseArg(f(a, b, c), HEX)
    ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
