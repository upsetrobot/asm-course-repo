
# 🔒 3-22 Competency 5 Locked Up - Competency

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

In this lab, you will implement a program that finally cracks the old vault 
that annoying monk keeps bothering you about.

``` groovy (for color)
 | o  ...  o| .  /   //   /        |o |:--|| o|    // //        \\        .
 | o.----. o|  /                   '--|:__||--'      // //        \\  .
 .__|:;_;|__' /     .-----------------''  ;|                       \\ 
 | o|:' |'---------' '""""""""""""""""    ||            ,:":,       ||    .
.| o|:' |    //       //     .-------------'           :-<o>-:       ||  .
 | o|:' |     //        // .|       O.      .O          ':_:'         ||
 | o'----------------.     :|        \\.==.//    //             /      ||  
 | o |   . |         |:    :|      .:'\\  //':.   //    ,:":,    //    || 
.| o | .  |   /      |:    :|     //   \\//   \\       :-<o>-:          ||
 | o |  . |  //      |: // :|  O======={()}=======O     ':_:'   O====D  ||  .
 | o |    |   /      |:    :|     \\   //\\   //                        ||
 | o | .   |         |:    :|      ":.//  \\.:"   //    ,:":,     ///  ||
 | o.----------------'     :|        //'=='\\          :-<o>-:         ||  
 | o|:' |       //      // '|       O'      'O          ':_:'         || 
 | o|:' |         //        '--------------.                         ||    . 
 |__|;'_;.---------.          """""""""""" |      // //             ||   
 |  |:' || o| \     '-----------------._  _.          // //        //   .  .
.| o'----' o| .\                   .--|:""||--.           /       //     .
_|_o_______o|____\   / /  /        |o |:  || o|                 //_____________
    __/       _/  '._______________|o_|:  ||_o|_______________.'  \_   -   \__
 __/        _/  __    / - -    |  --   '""'   _  |    __  \     --  \_   ___  \
/__________/_________/________|_________|_________|________\__________\________
  -      /  -       / --     |     --   |       -- |   - -- \     ----  \
```

This vault has three combination dials. Each dial must be set to open the 
vault (You guess this was a measure to ensure a minimum of three people were
needed to open the vault). You found that each dial takes a four-number 
combination with numbers ranging between `0` and `64`.

You start messing with the dials and note that you should be able to measure 
two constants. One is the tension of the dial; the other is the loudness of 
the clicks. You bring in some equipment to get precise measurements. You are 
able to measure the tension in each dial on a scale from `1` to `99` and the 
volume of the clicks on a scale from `1` to `99`. 

You also discover the constant of proportionality for the tension is `5` and 
the same for the volume level is `3`. According to your research, these values 
have to be normalized to values between `0` and `66` (modulo `67`). This leads 
to the following equation for the first number of the combination for one of 
the dials:

$$
    % N = (x - (3*V % 67))**2 + (x - (5*T % 67))**2
    N = (x - (3V \mod 67))^2 + (x - (5T \mod 67))^2
    \\{}
    \\
    \text {where } N \text { is the result value, } 
    x \text { is the dial setting, } \\
    V \text { is the volume measurement of the dial, and }
    T \text { is the tension measurement of the dial.}
$$

Okay, if you are able to try each number from `0` to `64` for `x`, you can 
find the lowest result value `N`. That number is a value to add to the volume 
and tension constants for the next combination value. 

You would repeat this four times to get all four numbers of the combination 
for one dial.

$$ 
    % N_1 = (x_1 - (3*(V + 0) % 67))**2 + (x_1 - (5*(T + 0) % 67))**2
    N_1 = (x_1 - (3(V+0)\mod 67))^2 + (x_1 - (5(T+0)\mod 67))^2

    % N_2 = (x_2 - (3*(V + N_1) % 67))**2 + (x_2 - (5*(T + N_1) % 67))**2
    \\ \text { then } N_2 = (x_2 - (3(V + N_1) \mod 67))^2
    + (x_2 - (5(T + N_1) \mod 67 ))

    % N_3 = (x_3 - (3*(V + N_2) % 67))**2 + (x_3 - (5*(T + N_2) % 67))**2
    \\ \text { then } N_3 = (x_3 - (3(V + N_2) \mod 67))^2
    + (x_3 - (5(T + N_2) \mod 67 ))

    % N_4 = (x_4 - (3*(V + N_3) % 67))**2 + (x_4 - (5*(T + N_3) % 67))**2
    \\ \text { then } N_4 = (x_4 - (3(V + N_3) \mod 67))^2
    + (x_4 - (5(T - N_3) \mod 67 ))
    \\{}
    \\
    \text {where } x_1, x_2, x_3, \text { and } x_4 
    \text { are the combination values to the dial.}
$$

Remember, $ x_1 = min((x - (3V \mod 67))^2 + (x - (5T \mod 67))^2) $. You have 
to find the minimum `N` during each step and use that in the next step 
**AND** save the `x` that resulted in the minimum.

So, all you have to do is repeat this process for each of the dials and 
decode the combinations for each of the locks. Your `studentFunction1` needs 
to return a pointer to an array of the combination values as `12` `char`s. 

You mess with the first dial and listen... You set up your instruments and 
start measurements... You were able to test all three locks to get the initial 
constants:

$$
    V_1 = 13, T_1 = 63 \\
    V_2 = 53, T_2 = 51 \\
    V_3 = 38, T_3 = 44
$$

Okay, you can use as many helper functions as you want if needed. All you 
have to do is find the minimum of `N` four times for each lock and record the 
combinations. Easy!

Here is some Python code in case you need it:

``` py
def n(v, t, n):
    min_N = 9999
    min_x = 65
    for i in range(65):
        N = (i - ((3*(v + n)) % 67))**2 + (i - ((5*(t + n)) % 67))**2
        if N < min_N:
            min_N = N
            min_x = i
    return min_x, min_N

n(13, 63, 0)
```


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- None.


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
