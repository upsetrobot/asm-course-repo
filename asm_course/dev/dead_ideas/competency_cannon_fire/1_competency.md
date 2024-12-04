# 💣 3-11 Competency 2 Cannon Fire - Competency

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

In this lab, you will implement a function that returns the whole number angle 
you have to set your cannon to to hit a target at a given range. 

``` coffee
                                                 .-------------.
                                                ( "You MISSED!" )
                                                 '-------------'>..
    ______                                                         \ 0 /
*--(@@____O = = = = = = - .                                         'M'
____(>#<)______________________'____________________________________.W.________
-----'''--  --- --- ---- -------- o------- <~^~~ ~^ ~~ ^^^^^> ------|||--------
------  ---- --  ------ ----- --- -- - <^^^ ~^^~ ~^^ ~~^> ----------O-O--------
----  ----  --- -- --- --  -----  --- --- <~^^ ~ ^^^ ~~ ^^> ------------------- 
```

To do this, you will need a couple things. First note that the range of a 
projectile function is:

$$
    d = \frac {v^2 sin(2\theta)} {g}        % `d = (v^2 sin(2*theta)) / g`.
$$

where `d` is the distance the projectile will travel (straight distance from
cannon to projectile), `v` is the velocity at which the projectile is launched,
`theta` is the angle at which the projectile is launched, and `g` is the force
of gravity (gravitational acceleration).  (This equation neglects air
resistance which we are considering negligible for this range ... plus your 
cannon ball bombs have drag-nullifying technology... yeah.)

We are solving for `theta`, so we have to rearrange our function:

$$
    sin(2\theta) = \frac {dg} {v^2}         % `sin(2*theta) = dg / v^2`.
$$
$$
    % `theta = arcsin(dg / v^2) / 2`.
    \theta = \frac {arcsin \left( \frac {dg}{v^2} \right)}{2}
$$

Okay, `g` is `9.81 m/s^2` which is `10 m/s^2` due to the fact you are standing 
on a bigger planet (yeah, you are fighting this battle on another planet after 
you went through a portal... you were told not to go in there).

Your function will take the range to the target in meters and the velocity of 
cannon ball bombs setting of your cannon in meters per second and return the
integer angle that you should set your cannon to to make the target (you 
should be able to round to the nearest angle).

You may need help with `arcsin`, so an `arcsin` function has been provided.


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- Do NOT use macros, assignments, or directives at this time.
- Do NOT use memory at this time.
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

<span style="display: block; border-left: 4px solid; 
border-radius: 4px; border-color: #9966ff; background-color: #9966ff10;
box-shadow: 2px 4px 4px 0 rgba(0,0,0,0.2), 4px 6px 10px 0 rgba(0,0,0,0.2);">
<span style="display: block; padding: 4px 9px; border-radius: 0 4px 0 0;
background-color: #9966ff33">
<span style="color: #9966ff">**ⓘ**</span>&nbsp;&nbsp;Info
</span><span style="display: block; padding: 15px 9px">
    Note that if your program crashes during the test, the files will not be 
    automatically cleaned up. This is not problem, just fix it and use `make` 
    again and when it does not crash, the files will be cleaned up. Or use
    `make clean` or `make clean_all`.
</span></span>


[Back to README](README.md)


<!--- End of file. --->