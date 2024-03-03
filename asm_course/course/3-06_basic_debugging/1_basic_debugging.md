
# 🪲 3-06 Basic Debugging - Knowledge

<span style="color:lightcoral">*"The only good bug... is a dead bug!"*</span>
 ~-~ Buenos Aires Survivor

[Back to README](README.md)


## Primer Contents

There are many different ways one could debug assembly code as discussed in
the *Tools* module of this course. This lesson is going to show debugging 
assembly using `gdb`. In this tutorial, we will go over the following topics:

- [`int3` Instruction](#int3---breakpoint)
- [Debugging in GDB](#debugging-in-gdb)
- [Common GDB Commands](#common-gdb-commands)
- [VS Code IDE Debugging](#vs-code-ide-debugging)
- [Other Debugging Enhancements](#other-debugging-enhancements)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## `int3` - Breakpoint

In assembly, there in an operation for breakpoint. At any point in your code, 
you can add `int3` and a debugger will break at that location. 

For example, consider the following example:

``` x86asm
    .hello:
        mov rax, 0
        add rax, 2

    .this:
        sub rax, 5
        add rax, 0x33
```

Say you want to debug this program. You can verify register state at any point 
in the program. Insert a breakpoint at the end of the `.hello` instructions to 
see the register state at that point.

``` x86asm
    .hello:
        mov rax, 0
        add rax, 2

        int3            ; Programmed breakpoint (aka SIGTRAP).

    .this:
        sub rax, 5
        add rax, 0x33
```

Now when the code is run, the program will fault on the `int3` instruction.
You can use this a debug point in your program. If you want to stop debugging, 
you can comment out the `int3` or simply remove it when you are done. 


## Debugging in GDB

Here is a program with a bug:

``` x86asm 
section  .text
    global main         ; main function used by gcc.
    extern printf       ; libc function.

main:                   ; gcc main

    push rbp            ; setup frame.

    mov rdi, 10
    mov rsi, 10
    call function

    ; Print result.
    mov rdi, msg
    mov rsi, rax
    call printf

    ; Exit.
    mov rax, 0
    pop rbp
    ret


function:           ; Custom function.

    add rsi, rdi
    add rdi, rdi
    mov rax, rsi

    ret

section  .data
msg db '(10 + 10) * 2 is %d', 10    ;string to be printed
```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    This program is setup to be compiled as a stand-alone program with `gcc`.
    That is why there is a `main` function and a c library call to `printf`.
    More practice on compiling different types of assembly programs will be
    given in a later module.
</span></span>

So, we compile this program and run it:

``` sh
nasm -f elf64 my_program.asm
gcc -no-pie my_program.o
./a.out
```

And it produces the following output:

```
(10 + 10) * 2 is 20
```

That is not right. So how do we debug this? Well, we know that `rax` holds 
the number to be printed as the answer. So, we should examine what happens to 
`rax` before the call to `printf`. So, we start up `gdb` and use some commands 
to add a breakpoint there. Or we can use `int3` to manually insert a 
breakpoint into the code. Let's do the first method first.

``` sh
$ gdb a.out
(gdb) set disassembly intel  # Use this to display in Intel syntax.
(gdb) disas main             # We use this if we want to look at disassembly of main.
(gdb) disas function         # Use to examine `function`.
(gdb) b * function+6         # Set break point at `mov rax, rsi`
(gdb) r                      # Run program.
(gdb) info r                 # Dump registers.
(gdb) x/4i $rip              # Examine four instructions from `rip`.
```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    GDB is a program with a commandline console, so when run `gdb
    <binary_executable>`, `gdb` loads the file and starts the `gdb` console.
    From the console, you can type commands to ask `gdb` to do different
    things.  The commands above are commands to type in the `gdb` console. Note   
    that the comments above (notated with `#`) should NOT be typed into the
    `gdb` console.
</span></span>

We can see that we are about to move 20 from `rsi` to `rax`. So we need to 
think about where `rsi` got 20. But to go back, we would have to exit `gdb` 
and start again. 

This time, we will use `int3`. Let's put a breakpoint in our function:

``` x86asm 
section  .text
    global main         ; main function used by gcc.
    extern printf       ; libc function.

main:                   ; gcc main

    push rbp            ; setup frame.

    mov rdi, 10
    mov rsi, 10
    call function

    ; Print result.
    mov rdi, msg
    mov rsi, rax
    call printf

    ; Exit.
    mov rax, 0
    pop rbp
    ret


function:           ; Custom function.

    int3            ; <---- Breakpoint here.
    add rsi, rdi
    add rdi, rdi
    mov rax, rsi

    ret

section  .data
msg db '(10 + 10) * 2 is %d', 10    ;string to be printed
```

Now `gdb` will break right at the beginning of `function`. Then we can 
examine the registers there before they are manipulated by the rest of the 
function.

``` sh
$ gdb -ex run ./a.out        # Run program in gdb.
(gdb) info r                 # Dump registers.  We see that 10 is in `rdi` and `rsi`.
(gdb) set disassembly intel  # Use this to display in Intel syntax.
(gdb) x/4i $rip              # Examine four instructions from `rip`.
(gdb) si                     # Step one instruction.
(gdb) info r                 # Examine registers to see that `rsi` now has 20.
(gdb) x/4i $rip              # Examine four instructions from `rip`.
(gdb) si                     # Step one instruction.
(gdb) info r                 # Examine registers to see that `rdi` now has 20.
(gdb) c                      # Continue to exit program.
(gdb) q                      # Quit gdb.
```

Now we can see that we never added 20 to `rsi`. So we can fix that and comment 
out the debug interrupt instruction (`int3`). 

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    Note that if we run the program with the `int3` instruction in it, we will
    get a breakpoint trap error. So, to run the program without a debugger, we
    have to remove the `int3` instruction.
</span></span>

``` x86asm 
section  .text
    global main         ; main function used by gcc.
    extern printf       ; libc function.

main:                   ; gcc main

    push rbp            ; setup frame.

    mov rdi, 10
    mov rsi, 10
    call function

    ; Print result.
    mov rdi, msg
    mov rsi, rax
    call printf

    ; Exit.
    mov rax, 0
    pop rbp
    ret


function:           ; Custom function.

    ;int3           ; Commented out if we don't want to debug. 
    add rsi, rdi
    add rsi, rsi
    mov rax, rsi

    ret

section  .data
msg db '(10 + 10) * 2 is %d', 10    ;string to be printed
```

Now the program produces the correct output:

```
(10 + 10) * 2 is 40
```


## Common GDB Commands

`gdb` is a powerful debugger with hundreds of commands, configurations, and 
applications. Exploring all these features and uses is outside the scope of 
this course. There are many sources and tutorials online if you are interested 
in furthering your `gdb` skills. For this course, you just need to know the 
basics. Here is a list of some of the most common `gdb` commands:

| Command                 | Description                                       |
|-------------------------|---------------------------------------------------|
| `h[elp]`                | Get help on `gdb` commands.                       |
| `h[elp] <cmd>`          | Get help on a specific `gdb` command.             |
| `r[un]`	              | Run to next breakpoint or to end.                 |
| `s[tep]`	              | Single-step, descending into functions.           |
| `n[ext]`	              | Single-step without descending into functions.    |
| `f[inish]`	          | Finish current function, loop, etc. (useful!).    |
| `c[ontinue]`	          | Continue to next breakpoint or end.               |
| `up`	                  | Go up one context level on stack (to caller).     |
| `do[wn]`	              | Go down one level (only possible after up).       |
| `l[ist]`	              | Show lines of code surrounding the current point. |
| `p[rint] <name>`	      | Print value of variable called `<name>`.          |
| `p * <name>`	          | Print what is pointed to by `<name>`.             |
| `p/x <name>`	          | Print value of `<name>` in hex format.            |
| `p <name> @<n>`	      | print `<n>` values starting at `<name>`.          |
| `p <chars> <tab>`	      | List all variables starting with `<chars>`.       |
| `b[reak] <name>`	      | Set a breakpoint at function `<name>`.            |
| `b <class> ::<name>`    | Set a breakpoint at `<name>` in `<class>`.        |
| `b <class> ::<tab>`	  | List all members in `<class>`.                    |
| `h[elp] b`	          | Documentation for setting breakpoints.            |
| `i[nfo] b`	          | List breakpoints.                                 |
| `i`	                  | List all info commands.                           |
| `dis[able] 1`	          | Disable breakpoint `1`.                           |
| `en[able] 1`	          | Enable breakpoint `1`.                            | 
| `d[elete] 1`	          | Delete breakpoint `1`.                            |
| `d 1 2`	              | Delete breakpoints `1` and `2`.                   |
| `d`	                  | Delete all breakpoints.                           |
| `cond[ition] 1 <expr>`  | Stop at breakpoint `1` only if `<expr>` is true.  |
| `cond 1`	              | Make breakpoint `1` unconditional.                |
| `comm[ands] 1`	      | Add a list of `gdb` commands to execute each      |\
| ^^                      | time breakpoint `1` is hit (usually just print    |\
| ^^                      | <var\>).                                          |

[[1]](#sources).

| Command     | Description                                                   |
|-------------|---------------------------------------------------------------|
| `x/4i $rip` | E`x`amine `4` `i`nstructions pointed to by `rip`.             |
| `x/4x $rsp` | E`x`amine `4` `dword`s pointed to by `rsp` (on the stack).    |
| `x/s $rsp`  | E`x`amine string starting at `rsp`.                           |
| `x/4g $rsp` | E`x`amine `4` `qword`s pointed to by `rsp`.                   |
| `x/4d $rsp` | E`x`amine `4` `d`ecimal numbers pointed to by `rsp` (qwords). |
| `i[nfo] r`  | Print `i`nfo on `r`egisters and their contents.               |
| `bt`        | Print `b`ack-`t`race of function calls based on stack.        |
| `si`        | `s`tep one `i`nstruction in execution.                        |
| `b * <addr>`| Set `b`reakpoint at address given.                            |
| `q`         | `q`uit.                                                       |


## VS Code IDE Debugging

You can use IDE debuggers for assembly too, but setting up the configuration 
is also outside the scope of this course. If you configure a *build* task in 
VS Code (`Terminal > Configure Tasks`) and a debug launch configuration, you 
can run a asm program in VSCode and examine all the registers at anytime, but 
you would still need to use the debug console to run gdb commands (using 
`-exec <gdb command>`). You can have your build task call `make` and run your 
program in the debugger. Debugging this way does have some advantages of 
not having to type `i r` to dump the registers as you can just look at them in 
the VS Code gui, but it does not provide much more help than that. 


## Other Debugging Enhancements

In `gdb`, you can create 
["hooks"](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Hooks.html) 
that allow similar abilities as dumping register values with every step. 
`gdb` extensions such as 
[`gef`](https://github.com/hugsy/gef) also allow for this.  There are many 
other debuggers and extensions that allow you to customize the way you 
debug your programs such as [`peda`](https://pypi.org/project/peda/), 
[`pwndbg`](https://github.com/pwndbg/pwndbg), and many others.


## Sources

1. *Useful Commands in GDB*. 
https://ccrma.stanford.edu/~jos/stkintro/Useful_commands_gdb.html.


## Required Additional Readings.

1. None.


## Resources

1. ***GDB Tutorialspoint Tutorial***. 
https://www.tutorialspoint.com/gnu_debugger/index.htm. 
Basic GDB Tutorial. 

2. ***GDB Docs***. 
https://www.sourceware.org/gdb/. 
Documentation on all things `gdb`.

3. ***Online GDB***. 
https://www.onlinegdb.com/. 
Interesting online source code compiler and debugger.

4. ***MyGeekAdventures Youtube GDB Course***. 
[![GDB Video](https://img.youtube.com/vi/xQ0ONbt-qPs/0.jpg)](https://www.youtube.com/watch?v=xQ0ONbt-qPs)

[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
