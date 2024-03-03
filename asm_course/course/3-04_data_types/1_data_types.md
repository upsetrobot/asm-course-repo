
# 💾 3-04 Data Types - Knowledge

<span style="color:lightcoral">*"Data?"*</span>
 ~-~ Commander La Forge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Data Sizes](#data-sizes)
- [Literals or Immediate Values](#literals-or-immediate-values)
- [Constants](#constants)
   - [The `EQU` Directive](#the-equ-directive)
   - [The `%assign` Directive](#the-assign-directive)
   - [The `%define` Directive](#the-define-directive)
- [Variables](#variables)
   - [Initialized Data](#allocating-storage-space-for-initialized-data)
   - [Multiple Definitions](#multiple-definitions)
   - [Multiple Initializations](#multiple-initializations)
   - [Uninitialized Data](#allocating-storage-space-for-uninitialized-data)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Data Sizes

Data in assembly can be interpreted and operated on specifically by size. 
Since all code, strings, numbers, symbols, addresses (pointers), objects, 
structures, and everything else are just binary numbers, there really are no 
rigid types in assembly. Instead, data is referenced by number of bytes. For 
example, the binary number (in hexadecimal) `0x7a6178ff` can be interpreted as 
four letters `zax�` (one letter not interpretable in ASCII) or four one-byte 
numbers `122`, `97`, `120`, and `255`, or four one-byte numbers `122`, `97`, 
`120`, and `-1`, or two two-byte numbers `24,954` and `65,400`, or two 
two-byte numbers `24,954` and `-136`, or one four-byte number `4,286,079,354`, 
or one four-byte number `-8887942` or one five-byte (or larger) number of 
`4,286,079,354`, or even assembly `jp 0x63, js 0x3` (`jp` is jump if parity 
flag is set, and `js` is jump if sign flag is set). So, you can see that the 
number of bytes being interpreted is one of the most important facts in binary 
data typing. 

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    The example in the above paragraph assumes little-endian order.
</span></span>

Typically, assembly references binary in byte quantities. The most common 
sizes are `byte` (one byte), `word` (two bytes), `dword` (double word or four 
bytes), and `qword` (quad word or eight bytes). Signed numbers on unsigned 
numbers are typically treated the same and depend on programming context. 
There is also the `sign flag` which assists with signed instructions. For 
example, `ja` is the unsigned instruction for "jump if unsigned operand one is 
larger (or *above*) unsigned operand two", whereas `jg` is the signed 
instruction for "jump if operand one is larger (or *greater*) than signed 
operand two".

| Keyword | Storage Space |
|---------|---------------|
| `byte`  | 1 byte        |
| `word`  | 2 bytes       |
| `dword` | 4 bytes       |
| `qword` | 8 bytes       |
| `tbyte` | 10 bytes      |

These sizes are used to tell the assembler what size to dereference from a 
pointer and sometimes when operand size clarification is needed. If the size 
is used for a pointer dereference, the word `ptr` may be used (but this is 
not required).

For example:

``` x86asm
    cmp byte [rdi], 10          ; Size declared as one byte.
    cmp byte ptr [rdi], 10      ; Exactly the same as above.

    mov rax, [rdi]              ; Size implied by size of operand (8 bytes).
    mov rax, qword [rdi]        ; Same as above.
    mov rax, qword ptr [rdi]    ; Same as above.

    cmp word [rdi], 10          ; Comparing two bytes to 10.
    cmp dword [rdi], 10         ; Comparing four bytes to 10.
```


## Literals or Immediate Values

In NASM assembly, you can use immediate values in many operations. These may 
be typed into the assembly code or data sections. Typically, you can use 
ASCII, decimal, hex, octal, or even binary. More information can be found in 
the 
[NASM docs in Chapter 3](https://www.nasm.us/xdoc/2.11.02/html/nasmdoc3.html#section-3.4). 
The size of the immediate is determined by context and NASM rules (e.g., if 
you move a number into a 64-bit register, the number will be signed extended 
in the register). You can force the size using the size keywords before the 
operand (such as in `mov r8, byte 1`) [[1]](#sources).

Example:

``` x86asm
   mov rax, 97          ; Load rax with value of 97. Decimal version.
   mov rax, 0x61        ; Load rax with value of 97. Hex version.
   mov rax, 61h         ; Load rax with value of 97. Alternate hex version.
   mov rax, 0o141       ; Load rax with value of 97. Octal version.
   mov rax, 'a'         ; Load rax with value of 97. ASCII version.
   mov rax, 01100001b   ; Load rax with value of 97. Binary version.
   mov rax, 0b1100001   ; Load rax with value of 97. Binary alternate version. 
```


## Constants

There are several directives provided by NASM that define constants. We will 
particularly discuss three directives:

- `equ`
- `%assign`
- `%define`

[[2]](#sources)


### The `EQU` Directive

The `EQU` directive is used for defining constants. The syntax of the `EQU` 
directive is as follows: `<constant_name> equ expression`.

For example:

``` x86asm
TOTAL_STUDENTS equ 50
```

[[2]](#sources)

You can then use this constant value in your code, like:

``` x86asm
mov  ecx,  TOTAL_STUDENTS 
cmp  eax,  TOTAL_STUDENTS
```

[[2]](#sources)

The operand of an `EQU` statement can be an expression:

``` x86asm
LENGTH equ 20
WIDTH  equ 10
AREA   equ length * width
```

[[2]](#sources)

The above code segment would define `AREA` as `200`. [[2]](#sources)

The following example illustrates the use of the `EQU` directive:

``` x86asm
SYS_EXIT  equ 1
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1
section	 .text
   global _start    ;must be declared for using gcc
	
_start:             ;tell linker entry point
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80                
	
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg2         
   mov edx, len2 
   int 0x80 
	
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg3         
   mov edx, len3 
   int 0x80
   
   mov eax,SYS_EXIT    ;system call number (sys_exit)
   int 0x80            ;call kernel

section	 .data
msg1 db	'Hello, programmers!',0xA,0xD 	
len1 equ $ - msg1			

msg2 db 'Welcome to the world of,', 0xA,0xD 
len2 equ $ - msg2 

msg3 db 'Linux assembly programming! '
len3 equ $- msg3
```

[[2]](#sources)

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
    The `$` in the above code represents "this location"; so, `$ - <label>` is
    the difference from the location where the `$` is to where the label is in
    bytes - which is the length.
</span></span>

When the above code is compiled and executed, it produces the following result:

```
Hello, programmers!
Welcome to the world of,
Linux assembly programming!
```

[[2]](#sources)


### The `%assign` Directive

The `%assign` directive can be used to define numeric constants like the `EQU` 
directive. But this directive allows redefinition. For example, you may define 
the constant `TOTAL` as:

``` x86asm 
%assign TOTAL 10
```

[[2]](#sources)

Later in the code, you can redefine it as:

``` x86asm
%assign  TOTAL  20
```

[[2]](#sources)

This directive is case-sensitive [[2]](#sources). 


### The `%define` Directive

The `%define` directive allows defining both numeric and string constants. 
This directive is similar to the `#define` in C. For example, you may define 
the constant `PTR` as:

``` x86asm 
%define PTR [EBP+4]
```

[[2]](#sources)

The above code replaces PTR by `[EBP+4]`. This directive also allows 
redefinition and it is case-sensitive [[2]](#sources).


## Variables

NASM provides various define directives for reserving storage space for 
variables. The define assembler directive is used for allocation of storage 
space. It can be used to reserve as well as initialize one or more bytes 
[[3]](#sources).


### Allocating Storage Space for Initialized Data

The syntax for storage allocation statement for initialized data is: 
`[<variable-name>] <define-directive> <initial-value> [, <initial-value>]...` 
where, `<variable-name>` is the identifier for each storage space. The 
assembler associates an offset value for each variable name defined in the 
data segment [[3]](#sources).

There are five basic forms of the define directive:

| Directive | Purpose           | Storage Space      |
|-----------|-------------------|--------------------|
| `DB`      | Define Byte       | allocates 1 byte   |
| `DW`      | Define Word       | allocates 2 bytes  |
| `DD`      | Define Doubleword | allocates 4 bytes  |
| `DQ`      | Define Quadword   | allocates 8 bytes  |
| `DT`      | Define Ten Bytes  | allocates 10 bytes |

[[3]](#sources)

Following are some examples of using define directives:

``` x86asm
choice		DB	'y'
number		dw	12345
neg_number	DW	-12345
big_number	DQ	123456789
real_number1	DD	1.234
real_number2	dq	123.456
```

[[3]](#sources)

Please note that:

- Each byte of a character is stored as its ASCII value in hexadecimal.
- Each decimal value is automatically converted to its 16-bit binary 
equivalent and stored as a hexadecimal number.
- The processor uses the little-endian byte ordering.
- Negative numbers are converted to their 2's complement representation.
- Short and long floating-point numbers are represented using 32 or 64 bits, 
respectively.

[[3]](#sources)

The following program shows the use of define directive:

``` x86asm 
section .text
   global _start     ;must be declared for linker (gcc)

_start:              ;tell linker entry point
   mov   edx,1       ;message length
   mov   ecx,choice  ;message to write
   mov   ebx,1       ;file descriptor (stdout)
   mov   eax,4       ;system call number (sys_write)
   int   0x80        ;call kernel

   mov   eax,1       ;system call number (sys_exit)
   int   0x80        ;call kernel

section .data
choice db 'y'
```

[[3]](#sources)

When the above code is compiled and executed, it produces the following result:
```
y
```

[[3]](#sources)


### Multiple Definitions

You can have multiple data definition statements in a program. For example:

``` x86asm 
choice   DB    'Y'         ;ASCII of y = 79H
number1  DW    12345       ;12345D = 3039H
number2  DD    12345679    ;123456789D = 75BCD15H
```

[[3]](#sources)

The assembler allocates contiguous memory for multiple variable definitions 
[[3]](#sources).


### Multiple Initializations

The `TIMES` directive allows multiple initializations to the same value. For 
example, an array named `marks` of size 9 can be defined and initialized to 
zero using the following statement:

``` x86asm 
marks  TIMES  9  DW  0
```

[[3]](#sources)

The `TIMES` directive is useful in defining arrays and tables. The following 
program displays 9 asterisks on the screen:

``` x86asm
section  .text
   global _start     ;must be declared for linker (ld)

_start:              ;tell linker entry point
   mov   edx,9       ;message length
   mov   ecx, stars  ;message to write
   mov   ebx,1       ;file descriptor (stdout)
   mov   eax,4       ;system call number (sys_write)
   int   0x80        ;call kernel

   mov   eax,1       ;system call number (sys_exit)
   int   0x80        ;call kernel

section  .data
stars    times 9 db '*'
```

[[3]](#sources)

When the above code is compiled and executed, it produces the following result:
```
*********
```

[[3]](#sources)


### Allocating Storage Space for Uninitialized Data

The reserve directives are used for reserving space for uninitialized data. 
The reserve directives take a single operand that specifies the number of 
units of space to be reserved. Each define directive has a related reserve 
directive [[3]](#sources).

There are five basic forms of the reserve directive:

| Directive | Purpose              |
|-----------|----------------------|
| `RESB`    | Reserve a Byte       |
| `RESW`    | Reserve a Word       |
| `RESD`    | Reserve a Doubleword |
| `RESQ`    | Reserve a Quadword   |
| `REST`    | Reserve a Ten Bytes  |

[[3]](#sources)

Example:

``` x86asm
section .bss
   sum resb 1           ; Reserve space for one byte.
   answer resd 5        ; Reserve space for five dwords.
   my_pointer resq 1    ; Reserve space for one qword.
```


## Sources

1. *3.4 Immediate Operands*. 
https://www.tortall.net/projects/yasm/manual/html/nasm-immediate.html. 
2. *Assembly Constants*. 
https://www.tutorialspoint.com/assembly_programming/assembly_constants.htm.
3. *Assembly Variables*. 
https://www.tutorialspoint.com/assembly_programming/assembly_variables.htm.


## Required Additional Readings

None.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
