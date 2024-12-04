#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-23 Interrupts and Syscalls - Test Case Adder Script.

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
    'abc',              # Case 1 of function 4.
    ''                  # Case 2 of function 4. 
]


# You can add functions here if you want or after the list.
# ------------- Add Functions Here If Desired To Use in List. -----------------



# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. Print Constant String "Welcome Aliens".
    # ;
    # ; char* studentFunction1();
    # ;
    # ; @brief    Function prints the message "Welcome, Aliens\n" to standard output 
    # ;           terminal and returns a pointer to the message.
    Case( func_id=1, args=(), ret_val="Welcome, Aliens\n" ),


    # ; 2. Print Given String.
    # ;
    # ; ssize_t studentFunction2(char* msg);
    # ;
    # ; @brief    Function prints `msg` to the screen and returns the number of 
    # ;           bytes written or an error code given by the syscall.
    # ;
    # ;           Pseudocode: `print(msg, end='')`.
    Case( func_id=2, args=("",), ret_val=0 ),
    Case( func_id=2, args=("a\n",), ret_val=2 ),
    Case( func_id=2, args=("hello\n",), ret_val=6 ),
    Case( func_id=2, args=("This is a longer message.\n",), ret_val=26 ),
    

    # ; 3. Concatenate Strings.
    # ;
    # ; char* studentFunction3(char* msg1, size_t msg1_len, char* msg2, size_t msg2_len);
    # ;
    # ; @brief    Function copies `msg1` to a buffer followed by the string " & " 
    # ;           and then `msg2` followed by a newline and null terminator and then 
    # ;           prints and returns the buffer. Given strings are null-terminated.
    # ;           Entire output striasm_course/dev/templates/competency/tests/add_testcases.py points to "Cheese" and `msg2` points to 
    # ;                    "Crackers", then "Cheese & Crackers\n" is printed and its 
    # ;                    pointer is returned.
    # ;
    # ;           Pseudocode: `print(msg1 + " & " + msg2 + "\n", end='')`.
    Case( func_id=3, args=(a:="Cheese", len(a), b:="Crackers", len(b)), ret_val=a + ' & ' + b + '\n' ),
    Case( func_id=3, args=(a:="a", len(a), b:="b", len(b)), ret_val=a + ' & ' + b + '\n' ),
    Case( func_id=3, args=(a:="Pickles", len(a), b:="Teriyaki", len(b)), ret_val=a + ' & ' + b + '\n' ),
    Case( func_id=3, args=(a:="movs", len(a), b:="nops", len(b)), ret_val=a + ' & ' + b + '\n' ),
    

    # ; 4. Print Input from User.
    # ;
    # ; unsigned long long studentFunction4();
    # ;
    # ; @brief    Function prints "Input: " and then gets input from user and then
    # ;           prints it to the screen. If the first character in the user input
    # ;           is a `@`, the function also prints the message "HOORAY\n" after
    # ;           printing the input. When the input is printed, it is followed by a 
    # ;           newline. Function returns `0`.
    # ;
    # ;           Python: `print(a := input("Input: ")); print("HOORAY") if a[0]=='@' else None`. 
    # ;           Pseudocode:
    # ;               `a = input("Input: ")
    # ;               print(a + '\n', end='')
    # ;               if a[0] == '@':
    # ;                   print("HOORAY\n", end='')`.
    Case( func_id=4, args=("abc\n",), ret_val="abc\n" ),
    Case( func_id=4, args=("\n",), ret_val="HOORAY\n" ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------



# -----------------------------------------------------------------------------



# End file.
