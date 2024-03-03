
# 🤔 3-20 Competency 4 Stumped - Competency

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

In this lab, you will implement a function to help you decrypt all those weird 
messages you have been getting in the mail, email, and even on your radio! You 
think that they may be related to a version of the Caesar Cipher. But they 
also appear to be reversed. So, if you can try various cipher methods and 
reversing methods, you may be able to decrypt the messages. The messages 
always have a number with them ... ... `33`.


``` js (for color)
         :|  //      ||  // //   |!     ______________________________________
 .-.     :|__________::__________|!    |.------------------------------------.|
//|\\    :|----------..----------|!    || c\xad¥±®M`l\xad¥±®M`n´«¢¢£²`§´«¨¹` ||
|||||)   :|   // //  ||   //     |!    || §¨´`¹±¬¬±F                         ||
 :|    .--------------.    //    |:    ||                                    ||
 :|   || .----------. |__________|:    || N XOR '!' - '!'                    ||
 :|   || | -- =-- - | |-----------'    ||    WHAT DOES IT MEAN??             ||
 :|  /|| | ===----- | |                ||_===-_______________________________||
 '|-| || | ==- -- - | |---------.      '-----------------------------__-------'
'--'l.|| '----------' |______    \                                .'"  "'.
      ''--------------'   .--\-.  \                              ;        '
        \\+++++++++++=++\  \ (_)\  \                             [;       ;
         \\::::::::::::::\  \____\  \                          ("..;     ;.__
          ''--------------'          \                        /."            \
======================================'                      //  ;            \
                                    | |                     ((   ;            
```

Your function should take a string and decrypt it by `XOR`ing each character 
by `33` and then by rotating each character by `33`. Then your function has to 
reverse the string. Easy!

If you want to print your string before or after, a print function has been 
provided. Just load the pointer into `rdi` and `call print`. This function 
does not mess with any other registers.


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- Do NOT use macros, assignments, or directives at this time.


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
