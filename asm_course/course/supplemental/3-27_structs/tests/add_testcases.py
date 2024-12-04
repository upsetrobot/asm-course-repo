#! /usr/bin/env python3

"""
################################################################################
DO NOT EDIT.  ONLY INSTRUCTORS MAY EDIT TEST APPLICATIONS.
################################################################################

3-27 Structs - Test Case Adder Script.

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
Date:       25 Feb 2024

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
import struct
import random

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

# I used this to generate a byte list and manually put it in the asm file 
# data section.
ARR = []
FIRST_ELE = 0x4050b0
ELE_SZ = 0x78

ARR.append(struct.pack(
    '<qi16sqqiiiihhi16siiiiiiiii',
    FIRST_ELE + ELE_SZ*1,
    1,
    b'C245h0v3221d3',       # handle.
    100000,                 # exp.
    1000,                   # crypto_curr.
    100,                    # coin.
    99,                     # speed.
    99,                     # power.
    20,                     # charisma.
    10,                     # life.
    99,                     # weapon.
    5,                      # ammo.
    b'NONE',                # affliate.
    99,                     # typing_skl.
    99,                     # re_skl.
    50,                     # vuln_skl.
    99,                     # net_skl.
    50,                     # os_skl.
    20,                     # prog_skl.
    99,                     # intrus_skl.
    99,                     # trav_skl.
    50,                     # crypto_skl.
))
ARR.append(struct.pack(
    '<qi16sqqiiiihhi16siiiiiiiii',
    FIRST_ELE + ELE_SZ*2,
    2,
    b'NEO',                 # handle.
    -1,                     # exp.
    0,                      # crypto_curr.
    0,                      # coin.
    -1,                     # speed.
    -1,                     # power.
    99,                     # charisma.
    -1,                     # life.
    -1,                     # weapon.
    -1,                     # ammo.
    b'ZION',                # affliate.
    10,                     # typing_skl.
    -1,                     # re_skl.
    -1,                     # vuln_skl.
    -1,                     # net_skl.
    -1,                     # os_skl.
    -1,                     # prog_skl.
    -1,                     # intrus_skl.
    1000000000,             # trav_skl.
    1000000000,             # crypto_skl.
))
ARR.append(struct.pack(
    '<qi16sqqiiiihhi16siiiiiiiii',
    0,      # Last element.
    3,
    b'matt',                # handle.
    1000000,                # exp.
    0,                      # crypto_curr.
    1000,                   # coin.
    99,                     # speed.
    99,                     # power.
    99,                     # charisma.
    1,                      # life.
    0,                      # weapon.
    10,                     # ammo.
    b'Anarchy',             # affliate.
    100,                    # typing_skl.
    100,                    # re_skl.
    100,                    # vuln_skl.
    100,                    # net_skl.
    100,                    # os_skl.
    100,                    # prog_skl.
    100,                    # intrus_skl.
    100,                    # trav_skl.
    100,                    # crypto_skl.
))
ARR = b''.join(ARR)
ARR_STR = [hex(i) for i in ARR]
ARR_STR = str(ARR_STR).replace("'", '').replace('[', '').replace(']', '') # Copy and paste this value.

def f1(arr, arr_sz):
    sz = len(arr) // arr_sz
    ret = 0
    for i in range(arr_sz):
        ret += struct.unpack('<q', arr[i*sz + 16:i*sz+24])[0]

    return ret

def f2(handle: str, power):
    ret = struct.pack(
        '<16sqqiiiihhi16siiiiiiiii',
        handle.encode(),        # handle.
        0,                      # exp.
        0,                      # crypto_curr.
        0,                      # coin.
        1,                      # speed.
        power,                  # power.
        1,                      # charisma.
        10,                     # life.
        0,                      # weapon.
        0,                      # ammo.
        b'NONE',                # affliate.
        1,                      # typing_skl.
        1,                      # re_skl.
        1,                      # vuln_skl.
        1,                      # net_skl.
        0,                      # os_skl.
        2,                      # prog_skl.
        1,                      # intrus_skl.
        0,                      # trav_skl.
        1,                      # crypto_skl.
    )
    return ret

def f3(handle, arr):
    num = len(arr) // ELE_SZ
    ret = 0
    
    for i in range(num):
        pos = i*ELE_SZ + 12
        if arr[pos:pos+16].strip(b'\x00') == handle:
            ret = FIRST_ELE + i*ELE_SZ + 12
            break

    return ret


# -----------------------------------------------------------------------------



# Add cases to `case_list`. `case_list` is imported by the 
# `test_case_generator.py`, so all test cases have to be add to this list.
case_list = CaseList()
case_list.cases = [

    # -------------------------- Add new cases here. --------------------------
        
    # ; 2. New Struct.
    # ;
    # ; struct hacker* studentFunction2(char* handle, int power)
    # ;
    # ; @brief    Function allocates a new hacker struct and populates with the 
    # ;           given data and the default data and returns a pointer to it.
    Case( func_id=2, args=(a:='handle', b:=0), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:='0c001', b:=10), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:='WHAT', b:=1), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:='MORPHEUS', b:=1000), ret_val=f2(a, b) ),
    Case( func_id=2, args=(a:='8l4cKR46617', b:=9999), ret_val=f2(a, b) ),


    # ; 3. Find Hacker in List.
    # ;
    # ; struct hacker* studentFunction3(char* handle, struct hxr_node* list);
    # ;
    # ; @brief    Function searches `list` for a `hacker` with the given `handle`.
    # ;           Function returns a pointer to the `hacker` struct if found; else 
    # ;           returns NULL.
    Case( func_id=3, args=(a:=b'none', FIRST_ELE), ret_val=f3(a, ARR) ),
    Case( func_id=3, args=(a:=b'C245h0v3221d3', FIRST_ELE), ret_val=f3(a, ARR) ),
    Case( func_id=3, args=(a:=b'NEO', FIRST_ELE), ret_val=f3(a, ARR) ),
    Case( func_id=3, args=(a:=b'matt', FIRST_ELE), ret_val=f3(a, ARR) ),


    # -------------------------------------------------------------------------

]



# Scripting space were you can add more cases if needed.
# -------------------------- Or add new cases here. ---------------------------


# ; 1. Iterate Struct Array.
# ;
# ; unsigned long long studentFunction1(struct hacker* hxr_arr, size_t num_hxrs);
# ;
# ; @brief    Function iterates the given struct array and adds up the 
# ;           experience of all the hackers. It then returns the sum.
def genArr():
    arr = b''

    for i in range(50):
        arr += struct.pack(
            '<16sqqiiiihhi16siiiiiiiii',
            b'blah',                # handle.
            random.randint(0,1000), # exp.
            random.randint(0,1000), # crypto_curr.
            random.randint(0,1000), # coin.
            random.randint(0,99),   # speed.
            random.randint(0,99),   # power.
            random.randint(0,99),   # charisma.
            random.randint(0,100),  # life.
            random.randint(0,99),   # weapon.
            random.randint(0,9999), # ammo.
            b'NONE',                # affliate.
            random.randint(0,99),   # typing_skl.
            random.randint(0,99),   # re_skl.
            random.randint(0,99),   # vuln_skl.
            random.randint(0,99),   # net_skl.
            random.randint(0,99),   # os_skl.
            random.randint(0,99),   # prog_skl.
            random.randint(0,99),   # intrus_skl.
            random.randint(0,99),   # trav_skl.
            random.randint(0,99),   # crypto_skl.
        )
    return arr

case_list.add(func_id=1, args=(a:=genArr(), 50), ret_val=f1(a, 50))
case_list.add(func_id=1, args=(a:=genArr(), 50), ret_val=f1(a, 50))


# -----------------------------------------------------------------------------



# End file.
