
# 🧶 3-19 Strings - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Strings in Assembly](#strings-in-assembly)
- [Declaring Strings](#declaring-strings)
- [String Instructions](#string-instructions)
- [`repcc` Prefix](#repcc-prefix)
- [`cld` Instruction](#cld-instruction)
- [`std` Instruction](#std-instruction)
- [`movs` Instruction](#movs-instruction)
- [`lods` Instruction](#lods-instruction)
- [`stos` Instruction](#stos-instruction)
- [`cmps` Instruction](#cmps-instruction)
- [`scas` Instruction](#scas-instruction)
- [Numerical Strings in Assembly](#numerical-strings-in-assembly)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Strings in Assembly

Strings can be a little difficult to work with in assembly at first. But there 
are several instructions and methods that make them easier to deal with. In 
this module, we will go over string definitions, buffers, and basic string 
operations in assembly.


## Declaring Strings

We have already used variable length strings in our previous examples. The
variable length strings can have as many characters as required. Generally, we
specify the length of the string by either of the two ways [[1]](#sources):

- Explicitly storing string length
- Using a sentinel character

We can store the string length explicitly by using the `$` location counter
symbol that represents the current value of the location counter. In the
following example, `$` points to the byte after the last character of the 
string variable `msg` [[1]](#sources).

``` x86asm
msg  db  'Hello, world!',0xa    ;our dear string
len  equ  $ - msg               ;length of our dear string
```
[[1]](#sources)

Therefore, `$-msg` gives the length of the string. We can also write
[[1]](#sources):

``` x86asm
msg db 'Hello, world!',0xa      ;our dear string
len equ 13                      ;length of our dear string
```
[[1]](#sources)

Alternatively, you can store strings with a trailing sentinel character to
delimit a string instead of storing the string length explicitly. The sentinel
character should be a special character that does not appear within a string 
[[1]](#sources).

This is the case with null-terminated strings. They are terminated with a `0` 
byte. 

For example:

``` x86asm
message DB 'This string is null-terminated. The sentinel is a null byte.', 0
```


## String Instructions

Each string instruction may require a source operand, a destination operand or
both. For 32-bit segments, string instructions use `ESI` and `EDI` registers 
to point to the source and destination operands, respectively. For 16-bit 
segments, however, the `SI` and the `DI` registers are used to point to the 
source and destination, respectively. There are five basic instructions for 
processing strings. They are [[1]](#sources):

- `MOVS` − This instruction "moves" 1 Byte, Word or Doubleword of data from 
one memory location to another [[1]](#sources).
- `LODS` − This instruction "loads" from memory. If the operand is of one byte, 
it is loaded into the `AL` register, if the operand is one word, it is loaded 
into the `AX` register and a doubleword is loaded into the `EAX` register
[[1]](#sources).
- `STOS` − This instruction "stores" data from register (`AL`, `AX`, or `EAX`) 
to memory [[1]](#sources).
- `CMPS` − This instruction "compares" two data items in memory. Data could be 
of a byte size, word or doubleword [[1]](#sources).
- `SCAS` − This instruction "scans" by comparing the contents of a register 
(`AL`, `AX` or `EAX`) with the contents of an item in memory [[1]](#sources).

Each of the above instruction has a byte, word, and doubleword version, and
string instructions can be repeated by using a repetition prefix
[[1]](#sources).

These instructions use the `ES:DI` and `DS:SI` pair of registers, where `DI` 
and `SI` registers contain valid offset addresses that refers to bytes stored 
in memory. `SI` is normally associated with `DS` (data segment) and `DI` is 
always associated with `ES` (extra segment). The `DS:SI` (or `ESI`) and 
`ES:DI` (or `EDI`) registers point to the source and destination operands, 
respectively. The source operand is assumed to be at `DS:SI` (or `ESI`) and 
the destination operand at `ES:DI` (or `EDI`) in memory. For 16-bit addresses, 
the `SI` and `DI` registers are used, and for 32-bit addresses, the `ESI` and 
`EDI` registers are used [[1]](#sources).

| Instruction | byte-version | word-version | dword-version | qword-version |
|-------------|--------------|--------------|---------------|---------------|
| `movs`      | `movsb`      | `movsw`      | `movsd`       | `movsq`       |
| `lods`      | `lodsb`      | `lodsw`      | `lodsd`       | `lodsq`       |
| `stos`      | `stosb`      | `stosw`      | `stosd`       | `stosq`       |
| `cmps`      | `cmpsb`      | `cmpsw`      | `cmpsd`       | `cmpsq`       |
| `scas`      | `scasb`      | `scasw`      | `scasd`       | `scasq`       |


## `repcc` Prefix

The `REP` prefix, when set before a string instruction, such as in `REP MOVSB`,
causes repetition of the instruction based on a counter placed at the `CX`
register. `REP` executes the instruction, decreases `CX` by 1, and checks 
whether `CX` is zero. It repeats the instruction processing until `CX` is zero.
The Direction Flag (`DF`) determines the direction of the operation. Use `CLD`
(Clear Direction Flag, DF = 0) to make the operation left to right. Use `STD`
(Set Direction Flag, DF = 1) to make the operation right to left
[[1]](#sources). 

The `REP` prefix also has the following variations [[1]](#sources):

- `REP` is the unconditional repeat. It repeats the operation until `CX` is
zero [[1]](#sources).
- `REPE` (or `REPZ`) is a conditional repeat. It repeats the operation while
the zero flag indicates equal/zero. It stops when the `ZF` indicates not
equal/zero or when `CX` is zero [[1]](#sources).
- `REPNE` (or `REPNZ`) is also a conditional repeat. It repeats the operation
while the zero flag indicates not equal/zero. It stops when the `ZF` indicates
equal/zero or when `CX` is decremented to zero [[1]](#sources).

`rep` repeats a string instruction the number of times specified in the count
register or until the indicated condition of the `ZF` flag is no longer met.
The `REP` (repeat), `REPE` (repeat while equal), `REPNE` (repeat while not
equal), `REPZ` (repeat while zero), and `REPNZ` (repeat while not zero)
mnemonics are prefixes that can be added to one of the string instructions. The
`REP` prefix can be added to the `INS`, `OUTS`, `MOVS`, `LODS`, and `STOS`
instructions, and the `REPE`, `REPNE`, `REPZ`, and `REPNZ` prefixes can be
added to the `CMPS` and `SCAS` instructions. (The `REPZ` and `REPNZ` prefixes
are synonymous forms of the `REPE` and `REPNE` prefixes, respectively.
[[2]](#sources)) 

The `REP` prefixes apply only to one string instruction at a time. To repeat a
block of instructions, use the `LOOP` instruction or another looping construct.
All of these repeat prefixes cause the associated instruction to be repeated
until the count in register is decremented to `0` [[2]](#sources). 

| Repeat Prefix | Termination Condition 1 | Termination Condition 2 |
|---------------|-------------------------|-------------------------|
| `REP`         | `RCX` or `(E)CX` = `0`  | None                    |
| `REPE/REPZ`   | `RCX` or `(E)CX` = `0`  | `ZF` = `0`              |
| `REPNE/REPNZ` | `RCX` or `(E)CX` = `0`  | `ZF` = `1`              |

[[2]](#sources)

The `REPE`, `REPNE`, `REPZ`, and `REPNZ` prefixes also check the state of the
`ZF` flag after each iteration and terminate the repeat loop if the `ZF` flag
is not in the specified state. When both termination conditions are tested, the
cause of a repeat termination can be determined either by testing the count
register with a `JECXZ` instruction or by testing the `ZF` flag (with a `JZ`,
`JNZ`, or `JNE` instruction) [[2]](#sources).

When the `REPE/REPZ` and `REPNE/REPNZ` prefixes are used, the `ZF` flag does
not require initialization because both the `CMPS` and `SCAS` instructions
affect the `ZF` flag according to the results of the comparisons they make
[[2]](#sources).

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Note that a `REP STOS` instruction is the fastest way to initialize a large
block of memory.
</span></span>

For examples, see the sections below.


## `cld` Instruction

Clears the `DF` flag in the `EFLAGS` register. When the `DF` flag is set to
`0`, string operations increment the index registers (`ESI` and/or `EDI`).
Operation is the same in all modes [[3]](#sources).

For examples, see the sections below.


## `std` Instruction

Sets the `DF` flag in the `EFLAGS` register. When the `DF` flag is set to `1`,
string operations decrement the index registers (`ESI` and/or `EDI`). Operation
is the same in all modes [[4]](#sources).

For examples, see the sections below.


## `movs` Instruction

Moves the byte, word, or doubleword specified with the second operand (source
operand) to the location specified with the first operand (destination
operand). Both the source and destination operands are located in memory. The
address of the source operand is read from the `DS:ESI` or the `DS:SI`
registers (depending on the address-size attribute of the instruction, 32 or
16, respectively). The address of the destination operand is read from the
`ES:EDI` or the `ES:DI` registers (again depending on the address-size
attribute of the instruction). The `DS` segment may be overridden with a
segment override prefix, but the `ES` segment cannot be overridden. In 64-bit
mode, the instruction’s default address size is 64 bits. The 64-bit addresses
are specified by `RSI` and `RDI`; 32-bit address are specified by `ESI` and
`EDI` [[5]](#sources). 

At the assembly-code level, two forms of this instruction are allowed: the
“explicit-operands” form and the “no-operands” form. The explicit-operands form
(specified with the `MOVS` mnemonic) allows the source and destination operands
to be specified explicitly. The no-operands form provides “short forms” of the
byte, word, and doubleword versions of the `MOVS` instructions. Here also
`DS:(E)SI` and `ES:(E)DI` are assumed to be the source and destination
operands, respectively. The size of the source and destination operands is
selected with the mnemonic: `MOVSB` (byte move), `MOVSW` (word move), or
`MOVSD` (doubleword move) [[5]](#sources).

After the move operation, the `(E)SI` and `(E)DI` registers are incremented or
decremented automatically according to the setting of the `DF` flag in the
`EFLAGS` register. (If the `DF` flag is `0`, the `(E)SI` and `(E)DI` register
are incremented; if the `DF` flag is `1`, the `(E)SI` and `(E)DI` registers are
decremented.) The registers are incremented or decremented by `1` for byte
operations, by `2` for word operations, or by `4` for doubleword operations
[[5]](#sources).

The `MOVS`, `MOVSB`, `MOVSW`, and `MOVSD` instructions can be preceded by the
`REP` prefix for block moves of `ECX` bytes, words, or doublewords
[[5]](#sources).

For example:

``` x86asm
section .text
    ...

    ; I want to copy a string into a buffer.

    mov rdi, buffer
    mov rsi, string
    mov rcx, sting_len
    cld                     ; Set direction left-to-right.
    rep movsb               ; Copy `rcx` bytes from source address (`rsi`) to 
                            ; destination address (`rdi`). `rdi` and `rsi` 
                            ; will be incremented to end of string and buffer.
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```


## `lods` Instruction

Loads a byte, word, or doubleword from the source operand into the `AL`, `AX`,
or `EAX` register, respectively. The source operand is a memory location, the
address of which is read from the `DS:ESI` or the `DS:SI` registers (depending
on the address-size attribute of the instruction, 32 or 16, respectively). The
`DS` segment may be overridden with a segment override prefix In 64-bit mode,
`LODS/LODSQ` load the quadword at address `(R)SI` into `RAX`. The `(R)SI`
register is then incremented or decremented automatically according to the
setting of the `DF` flag in the `EFLAGS` register [[6]](#sources).

At the assembly-code level, two forms of this instruction are allowed: the
“explicit-operands” form and the “no-operands” form. The explicit-operands form
(specified with the `LODS` mnemonic) allows the source operand to be specified
explicitly. Here, the source operand should be a symbol that indicates the size
and location of the source value. The destination operand is then automatically
selected to match the size of the source operand (the `AL` register for byte
operands, `AX` for word operands, and `EAX` for doubleword operands).  The
no-operands form provides “short forms” of the byte, word, and doubleword
versions of the `LODS` instructions. Here also `DS:(E)SI` is assumed to be the
source operand and the `AL`, `AX`, or `EAX` register is assumed to be the
destination operand. The size of the source and destination operands is
selected with the mnemonic: `LODSB` (byte loaded into register `AL`), `LODSW`
(word loaded into `AX`), or `LODSD` (doubleword loaded into `EAX`) (or `LODSQ`
and `RAX`) [[6]](#sources).

After the byte, word, or doubleword is transferred from the memory location
into the `AL`, `AX`, or `EAX` register, the `(E)SI` register is incremented or
decremented automatically according to the setting of the `DF` flag in the
`EFLAGS` register. (If the `DF` flag is `0`, the `(E)SI` register is
incremented; if the DF flag is `1`, the `ESI` register is decremented.) The
`(E)SI` register is incremented or decremented by `1` for byte operations, by
`2` for word operations, or by `4` for doubleword operations (or by `8` for
quadword operations) [[6]](#sources).

The `LODS`, `LODSB`, `LODSW`, and `LODSD` instructions can be preceded by the
`REP` prefix for block loads of `ECX` bytes, words, or doublewords. More often,
however, these instructions are used within a `LOOP` construct because further
processing of the data moved into the register is usually necessary before the
next transfer can be made [[6]](#sources). 

For example:

``` x86asm
section .text
    ...

    ; I want to encrypt a string by adding 0x10 and then put it in the buffer.

    mov rdi, buffer
    mov rsi, string
    mov rcx, sting_len
    cld                     ; Set the direction left-to-right.

    .loop:
        lodsb               ; Move byte from `rsi` to `al` and `inc rsi`.
        add al, 0x10        ; Rotate ASCII right by 16.
        stosb               ; Move byte from `al` to `rdi` and `inc rdi`.
        loop .loop          ; `dec rcx` and `jmp .loop` if `rcx` is not `0`.
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```


## `stos` Instruction

In non-64-bit and default 64-bit mode; stores a byte, word, or doubleword from
the `AL`, `AX`, or `EAX` register (respectively) into the destination operand.
The destination operand is a memory location, the address of which is read from
either the `ES:EDI` or `ES:DI` register (depending on the address-size
attribute of the instruction and the mode of operation). The `ES` segment
cannot be overridden with a segment override prefix. In 64-bit mode, the
default address size is 64 bits. The promoted no-operand mnemonic is `STOSQ`.
`STOSQ` (and its explicit operands variant) store a quadword from the `RAX`
register into the destination addressed by `RDI` or `EDI` [[7]](#sources).

At the assembly-code level, two forms of the instruction are allowed: the
“explicit-operands” form and the “no-operands” form. The explicit-operands form
(specified with the `STOS` mnemonic) allows the destination operand to be
specified explicitly. Here, the destination operand should be a symbol that
indicates the size and location of the destination value. The source operand is
then automatically selected to match the size of the destination operand (the
`AL` register for byte operands, `AX` for word operands, `EAX` for doubleword
operands). The no-operands form provides “short forms” of the byte, word,
doubleword, and quadword versions of the `STOS` instructions. Here also
`ES:(E)DI` is assumed to be the destination operand and `AL`, `AX`, or `EAX` is
assumed to be the source operand. The size of the destination and source
operands is selected by the mnemonic: `STOSB` (byte read from register `AL`),
`STOSW` (word from `AX`), `STOSD` (doubleword from `EAX`) [[7]](#sources).

After the byte, word, or doubleword is transferred from the register to the
memory location, the `(E)DI` register is incremented or decremented according
to the setting of the `DF` flag in the `EFLAGS` register. If the `DF` flag is
`0`, the register is incremented; if the `DF` flag is `1`, the register is
decremented (the register is incremented or decremented by `1` for byte
operations, by `2` for word operations, by `4` for doubleword operations)
[[7]](#sources).

The `STOS`, `STOSB`, `STOSW`, `STOSD`, `STOSQ` instructions can be preceded by
the `REP` prefix for block stores of `ECX` bytes, words, or doublewords. More
often, however, these instructions are used within a `LOOP` construct because
data needs to be moved into the `AL`, `AX`, or `EAX` register before it can be
stored [[7]](#sources).

For example:

``` x86asm
section .text
    ...

    ; I want to convert a lowercase string to uppercase and then put it in the buffer.

    mov rdi, buffer
    mov rsi, string
    mov rcx, sting_len
    cld                     ; Set the direction left-to-right.

    .loop:
        lodsb               ; Move byte from `rsi` to `al` and `inc rsi`.
        or al, 0x20         ; Convert ASCII from lowercase to uppercase.
        stosb               ; Move byte from `al` to `rdi` and `inc rdi`.
        loop .loop          ; `dec rcx` and `jmp .loop` if `rcx` is not `0`.
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```


## `cmps` Instruction

Compares the byte, word, doubleword, or quadword specified with the first
source operand with the byte, word, doubleword, or quadword specified with the
second source operand and sets the status flags in the `EFLAGS` register
according to the results [[8]](#sources).

Both source operands are located in memory. The address of the first source
operand is read from `DS:SI`, `DS:ESI` or `RSI` (depending on the address-size
attribute of the instruction is 16, 32, or 64, respectively). The address of
the second source operand is read from `ES:DI`, `ES:EDI` or `RDI` (again
depending on the address-size attribute of the instruction is 16, 32, or 64).
The `DS` segment may be overridden with a segment override prefix, but the `ES`
segment cannot be overridden [[8]](#sources).

At the assembly-code level, two forms of this instruction are allowed: the
“explicit-operands” form and the “no-operands” form. The explicit-operands form
(specified with the `CMPS` mnemonic) allows the two source operands to be
specified explicitly. Here, the source operands should be symbols that indicate
the size and location of the source values. The no-operands form provides
“short forms” of the byte, word, and doubleword versions of the `CMPS`
instructions. Here also the `DS:(E)SI` (or `RSI`) and `ES:(E)DI` (or `RDI`)
registers are assumed by the processor to specify the location of the source
operands. The size of the source operands is selected with the mnemonic:
`CMPSB` (byte comparison), `CMPSW` (word comparison), `CMPSD` (doubleword
comparison), or `CMPSQ` (quadword comparison) [[8]](#sources).

After the comparison, the `(E/R)SI` and `(E/R)DI` registers increment or
decrement automatically according to the setting of the `DF` flag in the
`EFLAGS` register. (If the `DF` flag is `0`, the `(E/R)SI` and `(E/R)DI`
register increment; if the `DF` flag is `1`, the registers decrement.) The
registers increment or decrement by `1` for byte operations, by `2` for word
operations, `4` for doubleword operations. If operand size is 64, `RSI` and
`RDI` registers increment by `8` for quadword operations [[8]](#sources).

The `CMPS`, `CMPSB`, `CMPSW`, `CMPSD`, and `CMPSQ` instructions can be preceded
by the `REP` prefix for block comparisons. More often, however, these
instructions will be used in a `LOOP` construct that takes some action based on
the setting of the status flags before the next comparison is made
[[8]](#sources).

For example:

``` x86asm
section .text
    ...

    ; I want to compare if a string and the string in my buffer are the same.

    mov rdi, buffer
    mov rsi, string
    mov rcx, sting_len
    cld                         ; Set direction left-to-right.
    repe cmpsb                  ; Compare strings while the bytes are equal.
    jrcxz .equal                ; If no more bytes, strings are equal.
    jmp .notEqual               ; If bytes left, strings are not equal.

    .equal:
        ...

    .notEqual:
        ...
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```


## `scas` Instruction

In non-64-bit modes and in default 64-bit mode: this instruction compares a
byte, word, doubleword or quadword specified using a memory operand with the
value in `AL`, `AX`, or `EAX`. It then sets status flags in `EFLAGS` recording
the results. The memory operand address is read from `ES:(E)DI` register
(depending on the address-size attribute of the instruction and the current
operational mode). Note that `ES` cannot be overridden with a segment override
prefix. In 64-bit mode, the instruction’s default address size is 64-bits. The
64-bit no-operand mnemonic is `SCASQ`. Address of the memory operand is
specified in either `RDI` or `EDI`, and `AL/AX/EAX/RAX` may be used as the
register operand. After a comparison, the destination register is incremented
or decremented by the current operand size (depending on the value of the `DF`
flag) [[9]](#sources).

At the assembly-code level, two forms of this instruction are allowed. The
explicit-operand form and the no-operands form. The explicit-operand form
(specified using the `SCAS` mnemonic) allows a memory operand to be specified
explicitly. The memory operand must be a symbol that indicates the size and
location of the operand value. The register operand is then automatically
selected to match the size of the memory operand (`AL` register for byte
comparisons, `AX` for word comparisons, `EAX` for doubleword comparisons). The
explicit-operand form is provided to allow documentation. The no-operands form
of the instruction uses a short form of `SCAS`. Again, `ES:(E)DI` is assumed to
be the memory operand and `AL`, `AX`, or `EAX` is assumed to be the register
operand. The size of operands is selected by the mnemonic: `SCASB` (byte
comparison), `SCASW` (word comparison), or `SCASD` (doubleword comparison)
[[9]](#sources).

After the comparison, the `(E)DI` register is incremented or decremented
automatically according to the setting of the `DF` flag in the `EFLAGS`
register. If the `DF` flag is `0`, the `(E)DI` register is incremented; if the
`DF` flag is `1`, the `(E)DI` register is decremented. The register is
incremented or decremented by `1` for byte operations, by `2` for word
operations, and by `4` for doubleword operations [[9]](#sources).

`SCAS`, `SCASB`, `SCASW`, `SCASD`, and `SCASQ` can be preceded by the `REP`
prefix for block comparisons of `ECX` bytes, words, doublewords, or quadwords.
Often, however, these instructions will be used in a `LOOP` construct that
takes some action based on the setting of status flags [[9]](#sources).

For example:

``` x86asm
section .text
    ...

    ; I want to move a pointer to the next word.

    mov rsi, string
    mov rcx, sting_len
    mov al, ' '

    .getWord:
        cld
        repne scasb
        jrcxz .endOfString

    .newWord:
        ...
        jmp .getWord

    .endOfString:
        ...
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```

Another example:

``` x86asm
section .text
    ...

    ; I want to move a detect if a character is in a string.

    mov rsi, string
    mov rcx, sting_len
    mov al, 'j'
    cld
    repne scasb
    je .foundIt

    .notFound:
        ...

    .foundIt:
        ...
    ...

section .data
    string  db "This is my string"
    string_len  equ     $ - string

section .bss
    buffer:     resb    256
```


## Numerical Strings in Assembly

Numerical data is generally represented in binary system. Arithmetic 
instructions operate on binary data. When numbers are displayed on screen or 
entered from keyboard, they are in ASCII form [[10]](#sources).

You can convert single ASCII digits to binary form and vice versa by simply 
subtracting '0' from (or adding '0' to) the ASCII value (or binary number). 
So, '3' in ASCII is is `51` in ASCII. To convert it to binary, you subtract 
`48` which is the ASCII value for '0'. To convert `8` to ASCII, you just add 
`48` which is the ASCII value for '0'. For multiple digits, you have to 
account for the placement of the digit (1's place, 10's place, 100's place, 
etc.)

Such conversions, however, have an overhead, and assembly language programming 
allows processing numbers in a more efficient way, in the binary form. Decimal 
numbers can be represented in two forms [[10]](#sources):

- ASCII form [[10]](#sources).
- BCD (or Binary Coded Decimal) form [[10]](#sources).

The instructions `aaa`, `aas`, `aam`, `aad`, `daa`, and `das` can be used in 
32-bit mode to assist with coding conversions. But they are not supported in 
64-bit mode, so we will not go over them in this module anymore. If you want 
to learn more for 32-bit mode, you may look them up in the Intel manual, the 
[source tutorial
](https://www.tutorialspoint.com/assembly_programming/assembly_numbers.htm)
or online elsewhere. The important concept here is to understand that you have
to deal with converting ASCII to binary manually in assembly.

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
If you want to look up ASCII codes or convert formats, you can use `man ascii` 
in a Linux terminal, use a tool like [Cyberchef](https://cyberchef.org/), or 
use a Python terminal (with commands like `ord('x')`). There are dozen other 
ways to convert ASCII, hex, decimal, and binary as well.
</span></span>


## Sources

1. *Assembly - Strings*. 
https://www.tutorialspoint.com/assembly_programming/assembly_strings.htm.
2. *REP/REPE/REPZ/REPNE/REPNZ — Repeat String Operation Prefix*.
https://www.felixcloutier.com/x86/rep:repe:repz:repne:repnz.
3. *CLD — Clear Direction Flag*.
https://www.felixcloutier.com/x86/cld.
4. *STD — Set Direction Flag*.
https://www.felixcloutier.com/x86/std.
5. *MOVS/MOVSB/MOVSW/MOVSD/MOVSQ — Move Data From String to String*. 
https://www.felixcloutier.com/x86/movs:movsb:movsw:movsd:movsq.
6. *LODS/LODSB/LODSW/LODSD/LODSQ — Load String*.
https://www.felixcloutier.com/x86/lods:lodsb:lodsw:lodsd:lodsq.
7. *STOS/STOSB/STOSW/STOSD/STOSQ — Store String*.
https://www.felixcloutier.com/x86/stos:stosb:stosw:stosd:stosq.
8. *CMPS/CMPSB/CMPSW/CMPSD/CMPSQ — Compare String Operands*.
https://www.felixcloutier.com/x86/cmps:cmpsb:cmpsw:cmpsd:cmpsq.
9. *SCAS/SCASB/SCASW/SCASD — Scan String*.
https://www.felixcloutier.com/x86/scas:scasb:scasw:scasd.
10. *Assembly - Numbers*.
https://www.tutorialspoint.com/assembly_programming/assembly_numbers.htm.


## Required Additional Readings

None.


## Resources

1. ***CyberChef***. https://cyberchef.org/. Totally awesome tool for all kinds 
of format and cryptography conversions. 


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
