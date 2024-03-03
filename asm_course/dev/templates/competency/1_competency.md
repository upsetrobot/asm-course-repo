
# <Topic> - Competency

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[ ]` Complete [lab](4_lab.asm).
2. `[ ]` Run `make` to use [Makefile](Makefile) to run application test 
program.

```
INSTRUCTOR COMMENTS:  
```


## 1. Complete the Competency Lab

### Competency Assignment

In this lab, you will implement ...


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- Do NOT use macros, assignments, or directives at this time.
- Do NOT use memory at this time.
- You may only use instructions that have been taught so far which include the 
following:
    - `mov`
    - `add`
    - `sub`
    - `int3`
    - `inc`
    - `dec`
    - `mul`
    - `imul`
    - `div`
    - `idiv`
    - `lea`
    - `xchg`
- You may use labels, but you may not use loops or jumps.
- Use the `sqrt` function provided. It does not change any registers except 
for `eax`. Place the number you want square-rooted in `edi` and the result 
will be in `eax`.


## 2. Run Application Test

Build and run application test using `make`.

``` sh
make
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
Then you can use the following commands to debug your function (in the example 
below we are debugging `studentFunction1`).

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
    again and when it does not crash, the files will be cleaned up. Or use
    `make clean` or `make clean_all`.
</span></span>


[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
