
# 📦 3-03 Registers - Knowledge

<span style="color:lightcoral">*"Where can I hook up my modem?"*</span>
 ~-~ Angela Bennett

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Registers](#registers)
- [Processor Registers](#processor-registers)
- [Data Registers](#data-registers)
- [Pointer Registers](#pointer-registers)
- [Index Registers](#index-registers)
- [Control Registers](#control-registers)
- [Segment Registers](#segment-registers)
- [x64 Registers](#x64-registers)
- [Uses of Registers](#uses-of-registers)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Registers

Processor operations mostly involve processing data. This data can be stored 
in memory and accessed from thereon. However, reading data from and storing 
data into memory slows down the processor, as it involves complicated 
processes of sending the data request across the control bus and into the 
memory storage unit and getting the data through the same channel 
[[1]](#sources).

To speed up the processor operations, the processor includes some internal 
memory storage locations, called registers. The registers store data elements 
for processing without having to access the memory. A limited number of 
registers are built into the processor chip [[1]](#sources).


## Processor Registers

There are ten 32-bit and six 16-bit processor registers in IA-32 architecture 
(a typical 32-bit Intel x86 CPU). The registers are grouped into three 
categories:

- General registers
- Control registers
- Segment registers

[[1]](#sources)

The general registers are further divided into the following groups:

- Data registers
- Pointer registers
- Index registers

[[1]](#sources)

Four 32-bit data registers are used for arithmetic, logical, and other 
operations. These 32-bit registers can be used in three ways:

- As complete 32-bit data registers: `eax`, `ebx`, `ecx`, and `edx`.
- Lower halves of the 32-bit registers can be used as four 16-bit data 
registers: `ax`, `bx`, `cx`, and `dx`.
- Lower and higher halves of the above-mentioned four 16-bit registers can be 
used as eight 8-bit data registers: `ah`, `al`, `bh`, `bl`, `ch`, `cl`, `dh`, 
and `dl`.

[[1]](#sources)

A 64-bit architecture (specifically IA-64 which can be thought of as x86-64) 
is similar to a IA-32, but there a large number of registers (including 128 
64-bit general integer register, 128 82-bit floating point registers, 64 1-bit 
predicate registers, eight 64-bit branch registers, and 128 special purpose 
registers) [[2]](#sources). There are eight 80-bit x87 registers, eight 64-bit 
MMX registers (which overlap with the x87 registers), 16 128-bit SSE registers 
(`xmm0` through `xmm15`) [[5]](#sources). And different variations may have 
more registers. Most of these registers are not important for this course. We 
will go over the registers that are. For purposes of this course, you may 
think of x86-64 (64-bit) as similar to x86 (32-bit) in regards to the types of 
registers except for that all 32-bit registers now have a 64-bit component 
which is denoted by a `r` prefix. So, for data registers, we have `rax`, `rbx`, 
`rcx`, and `rdx` in addition to all the 32-bit registers. 

``` js (just for coloring)
    BITS | 63                          32 | 31          16 | 15   8 | 7    0 |
         |--------------------------------|----------------|--------|--------|

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|  
         |                                |                | ax              |
REGISTER | rax                            | eax            .-----------------|
         |                                |                | ah     | al     |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|  
         |                                |                | bx              |
REGISTER | rbx                            | ebx            .-----------------|
         |                                |                | bh     | bl     |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|  
         |                                |                | cx              |
REGISTER | rcx                            | ecx            .-----------------|
         |                                |                | ch     | cl     |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|  
         |                                |                | dx              |
REGISTER | rdx                            | edx            .-----------------|
         |                                |                | dh     | dl     |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'
```


## Data Registers

Some of these data registers have specific use in arithmetical operations.

- `ax` is the ***primary accumulator***; it is used in input/output and most 
arithmetic instructions. For example, in multiplication operation, one operand 
is stored in `eax`, `ax`, or `al` register according to the size of the 
operand.
- `bx` is known as the ***base register***, as it could be used in indexed 
addressing.
- `cx` is known as the ***count register***. `ecx` and `cx` registers store 
the loop count in iterative operations.
- `dx` is known as the ***data register***. It is also used in input/output 
operations. It is also used with `ax` register along with `dx` for multiply 
and divide operations involving large values.

[[1]](#sources)


## Pointer Registers

The pointer registers are 32-bit `eip` (`rip` for 64-bit), `esp` (`rsp` for 
64-bit), and `ebp` (`rbp` for 64-bit) registers and corresponding 16-bit right 
portions `ip`, `sp`, and `bp`. There are three categories of pointer registers:

- ***Instruction Pointer (IP)*** − The 16-bit `ip` register stores the offset 
address of the next instruction to be executed. `ip` in association with the 
`cs` register (as `CS:IP`) gives the complete address of the current 
instruction in the code segment.
- ***Stack Pointer (SP)*** − The 16-bit `sp` register provides the offset value 
within the program stack. `sp` in association with the `ss` register (`SS:SP`) 
refers to be current position of data or address within the program stack.
- ***Base Pointer (BP)*** − The 16-bit `bp` register mainly helps in 
referencing the parameter variables passed to a subroutine. The address in 
`ss` register is combined with the offset in `bp` to get the location of the 
parameter. `bp` can also be combined with `di` and `si` as base register for 
special addressing.

[[1]](#sources)

For 32-bit and 64-bit, `eip` and `rip` store the next instruction address, 
`esp` and `rsp` store the current stack address (top of the stack), and `ebp`, 
and `rbp` store the address of the base of the current stack frame (if stack 
frames are used). So, this scheme is a little simpler than the 16-bit 
architecture. More on some of these topics will be discussed in later modules.

``` js (just for coloring)
    BITS | 63                          32 | 31          16 | 15   8 | 7    0 |
         |--------------------------------|----------------|--------|--------|

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|
REGISTER | rip                            | eip            | ip              |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|
REGISTER | rsp                            | esp            | sp              |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|
REGISTER | rbp                            | ebp            | bp              |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'
```


## Index Registers

The 32-bit index registers, `esi` and `edi`, and their 16-bit rightmost 
portions `si` and `di`, are used for indexed addressing and sometimes used in 
addition and subtraction. There are two sets of index pointers:

- ***Source Index (SI)*** − It is used as source index for string operations.
- ***Destination Index (DI)*** − It is used as destination index for string 
operations.

[[1]](#sources)

For 64-bit, `rsi` and `rdi` are the source and destination index pointers.

``` js (just for coloring)
    BITS | 63                          32 | 31          16 | 15   8 | 7    0 |
         |--------------------------------|----------------|--------|--------|

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|
REGISTER | rsi                            | esi            | si              |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'

         .-------------------------------------------------------------------.
         |                                .----------------------------------|
         |                                |                .-----------------|
REGISTER | rdi                            | edi            | di              |
         |                                |                '-----------------|
         |                                '----------------------------------|
         '-------------------------------------------------------------------'
```


## Control Registers

The 32-bit instruction pointer register and the 32-bit flags register combined 
are considered as the control registers. Many instructions involve comparisons 
and mathematical calculations and change the status of the flags and some 
other conditional instructions test the value of these status flags to take 
the control flow to other location.

The common flag bits are:

- ***Overflow Flag (`OF`)*** − It indicates the overflow of a high-order bit 
(leftmost bit) of data after a signed arithmetic operation.
- ***Direction Flag (`DF`)*** − It determines left or right direction for 
moving or comparing string data. When the `DF` value is `0`, the string 
operation takes left-to-right direction and when the value is set to `1`, the 
string operation takes right-to-left direction.
- ***Interrupt Flag (`IF`)*** − It determines whether the external interrupts 
like keyboard entry, etc., are to be ignored or processed. It disables the 
external interrupt when the value is `0` and enables interrupts when set to 
`1`.
- ***Trap Flag (`TF`)*** − It allows setting the operation of the processor in 
single-step mode. Debugging programs may set the trap flag, so we could step 
through the execution one instruction at a time.
- ***Sign Flag (`SF`)*** − It shows the sign of the result of an arithmetic 
operation. This flag is set according to the sign of a data item following the 
arithmetic operation. The sign is indicated by the high-order of leftmost bit. 
A positive result clears the value of `SF` to `0` and negative result sets it 
to `1`.
- ***Zero Flag (`ZF`)*** − It indicates the result of an arithmetic or 
comparison operation. A nonzero result clears the zero flag to `0`, and a zero 
result sets it to `1`.
- ***Auxiliary Carry Flag (`AF`)*** − It contains the carry from bit 3 to bit 
4 following an arithmetic operation; used for specialized arithmetic. The `AF` 
is set when a 1-byte arithmetic operation causes a carry from bit 3 into bit 4.
- ***Parity Flag (`PF`)*** − It indicates the total number of 1-bits in the 
result obtained from an arithmetic operation. An even number of 1-bits sets 
the parity flag to `1` and an odd number of 1-bits sets the parity flag to 
`0`. According to this 
[Wikipedia article](https://en.wikipedia.org/wiki/Parity_flag), x86 processors 
only set the parity flag according to the parity of the least significant byte. 
- ***Carry Flag (`CF`)*** − It contains the carry of 0 or 1 from a high-order 
bit (leftmost) after an arithmetic operation. It also stores the contents of 
last bit of a shift or rotate operation.

[[1]](#sources)

The 16-bit register to hold flags is called the `FLAGS` register.  The 32-bit 
version is called the `EFLAGS` registers, and the 64-bit version is called the 
`RFLAGS` register.  The following table shows the positions of the flags. 
There are other flags shown here that are not discussed in this course. 

| BITS     | 63-32    | 31-16        | 15 | 14 | 13-12 | 11 | 10 | 9  | 8  | 7  | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|----------|----------|--------------|----|----|-------|----|----|----|----|----|----|----|----|----|----|----|----|
| FLAG     | Reserved | System flags | MD | NT | IOPL  | OF | DF | IF | TF | SF | ZF | *  | AF | *  | PF | 1  | CF |

`*` = Reserved.

[[3]](#sources)

The [Wikipedia article on FLAGS register](https://en.wikipedia.org/wiki/FLAGS_register) 
has a table with more information on flags including system flags and 
architecture-dependent flags. 


## Segment Registers

Segments are specific areas defined in a program for containing data, code and 
stack. There are three main segments:

- ***Code Segment*** − It contains all the instructions to be executed. A 
16-bit Code Segment register or `CS` register stores the starting address of 
the code segment.
- ***Data Segment*** − It contains data, constants and work areas. A 16-bit 
Data Segment register or `DS` register stores the starting address of the data 
segment.
- ***Stack Segment*** − It contains data and return addresses of procedures or 
subroutines. It is implemented as a "stack" data structure. The Stack Segment 
register or `SS` register stores the starting address of the stack.

[[1]](#sources)

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    Details on use of segmented memory in real mode and protected mode is
    outside of the scope of this course. x64 does not typically use memory
    segmentation  [[4]](#sources).
</span></span>

Apart from the `DS`, `CS` and `SS` registers, there are other extra segment 
registers: `ES` (extra segment), `FS` and `GS`, which provide additional 
segments for storing data [[1]](#sources).

In assembly programming, a program needs to access the memory locations. All 
memory locations within a segment are relative to the starting address of the 
segment. A segment begins in an address evenly divisible by 16 or 
hexadecimal 10. So, the rightmost hex digit in all such memory addresses is 0, 
which is not generally stored in the segment registers [[1]](#sources).

The segment registers stores the starting addresses of a segment. To get the 
exact location of data or instruction within a segment, an offset value (or 
displacement) is required. To reference any memory location in a segment, the 
processor combines the segment address in the segment register with the offset 
value of the location [[1]](#sources).


## x64 Registers 

There are also many other registers that have not been discussed. For example, 
there is a set of 128-bit (or larger) registers called `xmm` registers that a 
programmer can use.  If supported by the processor, you may also have `ymm` 
and `zmm` registers.  These are not very important for this course. x64 has 
additional general purpose registers which are important. These are `r8` 
through `r15`. Here is a table of the registers you need to be familar with:

| 64-bit Register | Lower 32 bits | Lower 16 bits | Upper 8 bits of Lower 16 bits | Lower 8 bits |
|-----------------|---------------|---------------|-------------------------------|--------------|
| `rax`           | `eax`         | `ax`          | `ah`                          | `al`         |
| `rbx`           | `ebx`         | `bx`          | `bh`                          | `bl`         |
| `rcx`           | `ecx`         | `cx`          | `ch`                          | `cl`         |
| `rdx`           | `edx`         | `dx`          | `dh`                          | `dl`         |
| `rsi`           | `esi`         | `si`          | [none]                        | `sil`        |
| `rdi`           | `edi`         | `di`          | [none]                        | `dil`        |
| `rbp`           | `ebp`         | `bp`          | [none]                        | `bpl`        |
| `rsp`           | `esp`         | `sp`          | [none]                        | `spl`        |
| `rip`           | `eip`         | `ip`          | [none]                        | [none]       |
| `rflags`        | `eflags`      | `flags`       | [none]                        | [none]       |
| `r8`            | `r8d`         | `r8w`         | [none]                        | `r8b`        |
| `r9`            | `r9d`         | `r9w`         | [none]                        | `r9b`        |
| `r10`           | `r10d`        | `r10w`        | [none]                        | `r10b`       |
| `r11`           | `r11d`        | `r11w`        | [none]                        | `r11b`       |
| `r12`           | `r12d`        | `r12w`        | [none]                        | `r12b`       |
| `r13`           | `r13d`        | `r13w`        | [none]                        | `r13b`       |
| `r14`           | `r14d`        | `r14w`        | [none]                        | `r14b`       |
| `r15`           | `r15d`        | `r15w`        | [none]                        | `r15b`       |

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    Operations that output to a 32-bit subregister are automatically
    zero-extended to the entire 64-bit register. Operations that output to
    8-bit or 16-bit subregisters are not zero-extended (this is compatible x86
    behavior) [[5]](#sources).
</span></span>

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    `d` in the `r` registers refers to `double word`, `w` refers to `word`, and
    `b` refers to `byte`. More information on assembly sizes will be discussed
    in a later module.
</span></span>


## Uses of Registers

Programmers can use general purpose registers (like `rax` through `rdx` and 
`r8` through `r15`) for any storage of data and manipulation of data using 
operations.  But there are conventions that can (and, sometimes have to) be 
followed. ***Calling conventions*** are rules for parameter-passing between 
functions and additional caller and callee responsibilities to ensure that 
callers and callees are able to communicate effectively. Function parameters 
can be passed via registers. You can also expect paramters to be loaded into 
certain registers when your function is called so that you can use them for 
your function. So, if you are calling a function, you may need to load certain 
registers with the parameters. There are many different calling conventions 
(e.g., 32-bit and 64-bit are generally different; Windows and Linux are 
generally different; you can define your own; different compilers may use 
different conventions; syscalls may have their own conventions, or even, 
sometimes, programmers may use several different conventions in one program). 

For example, a typical x86-64 Linux convention is to pass the first parameter 
via the `rdi` register, the second via the `rsi` register, the third via the 
`rdx` register, the fourth via the `rcx` register, the fifth via the `r8` 
register, the sixth via the `r9` register, and additional parameters via the 
stack. You have to consider the return register as well (generally `rax`). 
Sometimes, you can even use special registers as general registers (such as 
when a program does not use stack frame pointers - then you can use `rbp` as a 
general register). Additionally, you have to consider what registers the 
caller to your function is expecting to remain constant. These are called 
***volatile registers*** and are determined by conventions. You can use those 
registers, but you have to ensure that the original values are reloaded into 
them before exiting the function. That is all you need to know about the topic 
for now. More on this topic will be discussed in later modules.


## Sources

1. *NASM Tutorial*. 
https://www.tutorialspoint.com/assembly_programming/assembly_registers.htm.
2. *IA-64*. 
https://en.wikipedia.org/wiki/IA-64.
3. *FLAGS Register*. 
https://en.wikipedia.org/wiki/FLAGS_register.
4. *x86 Memory Segmentation*. 
https://en.wikipedia.org/wiki/X86_memory_segmentation.
5. *Part 8 - General Architecture*. 
https://0xinfection.github.io/reversing/pages/part-8-general-architecture.html.


## Required Additional Readings

None.


## Resources

1. ***0xinfection Github IO***. 
https://0xinfection.github.io/reversing/. 
Outstanding assembly courses. Definitely add this bookmark. Here is a link to 
the github page: https://github.com/mytechnotalent/Reverse-Engineering.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
