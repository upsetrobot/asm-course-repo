
# 👾 3-09 Bit Operations - Knowledge

<span style="color:lightcoral">*"Click on it, and then press control-shift"*</span>
 ~-~ Angela Bennett

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [`shl` and `shr` Instructions](#shl-and-shr-instructions)
- [`sal` and `sar` Instructions](#sal-and-sar-instructions)
- [`rol` and `ror` Instructions](#rol-and-ror-instructions)
- [`rcl` and `rcr` Instructions](#rcl-and-rcr-instructions)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## `shl` and `shr` Instructions

`shl` (shift left) and `shr` (shift right) are logical binary shift 
operations. They allow for binary shifting of values in registers or memory.

Shifts the bits in the first operand (destination operand) to the left (`shl`) 
or right (`shr`) by the number of bits specified in the second operand (count 
operand). Bits shifted beyond the destination operand boundary are first 
shifted into the `CF` flag, then discarded. At the end of the shift operation, 
the `CF` flag contains the last bit shifted out of the destination operand
[[1]](#sources).

The destination operand can be a register or a memory location. The count 
operand can be an immediate value or the `CL` register. The count is masked to 
5 bits (or 6 bits if in 64-bit mode). The count range is limited to 0 to 31 
(or 63 if 64-bit mode) [[1]](#sources).

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
Note that the mask causes the number to rotate. E.g., if 63 is the max (6-bit 
mask), then 64 will be the same as 1, and 65 will be the same as 2, etc. This 
is because a mask is an `AND` operation (e.g., `0011 1111` anded with 
`0000 0001` is `0000 0001`; `0011 1111` anded with `0100 0001` is `0000 0001`)
</span></span>

The shift arithmetic left (`SAL`) and shift logical left (`SHL`) instructions 
perform the same operation; they shift the bits in the destination operand to 
the left (toward more significant bit locations). For each shift count, the 
most significant bit of the destination operand is shifted into the `CF` flag, 
and the least significant bit is cleared [[1]](#sources).

The `SHR` instruction clears the most significant bit [[1]](#sources).

The `SAR` and `SHR` instructions can be used to perform signed or unsigned 
division, respectively, of the destination operand by powers of 2. For 
example, using the `SAR` instruction to shift a signed integer 1 bit to the 
right divides the value by 2 [[1]](#sources).

The `OF` flag is affected only on 1-bit shifts. For left shifts, the `OF` flag 
is set to `0` if the most-significant bit of the result is the same as the 
`CF` flag (that is, the top two bits of the original operand were the same); 
otherwise, it is set to `1` [[1]](#sources). 

For the `SHR` instruction, the `OF` flag is set to the most-significant bit of 
the original operand [[1]](#sources).

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Shifting left is the same as multiplying a number by 2. So, if you shift left 
5 times, you have multiplied the number by 2, 5 times, or 32 times total.
Obviously, you can clear the register if you shift to the size of the register 
minus 1 (e.g., `shl rax, 63` will result in `rax` having the value `0` 
regardless of the value that was in `rax`). The same works for dividing by 2 
with shift right (with some exceptions in regards to sign as explained in the 
`sar` section). Also, shifting `1` left by `1` results in `0`.
</span></span>

Example:

``` x86asm
    mov al, 1       ; al = 0b 0000 0001 = 1
    shl al, 1       ; al = 0b 0000 0010 = 2 = 1 * 2
    shl al, 2       ; al = 0b 0000 1000 = 8 = 2 * 2 * 2 = 2 * 2^2
    shr al, 1       ; al = 0b 0000 0100 = 4 = 8 // 2

    mov al, 5       ; al = 0b 0000 0101 = 5
    shl al, 1       ; al = 0b 0000 1010 = 10 = 5 * 2
    shr al, 2       ; al = 0b 0000 0010 = 2 = 10 // 2 // 2

    mov rax, 2433
    shl rax, 63     ; rax = 0

    mov rdx, addressMemory
    mov cl, 4
    shl byte [rdx], cl
```

## `sal` and `sar` Instructions

`sal` (shift arithmetic left) and `sar` (shift arithmetic right) are 
arithmetic binary shift operations. They allow for binary shifting of values 
in registers or memory and are are signed operations.

Shifts the bits in the first operand (destination operand) to the left (`sal`) 
or right (`sar`) by the number of bits specified in the second operand (count 
operand). Bits shifted beyond the destination operand boundary are first 
shifted into the `CF` flag, then discarded. At the end of the shift operation, 
the `CF` flag contains the last bit shifted out of the destination operand
[[1]](#sources).

The destination operand can be a register or a memory location. The count 
operand can be an immediate value or the `CL` register. The count is masked to 
5 bits (or 6 bits if in 64-bit mode). The count range is limited to 0 to 31 
(or 63 if 64-bit mode) [[1]](#sources).

The shift arithmetic left (`SAL`) and shift logical left (`SHL`) instructions 
perform the same operation; they shift the bits in the destination operand to 
the left (toward more significant bit locations). For each shift count, the 
most significant bit of the destination operand is shifted into the `CF` flag, 
and the least significant bit is cleared [[1]](#sources).

The `SAR` instruction sets or clears the most significant bit to correspond to 
the sign (most significant bit) of the original value in the destination 
operand. In effect, the `SAR` instruction fills the empty bit position’s 
shifted value with the sign of the unshifted value [[1]](#sources).

The `SAR` and `SHR` instructions can be used to perform signed or unsigned 
division, respectively, of the destination operand by powers of 2. For 
example, using the `SAR` instruction to shift a signed integer 1 bit to the 
right divides the value by 2 [[1]](#sources).

Using the `SAR` instruction to perform a division operation does not produce 
the same result as the `IDIV` instruction. The quotient from the `IDIV` 
instruction is rounded toward zero, whereas the “quotient” of the `SAR` 
instruction is rounded toward negative infinity. This difference is apparent 
only for negative numbers. For example, when the `IDIV` instruction is used to 
divide -9 by 4, the result is -2 with a remainder of -1. If the `SAR` 
instruction is used to shift -9 right by two bits, the result is -3 and the 
“remainder” is +3; however, the `SAR` instruction stores only the most 
significant bit of the remainder (in the `CF` flag) [[1]](#sources).

The `OF` flag is affected only on 1-bit shifts. For left shifts, the `OF` flag 
is set to `0` if the most-significant bit of the result is the same as the 
`CF` flag (that is, the top two bits of the original operand were the same); 
otherwise, it is set to `1` [[1]](#sources). 

For the `SAR` instruction, the `OF` flag is cleared for all 1-bit shifts 
[[1]](#sources).

Example:

``` x86asm
    mov al, 1       ; al = 0b 0000 0001 = 1
    sal al, 1       ; al = 0b 0000 0010 = 2 = 1 * 2
    sal al, 2       ; al = 0b 0000 1000 = 8 = 2 * 2 * 2 = 2 * 2^2
    sar al, 1       ; al = 0b 0000 0100 = 4 = 8 // 2

    mov al, 5       ; al = 0b 0000 0101 = 5
    sal al, 1       ; al = 0b 0000 1010 = 10 = 5 * 2
    sar al, 2       ; al = 0b 0000 0010 = 2 = 10 // 2 // 2
    
    mov rdx, addressMemory
    mov cl, 4
    sal byte [rdx], cl

    ; Notice sal and sar are the same as shl and shr for positive signed numbers.

    mov rax, 2433
    sal rax, 63     ; rax = 0

    mov rax, 2433
    sar rax, 63     ; rax = 0

    mov rax, -2433
    sar rax, 63     ; rax = -1

    mov al, -1      ; al = 0b 1111 1111 = -1
    sal al, 1       ; al = 0b 1111 1110 = -2 = -1 * 2

    mov al, -64     ; al = 0b 1100 0000 = -64
    sal al, 1       ; al = 0b 1110 0000 = -32 = -64 // 2

    ; Note that division result using sar is rounded down towards negative 
    ; infinity, so 5 // 2 = 2, but -5 // 2 = -3 instead of -2 with this method.
```


## `rol` and `ror` Instructions

Shifts (rotates) the bits of the first operand (destination operand) the 
number of bit positions specified in the second operand (count operand) and 
stores the result in the destination operand. The destination operand can be a 
register or a memory location; the count operand is an unsigned integer that 
can be an immediate or a value in the `CL` register. The count is masked to 
5 bits (or 6 bits if in 64-bit mode) [[2]](#sources).

The rotate left (`ROL`) and rotate through carry left (`RCL`) instructions 
shift all the bits toward more-significant bit positions, except for the 
most-significant bit, which is rotated to the least-significant bit location. 
The rotate right (`ROR`) and rotate through carry right (`RCR`) instructions 
shift all the bits toward less significant bit positions, except for the 
least-significant bit, which is rotated to the most-significant bit location 
[[2]](#sources).

For the `ROL` and `ROR` instructions, the original value of the `CF` flag is 
not a part of the result, but the `CF` flag receives a copy of the bit that 
was shifted from one end to the other [[2]](#sources).

The `OF` flag is defined only for the 1-bit rotates; it is undefined in all 
other cases. For left rotates, the `OF` flag is set to the exclusive OR of the 
`CF` bit (after the rotate) and the most-significant bit of the result. For 
right rotates, the `OF` flag is set to the exclusive OR of the two 
most-significant bits of the result [[2]](#sources).

Example:

``` x86asm
mov al, 1       ; al = 0b 0000 0001 = 1
rol al, 1       ; al = 0b 0000 0010 = 2

mov al, 1       ; al = 0b 0000 0001 = 1
ror al, 1       ; al = 0b 1000 0000 = 128

mov al, 1       ; al = 0b 0000 0001 = 1
rol al, 8       ; al = 0b 0000 0001 = 1

mov al, 1       ; al = 0b 0000 0001 = 1
rol al, 7       ; al = 0b 1000 0000 = 128

mov cl, 2
mov rdx, addressInMemory        ; assume addressInMemory = 1
ror dword [rdx], cl
rol dword [addressInMemory], cl ; addressInMemory = 1
```

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
Remember that in 64-bit mode, **operations on 32-bit registers like `eax` will 
ZERO the upper bits of the 64-bit register**. So, if you 
`mov rax, 0xffffffffaabbccdd` and then `rol eax, 8`, `rax` will have a value of 
`0xaabbddcc` - not `0xffffffffaabbddcc`!
</span></span>


## `rcl` and `rcr` Instructions

Shifts (rotates) the bits of the first operand (destination operand) the 
number of bit positions specified in the second operand (count operand) and 
stores the result in the destination operand. The destination operand can be a 
register or a memory location; the count operand is an unsigned integer that 
can be an immediate or a value in the `CL` register. The count is masked to 
5 bits (or 6 bits if in 64-bit mode) [[2]](#sources).

The rotate left (`ROL`) and rotate through carry left (`RCL`) instructions 
shift all the bits toward more-significant bit positions, except for the 
most-significant bit, which is rotated to the least-significant bit location. 
The rotate right (`ROR`) and rotate through carry right (`RCR`) instructions 
shift all the bits toward less significant bit positions, except for the 
least-significant bit, which is rotated to the most-significant bit location 
[[2]](#sources).

The `RCL` and `RCR` instructions include the `CF` flag in the rotation. The 
`RCL` instruction shifts the `CF` flag into the least-significant bit and 
shifts the most-significant bit into the `CF` flag. The `RCR` instruction 
shifts the `CF` flag into the most-significant bit and shifts the 
least-significant bit into the `CF` flag [[2]](#sources).

The `OF` flag is defined only for the 1-bit rotates; it is undefined in all 
other cases (except `RCL` and `RCR` instructions only: a zero-bit rotate does 
nothing, that is affects no flags). For left rotates, the `OF` flag is set to 
the exclusive OR of the `CF` bit (after the rotate) and the most-significant 
bit of the result. For right rotates, the `OF` flag is set to the exclusive OR 
of the two most-significant bits of the result [[2]](#sources).

Example:

``` x86asm
    mov al, 1       ; al = 0b 0000 0001 = 1
    rcl al, 1       ; al = 0b 0000 0010 = 2 ; CF = 0

    mov al, 1       ; al = 0b 0000 0001 = 1
    rcr al, 1       ; al = 0b 0000 0000 = 0 ; CF = 1

    mov al, 1       ; al = 0b 0000 0001 = 1
    rcl al, 8       ; al = 0b 0000 0000 = 0 ; CF = 1

    mov al, 1       ; al = 0b 0000 0001 = 1
    rcl al, 7       ; al = 0b 1000 0000 = 128   ; CF = 0

    mov cl, 2
    mov rdx, addressInMemory        ; assume addressInMemory = 1
    rcr dword [rdx], cl
    rcl dword [addressInMemory], cl ; addressInMemory = 128
```


## Sources

1. *SAL/SAR/SHL/SHR - Shift*. 
https://www.felixcloutier.com/x86/sal:sar:shl:shr.
2. *RCL/RCR/ROL/ROR - Rotate*. 
https://www.felixcloutier.com/x86/rcl:rcr:rol:ror.


## Required Additional Readings.

None.


## Resources

1. ***felixcloutier x86 and amd64 Instruction Reference***. 
https://www.felixcloutier.com/x86/. 
Index of tons of assembly instructions. Highly recommended as a quick 
reference.

2. ***GodBolt***. 
https://godbolt.org/. 
Awesome online compiler for multiple languages including assembly.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
