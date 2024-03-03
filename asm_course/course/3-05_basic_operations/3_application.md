
# 3-05 Basic Operations - Application

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[ ]` Complete [lab](4_lab.asm).
2. `[ ]` Run `make` to use [Makefile](Makefile) to run application test 
program.

```
INSTRUCTOR COMMENTS:  
```


## 1. Complete Lab

In this lab, you will implement two assembly functions `studentFunction1` and 
`studentFunction2`. Each function will be called by a C program that will test 
your implementation. Functions in x64 Linux work by passing arguments via the 
registers (more on this topic will be discussed in a later module). What you 
need to know is that the order of parameters is `rdi`, `rsi`, `rdx`, `rcx`, 
`r8`, and `r9`, and that the return value is passed back to the caller in 
`rax`. 

Open the lab file and scroll down. You will find two functions. In between 
the lines in the comments, add assembly code to meet the condition stated in 
the comments above the function.

For example, you find the following code:

``` x86asm
; int studentFunction1(int a, int b)
;
; @brief    Function adds two numbers together and returns the sum.
;
; @param    a   The augend
; @param    b   The addend
; @return   int Returns the sum of `a` and `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; -- Add your solution below this line -------------------------------------

     

    ; -- Do not edit below this line -------------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Notice the size of the arguments. In this case, `int`s are being passed in,
    which are four bytes long each, and therefore are `DWORD`s. The return type
    is a `DWORD` as well, so the caller will only expecting to interpret what
    is in `eax` (the lower 32-bits of `rax`).
</span></span>

To complete this, you add your code as in this example:

``` x86asm
; int studentFunction1(int a, int b)
;
; @brief    Function adds two numbers together and returns the sum.
;
; @param    a   The augend
; @param    b   The addend
; @return   int Returns the sum of `a` and `b`.
;
; TODO: Implement this function.
; RULE: Do not use macros, directives, constants, or memory at this time.
; RULE: Only use the following operations: `mov`, `add`, `sub`.
; RULE: You can use internal dot labels (e.g., `.label`) if needed.
;
studentFunction1:

    ; -- Add your solution below this line -------------------------------------

    add edi, esi        ; Add arguments together.
    mov eax, edi        ; Clears register and moves sum to return register.

    ; Now rax is populated with the return value, so assignment is complete.

    ; -- Do not edit below this line -------------------------------------------
    ret         ; Notice there is a ret operation at the end of a function.
```


## 2. Run Application Test

Build application test using `make`

``` sh
make
```

This will build and run your application and test it. It will print out results 
about your solution. Output of the test will tell you if the test passed or 
not.  If the test did not pass, fix any errors and try again. 

Failure Example:

```
rm -f *.o application_test test_data.dat
nasm -f elf64 5_application_lab.nasm -o 5_application_lab.o
gcc -g -Wall -Wextra -no-pie 5_application_lab.o application_test.c -o application_test
/bin/python3 test_case_generator.py
rm -fr *.o __pycache__
valgrind ./application_test
==120664== Memcheck, a memory error detector
==120664== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==120664== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==120664== Command: ./application_test
==120664== 
====================== Welcome to the Application Tester! ======================

Please only use instructions covered up until this point.
Testing functions...

        Case 1          studentFunction1        FAILED

Test failed.
Parameters: 0, 0
Expected: 0
Got: 1

Application test complete.

Sorry, the test did not pass. Please try again.

================================================================================
==120664== 
==120664== HEAP SUMMARY:
==120664==     in use at exit: 0 bytes in 0 blocks
==120664==   total heap usage: 4 allocs, 4 frees, 13,656 bytes allocated
==120664== 
==120664== All heap blocks were freed -- no leaks are possible
==120664== 
==120664== For lists of detected and suppressed errors, rerun with: -s
==120664== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
rm -f *.o application_test test_data.dat
```

Passing Example:

```
rm -f *.o application_test test_data.dat
nasm -f elf64 5_application_lab.nasm -o 5_application_lab.o
gcc -g -Wall -Wextra -no-pie 5_application_lab.o application_test.c -o application_test
/bin/python3 test_case_generator.py
rm -fr *.o __pycache__
valgrind ./application_test
==118404== Memcheck, a memory error detector
==118404== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==118404== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==118404== Command: ./application_test
==118404== 
====================== Welcome to the Application Tester! ======================

Please only use instructions covered up until this point.
Testing functions...

        Case 1          studentFunction1        PASSED
        Case 2          studentFunction1        PASSED
        Case 3          studentFunction2        PASSED
        Case 4          studentFunction2        PASSED

Application test complete.

CONGRATULATIONS! ALL TESTS PASSED!

================================================================================
==118404== 
==118404== HEAP SUMMARY:
==118404==     in use at exit: 0 bytes in 0 blocks
==118404==   total heap usage: 4 allocs, 4 frees, 13,656 bytes allocated
==118404== 
==118404== All heap blocks were freed -- no leaks are possible
==118404== 
==118404== For lists of detected and suppressed errors, rerun with: -s
==118404== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
rm -f *.o application_test test_data.dat
```

This will build and run your application and test it. It will print out 
results of your solution test. Output of the test will tell you if the test 
passed or not.  If the test did not pass, fix any errors and try again.

Note the output and fix any errors if needed. If you need help, ask an 
instructor. You can also examine what is happening in each register by 
debugging your function in `gdb`.

If you want to debug your application in `gdb`, you can use the following 
`make` command to build your application executable without cleaning it up:

``` sh
make build
```

This will build your application without running it or cleaning up the files. 
Then you can use the following commands to debug your function (in this 
case, we are debugging `studentFunction1`).

``` sh
gdb ./application_test
b studentFunction1
r
```

Afterwards, you can use `make` again to clean up or use the following command 
to clean up files:

``` sh
make clean_all
```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    Note that if your program crashes during the test, the files will not be
    automatically cleaned up. This is not problem, just fix it and use `make`
    again and when it does not crash, the files will be cleaned up.
</span></span>


[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
