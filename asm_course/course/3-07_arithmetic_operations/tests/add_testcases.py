#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-07 Arithmetic - Test Case Adder Script.

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

    `case_list` -- This is base class for holding all the test cases to be 
    generated. This is already created in the template and is imported by the 
    `test_case_generator.py` script. Show no action is need if you are just 
    trying to add more test cases.

        `case_list.add(Case)` -- You can use this function to add one case. Or 
        you can add cases to the `case_list.cases` list (which is what the 
        `add` function does).

        `case_list.generate_data_file(str)` -- This function produces a binary 
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


    # ; 1. Basic Multiplication.
    # ;
    # ; int studentFunction1(int a, int b);
    # ;
    # ; @brief    Function multiplies two numbers together and returns the product.
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(0, INT32),  CaseArg(0, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(0, INT32),  CaseArg(1, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(1, INT32),  CaseArg(0, INT32))),
    Case(func_id=1, ret_val=CaseArg(1, INT32), args=(CaseArg(1, INT32),  CaseArg(1, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(2, INT32),  CaseArg(0, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(0, INT32),  CaseArg(2, INT32))),
    Case(func_id=1, ret_val=CaseArg(2, INT32), args=(CaseArg(1, INT32),  CaseArg(2, INT32))),
    Case(func_id=1, ret_val=CaseArg(4, INT32), args=(CaseArg(2, INT32),  CaseArg(2, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(0, INT32),  CaseArg(-1, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(-1, INT32), CaseArg(0, INT32))),
    Case(func_id=1, ret_val=CaseArg(-1, INT32), args=(CaseArg(-1, INT32), CaseArg(1, INT32))),
    Case(func_id=1, ret_val=CaseArg(-1, INT32), args=(CaseArg(1, INT32),  CaseArg(-1, INT32))),
    Case(func_id=1, ret_val=CaseArg(1, INT32), args=(CaseArg(-1, INT32), CaseArg(-1, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(-2, INT32), CaseArg(0, INT32))),
    Case(func_id=1, ret_val=CaseArg(0, INT32), args=(CaseArg(0, INT32),  CaseArg(-2, INT32))),
    Case(func_id=1, ret_val=CaseArg(-2, INT32), args=(CaseArg(-1, INT32), CaseArg(2, INT32))),
    Case(func_id=1, ret_val=CaseArg(-2, INT32), args=(CaseArg(1, INT32),  CaseArg(-2, INT32))),
    Case(func_id=1, ret_val=CaseArg(2, INT32), args=(CaseArg(-1, INT32), CaseArg(-2, INT32))),
    Case(func_id=1, ret_val=CaseArg(-4, INT32), args=(CaseArg(-2, INT32), CaseArg(2, INT32))),
    Case(func_id=1, ret_val=CaseArg(-4, INT32), args=(CaseArg(2, INT32),  CaseArg(-2, INT32))),
    Case(func_id=1, ret_val=CaseArg(-20508, INT32), args=(CaseArg(-2, INT32), CaseArg(10254, INT32))),
    Case(func_id=1, ret_val=CaseArg(2000000000, INT32), args=(CaseArg(2000, INT32), CaseArg(1000000, INT32))),
    Case(func_id=1, ret_val=CaseArg(-2000000000, INT32), args=(CaseArg(2000, INT32), CaseArg(-1000000, INT32))),


    # ; 2. Multiply Number by 8000.
    # ;
    # ; unsigned long long studentFunction2(unsigned long long a);
    # ;
    # ; @brief    Function returns product of `a` and `8000` (`a*8000`). 
    Case(func_id=2, ret_val=0, args=(0,)),
    Case(func_id=2, ret_val=8000, args=(1,)),
    Case(func_id=2, ret_val=-8000, args=(-1,)),  # Math checks out; will be 
    Case(func_id=2, ret_val=16000, args=(2,)),   # twos complement of this.
    Case(func_id=2, ret_val=80000, args=(10,)),


    # ; 3. Division of Differences. 
    # ;
    # ; long long studentFunction3(
    # ;   long long a, 
    # ;   long long b, 
    # ;   long long c, 
    # ;   long long d
    # ; );
    # ;
    # ; @brief    Function returns result of following calculation 
    # ;           `(c - d) * b / (a - 1)`. Does not handle division by zero error.
    Case(func_id=2, ret_val=0, args=(0, 0, 0, 0)),
    # Case(func_id=2, ret_val=0, args=(1, 0, 0, 0)),    # Div by 0.
    Case(func_id=3, ret_val=0, args=(0, 1, 0, 0)),
    Case(func_id=3, ret_val=0, args=(0, 0, 1, 0)),
    Case(func_id=3, ret_val=0, args=(0, 0, 0, 1)),
    Case(func_id=3, ret_val=0, args=(0, 1, 1, 1)),
    Case(func_id=3, ret_val=0, args=(0, 2, 0, 0)),
    Case(func_id=3, ret_val=0, args=(0, 0, 2, 0)),
    Case(func_id=3, ret_val=0, args=(0, 0, 0, 2)),
    Case(func_id=3, ret_val=0, args=(0, 2, 1, 1)),
    Case(func_id=3, ret_val=-1, args=(0, 1, 2, 1)),
    Case(func_id=3, ret_val=1, args=(0, 1, 1, 2)),


    # ; 4. Division by Pointer. 
    # ;
    # ; int studentFunction4(int* a, int* b);
    # ;
    # ; @brief    Function returns integer quotient of the integer pointed to by `a` 
    # ;           divided by the integer pointed to by `b`. Does not handle division 
    # ;           by zero errors.
    Case(
        func_id=4, 
        ret_val=CaseArg(0, INT32), 
        args=(
            CaseArg(struct.pack("<i", 0), STR), 
            CaseArg(struct.pack("<i", 1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(1, INT32), 
        args=(
            CaseArg(struct.pack("<i", 1), STR), 
            CaseArg(struct.pack("<i", 1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(2, INT32), 
        args=(
            CaseArg(struct.pack("<i", 2), STR), 
            CaseArg(struct.pack("<i", 1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(1, INT32), 
        args=(
            CaseArg(struct.pack("<i", 2), STR), 
            CaseArg(struct.pack("<i", 2), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(0, INT32), 
        args=(
            CaseArg(struct.pack("<i", 0), STR), 
            CaseArg(struct.pack("<i", -1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(1, INT32), 
        args=(
            CaseArg(struct.pack("<i", -1), STR), 
            CaseArg(struct.pack("<i", -1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(-1, INT32), 
        args=(
            CaseArg(struct.pack("<i", -1), STR), 
            CaseArg(struct.pack("<i", 1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(-1, INT32), 
        args=(
            CaseArg(struct.pack("<i", 1), STR), 
            CaseArg(struct.pack("<i", -1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(-2, INT32), 
        args=(
            CaseArg(struct.pack("<i", -2), STR), 
            CaseArg(struct.pack("<i", 1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(-2, INT32), 
        args=(
            CaseArg(struct.pack("<i", 2), STR), 
            CaseArg(struct.pack("<i", -1), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(1, INT32), 
        args=(
            CaseArg(struct.pack("<i", -2), STR), 
            CaseArg(struct.pack("<i", -2), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(-1, INT32), 
        args=(
            CaseArg(struct.pack("<i", -2), STR), 
            CaseArg(struct.pack("<i", 2), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(2, INT32), 
        args=(
            CaseArg(struct.pack("<i", 18), STR), 
            CaseArg(struct.pack("<i", 9), STR)
        )
    ),
    Case(
        func_id=4, 
        ret_val=CaseArg(2500, INT32), 
        args=(
            CaseArg(struct.pack("<i", 10000), STR), 
            CaseArg(struct.pack("<i", 4), STR)
        )
    ),


    # ; 5. Addition of ASCII Digits.
    # ; 
    # ; int studentFunction5(char a, char b);
    # ;
    # ; @brief    Function converts the given ASCII digits to numbers, adds them 
    # ;           together and returns the sum.

    Case(func_id=5, ret_val=CaseArg(0, INT32), args=(ord('0'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(1, INT32), args=(ord('1'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(1, INT32), args=(ord('0'), ord('1'))),
    Case(func_id=5, ret_val=CaseArg(2, INT32), args=(ord('2'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(3, INT32), args=(ord('3'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(4, INT32), args=(ord('4'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(5, INT32), args=(ord('5'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(6, INT32), args=(ord('6'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(7, INT32), args=(ord('7'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(8, INT32), args=(ord('8'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(9, INT32), args=(ord('9'), ord('0'))),
    Case(func_id=5, ret_val=CaseArg(3, INT32), args=(ord('1'), ord('2'))),
    Case(func_id=5, ret_val=CaseArg(11, INT32), args=(ord('5'), ord('6'))),
    Case(func_id=5, ret_val=CaseArg(18, INT32), args=(ord('9'), ord('9'))),
    Case(func_id=5, ret_val=CaseArg(8, INT32), args=(ord('4'), ord('4'))),
    Case(func_id=5, ret_val=CaseArg(9, INT32), args=(ord('3'), ord('6'))),


    # ; 6. Byte Moving and Swapping.
    # ;
    # ; int studentFunction6(int a, int b);
    # ;
    # ; @brief    Function returns a number with the upper 2 bytes of `b` and the 
    # ;           lower bytes of `a` but reversed. E.g., 
    # ;           `studentFunction6(0xaabbccdd, 0x11223344)` should return 
    # ;           `0x1122ddcc`.
    Case(func_id=6, ret_val=0x00000000, args=(0x00000000, 0x00000000)),
    Case(func_id=6, ret_val=0x00000100, args=(0x00000001, 0x00000000)),
    Case(func_id=6, ret_val=0x00000000, args=(0x00000000, 0x00000001)),
    Case(func_id=6, ret_val=0x00000100, args=(0x00000001, 0x00000001)),
    Case(func_id=6, ret_val=0x0000ff00, args=(0x000000ff, 0x000000ff)),
    Case(func_id=6, ret_val=0x0000ffff, args=(0x0000ffff, 0x0000ffff)),
    Case(func_id=6, ret_val=0xffffffff, args=(0xffffffff, 0xffffffff)),
    Case(func_id=6, ret_val=0x00000000, args=(0xffff0000, 0x0000ffff)),
    Case(func_id=6, ret_val=0x000000aa, args=(0xffffaa00, 0x0000ffff)),
    Case(func_id=6, ret_val=0x0000aa00, args=(0xffff00aa, 0x0000ffff)),
    Case(func_id=6, ret_val=0xaa000000, args=(0xffff0000, 0xaa00ffff)),
    Case(func_id=6, ret_val=0x00aa0000, args=(0xffff0000, 0x00aaffff)),
    Case(func_id=6, ret_val=0x0000bbaa, args=(0xffffaabb, 0x0000ffff)),
    Case(func_id=6, ret_val=0xccddbbaa, args=(0xffffaabb, 0xccddffff)),
    Case(func_id=6, ret_val=0xcafebeba, args=(0xcafebabe, 0xcafebabe)),
    Case(func_id=6, ret_val=0xcafeafec, args=(0xbaddecaf, 0xcafebabe)),
    Case(func_id=6, ret_val=0x87657856, args=(0x12345678, 0x87654321)),


    # ; 7. Return Address.
    # ;
    # ; int* studentFunction7(int* a);
    # ;
    # ; @brief    Returns the address of the fifth integer in the array pointed to 
    # ;           by `a`.
    Case(func_id=7, ret_val=16, args=(0,)),
    Case(func_id=7, ret_val=17, args=(1,)),
    Case(func_id=7, ret_val=136, args=(120,)),
    Case(func_id=7, ret_val=2000016, args=(2000000,)),

    # ChatGPT help.
    Case(func_id=7, ret_val=21, args=(5,)),
    Case(func_id=7, ret_val=8, args=(-8,)),
    Case(func_id=7, ret_val=16, args=(0,)),
    Case(func_id=7, ret_val=116, args=(100,)),
    Case(func_id=7, ret_val=18, args=(2,)),
    Case(func_id=7, ret_val=19, args=(3,)),
    Case(func_id=7, ret_val=6, args=(-10,)),
    Case(func_id=7, ret_val=23, args=(7,)),


    # ; 8. Sum Product.
    # ; 
    # ; long long studentFunction8(long long a, long long b);
    # ;
    # ; @brief    Returns the sum of `a`, `22`, and the product of `8` and `b`. 
    # ;           This would be the result `a + 8*b + 22`.
    Case(func_id=8, ret_val=22, args=(0, 0)),

    # ChatGPT help (which, interestingly, had to be fixed).
    Case(func_id=8, ret_val=43, args=(5, 2)),
    Case(func_id=8, ret_val=22, args=(-8, 1)),
    Case(func_id=8, ret_val=86, args=(0, 8)),
    Case(func_id=8, ret_val=144, args=(10, 14)),
    Case(func_id=8, ret_val=56, args=(2, 4)),
    Case(func_id=8, ret_val=81, args=(3, 7)),
    Case(func_id=8, ret_val=76, args=(-10, 8)),
    Case(func_id=8, ret_val=69, args=(7, 5)),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------


# ChatGPT help.
# Test Case 1
a, b, c, d = 5, 3, 10, 2
# (10 - 2) * 3 // (5 - 1) = 8 * 3 // 4 = 6
expected_result = 6
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 2
a, b, c, d = 2, 5, 8, 1
# (8 - 1) * 5 // (2 - 1) = 7 * 5 // 1 = 35
expected_result = 35
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 3
a, b, c, d = 7, 2, 9, 4
# (9 - 4) * 2 // (7 - 1) = 5 * 2 // 6 = 1
expected_result = 1
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 4
a, b, c, d = 3, 4, 6, 2
# (6 - 2) * 4 // (3 - 1) = 4 * 4 // 2 = 8
expected_result = 8
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 5
# a, b, c, d = 1, 2, 3, 4
# # (3 - 4) * 2 // (1 - 1) = -1 * 2 // 0, Division by zero, handle this case in your function
# expected_result = "Division by zero"

# Test Case 6
a, b, c, d = 6, 3, 12, 2
# (12 - 2) * 3 // (6 - 1) = 10 * 3 // 5 = 6
expected_result = 6
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 7
a, b, c, d = 0, 5, 8, 2
# (8 - 2) * 5 // (0 - 1) = 6 * 5 // -1 = -30
expected_result = -30
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 8
a, b, c, d = 4, 3, 9, 1
# (9 - 1) * 3 // (4 - 1) = 8 * 3 // 3 = 8
expected_result = 8
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 9
a, b, c, d = -2, 3, 7, 1
# (7 - 1) * 3 // (-2 - 1) = 6 * 3 // -3 = -6
expected_result = -6
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))

# Test Case 10
a, b, c, d = 10, 2, 5, 3
# (5 - 3) * 2 // (10 - 1) = 2 * 2 // 9 = 0
expected_result = 0
case_list.add(func_id=3, ret_val=expected_result, args=(a, b, c, d))


# -----------------------------------------------------------------------------



# End file.
