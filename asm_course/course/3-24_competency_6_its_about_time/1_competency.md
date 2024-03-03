
# 🕤 3-24 Competency 6 Its About Time - Competency

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

While on your daily evening walk during your stay at the mansion, you wonder 
towards the back of the northern fields and find a strange stone. The stone 
looks like some sort of memorial, but it has an inscription... "Your time is 
up". You notice there's a mark on the stone and remember that the pocket watch 
you took from the old vault had a very similar mark. You take out the watch...
of course, it's not working. You decide to fix and wind the watch. There is a 
strange time marked on the stone as well. You wonder if you can solve this 
mystery by setting your watch and moving time forward. You will implement a 
program that will help you set the time on your pocket watch.

``` v (for color)
     '"'\__\__"'\_/;  / /\\. ||;v/\\ \/ ./ /,./'' __..."    .          *
 .    __.--.__';  \\ |;'. \\  \\ \.\\ \v/ // ___/""'   '.._
    :>--.___.  \\  \i'.'\//\\_//.;\v/; |V;' /'  ..--._.-- 
     .;`    \\__;\_ \\__ ;|'\// ; _//__//  /;  /._.<_  `.    +   
             '-----;.\_ \\.\:|;.'/;----'_./;__//__...
 .                  \__\_\\_.\k;/;___.;"""""""'  \              .             *                
              .        \__.-';_ /.---'
                          \' .;//            .                _____      . 
     .                     !.;!|                         .:'`_____ ;l;:.   
______________________,____!.;!|_________________________|;""""""""!' :;_______
 -   -- --  --- - ,;"` - - !.;!|  -- ` -  ` -`` `-    `  ||  YOUR  |  :| -` --` 
-- - - -- ..   ,+!'` .. .. !.;!|.. `.````...`.`. ` ..` ` ||  TIME  |  :|`` -- .  
""" "" """ __|/|'  " """ " !.;!|  """ """" '''' '''   ,--|| IS  UP |  :|----, '
  _   __||/  |/  '""    _..|.;|;...__     '''""""    /   || -33:33 |  !;   /| "
_|:|_/  || _.|""' ' ' .'_/;:.|\ \;___ '""""'''" ""' /    '!________!.-'   / ;""     
 |:|  " ||/ '   ''  __//   /  \\..   \;\:.  ''''   ;-------------------:' |/  "              
 |:| " /||   .;;;;;.     '"     '..        ''  ''  `:|   ~<{<0>}>~    |;'"'  "
"|;| _/    ;"       ".  ''  _'       ''' ''' '' ' '  '----------------'     "'
 |;|/  "" !           \  ."` `".  ' ';;'' ; ' :; ;; "' "  "  '  ;'; ";';' """ '
