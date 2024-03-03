
# ☎️ 3-23 Interrupts and Syscalls - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Interrupts](#interrupts)
- [System Call Introduction](#system-call-introduction)
- [Calling Syscalls](#calling-syscalls)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Interrupts

The `int` instruction generates an interrupt in the system that may stop the 
current processor execution (that is why they are called "interrupts") and 
even route execution to different interrupt handlers. Interrupts are also 
sometimes called "traps". There are many different types and levels of 
interrupts, exceptions, and interrupt handling schemes. There are hardware 
interrupts, software interrupts, interrupt masking, processor interrupts, 
operating system interrupts and much more on these topics. Most of these are 
outside the scope of this course. When an interrupt occurs, the processor 
saves the CPU state, routes execution to the registered handler, then restores 
the state and continues execution (such as when you have a breakpoint in a 
program which is a kind of interrupt). One type of interrupt is `int 0x80` 
which is the legacy way on 32-bit systems of calling the kernel to do a 
kernel procedure (aka a syscall). 
[Here](https://www.baeldung.com/linux/interrupt-handling) is a page on 
interrupts if you want to read more.


## System Call Introduction

System calls are functions that you can call to interact with the OS. System 
calls are very different in Linux from system calls in Windows. They can even 
be different between different versions of one type of operating system. They 
may also have their own special calling conventions and those conventions are, 
of course, different for 32-bit versus 64-bit programming. So, if you are 
programming for a specific platform and architecture, you may have to learn 
specific system calls and calling conventions for the target system.

You can access system routines by loading defined registers with arguments, 
moving a syscall number in a special register (`rax` typically), and then 
calling the kernel using a special interrupt code (`int 0x80` or just use the 
`syscall` instruction). In Unix, you can use `man 2` to lookup different 
syscalls. Recall that you can also `man syscall` to find System ABI info on 
syscalls, and you can look for files like
`/usr/include/x86_64-linux-gnu/asm/unistd_64.h` to find syscall numbers (the
number you have to put in `rax` before executing the syscall).

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    Note that x86 (32-bit) Unix and x86_64 (64-bit) Unix syscalls (and Windows
    for that matter) are different. You cannot rely on 32-bit syscall numbers
    being the same for 64-bit. Syscall numbers may even be different if using
    the `syscall` instruction versus the `sysenter` instruction versus the `int
    0x80` instruction (see
    [this](https://stackoverflow.com/questions/12806584/what-is-better-int-0x80-or-syscall-in-32-bit-code-on-linux)
    and other sources for more info). That source recommends using `sysenter`
    for 32-bit and `syscall` for 64-bit.
</span></span>


## `int` Instruction

The `INT n` instruction generates a call to the interrupt or exception handler
specified with the destination operand (see the section titled “Interrupts and
Exceptions” in Chapter 6 of the Intel® 64 and IA-32 Architectures Software
Developer’s Manual, Volume 1). The destination operand specifies a vector from
`0` to `255`, encoded as an 8-bit unsigned intermediate value. Each vector
provides an index to a gate descriptor in the IDT. The first 32 vectors are
reserved by Intel for system use. Some of these vectors are used for internally
generated exceptions [[1]](#sources).

`int 0x80` requests operating system kernel call with current register state.
This is used on x86 32-bit systems, but some sources recommend using 
`sysenter` instead. For x86_64 64-bit systems, `syscall` is used. 


## `sysenter` Instruction

Executes a fast call to a level 0 system procedure or routine. `SYSENTER` is a
companion instruction to `SYSEXIT`. The instruction is optimized to provide the
maximum performance for system calls from user code running at privilege level
3 to operating system or executive procedures running at privilege level 0 
[[2]](#sources).

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
`sysenter` may require passing certain arguments on the stack. There is a lot 
of nuance with different ways to call system calls using `sysenter` and 
calling system calls in general on various architectures and systems. There 
are even sources that recommend wrapping syscalls in separate library 
functions or using stubs. This course recommends starting with `int 0x80` for 
x32 Linux when starting as more tutorials using this method seem to be 
available online. 
</span></span>


## `syscall` Instruction

`SYSCALL` invokes an OS system-call handler at privilege level 0. It does so by
loading `RIP` from the IA32_LSTAR MSR (after saving the address of the
instruction following `SYSCALL` into `RCX`). (The WRMSR instruction ensures
that the IA32_LSTAR MSR always contain a canonical address.) `SYSCALL` also
saves `RFLAGS` into `R11` and then masks `RFLAGS` using the IA32_FMASK MSR (MSR
address C0000084H); specifically, the processor clears in `RFLAGS` every bit
corresponding to a bit that is set in the IA32_FMASK MSR. [[3]](#sources). Used
on x64 systems to invoke system calls. 

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Note that because `syscall` clobbers `rcx`, `r10` is used as the fourth 
    integer argument register in x64 Linux syscall calling convention. 
</span></span>


## Calling Syscalls

There are hundreds of syscalls for various systems. But for x64 Linux, some of 
the common ones to get you started include:

| Syscall | x64 No. | x86 No. | Description                                   |
|---------|---------|---------|-----------------------------------------------|
| `read`  | 0       | 3       | Read from a file (including a terminal).      |
| `write` | 1       | 4       | Write to a file (including a terminal).       |
| `open`  | 2       | 5       | Open a file.                                  |
| `close` | 3       | 6       | Close a file.                                 |
| `stat`  | 4       | 106     | Get information on a file.                    |
| `mmap`  | 9       | 90      | Map virtual memory.                           |
| `brk`   | 12      | 45      | Expand the heap.                              |
| `fork`  | 57      | 2       | Create a new child process.                   |
| `exit`  | 60      | 1       | Exit the program.                             |

The man page for syscall (`man syscall`) says that the calling convention for 
syscalls are to pass arguments via `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9` and 
that the return value will be in `rax`.

You can use preprocessor directives or any of the constant designations to 
define syscall numbers you want to use in your program if you want. 

For example:
``` x86asm
%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_OPEN    2
%define SYS_CLOSE   3
%define SYS_STAT    4
%define SYS_MMAP    9
%define SYS_BRK     12
%define SYS_FORK    57
%define SYS_EXIT    60
```

Then, you can use the man page for the specific syscall you are using to get 
the arguments. The page also provides information on how to use the syscall 
and what errors can be produced.

For example, `man 2 write` shows we need the file descriptor, a buffer, and a 
count:
```
WRITE(2)                   Linux Programmer's Manual                  WRITE(2)

NAME
       write - write to a file descriptor

SYNOPSIS
       #include <unistd.h>

       ssize_t write(int fd, const void *buf, size_t count);
```

Here is an example of reading and writing to a terminal. Remember the standard 
file descriptors (`0` is `stdin`, `1` is `stdout`, and `2` is `stderr`):

``` x86asm
%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_EXIT    60

%define STDIN       0
%define STDOUT      1
%define STDERR      2

%define NEWLINE     10
%define NULL        0

%define EXIT_SUCCESS    0
%define EXIT_FAILURE    -1

%define BUFSZ       256


section .data

    msg_hello       db  "Hello, Please select a number: 1 or 2", NEWLINE, NULL
    msg_hello_len   equ     $ - msg_hello

    msg_1           db  "No, that one is a bad choice!", NEWLINE, NULL
    msg_1_len       equ $ - msg_1

    msg_2           db  "Yeah, I like that number two!", NEWLINE, NULL
    msg_2_len       equ $ - msg_2

    msg_other       db  "Next time, be obedient and do what you're told ;)", NEWLINE, NULL
    msg_other_len   equ $ - msg_other

    msg_buffer      db  NEWLINE, "Here's your buffer: ", NULL
    msg_buffer_len  equ $ - msg_buffer


section .bss

    buffer:     resb    BUFSZ


section .text

global _start                   ; Needed to avoid NASM warning for entry point.


    _start:                     ; Used if you are compiling with nasm.
        push rbp
        mov rbp, rsp

        ; Ask the user to type a number.
        ; ssize_t write(int fd, const void *buf, size_t count);
        mov rax, SYS_WRITE      ; Set syscall number.
        mov rdi, STDOUT
        mov rsi, msg_hello
        mov rdx, msg_hello_len
        syscall

        ; Read user response into buffer.
        ; ssize_t read(int fd, void *buf, size_t count);
        mov rax, SYS_READ
        mov rdi, STDIN
        mov rsi, buffer
        mov rdx, BUFSZ
        syscall

        ; Choose a response.
        mov rdi, buffer
        cmp byte [rdi], '1'
        je .one

        cmp byte [rdi], '2'
        je .two

        .other:
            ; Print Error response.
            mov rax, SYS_WRITE
            mov rdi, STDERR
            mov rsi, msg_other
            mov rdx, msg_other_len
            syscall

            or rax, EXIT_FAILURE
            jmp .end

        .one:
            ; Print response 1.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_1
            mov rdx, msg_1_len
            syscall

            jmp .success

        .two:
            ; Print response 2.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_2
            mov rdx, msg_2_len
            syscall

        .success:
            xor rax, rax    ; EXIT_SUCCESS.

        .end:
            ; Just for fun, let's print the buffer.
            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, msg_buffer
            mov rdx, msg_buffer_len
            syscall

            mov rax, SYS_WRITE
            mov rdi, STDOUT
            mov rsi, buffer
            mov rdx, BUFSZ
            syscall

            ; Exit program.
            mov rdi, rax
            mov rax, SYS_EXIT
            syscall

            leave
            ret             ; Returning is probably not needed here, but if 
                            ; you were compiling with gcc and using a main 
                            ; function, then it would be.

    ; End _start.
```

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
This can be compiled with `nasm -f elf64 <filename>.<suffix>` followed by 
`ld <filename>.o -o <filename>`.
</span></span>


## Sources

1. *INT n/INTO/INT3/INT1 — Call to Interrupt Procedure*.
https://www.felixcloutier.com/x86/intn:into:int3:int1.
2. *SYSENTER — Fast System Call*. 
https://www.felixcloutier.com/x86/sysenter.
3. *SYSCALL — Fast System Call*.
https://www.felixcloutier.com/x86/syscall.


## Required Additional Readings

None.


## Resources

1. ***Man Pages***. 
https://www.man7.org/linux/man-pages/dir_section_2.html. 
The `man` pages are the way to go. This is an online version. 

2. ***System Calls Wiki on OS Dev***.
https://wiki.osdev.org/System_Calls.
Some information on system calls.

3. ***Linux System Call Table for x86 64***.
https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/.
x64 syscall table.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
