
# ⚗️ 3-02 Syntax - Knowledge

<span style="color:lightcoral">*"The code? You're pirates! Hang the code and 
hang the rules! They're more like guidelines anyway."*</span>
 ~-~ Elizabeth Swann

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [What is a Register?](#what-is-a-register)
- [What is an Operation?](#what-is-an-operation)
- [Intel Versus AT&T Syntax](#intel-versus-att-syntax)
- [Sections](#sections)
- [Comments](#comments)
- [Assembly Language Statements](#assembly-language-statements)
- [Syntax](#syntax-of-assembly-language-statements)
- [Labels](#labels)
- [Pointers](#pointers)
- [Hello World](#the-hello-world-program-in-assembly)
- [Compiling and Linking](#compiling-and-linking-an-assembly-program-in-nasm)
- [Memory Segments](#memory-segments)
- [Directives](#directives)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## What is a Register?

A register is structure inside a CPU that can hold a finite number of bits of 
data.  Registers in a typical 32-bit processor can hold 32 bits (4 bytes). 
Typically, the value stored in the register is only held while the processor 
has power.  There can be registers of multiple sizes, but many modern 
processors standardize many CPU registers to be one size for easier design 
of the processor.  In assembly programming, a register is similar to a 
variable in C programming - it can be used to temporarily store a value 
(although it is not always the same as a variable in C because some assemblers 
support named variables separate from the registers such as `stack` variables, 
`data` section variables, and `bss` section variables). Registers can hold 
values including addresses.  In simple memory designs, this is why a 32-bit 
CPU architecture can only have 2 to the power of 32 bits of addressable memory 
(RAM) - because the CPU registers and functionality have that number of bits 
(note there have been addressing schemes developed to get around this 
limitation, but they will not be discussed in this course).


## What is an Operation?

An operation (aka instruction or operator) is a command that can be executed 
by a CPU. In some x86 languages (such as NASM), examples include `mov`, `add`, 
`test`, `imul`, `xor`, `jmp`, etc. Common instructions will be introduced in 
several modules of this course.


## Intel Versus AT&T Syntax

x86 assembly can often be written in or displayed in either Intel or AT&T 
syntax. There are numerous differences. Some people prefer one or the other. 
This course uses Intel syntax. The differences are not a topic of this course. 
If you want to learn more, there are numerous online sources on the topic (for 
example, check out this 
[short summary](https://imada.sdu.dk/u/kslarsen/dm546/Material/IntelnATT.htm) 
of key differences.).


## Sections

An assembly program can typically be divided into at least three sections: the 
`data` section, the `bss` section, and the `text` section. [[1]](#sources)

- The ***`data` section*** is used for declaring initialized data or constants. 
This data does not change at runtime. You can declare various constant values, 
file names, or buffer sizes, etc., in this section.  The syntax for declaring 
the `data` section is `section .data`. [[1]](#sources)

- The ***`bss` section*** is used for declaring variables. The syntax for 
declaring the `bss` section is `section .bss`. [[1]](#sources)

- The ***`text` section*** is used for keeping the actual code. This section 
must begin with the declaration `global _start`, which tells the kernel where 
the program execution begins. The syntax for declaring text section is: 

``` x86asm
section.text

   global _start

_start:
``` 
[[1]](#sources)

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    The `main` function in C is setup by the compiler to be called by the
    `_start` sequence. When programming directly in assembly, you can start in
    `_start` (or in `main` if you use a C compiler).
</span></span>


## Comments

Assembly language comments begins with a semicolon. A comment may contain any 
printable character including blanks. A comment can appear on a line by itself
or on the same line as code. [[1]](#sources)

Example:

``` x86asm 
; This is a comment. This program displays a message on screen.

   add eax, ebx     ; This is an end-of-line comment.  adds ebx to eax
```
[[1]](#sources)


## Assembly Language Statements

Assembly language programs consist of three types of statements:

- Executable instructions or instructions
- Assembler directives or pseudo-ops
- Macros

The executable instructions or simply, instructions, tell the processor what 
to do. Each instruction consists of an operation code (opcode). Each 
executable instruction generates one machine language instruction 
[[1]](#sources). Each instruction may be followed by zero or more operands 
depending on the instruction.  These operands commonly are registers, memory 
locations, or literals (called "immediates").  These operands become codes 
(specific to the instruction) or literal binary translations once that 
translated into machine code. 

Example:

``` x86asm
   mov eax, 0xbeef
   jmp [eax]
```

becomes:

``` x86asm
0:  b8 ef be 00 00          mov    eax,0xbeef
5:  ff 20                   jmp    DWORD PTR [eax]
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Note that `0xbeef` becomes `0xef 0xbe` in machine code due to x86
    architectures typically being little endian.
</span></span>

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Note that `dword ptr` and `dword` as a prefix to a register dereference
    have the same meaning in NASM. The same goes for the rest of the size
    keywords.
</span></span>

The assembler directives or pseudo-ops tell the assembler about the various 
aspects of the assembly process. These are non-executable and do not generate 
machine language instructions. [[1]](#sources)

Macros are basically a text substitution mechanism. [[1]](#sources)


## Syntax of Assembly Language Statements

Assembly language statements are entered one statement per line. Each 
statement follows the following format: 
`[label]   mnemonic   [operands]   [;comment]`. The fields in the square 
brackets are optional. A basic instruction has two parts, the first one is the 
name of the instruction (aka the "mnemonic"), which is to be executed, and the 
second are the operands or the parameters of the command. [[1]](#sources)

Following are some examples of typical assembly language statements:

``` x86asm
INC COUNT        ; Increment the memory variable COUNT

MOV TOTAL, 48    ; Transfer the value 48 in the 
                 ; memory variable TOTAL
					  
ADD AH, BH       ; Add the content of the 
                 ; BH register into the AH register
					  
AND MASK1, 128   ; Perform AND operation on the 
                 ; variable MASK1 and 128
					  
ADD MARKS, 10    ; Add 10 to the variable MARKS
MOV AL, 10       ; Transfer the value 10 to the AL register
```
[[1]](#sources)

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Many assemblers allow variables and operations to be capitalized. This is
    fine as long as you are consistent. This course will usually use lowercase.
</span></span>


## Labels

In assembly, functions, procedures, or just sections of your code are grouped 
under a label. A label is just the label name followed by a colon. That would 
define a new function. Inside your function, you can create "dot labels" 
which are labels preceded by a period and only apply to one function. 

For example:

``` x86asm
myFunction:     ; <--- Label (in this case, a function label).

    ...         ; Assembly code.

    .myLoop:    ; <--- Internal dot label. During this course, you can use these.

        ...

    .end:
        ret

label2:         ; Another function.

    ...
    ret
```


## Pointers

Pointers are just addresses and do not have any specific definition in 
assembly. In assembly, a pointer (an address) may be stored in a register. To 
operate on the address itself, you would use the register name. To reference 
the value of the memory the address is pointing at, brackets are used. 

For example:

``` x86asm
    mov rax, address
    mov rcx, rax            ; Move value in rax (an address) into rcx.
    mov rcx, [rax]          ; Moves value pointed to by rax into rcx.
                            ; Since rcx is 8 bytes big, 8 bytes of memory 
                            ; will be moved into rcx.
```

The size here is based on the operand size. Some instructions may not have 
implicit sizes, so you have to define the size. For example:

``` x86asm
    cmp byte [rdi], 'b'     ; "byte" defines the size of what rdi is pointing at.
    cmp byte ptr [rdi], 'b' ; Same as above.
```

More on this will be discussed in several modules. It is important now that 
you understand brackets are used to dereference a pointer. Sizes, registers, 
and operations will be described in the next few modules.


## The Hello World Program in Assembly

The following assembly language code displays the string 'Hello World' on the 
screen: 

``` x86asm 
section  .text
   global _start     ; must be declared for linker (ld)

_start:              ; tells linker entry point
   mov   edx,len     ; message length
   mov   ecx,msg     ; message to write
   mov   ebx,1       ; file descriptor (stdout)
   mov   eax,4       ; system call number (sys_write)
   int   0x80        ; call kernel
	
   mov   eax,1       ; system call number (sys_exit)
   int   0x80        ; call kernel

section  .data
msg db 'Hello, world!', 0xa   ; string to be printed
len equ $ - msg               ; length of the string
```
[[1]](#sources)

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    This code is for 32-bit Linux for syscalls and calling convention and is
    meant as an example of syntax.  Syscalls and calling convention will vary
    between architectures, operating systems, and system size. More information
    on this topic will be discussed in a later module.
</span></span>

When the above code is compiled and executed, it produces the following result:

```
Hello, world!
```
[[1]](#sources)


## Compiling and Linking an Assembly Program in NASM

This section describes how to compile the "hello world" program above. You do 
not have to do this unless you want to. Move practice will be given in later 
modules.

Make sure you have set the path of `nasm` and `ld` binaries in your `PATH` 
environment variable. Now, take the following steps for compiling and linking 
the above program:

- Type the above code using a text editor and save it as `hello.asm`.

- Make sure that you are in the same directory as where you saved `hello.asm`.

- To assemble the program, type `nasm -f elf hello.asm`.

    <span class="box-green"><span class="bar-green">
        💲 Tip   
    </span><span class="inner">
        This is for a 32-bit Linux ELF file. For 64-bit, use `-f elf64`.
    </span></span>

- If there is any error, you will be prompted about that at this stage. 
Otherwise, an object file of your program named `hello.o` will be created.

    <span class="box-green"><span class="bar-green">
        💲 Tip   
    </span><span class="inner">
        Use `-o <output-name>` to customize the name of your outputted object
        file.
    </span></span>

- To link the object file and create an executable file named hello, type 
`ld -m elf_i386 -s -o hello hello.o`.

    <span class="box-green"><span class="bar-green">
        💲 Tip   
    </span><span class="inner">
        This is for 32-bit Linux ELF file using `ld`. You can also specify
        other formats for the linker or you try using `gcc` to link the file.
        (e.g., use `ld <object-file>` to accept default format.)
    </span></span>

- Execute the program by typing `./hello`.

- If you have done everything correctly, it will display `Hello, world!` on 
the screen.  [[1]](#sources)

Interestingly, if you replace the `section` keyword with `segment`, you will 
get the same result. Try the following code:

``` x86asm
segment .text        ;code segment
   global _start     ;must be declared for linker 

_start:              ;tell linker entry point
   mov edx,len       ;message length
   mov ecx,msg       ;message to write
   mov ebx,1         ;file descriptor (stdout)
   mov eax,4         ;system call number (sys_write)
   int 0x80          ;call kernel

   mov eax,1         ;system call number (sys_exit)
   int 0x80          ;call kernel

segment .data        ;data segment
msg   db 'Hello, world!',0xa  ;our dear string
len   equ   $ - msg           ;length of our dear string
```
[[1]](#sources)

When the above code is compiled and executed, it produces the following result:

```
Hello, world!
```
[[1]](#sources)


## Memory Segments

A segmented memory model divides the system memory into groups of independent 
segments referenced by pointers located in the segment registers. Each segment 
is used to contain a specific type of data. One segment is used to contain 
instruction codes, another segment stores the data elements, and a third 
segment keeps the program stack. [[1]](#sources)

In the light of the above discussion, we can specify various memory segments 
as:

- ***Data segment*** − It is represented by `.data` section and the `.bss` 
section. 

    - The ***`.data` section*** is used to declare the memory region, where 
    data elements are stored for the program. This section cannot be expanded 
    after the data elements are declared, and it remains static throughout the 
    program.

        <span class="box-purple"><span class="bar-purple">
            <span class="purple">**ⓘ**</span>&nbsp; Info   
        </span><span class="inner">
            Static variables are analogous to global variables (i.e., they
            exist for the entire runtime). Checkout this [Wikipedia
            article](https://en.wikipedia.org/wiki/Data_segment) for more
            information.
        </span></span>

    - The ***`.bss` section*** is also a static memory section that contains 
    buffers for data to be declared later in the program. This buffer memory 
    is zero-filled.

- ***Code segment*** − It is represented by `.text` section. This defines an 
area in memory that stores the instruction codes. This is also a fixed area.

- ***Stack*** − This segment contains data values passed to functions and 
procedures within the program.

[[1]](#sources)


## Directives

NASM assembly has several other directives and keywords that can be used to 
direct the preprocessor besides the `section` keyword.  You can type 
`man nasm` in Linux to see the NASM "man page".  This page describes some 
directives including `ABSOLUTE <address>` (used to start assembly at a 
specified location), `RESB` (and `RESW`, `RESD`, etc.) (used for reserving 
uninitialized space for variables and arrays), `BITS 16` (and `BITS 32` and 
`BITS 64`) (used for switching the default processor mode to another mode), 
`EXTERN <symbol>` (used for declaring a symbol such as a function to import 
from another module), `GLOBAL <symbol>` (used for declaring a symbol that can 
be used in other modules), and `STRUC <strucname>` (and `ENDSTRUC`) (used for 
defining a structure).  Some of these directives will be used later in this 
course.
[[2]](#sources)

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    Many assembly languages can be coded in lowercase or uppercase. The
    convention varies. Some people use uppercase for headers or certain
    keywords. Either way is acceptable for this course; however, this course
    will generally use lowercase characters for keywords, directives, and
    instructions.
</span></span>


## Sources

1. *Basic Syntax - NASM Tutorial*. 
https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm. 
2. *NASM Man Page*. `man nasm`.


## Required Additional Readings

None.


## Resources

1. ***die.net Linux Docs and Man Pages***. 
https://linux.die.net/man/. 
Website with Linux man pages and docs.

2. ***NASM Docs***. 
https://www.nasm.us/doc/. 
Documentation for NASM utility.

3. ***YASM User Manual***. 
https://www.tortall.net/projects/yasm/manual/html/index.html. 
Interesting manual with chapters about NASM syntax and other syntaxes.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
