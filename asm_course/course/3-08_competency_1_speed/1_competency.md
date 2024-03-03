
# 🧪 3-08 Competency 1 Speed - Competency

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

In this lab, you will implement a given assembly function. Your function will 
be given starting and ending coordinates in miles for a two-dimensional plane 
and a time in minutes that someone should be able to travel between the two 
points. You will return the minimum integral (integer) speed in miles per hour 
that someone at point 1 has to travel to get to point 2 in time.

So, basically, given `x1`, `y1`, `x2`, `y2`, and `t`, you have to calculate
`sqrt( (y2 - y1)^2 + (x2 - x1)^2 ) // (t / 60) + 1`. A square root function
will be provided for you.

<br>

$$
    % ( sqrt((y_2 - y_1)**2 + (x_2 - x_1)**2) // (t // 60) ) + 1
    \Biggl \lfloor 
        \frac {\sqrt {(y_2 - y_1)^2 + (x_2 - x_1)^2}} {\frac {t} {60}} 
    \Biggr \rfloor
     + 1
$$

<br>

```
.
.             |  t = 120
.             |
6             |        X P2(3,6)
5             |      _/             Distance = sqrt((6-2)^2 + (3-1)^2) ~ 5 mi. 
4             |    _/               Time in hours: t_hours = 120 / 60 = 2.
3             |   /                 Speed = 5 // 2 = 2 mph.
2             |  X P1(1,2)          Minimum Speed = Speed + 1 = 3 mph.
1             |
0 +--+--+--+--+--+--+--+--+--+--+--+--+--
-1  ... -2 -1 0  1  2  3  4  5  6  ...
-2            |
.             |
.             |
.             |
```

Even if the math results in integer division, you will still increment by one. 
(E.g., 8 // 4 = 2; so the minimum speed is 2 mph, but you will still result in 
3 mph to account for non-integer division (basically, you are doing this for 
now; later you will learn about branching, control flow, and boolean 
operations, any of which would allow you to solve the problem here while being 
able to round down or up as needed)).


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- Do NOT use macros, assignments, or directives at this time.
- Do NOT use memory at this time.
- You may only use instructions that have been taught so far which include the 
following:
    - `mov`
    - `add`, `sub`
    - `int3`
    - `inc`, `dec`
    - `mul`, `imul`
    - `div`, `idiv`
    - `cbw`, `cwde`, `cdqe`
    - `cwd`, `cdq`, `cqo`
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
