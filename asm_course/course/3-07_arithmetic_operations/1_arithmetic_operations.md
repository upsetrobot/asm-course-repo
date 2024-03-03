
# 🧮 3-07 Arithmetic Operations - Knowledge

<span style="color:lightcoral">*"I hate math"*</span>
 ~-~ Evelyn Salt

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [`inc` Instruction](#inc-instruction)
- [`dec` Instruction](#dec-instruction)
- [`mul` and `imul` Instructions](#mul-and-imul-instructions)
- [`div` and `idiv` Instructions](#div-and-idiv-instructions)
- [`cbw`, `cwde`, and `cdqe` Instructions](#cbw-cwde-and-cdqe-instructions)
- [`cwd`, `cdq`, and `cqo` Instructions](#cwd-cdq-and-cqo-instructions)
- [`lea` Instruction](#lea-instruction)
- [`xchg` Instruction](#xchg-instruction)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## `inc` Instruction

The `inc` operation adds 1 to the destination operand, while preserving the 
state of the `CF` flag. The destination operand can be a register or a memory 
location. This instruction allows a loop counter to be updated without 
disturbing the `CF` flag. (Use a `ADD` instruction with an immediate operand 
of `1` to perform an increment operation that does update the `CF` flag.) 
[[1]](#sources).

Example: 

``` x86asm
    inc ebx        ; Increments 32-bit register
    inc dl         ; Increments 8-bit register
    inc [count]    ; Increments the count variable
```
[[2]](#sources)


## `dec` Instruction

The `dec` operation subtracts 1 from the destination operand, while preserving 
the state of the `CF` flag. The destination operand can be a register or a 
memory location. This instruction allows a loop counter to be updated without 
disturbing the `CF` flag. (To perform a decrement operation that updates the 
`CF` flag, use a `SUB` instruction with an immediate operand of 1.)
[[3]](#sources).

Example:

``` x86asm
    segment .data   

        count dw 0
        value db 15

    segment .text

        inc [count]
        dec [value]

        mov ebx, count
        inc word [ebx]

        mov esi, value
        dec byte [esi]
```
[[2]](#sources)


## `mul` and `imul` Instructions

There are two instructions for multiplying binary data. The `mul` (multiply) 
instruction handles unsigned data and the `imul` (integer multiply) handles 
signed data. Both instructions affect the `CF` and `OF` flags [[1]](#sources).

Performs an unsigned multiplication of the first operand (destination operand) 
and the second operand (source operand) and stores the result in the 
destination operand. The destination operand is an implied operand located in 
register `AL`, `AX` or `EAX` (depending on the size of the operand); the 
source operand is located in a general-purpose register or a memory location. 
The action of this instruction and the location of the result depends on the 
opcode and the operand size as shown in the table below [[4]](#sources).

The result is stored in register `AX`, register pair `DX:AX`, or register pair 
`EDX:EAX` (depending on the operand size), with the high-order bits of the 
product contained in register `AH`, `DX`, or `EDX`, respectively. If the 
high-order bits of the product are `0`, the `CF` and `OF` flags are cleared; 
otherwise, the flags are set [[4]](#sources).

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
    Remember that the syntax of two registers with a colon represents both 
    registers being used as one in an instruction. So, you can think of them 
    being put together as one big register. For example, `DX:AX` can be 
    thought of as one DWORD register consisting of the bytes from `DX` 
    followed by the bytes from `AX`. For multiplication, this helps with 
    identifying overflows. So, you **HAVE** to beware that instructions like 
    `mul` and `div` effect or are effected by `rdx` and `rax`. 
</span></span>

| Operand Size | Source 1 | Source 2 | Destination |
|--------------|----------|----------|-------------|
| Byte         | `AL`     | r/m8     | `AX`        |
| Word	       | `AX`     | r/m16    | `DX:AX`     |
| Doubleword   | `EAX`    | r/m32    | `EDX:EAX`   |
| Quadword     | `RAX`    | r/m64    | `RDX:RAX`   |

Example:

``` x86asm
    mov al, 10
    mov cl, 25
    mul cl          ; ax = 250
    
    mov al, 0BEh    ; al = -66
    mov cl, 0FFh    ; cl = -1
    imul cl         ; ax = 66
```


## `div` and `idiv` Instructions

The division operation generates two elements - a **quotient** and a 
**remainder**. In case of multiplication, overflow does not occur because 
double-length registers are used to keep the product. However, in case of 
division, overflow may occur. The processor generates an interrupt if 
overflow occurs [[1]](#sources).

The `div` (divide) instruction is used for unsigned data and the `idiv` 
(integer Divide) is used for signed data [[1]](#sources).

Divides unsigned the value in the `AX`, `DX:AX`, `EDX:EAX`, or `RDX:RAX` 
registers (dividend) by the source operand (divisor) and stores the result in 
the `AX` (`AH:AL`), `DX:AX`, `EDX:EAX`, or `RDX:RAX` registers. The source 
operand can be a general-purpose register or a memory location. The action of 
this instruction depends on the operand size (dividend/divisor) (see the table 
below). Division using 64-bit operands is available only in 64-bit mode 
[[5]](#sources).

Non-integral results are truncated (chopped) towards `0`. The remainder is 
always less than the divisor in magnitude. Overflow is indicated with the 
`#DE` (divide error) exception rather than with the `CF` flag [[5]](#sources).

| Operand Size        | Dividend  | Divisor | Quotient | Remainder | Maximum Quotient |
|---------------------|-----------|---------|----------|-----------|------------------|
| word / byte         | `AX`      | r/m8    | `AL`     | `AH`      | 255              |
| dword / word        | `DX:AX`   | r/m16   | `AX`     | `DX`      | 65,535           |
| qword / dword       | `EDX:EAX` | r/m32   | `EAX`    | `EDX`     | 2^32 − 1         |
| doubleqword / qword | `RDX:RAX` | r/m64   | `RAX`    | `RDX`     | 2^64 − 1         |

Example:

``` x86asm
    mov ax, '8'
    sub ax, '0'     ; adjust ASCII value to numerical value (if single digit).

    mov bl, '2'
    sub bl, '0'     ; adjust ASCII value to numerical value (if single digit).

    div bl          ; quotient = al = 4, remainder = ah = 0

    add ax, '0'     ; adjust numerical value to ASCII value (if single digit)
```


## `cbw`, `cwde`, and `cdqe` Instructions

These instructions are used for sign-extending a register. `cbw` is "convert 
byte to word", `cwde` is "convert word to doubleword extend", and `cdqe` is 
"convert doubleword to quadword extend". The sign extend the `al` to the `ax`, 
`ax` to the `eax`, and `eax` to the `rax` registers respectively.

Double the size of the source operand by means of sign extension. The `CBW`
(convert byte to word) instruction copies the sign (bit 7) in the source
operand into every bit in the `AH` register. The `CWDE` (convert word to
double-word) instruction copies the sign (bit 15) of the word in the `AX`
register into the high 16 bits of the `EAX` register [[8]](#sources).

`CBW` and `CWDE` reference the same opcode. The `CBW` instruction is intended
for use when the operand-size attribute is 16; `CWDE` is intended for use when
the operand-size attribute is 32. Some assemblers may force the operand size.
Others may treat these two mnemonics as synonyms (`CBW`/`CWDE`) and use the
setting of the operand-size attribute to determine the size of values to be
converted [[8]](#sources).

In 64-bit mode, the default operation size is the size of the destination
register. In which case, `CDQE` copies the sign (bit 31) of the doubleword in
the `EAX` register into the high 32 bits of `RAX` [[8]](#sources).

Example:

``` x86asm
    xor rax, rax
    mov al, -99
    
    ; rax = 0x9d.

    cbw

    ; rax = 0xff9d.
```

This can be useful when doing signed arithmetic operations or when moving 
signed values into registers with different register sizes.


## `cwd`, `cdq` and `cqo` Instructions

Thes instructions are used for sign-extending a register, but do so to the 
`dx` series of registers. `cwd` is "convert word to double", `cdq` is "convert 
doubleword to quadword", and `cqo` is "convert quadword to double quadword".

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    This is very useful for signed division as you may want to sign-extend the
    `rdx` register from the `rax` register before dividing, so that your
    division is correct.
</span></span>

Doubles the size of the operand in register `AX`, `EAX`, or `RAX` (depending on
the operand size) by means of sign extension and stores the result in registers
`DX:AX`, `EDX:EAX`, or `RDX:RAX`, respectively. The `CWD` instruction copies
the sign (bit 15) of the value in the `AX` register into every bit position in
the `DX` register. The `CDQ` instruction copies the sign (bit 31) of the value
in the `EAX` register into every bit position in the `EDX` register. The `CQO`
instruction (available in 64-bit mode only) copies the sign (bit 63) of the
value in the `RAX` register into every bit position in the `RDX` register
[[9]](#sources).

The `CWD` instruction can be used to produce a doubleword dividend from a word
before word division. The `CDQ` instruction can be used to produce a quadword
dividend from a doubleword before doubleword division. The `CQO` instruction
can be used to produce a double quadword dividend from a quadword before a
quadword division [[9]](#sources).

The `CWD` and `CDQ` mnemonics reference the same opcode. The `CWD` instruction
is intended for use when the operand-size attribute is 16 and the `CDQ`
instruction for when the operand-size attribute is 32. Some assemblers may
force the operand size to 16 when `CWD` is used and to 32 when `CDQ` is used.
Others may treat these mnemonics as synonyms (`CWD`/`CDQ`) and use the current
setting of the operand-size attribute to determine the size of values to be
converted, regardless of the mnemonic used [[9]](#sources).

Example:

``` x86asm
    mov rax, -100
    mov rcx, 5
    cqo             ; Makes `rdx` = `0xffffffffffffffff` (-1).
    idiv rcx        ; Divides `rdx:rax` (-100) by `rcx` (5).

    ; `rax` = -20.
```

## `lea` Instruction

The `lea` operation (or "load effective address" operation) has two primary 
functions. The first is to load a pointer (address) of something into a 
register. The second function is a by-product of the first, that `lea` can be 
used to do some arithmetic.

Computes the effective address of the second operand (the source operand) and 
stores it in the first operand (destination operand). The source operand is a 
memory address (offset part) specified with one of the processors addressing 
modes; the destination operand is a general-purpose register. The address-size 
and operand-size attributes affect the action performed by this instruction, 
as shown in the following table. The operand-size attribute of the instruction 
is determined by the chosen register; the address-size attribute is determined 
by the attribute of the code segment [[6]](#sources).

Example:

``` x86asm
global main
section .text

main:

    mov rsi, numberInMemory
    mov rax, qword [rsi]        ; Moves a QWORD of data from the location 
                                ; pointed to by the address in rsi.
                                ; The brackets are dereferecing.
    
    lea rax, qword [rsi]        ; Move the address of the QWORD of data from 
                                ; the location pointed to by the address in rsi.
                                ; equivalent to mov rax, rsi

    lea rax, [rsi + 44]         ; Add 44 to rsi contents (which is presumed to 
                                ; be an address), and store that address in rax.
                                ; This is effectively add rsi, 44, then mov rax, rsi.
                                ; but it is done in one operation.

    lea rax, [rsi + 2*rdx + 10] ; Moves contents of rsi + 2 * (contents or rdx)
                                ; + constant 10 into rax.

    mov rax, bytesInMemory      ; Moves address of "Location in..." to rax.
    lea rax, bytesInMemory      ; Does same as mov rax, bytesInMemory.
    lea rax, [bytesInMemory]    ; Does same as mov rax, bytesInMemory.
    lea rax, [bytesInMemory + 33]   ; Moves address of "Location..." plus 33 to rax.

    mov rdx, bytesInMemory
    lea rax, [rdx]              ; Same as mov rax, bytesInMemory.
    lea rax, [rdx - 22]         ; Same as mov rdx, bytesInMemory,
                                ; sub rdx, 22, mov rax, rdx.

    ret

section .data
    bytesInMemory   db  "Location in memory", 0
    numberInMemory  dq  88
```

Examples of invalid uses of lea:

``` x86asm
global main
section .text

main:
    mov rsi, hello
    lea rax, rsi                ; Address of register is invalid.
    lea rax, [rsi + rdx*33]     ; Expression in second operand must have 
                                ; multipliers of 1, 2, 4, or 8.

    lea rax, [rsi*3]            ; Same reason as previous operation.
    lea rax, [rsi - rdx*2]      ; A second register in the second operand 
                                ; cannot be subtracted - only added.

    ret

section .data
    hello db "Location in memory", 0
```

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Note that the previous programs have a `main` function and can be compiled 
using `nasm -f elf64 <asm-file>`, `gcc -no-pie <asm-file>.o`. Since the 
`main` function does not call any other functions, no framing is required. 
Really, no framing is needed in general, but backtraces may use it during 
debugging. More on this topic will be given in later modules.
</span></span>

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
If you want to muliply a value by 2, 4, or 8, subtract an immediate from it, 
add a register value to it, and/or add an immediate value to it, you can 
`lea` as one instruction instead of doing two or more operations to do the 
same thing. `lea rax, [rdi + rcx*2 - 110]` is the same as `shl rcx, 2, 
add rdi, rcx, sub rdi, 110, mov rax, rdi`.
</span></span>


## `xchg` Instruction

Exchanges the contents of the destination (first) and source (second) 
operands. The operands can be two general-purpose registers or a register and 
a memory location. [[7]](#sources). 

Example:

``` x86asm
    mov rax, 10
    mov rcx, 2
    xchg rax, rcx       ; rax = 2, rcx = 10

    ; If bytesInMemory points to QWORD 1.
    mov rcx, 2
    xchg [bytesInMemory], rcx   ; rcx = 1, [bytesInMemory] = 2
```

Examples of invalid uses of lea:

``` x86asm
    ; If bytesInMemory points to QWORD 1.
    ; If bytesInMemory2 points to QWORD 100.
    xchg [bytesInMemory], [bytesInMemory2]  ; Invalid due to two memory locations.
```


## Sources

1. *INC - Increment by 1*. 
https://www.felixcloutier.com/x86/inc.
2. *Assembly - Arithmetic Instructions*. 
https://www.tutorialspoint.com/assembly_programming/assembly_arithmetic_instructions.htm.
3. *DEC - Decrement by 1*. 
https://www.felixcloutier.com/x86/dec.
4. *MUL - Unsigned Multiply*. 
https://www.felixcloutier.com/x86/mul.
5. *DIV - Unsigned Division*. 
https://www.felixcloutier.com/x86/div.
6. *LEA - Load Effective Address*.
https://www.felixcloutier.com/x86/lea.
7. *XCHG - Exchange Register/Memory With Register*.
https://www.felixcloutier.com/x86/xchg.
8. *CBW/CWDE/CDQE — Convert Byte to Word/Convert Word to Doubleword/Convert
Doubleword toQuadword*.
https://www.felixcloutier.com/x86/cbw:cwde:cdqe.
9. *CWD/CDQ/CQO — Convert Word to Doubleword/Convert Doubleword to Quadword*.
https://www.felixcloutier.com/x86/cwd:cdq:cqo.


## Required Additional Readings

None.


## Resources

1. ***felixcloutier x86 and amd64 Instruction Reference***. 
https://www.felixcloutier.com/x86/. 
Index of tons of assembly instructions. Highly recommended as a quick 
reference.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
