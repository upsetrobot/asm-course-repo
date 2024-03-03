
# 🔁 3-14 Loop Operations - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Loop Operations Introduction](#loop-operations-introduction)
- [`loop` Instruction](#loop-instruction)
- [`loopcc` Instruction](#loopcc-instruction)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Loop Operations Introduction

In assembly, the primary loop operations are `jcc` and `jmp`, which will be 
discussed more in the next module. However, there are other loop instructions 
in assembly including `loop`, `loopcc`, `rep`, and some others. You can also 
create loops with functions (like recursive loops). `rep` and functions will 
be discussed in later modules. This module will just go over the `loop` and 
`loopcc` instructions. 


## `loop` Instruction

Performs a loop operation using the `RCX`, `ECX` or `CX` register as a counter
(depending on whether address size is 64 bits, 32 bits, or 16 bits)
[[1]](#sources).

Each time the `LOOP` instruction is executed, the count register is
decremented, then checked for `0`. If the count is `0`, the loop is terminated
and program execution continues with the instruction following the `LOOP`
instruction. If the count is not zero, a near jump is performed to the
destination (target) operand, which is presumably the instruction at the
beginning of the loop [[1]](#sources).

The target instruction is specified with a relative offset (a signed offset
relative to the current value of the instruction pointer in the
`IP`/`EIP`/`RIP` register). This offset is generally specified as a label in
assembly code, but at the machine code level, it is encoded as a signed, 8-bit
immediate value, which is added to the instruction pointer. Offsets of `–128`
to `+127` are allowed with this instruction [[1]](#sources).

For example:

``` x86asm
    ...

    ; I want to do something 10 times.

    mov rcx, 10

    .myLoop:
        add rax, 5
        loop .myLoop    ; Decrements `rcx` and jumps if `rcx` is not zero.

    ; `rcx` is now 0.

    ...
```


## `loopcc` Instruction

Some forms of the loop instruction (`LOOPcc`) also accept the `ZF` flag as a
condition for terminating the loop before the count reaches zero. With these
forms of the instruction, a condition code (`cc`) is associated with each
instruction to indicate the condition being tested for. Here, the `LOOPcc`
instruction itself does not affect the state of the `ZF` flag; the `ZF` flag is
changed by other instructions in the loop [[1]](#sources).

The condition codes are `e` and `ne` so that you can use the `ZF` as another 
loop terminator (this includes the condition codes `z` and `nz`).

For example:

``` x86asm

    ...

    mov rcx, 10

    .myLoop:
        add rax, 5
        test rax, rax
        loopnz .myLoop      ; Loop will fall through if `rcx` or `rax` is 0.

    ...

    mov rcx, 100

    .myLoop2:
        add rax, 11
        cmp rax, 100
        loopne .myLoop2     ; Loop falls through if `rcx` is `0` or
                            ; if `rax` is `100`.
    ...
```


## Sources

1. *LOOP/LOOPcc - Loop According to the ECX Counter*. 
https://www.felixcloutier.com/x86/loop:loopcc.


## Required Additional Readings

None.


## Resources

1. ***felixcloutier x86 and amd64 Instruction Reference***. 
https://www.felixcloutier.com/x86/. 
Index of tons of assembly instructions. Highly recommended as a quick 
reference.

2. ***Online ASM Compiler***. 
https://www.tutorialspoint.com/compile_assembly_online.php. 
Assembly compiler online where you can test new instructions you learn.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
