#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-15 Loops - Test Case Adder Script.

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


    # ; 1. Power.
    # ;
    # ; unsigned int studentFunction1(unsigned int a, unsigned int b);
    # ;
    # ; @brief    Function executes exponentiation. Finds the `b`th power of `a`. 
    # ;           In other words produces the result of `a` to the power of `b`. 
    # ;           Only calculates positive exponentiation.
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(0, UINT32),  CaseArg(0, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(2, UINT32),  CaseArg(0, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(4, UINT32),  CaseArg(0, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(8, UINT32),  CaseArg(0, UINT32))),
    Case(func_id=1, ret_val=CaseArg(0, UINT32), args=(CaseArg(0, UINT32),  CaseArg(1, UINT32))),
    Case(func_id=1, ret_val=CaseArg(0, UINT32), args=(CaseArg(0, UINT32),  CaseArg(2, UINT32))),
    Case(func_id=1, ret_val=CaseArg(0, UINT32), args=(CaseArg(0, UINT32),  CaseArg(23431, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(1, UINT32),  CaseArg(1, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(1, UINT32),  CaseArg(2, UINT32))),
    Case(func_id=1, ret_val=CaseArg(1, UINT32), args=(CaseArg(1, UINT32),  CaseArg(8455, UINT32))),
    Case(func_id=1, ret_val=CaseArg(2, UINT32), args=(CaseArg(2, UINT32),  CaseArg(1, UINT32))),
    Case(func_id=1, ret_val=CaseArg(4, UINT32), args=(CaseArg(2, UINT32),  CaseArg(2, UINT32))),
    Case(func_id=1, ret_val=CaseArg(8, UINT32), args=(CaseArg(2, UINT32),  CaseArg(3, UINT32))),
    Case(func_id=1, ret_val=CaseArg(16, UINT32), args=(CaseArg(2, UINT32),  CaseArg(4, UINT32))),
    Case(func_id=1, ret_val=CaseArg(268435456, UINT32), args=(CaseArg(4, UINT32),  CaseArg(14, UINT32))),


    # ; 2. XOR String.
    # ; 
    # ; char* studentFunction2(char* string, size_t string_len, char key);
    # ;
    # ; @brief    Function `xor`s each character in the string with the given key 
    # ;           byte.
    Case(func_id=2, args=(CaseArg("aaa", STR), 3, 0xff), ret_val=CaseArg(b"\x9e\x9e\x9e")),
    Case(func_id=2, args=(CaseArg("abb", STR), 3, 0xff), ret_val=CaseArg(b"\x9e\x9d\x9d")),
    Case(func_id=2, args=(CaseArg("abc", STR), 3, 0xff), ret_val=CaseArg(b"\x9e\x9d\x9c")),
    Case(func_id=2, args=(CaseArg("Hello", STR), 5, 0xff), ret_val=CaseArg(b"\xb7\x9a\x93\x93\x90")),
    Case(func_id=2, args=(CaseArg("Encryption", STR), 10, 0x0a), ret_val=CaseArg(b"Odixsz~ced")),
    Case(func_id=2, args=(CaseArg("TRY THIS", STR), 8, 0x01), ret_val=CaseArg(b"USX!UIHR")),
    Case(
        func_id=2, 
        args=(CaseArg("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789", STR), 64, 0x03), 
        ret_val=CaseArg(b"ba`gfedkjihonmlsrqpwvut{zy#BA@GFEDKJIHONMLSRQPWVUT[ZY#32107654;:")
    ),


    # ; 3. Caesar Cipher 1.
    # ;
    # ; char* studentFunction3(char* string)
    # ;
    # ; @brief    Function encrypts the string using a add 1 caesar-like cipher. The 
    # ;           string in null-terminated. This function does not rotate. In other 
    # ;           words `z` becomes `{`.
    Case(func_id=3, args=(CaseArg("aaa", STR), ), ret_val=CaseArg(b"bbb")),
    Case(func_id=3, args=(CaseArg("Sad Encryption", STR),), ret_val=CaseArg(b"Tbe!Fodszqujpo")),
    Case(func_id=3, args=(CaseArg("TRY THIS", STR),), ret_val=CaseArg(b"USZ!UIJT")),
    Case(
        func_id=3, 
        args=(CaseArg("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789", STR),), 
        ret_val=CaseArg(b"bcdefghijklmnopqrstuvwxyz{!BCDEFGHIJKLMNOPQRSTUVWXYZ[!123456789:")
    ),


    # ; 4. Number of Bits Set.
    # ; 
    # ; unsigned long long studentFunction4(unsigned long long a);
    # ;
    # ; @brief    Function returns the number of bits set in the given 64-bit number.
    #
    # sum([int(i) for i in bin(123450) if i == '1']).
    Case(func_id=4, args=(0,), ret_val=0),
    Case(func_id=4, args=(1,), ret_val=1),
    Case(func_id=4, args=(2,), ret_val=1),
    Case(func_id=4, args=(3,), ret_val=2),
    Case(func_id=4, args=(4,), ret_val=1),
    Case(func_id=4, args=(5,), ret_val=2),
    Case(func_id=4, args=(6,), ret_val=2),
    Case(func_id=4, args=(7,), ret_val=3),
    Case(func_id=4, args=(8,), ret_val=1),
    Case(func_id=4, args=(16,), ret_val=1),
    Case(func_id=4, args=(32,), ret_val=1),
    Case(func_id=4, args=(15,), ret_val=4),
    Case(func_id=4, args=(123450,), ret_val=9),
    Case(func_id=4, args=(45661866043,), ret_val=16),
    Case(func_id=4, args=(11112222333344445555,), ret_val=30),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
