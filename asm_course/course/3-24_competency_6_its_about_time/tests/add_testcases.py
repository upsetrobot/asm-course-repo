#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-24 Competency 6 Its About Time - Test Case Adder Script.

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
import time

## Other libraries.
# None.

## Local libraries.
sys.path.append(str(Path(__file__).resolve().parent))
from testcaselib import *


# Use this for programs with user input. Each line without the newline.
# INPUT = ['hello', 'what'] # represents 'hello' followed by an `ENTER` and 
# then 'what' followed by an `ENTER`.
INPUT = [
    '', '', '0', '0',
    'a', '1', 'a', '1',
    '1a', '25', '1a', '61',
    '33', '33',
]


# You can add functions here if you want or after the list.
# ------------- Add Functions Here If Desired To Use in List. -----------------

def printTime(hours, mins):
    print("TIME: ", end='')

    if hours >= 10:
        print(chr(1 + ord('0')), end='')
        p = hours % 10
        print(chr(p + ord('0')), end='')

    else:
        print(chr(hours + ord('0')), end='')

    print(':', end='')
    print(chr(mins // 10 + ord('0')), end='')
    print(chr(mins % 10 + ord('0')), end='\n')

    return

def getHours(secs):
    r = (secs // 60 // 60 % 24) - 5
    if r > 0:
        return r % 12
    else:
        return (r + 24) % 12

def getMins(secs):
    return secs // 60 % 60

def getTwoDigits():
    buf = b"\0" * 255
    buf = sys.stdin.readline(255)

    if buf[0] == '\0' or buf[0] == '\n':
        return -1

    if ord(buf[0]) < ord('0') or ord(buf[0]) > ord('9'):
        sys.stdout.write("Error: Invalid Input\n")
        sys.stdout.flush()
        return -1

    if buf[1] == '\0' or buf[1] == '\n':
        return ord(buf[0]) - ord('0')

    if ord(buf[1]) < ord('0') or ord(buf[1]) > ord('9'):
        sys.stdout.write("Error: Invalid Input\n")
        sys.stdout.flush()
        return -1

    return (ord(buf[0]) - ord('0'))*10 + (ord(buf[1]) - ord('0'))

def inputHours():
    sys.stdout.write("Enter hours: ")
    sys.stdout.flush()
    return getTwoDigits()

def inputMins():
    sys.stdout.write("Enter minutes: ")
    sys.stdout.flush()
    return getTwoDigits()

def f1(input_hours, input_mins):
    s = int(time.time())
    h = getHours(s)
    m = getMins(s)
    #printTime(h, m)

    h_to_add = -1
    m_to_add = -1

    while h_to_add == -1:
        # h_to_add = inputHours()
        h_to_add = input_hours

    while m_to_add == -1:
        # m_to_add = inputMins()
        m_to_add = input_mins

    h = (h + h_to_add + (m + m_to_add) // 60) % 12
    m = (m + m_to_add) % 60

    #printTime(h, m)

    return h*3600 + m*60

# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------


    # ; 1. Competency 6 Its About Time.
    # ;
    # ; unsigned int studentFunction1();
    # ;
    # ; @brief    This function gets the time using the `time` syscall (which returns
    # ;           the time in seconds in UTC time since January 1, 1970). Then the 
    # ;           time is converted to time in EST zone hours and minutes. The time 
    # ;           is printed in hh:mm format. Then the user is prompted for hours 
    # ;           to add in form of one or two digits. Then the user is prompted for 
    # ;           minutes to add in the form of one or two digits. The hours are 
    # ;           added to the current hours, and the minutes are added to the 
    # ;           current minutes. Then the new time is printed. Finally, the 
    # ;           function returns the current time value of hours and minutes in 
    # ;           the number of seconds. 
    # ;
    # ;           The number of EST hours is calculated using the following 
    # ;           equation:
    # ;               `h = (s // 60 // 60 % 24) - 5
    # ;               if h > 0: h = h % 12
    # ;               else: h = (h + 24) % 12`.
    # ;
    # ;           The number of minutes is calculated using the following equation:
    # ;               `m = s // 60 % 60`.
    # ;
    # ;           After the time is set, the minutes are added using this equation:
    # ;               `new_m` = (m + user_m) % 60`.
    # ;
    # ;           And the new hours are added using this equation:
    # ;               `new_h = (h + user_h + (m + user_m) // 60) % 12`.
    # ;
    # ;           The return value is calculated using the following equation:
    # ;               `return new_h*3600 + new_m*60`.
    # ;
    # ;           Full Python code example can be found in the `1_competency.md` 
    # ;           file.
    Case( func_id=1, args=(), ret_val=f1(0, 0) ),
    Case( func_id=1, args=(), ret_val=f1(1, 1) ),
    Case( func_id=1, args=(), ret_val=f1(25, 61) ),
    Case( func_id=1, args=(), ret_val=f1(33, 33) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------




# -----------------------------------------------------------------------------



# End file.