/|;| "   ;            ;  [{<0>}]    '' ; ' ' ; ;';  ' ' '' "" ""; ''" "'';;'; ' 
 |;|     :            ;  `.___.'  ' '''' ''''""'"'' '' ''' ' ' '  ''' ' ' ' '' 
"|;|/""   ;          ;; :` V  ;)   ''"""/""/""/""//"\ '"'\"'""'\""'\ \"'\'\/\|"
           ;,       ;"  `----'/   /\/\/""\ \ "|/ "//\"\\"" \\"|/ \  \//\  \/\/
    ___---',      .'.____/ ' ;    \ /\/"\\"/\" \/| \""\"\"/ | \|"\/"|\"/'""\ /
  .' ---           ----  \_  ;      |  / / \ \|\/ //  // /  \ \  /\\\///\\ /\/  
                           ` ;   
```

You will need to ask the operating system for the current time to set the 
watch. You will then need to prompt the user for input, capture the input and 
use that to manipulate your time. You will need to print your time and the new 
calculated time and return it.

Here are the steps to complete:

1. Get the time using a system call and save it.

    - To do this, you need to use the `time` syscall which will return the 
    number of seconds since January 1, 1970, UTC. You can read about this in 
    the man pages (`man 2 time`).

2. Calculate number of minutes and minutes in local time (EST in this case).

    - Because of the scenario, you are in the Eastern time zone in the United 
    States before Daylight Savings Time (this time zone is called Eastern 
    Standard Time (EST)). This time zone is `five` hours behind the 
    [Coordinated Universal Time
    ](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)
    (UTC) zone (regardless of the time of the year). You will use the 
    following equations to retrieve the hours and minutes you need. 

$$ 
    % s = time()
    sec = time() \\{}
    \\
    % m = s // 60 % 60
    min_{utc} = \frac {sec} {60} \mod 60 \\{}
    \\
    % h = (a := s // 60 // 60 % 24) - 5 if a > 0 else a - 5 + 24
    hr_{utc} = \frac {\frac {sec} {60}} {60} \mod 24 \\{}
    \\
    \text {if } \space hr_{utc} - 5 > 0 \text {, then } \space hr_{est} = hr_{utc} - 5 \\{}
    \\
    \text {if } \space hr_{utc} - 5 < 0 \text {, then } \space hr_{est} = hr_{utc} - 5 + 24 \\{}
    \\
    % h = h % 12        # To adjust to 12-hour clock.
    hr = hr_{est} \mod 12 \\{}
    \\
    time = \lq hr:min \rq
$$
    
3. Print the time hours and minutes.

    - To do this, you will use the `write` syscall with the `stdout` file 
    descriptor. 

    - For the hours, you will have to check if the value is less 
    than 10 and if so, add '0' to the number to get a printable ASCII value; 
    and if it is `10`, `11`, `12`, you could print `1` and then `0` added to 
    the modulus of the number and `10`. 

    - For the minutes, you have to use the modulus `10` to get the 10's of 
    minutes to print and then the remainder as the 1's place of minutes. 

    - You will print time in regular format: "TIME: 1:23" or "TIME: 01:23". 
    
4. Prompt the user to give hours to add.

    - To do this, you will use the `read` syscall with the `stdin` file 
    descriptor. You can use a buffer size of your choosing. You will print the 
    following prompt before reading: "Enter hours: ". You will examine the 
    first two characters of your buffer and create a value to add to your 
    hours variable.

    - Add the value to your hours variable. You will have to modulo the value 
    by `12` to correct rollovers.

5. Prompt the user to give minutes to add.

    - You will do this in the same way you did hours. Your prompt to print 
    before reading is "Enter minutes: ". You will examine the first two 
    characters and create a value to add to your minutes.

    - Add the value to your minutes variable. If the value is greater or equal 
    to `60`, you will have to add `1` to your hours (and check the modulo 
    again) and modulo your minutes variable by `60`.

6. Loop if the user does not give valid input.

    - If there user just presses `Enter` without putting in a number, you 
    will ask for valid input again. This goes for both prompts (hours and 
    minutes). 

    - If one of the first two bytes in the buffer are not digits, you will 
    print an "ERROR: Invalid Input" message and loop back to the prompt.

7. Now print the adjusted time after adding the user hours and minutes.

    - Do this is the same way you did with the first time you printed. You 
    can use the same message.

8. Finally return the time as the number of seconds.

    - You do this by multiplying the values and adding them together.

$$
    % return h*3600 + m*60
    ret = hrs \times 3600 + min \times 60 \\
    \text {where } ret \text { is the time to return in seconds.}
$$

That's it! Easy!

Here's some Python code with more of a assembly-like structure to help if 
needed:

``` py
import sys
import time

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
    

def main():
    s = int(time.time())
    h = getHours(s)
    m = getMins(s)
    printTime(h, m)

    h_to_add = -1
    m_to_add = -1

    while h_to_add == -1:
        h_to_add = inputHours()

    while m_to_add == -1:
        m_to_add = inputMins()

    h = (h + h_to_add + (m + m_to_add) // 60) % 12
    m = (m + m_to_add) % 60

    printTime(h, m)

    return h*3600 + m*60
```


### Requirements

- Pass test verification of all test cases.
- Meet all limitation requirements.


### Limitations

- You may not use library calls during this challenge. You may only use your 
own functions and system calls.


## 2. Run Application Test

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    Testing this module takes about 10 seconds. If the system time goes 
    passed the minute mark during that time, the test may fail. Therefore, 
    you should test twice to ensure you have passed the minute mark if the 
    first time, the test fails.  `( = P)`.
</span></span>

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
