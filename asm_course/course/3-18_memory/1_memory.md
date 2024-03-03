
# 🧠 3-18 Memory - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Memory in Assembly](#memory-in-assembly)
- [Memory Sections](#memory-sections)
    - [Direct Memory Addressing](#direct-memory-addressing)
    - [Direct-Offset Memory Addressing](#direct-offset-memory-addressing)
    - [Indirect Memory Addressing](#indirect-memory-addressing)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Memory in Assembly

You have already briefly seen use of memory referencing in NASM in earlier 
modules, but this module will go over it a little more. Assembly can make use 
of memory that is designated to be allocated in the program when the program 
first runs (static memory allocations). And then memory can be allocated 
dynamically while the program is running (which will be discussed more in the 
syscalls module). Even memory that was not explicitly allocated can be read or 
written to in some cases. There are many interesting things you can do with 
memory in assembly. This module will go over the static memory setup and 
referencing again and give some examples of how to use global memory in your 
programs.


## Memory Sections

Recall that there are memory sections that you can declare or define in your 
program. The most common sections in Linux NASM are the `.text` section (which 
is where your executable code goes), the `.data` section (for initialized 
data), the `.rodata` section (for initialized read-only data), and the `.bss` 
section (for uninitialized data). The `.text` section is setup in the process 
with read-execute privileges, the `.data` section gets read-write privileges, 
the `.rodata` section gets read privileges, and the `.bss` get read-write 
privileges. The heap also gets read-write privileges and will be discussed 
more in the syscalls modules. The stack may have read-write-execute privileges 
(sometimes depends on compilation and security settings). Here is an example 
of memory layout in a process as shown by `gdb` using the `i proc map` command:

``` gdb
gef➤  i proc map
process 863426
Mapped address spaces:

          Start Addr           End Addr       Size     Offset  Perms  objfile
            0x400000           0x401000     0x1000        0x0  r--p   /asm_course/3-09_bit_operations/lab_tester
            0x401000           0x403000     0x2000     0x1000  r-xp   /asm_course/3-09_bit_operations/lab_tester
            0x403000           0x404000     0x1000     0x3000  r--p   /asm_course/3-09_bit_operations/lab_tester
            0x404000           0x405000     0x1000     0x3000  r--p   /asm_course/3-09_bit_operations/lab_tester
            0x405000           0x406000     0x1000     0x4000  rw-p   /asm_course/3-09_bit_operations/lab_tester
            0x406000           0x427000    0x21000        0x0  rw-p   [heap]
      0x7ffff7d72000     0x7ffff7d75000     0x3000        0x0  rw-p   
      0x7ffff7d75000     0x7ffff7d9d000    0x28000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7d9d000     0x7ffff7f32000   0x195000    0x28000  r-xp   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f32000     0x7ffff7f8a000    0x58000   0x1bd000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f8a000     0x7ffff7f8e000     0x4000   0x214000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f8e000     0x7ffff7f90000     0x2000   0x218000  rw-p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f90000     0x7ffff7f9d000     0xd000        0x0  rw-p   
      0x7ffff7fbb000     0x7ffff7fbd000     0x2000        0x0  rw-p   
      0x7ffff7fbd000     0x7ffff7fc1000     0x4000        0x0  r--p   [vvar]
      0x7ffff7fc1000     0x7ffff7fc3000     0x2000        0x0  r-xp   [vdso]
      0x7ffff7fc3000     0x7ffff7fc5000     0x2000        0x0  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7fc5000     0x7ffff7fef000    0x2a000     0x2000  r-xp   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7fef000     0x7ffff7ffa000     0xb000    0x2c000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7ffb000     0x7ffff7ffd000     0x2000    0x37000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7ffd000     0x7ffff7fff000     0x2000    0x39000  rw-p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffffffde000     0x7ffffffff000    0x21000        0x0  rwxp   [stack]
  0xffffffffff600000 0xffffffffff601000     0x1000        0x0  --xp   [vsyscall]
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
Notice the permissions column (labeled "Perms"). Also, notice that Linux 
executables seem to have libc and linker (ld) libraries already mapped as 
well. Also, notice that there are several sections with space with read-write 
memory allocated. Can you use this space?
</span></span>


## Using Memory

All you need to use memory in assembly is permission and an address. Since 
everything is done with addresses (pointers), you can move around memory by 
adding and subtracting from addresses. Labels are just addresses or offsets to 
addresses. NASM helps out by letting you use labels instead of offsets and 
addresses. 

<span class="box-green"><span class="bar-green">
    💲 Tip**
</span><span class="inner">
Review Module "3-04 Data Sizes" if you need a refresher on the memory sections.
</span></span>


### Direct Memory Addressing

When operands are specified in memory addressing mode, direct access to main
memory, usually to the data segment, is required. This way of addressing
results in slower processing of data. To locate the exact location of data in
memory, we need the segment start address, which is typically found in the 
`DS` register and an offset value. This offset value is also called effective
address [[1]](#sources).

In direct addressing mode, the offset value is specified directly as part of
the instruction, usually indicated by the variable name. The assembler
calculates the offset value and maintains a symbol table, which stores the
offset values of all the variables used in the program [[1]](#sources).

In direct memory addressing, one of the operands refers to a memory location
and the other operand references a register [[1]](#sources).

For example:

``` x86asm
    ADD	BYTE_VALUE, DL	; Adds the register in the memory location
    MOV	BX, WORD_VALUE	; Operand from the memory is added to register
```
[[1]](#sources)


### Direct-Offset Memory Addressing

This addressing mode uses the arithmetic operators to modify an address. For
example, look at the following definitions that define tables of data
[[1]](#sources):

``` x86asm
    BYTE_TABLE DB  14, 15, 22, 45      ; Tables of bytes
    WORD_TABLE DW  134, 345, 564, 123  ; Tables of words
```
[[1]](#sources)

The following operations access data from the tables in the memory into
registers [[1]](#sources):

``` x86asm
    MOV CL, BYTE_TABLE[2]	; Gets the 3rd element of the BYTE_TABLE
    MOV CL, BYTE_TABLE + 2	; Gets the 3rd element of the BYTE_TABLE
    MOV CX, WORD_TABLE[3]	; Gets the 4th element of the WORD_TABLE
    MOV CX, WORD_TABLE + 3	; Gets the 4th element of the WORD_TABLE
```
[[1]](#sources)


### Indirect Memory Addressing

This addressing mode utilizes the computer's ability of Segment:Offset
addressing. Generally, the base registers `EBX`, `EBP`(or `BX`, `BP`) and the
index registers (`DI`, `SI`), coded within square brackets for memory
references, are used for this purpose [[1]](#sources).

Indirect addressing is generally used for variables containing several elements
like, arrays. Starting address of the array is stored in, say, the `EBX`
register [[1]](#sources).

The following code snippet shows how to access different elements of the
variable [[1]](#sources):

``` x86asm
    MY_TABLE TIMES 10 DW 0  ; Allocates 10 words (2 bytes) each initialized to 0
    MOV EBX, [MY_TABLE]     ; Effective Address of MY_TABLE in EBX
    MOV [EBX], 110          ; MY_TABLE[0] = 110
    ADD EBX, 2              ; EBX = EBX + 2
    MOV [EBX], 123          ; MY_TABLE[1] = 123
```
[[1]](#sources)


The `MOV` instruction causes ambiguity at times. For example, look at the
statements [[1]](#sources):

``` x86asm
    MOV  EBX, [MY_TABLE]  ; Effective Address of MY_TABLE in EBX
    MOV  [EBX], 110	      ; MY_TABLE[0] = 110
```
[[1]](#sources)

It is not clear whether you want to move a byte equivalent or word equivalent
of the number 110. In such cases, it is wise to use a type specifier
[[1]](#sources).

``` x86asm
    MOV  EBX, [MY_TABLE]    ; Effective Address of MY_TABLE in EBX
    MOV  BYTE [EBX], 110	; MY_TABLE[0] = 110
```
[[1]](#sources)

Remember that the "Data Sizes" module describes these size specifiers.

The following program illustrates some of the concepts discussed above. It
stores a name 'Zara Ali' in the data section of the memory, then changes its
value to another name 'Nuha Ali' programmatically and displays both the names
[[1]](#sources).

``` x86asm
section	.text
   global _start     ;must be declared for linker (ld)

_start:             ;tell linker entry point
	
   ; Writing the name 'Zara Ali'
   mov	edx,9       ;message length
   mov	ecx, name   ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
	
   mov	[name],  dword 'Nuha'    ; Changed the name to Nuha Ali
	
   ; Writing the name 'Nuha Ali'
   mov	edx,8       ;message length
   mov	ecx,name    ;message to write
   mov	ebx,1       ;file descriptor (stdout)
   mov	eax,4       ;system call number (sys_write)
   int	0x80        ;call kernel
	
   mov	eax,1       ;system call number (sys_exit)
   int	0x80        ;call kernel

section	.data
name db 'Zara Ali '
```

When the above code is compiled and executed, it produces the following result
[[1]](#sources):

```
Zara Ali Nuha Ali
```
[[1]](#sources)


## Sources

1. *Assembly - Addressing Modes*. 
https://www.tutorialspoint.com/assembly_programming/assembly_addressing_modes.htm.


## Required Additional Readings

None.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
