
# 💣 3-11 Competency 2 Its a Bomb! - Competency

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[ ]` Complete [lab](4_lab.nasm).
2. `[ ]` Run `make` to use [Makefile](Makefile) to run application test 
program.

```
INSTRUCTOR COMMENTS:  
```


## 1. Complete the Competency Lab

### Competency Assignment

In this lab, you will implement a function that helps you deactivate the bomb! 
Your function will return the result code after calculations from three input 
codes which are the inputs to a digital combination lock on a bomb. 

``` vim (for color)

        .---------------------------------------------------.               
        ||       Deactivate Code: #$%!!@#@                  |\               
        ||  //           .------.  ____        TIMER        | |      __________
        || ////// code A | 0000 | |++++|,~~~.----------.    | |     |l---------
        ||    //          >----<   ____ |.~~| 00:08:05 | // | |     || MANUAL  
        ||        code B | 0000 | |++++|||.~'----------' // | |     ||--- ---- 
        || //             >----<   ____ |||      o          | |     ||-- -- ---
        ||        code C | 0000 | |++++||||   __/__         | |     ||---- --- 
        || //            '------'       |||      o          | |     || -= '"\-/
        ||=============[:]`~|~|~~~~~~~~~'||   __/__   ( / ) | |     ||  L_/'o -
        ||#############     '~|~~~~~~~~~~'|                 | |     ||--- -----
        ||#############       '~~~~~~~~~~~'    O  O  O      | |     ||- --- ---
        |___________________________________________________| |     |;_33______
        '---------------------------------------------------' |     '----------
         \___________________________________________________\|               

```

During your analysis of the bomb, you learned a few things. One thing you 
learned is that there are three input terminals that have a circuit with a bus 
connection to the timer.  The digital number that you need all the combos to 
result in will stop the timer. So, you wanted to create a program that would 
calculate a bus number based on the input combinations. 

Another thing you learned is that the first combination panel does arithmetic 
operations, the second circuit does bit operations, and the third does boolean 
operations. You are able to derive the operations from your analysis.

Circuit A executes the following:

$$ 
    % `A = ( (A*B + A*C + B*C) % C ) - 0x60a7 + 0xca7`.
    A = ((AB + AC + BC) \mod C)
    + \mathrm {0xdeadbeef} - \mathrm {0x60a7} + \mathrm {0xca7}
$$

Circuit B executes the following:

$$
    % `B = ( ((A << 8) >>> 22) // 8 ) + (B >> (C & 0xf)) + ((C >> 3) <<< 42) + 0x20d1ac`.
    B = \frac {(A \verb| << | 8) \verb| >>> | 22} {8} 
    + (B \verb| >> | (C \land \mathrm {0x0f}))
    + ((C \verb| >> | 3) \verb| <<< | 42 ) + \mathrm {0x20d1ac}
    \\{}
    \\
    \text {where \verb|<<<| is rotate left and \verb|>>>| is rotate right.}
$$

And Circuit C executes the following:

$$
    % `C = NOT ( B OR C XOR ((A AND B) OR C) ) XOR 0xca7dec0de57ac05`.
    C = \lnot ( B \lor C \oplus ((A \land B) \lor C) ) 
    \oplus \mathrm {0xca7dec0de57ac05}
    \\{}
    \\
    \text {where } \lnot \text { is bitwise NOT,} \\
    \land \text { is bitwise AND,} \\
    \lor \text { is bitwise OR,} \\
    \text {and } \oplus \text { is bitwise XOR,}


$$

The `A` circuit is executed, then the `B` circuit, and finally the `C` 
circuit. The final number passed on the bus is $ A \oplus B \oplus C $ (e.g.,
in Python, `A ^ B ^ C`).

Your function will take the intended `A`, `B`, and `C` codes and return the 
calculated bus code. 


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- Do NOT use macros, assignments, or directives at this time.
- Do NOT use memory at this time.
- You may use labels, but you may not use loops or jumps.


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
