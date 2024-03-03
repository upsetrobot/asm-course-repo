
# 📚 3-00 Fundamentals - Knowledge

<span style="color:lightcoral">*"The best way to teach somebody something is 
to throw them in the deep end."*</span>
 ~-~ Joe West

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [What is Assembly?](#what-is-assembly)
- [Types of Assembly](#types-of-assembly)
- [Assembly Syntax](#assembly-syntax)
- [Uses of Assembly](#uses-of-assembly)
- [Assembly Model](#assembly-model)
- [Machine Code](#what-is-machine-code)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## What is Assembly?

Assembly language is a low-level programming language for computers and other 
programmable devices. Assembly languages are usually each specific to 
particular architecture unlike higher-level languages. Assembly language code 
is converted into executable machine code by a utility program called an 
*assembler* such as NASM, MASM, etc. [[1]](#sources).


## Types of Assembly

It is important to know that there are several types of assembly programming 
languages. All of them share similar general formats, but each can have 
very different syntax, operations, features, etc.

- ***Netwide Assembler (NASM)*** is an x8086 (32-bit) and x86-64 (64-bit) 
assembler designed for portability and modularity. It supports a range of 
executable formats including Linux and BSD "a.out", ELF, Mach-O, .obj, COFF 
(including Win32 and Win64 variants). It can also output plain binary files, 
Intel hex and Motorola S-record formats. Its syntax is designed to be simple 
and easy to understand, similar to the syntax in the Intel Software Developer 
Manual with minimal complexity. It supports all currently known x86 
architectural extensions, and has strong support for macros [[2]](#sources).

- ***Microsoft Macro Assembler (MASM)*** is an x86 assembler that uses the 
Intel syntax for MS-DOS and Microsoft Windows. Beginning with MASM 8.0, there 
are two versions of the assembler: One for 16-bit & 32-bit assembly sources, 
and another (ML64) for 64-bit sources only. MASM is maintained by Microsoft, 
but since version 6.12 it has not been sold as a separate product. It is 
instead supplied with various Microsoft SDKs and C compilers. Recent versions 
of MASM are included with Microsoft Visual Studio. Notable applications 
compiled using MASM including RollerCoaster Tycoon which was 99% written in 
assembly and built with MASM [[3]](#sources).

- The ***GNU Assembler***, commonly known as GAS or AS, is the assembler 
developed by the GNU Project. It is the default back-end of GCC. It is used to 
assemble the GNU operating system and the Linux kernel, and various other 
software. It is a part of the GNU Binutils package. The GAS executable is 
named 'as', the standard name for a Unix assembler. GAS is cross-platform, and 
both runs on and assembles for a number of different computer architectures. 
GAS is free software released under the GNU General Public License v3 
[[4]](#sources).

- There are other assemblers (and languages and syntaxes such as TASM, YASM, 
etc.) for x86 and numerous types of other architectures (such as MIPS and ARM).


## Assembly Syntax

There are several types of assembly syntax. There are two main types of 
general syntax representations for x86 - Intel and AT&T. This course will 
focus mainly on Intel as it is considered generally easier to use. 

Example:

``` x86asm
    mov rax, 15       ; Intel syntax for 'move value of 15 into register rax'.
    mov $15, %rax     ; AT&T syntax for 'move value of 15 into register rax'.
```

There are several differences between the two syntaxes. Some of them are 
described 
[here](https://staffwww.fullcoll.edu/aclifton/courses/cs241/syntax.html). 
Other differences are not described in this course.


## Uses of Assembly

There are several different reasons someone would want to learn or use 
assembly.

- ***Optimization*** - code written in assembly can be much faster at 
execution time than other languages due to be close to machine code and having 
very little overhead code or routines. Some developers may also want to use 
CPU instructions that are not generally used in C or C++ compilations.  
Optimizations may also be used for physics or math to make algorithms that are 
more easily computed on a computer than their logical or abstracted 
interpretions. 

- ***Device Support*** - some architectures may not have full C or C++ 
compilers and thus may have to be written in a type of assembly.

- ***Language or Low-level Development*** - some people who are developing a 
new programming language or other low-level system, operating system, 
graphics, memory management or data-intensive program modules may use assembly 
for a variety of required or optional reasons.  Some language compilers are 
written in part or entirely in assembly. 

- ***Reverse Engineering*** - decompilers and disassemblers will take machine 
code binary and executable formats and reverse them to produce assembly code.  
To be good a reverse engineering software, engineers often have to be able to 
understand assembly. Most programs are very difficult to completely reverse 
to source code (such as C or C++) due to many factors. Dynamic debugging and 
reverse engineering also requires understanding of assembly due to the fact 
that code being executed in binary is machine code (already compiled), so the 
easiest translation of the machine code during runtime is often assembly. 
Vulnerability research and anti-malware research often uses assembly or binary 
as well.

- ***Exploitation*** - assembly is sometimes used to write code injections, 
code patches, or other exploitatives that have specific requirements (such as 
size, instructions used, etc.) for binary exploitation. Assembly is often used 
in exploitation research as well when looking for and exploiting binary 
vulnerabilities.


## Assembly Model

Assembly languages typically use a CPU abstraction model where there are 
registers which can temporarily hold data of up to the CPU data size (such as 
numbers, addresses, CPU instructions, etc.), operations as keywords that 
represent machine code CPU instructions, and special keywords for the 
assembler. Typical format for general assembly instructions is 
`<operation> <argument>...` where the argument may be an immediate value, a 
memory location, or a register. 

Example:

``` x86asm
    mov rax, 15
     ^   ^   ^
     |   |   |
     |   |   2nd operand (in this case, an immediate value of 15)
     |   1st operand (in this case, a register)
     operator (aka instruction or operation)
```


## What is Machine Code?

Machine code (also known as machine language or native code) is a low level 
programming language in the form of hexadecimal or binary instructions that 
execute computer programs on the computers’ CPU. Machine code is the lowest 
level of code which means that it communicates the programs instructions in 
the form of software directly to the hardware of the computer via the CPU 
[[5]](#sources).

Example:

``` x86asm
ASSEMBLY:                   mov rax, 15

MACHINE CODE (in hex):      48 c7 c0 0f 00 00 00 
```


## Sources

1. *Learn NASM Tutorial*. 
https://www.tutorialspoint.com/assembly_programming/index.htm.
2. *NASM Documentation*.
https://www.nasm.us/doc/nasmdoc1.html#section-1.1.
3. *Microsoft Macro Assembler*.
https://en.wikipedia.org/wiki/Microsoft_Macro_Assembler. 
4. *GNU Assembler*.
https://en.wikipedia.org/wiki/GNU_Assembler.
5. *Machine Code*.
https://www.codecademy.com/resources/docs/general/machine-code


## Required Additional Readings

None.


## Resources

1. ***Defuse CA Online Assembler***. 
https://defuse.ca/online-x86-assembler.htm. 
Great for looking at machine code representation of assembly code snippets. 
It shows you how many bytes an instruction will become. They also have many 
other tools. 


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
