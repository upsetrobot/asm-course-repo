
# & 3-10 Boolean Operations - Knowledge

<span style="color:lightcoral">*"Logic is the beginning of wisdom—not the end."*
</span>
 ~-~ Spock

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [`and` Instruction](#and-instruction)
- [`or` Instruction](#or-instruction)
- [`xor` Instruction](#xor-instruction)
- [`test` Instruction](#test-instruction)
- [`not` Instruction](#not-instruction)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## `and` Instruction

Performs a bitwise `AND` operation on the destination (first) and source 
(second) operands and stores the result in the destination operand location. 
The source operand can be an immediate, a register, or a memory location; the 
destination operand can be a register or a memory location. (However, two 
memory operands cannot be used in one instruction.) Each bit of the result is 
set to `1` if both corresponding bits of the first and second operands are 
`1`; otherwise, it is set to `0` [[1]](#sources). E.g., `1101` `AND` `0110` is 
`0100` because each bit is set only if the two corresponding bits of the 
operands are both `1`.

The `AND` operation can be used for clearing one or more bits. For example, 
say the `BL` register contains `0011 1010`. If you need to clear the 
high-order bits to `0`, you `AND` it with `0FH` [[2]](#sources).

Example:

``` x86asm
    mov bl, 0011_1010b
    and bl, 0fh         ; bl = 0b 0000 1010
```

[[2]](#sources)

<span class="box-purple"><span class="bar-purple">
    <span class="purple">**ⓘ**</span>&nbsp; Info   
</span><span class="inner">
Using `and` to zero-out certain bits that results in only some bits of an 
operand is known as "masking". A bit-mask of `ffh` on a one-byte number will 
result in that number. A bit-mask of `00h` and a number will result in `0`. A 
bit-mask of `01h` and a number will tell you if the last bit is set or not in 
that number.
</span></span>

Let's take up another example. If you want to check whether a given number is 
odd or even, a simple test would be to check the least significant bit of the 
number. If this is `1`, the number is odd, else the number is even 
[[2]](#sources).

Example:

``` x86asm
    mov al, number
    and al, 01h     ; al = 1 if odd and al = 0 if even.
```

[[2]](#sources)

Similarly to clear the entire register you can `AND` it with `00H` 
[[2]](#sources).


## `or` Instruction

Performs a bitwise inclusive `OR` operation between the destination (first) and
source (second) operands and stores the result in the destination operand
location. The source operand can be an immediate, a register, or a memory
location; the destination operand can be a register or a memory location.
(However, two memory operands cannot be used in one instruction.) Each bit of
the result of the `OR` instruction is set to `0` if both corresponding bits of 
the first and second operands are `0`; otherwise, each bit is set to `1` 
[[3]](#sources).

The `OR` operation can be used for setting one or more bits. For example, let
us assume the `AL` register contains `0011 1010`, you need to set the four
low-order bits, you can `OR` it with a value `0000 1111` [[2]](#sources).

Example:

``` x86asm
    mov bl, 0b00111010
    or bl, 0x0f             ; This sets bl to 0b 0011 1111
```

[[2]](#sources)


## `xor` Instruction

Performs a bitwise exclusive `OR` (`XOR`) operation on the destination (first)
and source (second) operands and stores the result in the destination operand
location. The source operand can be an immediate, a register, or a memory
location; the destination operand can be a register or a memory location.
(However, two memory operands cannot be used in one instruction.) Each bit of
the result is `1` if the corresponding bits of the operands are different; each
bit is `0` if the corresponding bits are the same [[4]](#sources).

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Using `xor` on an operand and itself changes the operand value to `0`. This is 
used to clear registers. So, `xor rax, rax` is the same as `mov rax, 0`, but 
it uses less machine code.
</span></span>


## `test` Instruction

Computes the bit-wise logical `AND` of first operand (source 1 operand) and the
second operand (source 2 operand) and sets the `SF`, `ZF`, and `PF` status
flags according to the result. The result is then discarded [[5]](#sources).

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
Using `test` on an operand and itself can tell you if the register value is 
`0` or not (by setting the `ZF`). This is used to tell when a register reaches 
`0`. So, `test rax, rax` then `jz .end` is the same as `cmp rax, 0` then 
`je .end`, but it uses less machine code (jumps and compares will be explained 
in a later module).
</span></span>


## `not` Instruction

Performs a bitwise `NOT` operation (each `1` is set to `0`, and each `0` is 
set to `1`) on the destination operand and stores the result in the 
destination operand location. The destination operand can be a register or a 
memory location [[6]](#sources).

Example:

``` x86asm
   mov al, 1      ; al = 0b 0000 0001 = 1
   not al         ; al = 0b 1111 1110 = -2 or 254
```

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
You can use `not` to convert negative numbers to positive numbers. Just 
increment the negative number after the `not` operation. The same operation 
can be done to convert positive numbers to negative numbers. This may be 
useful when dealing with signed numbers. You can also use `not` to turn `0` in 
a register into `-1`. 
</span></span>


## Sources

1. *AND - Logical AND*. 
https://www.felixcloutier.com/x86/and.
2. *Assembly - Logical Instructions*. 
https://www.tutorialspoint.com/assembly_programming/assembly_logical_instructions.htm.
3. *OR - Logical Inclusive OR*.
https://www.felixcloutier.com/x86/or.
4. *XOR - Logical Exclusive OR*.
https://www.felixcloutier.com/x86/xor.
5. *TEST - Logical Compare*.
https://www.felixcloutier.com/x86/test.
6. *NOT - One's Complement Negation*.
https://www.felixcloutier.com/x86/not.


## Required Additional Readings.

1. None.


## Resources

1. ***felixcloutier x86 and amd64 Instruction Reference***. 
https://www.felixcloutier.com/x86/. 
Index of tons of assembly instructions. Highly recommended as a quick 
reference.

2. ***Geek for Geeks Boolean Algebra Page***. 
https://www.geeksforgeeks.org/boolean-algebra/. 
Description of basic Boolean algebra rules. There are many other sites like 
this that can help you understand Boolean rules and use cases if needed.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
