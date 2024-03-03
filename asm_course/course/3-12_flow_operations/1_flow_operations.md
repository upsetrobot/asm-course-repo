
# ⏭️ 3-12 Flow Operations - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Introduction to Flow Operations](#introduction-to-flow-operations)
- [`cmp` Instruction](#cmp-instruction)
- [`jmp` Instruction](#jmp-instruction)
- [`jcc` Instruction](#jcc-instruction)
- [Other `cc` Instructions](#other-cc-instructions)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Introduction to Flow Operations

Compares and jumps are what allow for control flow in programming and 
computing and absolutely fundamental to programming in assembly. These 
instructions allow execution to split and are the basis of `for` loops, 
`while` loops, `if` statements, function calls, and other fundamental 
programming structures. After adding these instructions to you tool belt, you 
can write basic any program (well, you need syscalls as well to interact 
with the operating system and memory to store more data, but after that, you 
will have every tool you need; everything else is just about making your 
programming life easier).

Basically, you use `cmp` as an if-statement and `jmp` to move around in your 
code or to move to other code.


## `cmp` Instruction

Compares the first source operand with the second source operand and sets the
status flags in the `EFLAGS` register according to the results. The comparison
is performed by subtracting the second operand from the first operand and then
setting the status flags in the same manner as the `SUB` instruction. When an
immediate value is used as an operand, it is sign-extended to the length of the
first operand [[1]](#sources).

The condition codes used by the `Jcc`, `CMOVcc`, and `SETcc` instructions are
based on the results of a `CMP` instruction. Appendix B, “EFLAGS Condition
Codes,” in the Intel® 64 and IA-32 Architectures Software Developer’s Manual,
Volume 1, shows the relationship of the status flags and the condition codes 
[[1]](#sources).

The `CMP` instruction compares two operands. It is generally used in
conditional execution. This instruction basically subtracts one operand from
the other for comparing whether the operands are equal or not. It does not
disturb the destination or source operands. It is used along with the
conditional jump instruction for decision making [[2]](#sources).

Example:

``` x86asm
    CMP DX,	00  ; Compare the DX value with zero
    JE  L7      ; If yes (they are equal), then jump to label L7
    .           ; Else continue here.
    .
    L7: ...
```

[[2]](#sources)

`CMP` is often used for comparing whether a counter value has reached the 
number of times a loop needs to be run. Consider the following typical 
condition:

``` x86asm
    INC	EDX
    CMP	EDX, 10	; Compares whether the counter has reached 10
    JLE	LP1     ; If it is less than or equal to 10, then jump to LP1
```


## `jmp` Instruction

Transfers program control to a different point in the instruction stream
without recording return information. The destination (target) operand
specifies the address of the instruction being jumped to. This operand can be
an immediate value, a general-purpose register, or a memory location 
[[3]](#sources).

This instruction can be used to execute four different types of jumps:

- ***Near jump***. A jump to an instruction within the current code segment 
(the segment currently pointed to by the CS register), sometimes referred to 
as an intrasegment jump [[3]](#sources).

- ***Short jump***. A near jump where the jump range is limited to `-128` to 
`+127` from the current `EIP` value [[3]](#sources).

- ***Far jump***. A jump to an instruction located in a different segment than 
the current code segment but at the same privilege level, sometimes referred 
to as an intersegment jump [[3]](#sources).

- ***Task switch***. A jump to an instruction located in a different task 
[[3]](#sources).

There is a bunch of nuance with different types of jumps in different 
processor architectures and modes (some of which can be read 
[here](https://www.felixcloutier.com/x86/jmp)), but for now, you just need to 
know that you can jump to different functions or labels.

Conditional execution in assembly language is accomplished by several looping
and branching instructions. These instructions can change the flow of control
in a program. Conditional execution is observed in two scenarios 
[[2]](#sources):

- ***Unconditional jump***. This is performed by the `JMP` instruction.
Conditional execution often involves a transfer of control to the address of an
instruction that does not follow the currently executing instruction. Transfer
of control may be forward, to execute a new set of instructions or backward, to
re-execute the same steps [[2]](#sources).

- ***Conditional jump***. This is performed by a set of jump instructions
`j<condition>` depending upon the condition. The conditional instructions
transfer the control by breaking the sequential flow and they do it by changing
the offset value in `IP` [[2]](#sources).

Example:

``` x86asm
    xor rcx, rcx

    .loop:      ; create a label called .loop
        inc rcx
        jmp .loop       ; jumps back to .loop
                        ; Note that this loop will never end.

    .myLabel1:
        xor rcx, rcx

    .myLabel2:
        inc rcx
        jmp myLabel1    ; This is also a weird endless loop.
```


## `jcc` Instruction (Conditional Jumps)

Conditional jumps come in many varieties based on the "condition code" which 
is the last two letters in the instruction name after "j". Some common 
conditional jump instructions include the following: `je`, `jne`, `jz`, `jnz`, 
`jl`, `jle`, `jb`, `jbe`, `jg`, `jge`, `ja`, `jae`, `js`, and `jns`. And there 
are others. These condition codes can be used in some other assembly 
instructions, some of which will be reviewed in later modules.

Checks the state of one or more of the status flags in the `EFLAGS` register
(`CF`, `OF`, `PF`, `SF`, and `ZF`) and, if the flags are in the specified state
(condition), performs a jump to the target instruction specified by the
destination operand. A condition code (cc) is associated with each instruction
to indicate the condition being tested for. If the condition is not satisfied,
the jump is not performed and execution continues with the instruction
following the `Jcc` instruction [[4]](#sources).

| Pneumonic | Name                              | Flag                        |
|-----------|-----------------------------------|-----------------------------|
| `je`      | Jump if equal                     | `ZF` = 1                    |
| `jne`     | Jump if not equal                 | `ZF` = 0                    |
| `jz`      | Jump if zero                      | `ZF` = 1                    |
| `jnz`     | Jump if not zero                  | `ZF` = 0                    |
| `jl`      | Jump if less than                 | `SF` != `OF`                |
| `jle`     | Jump if less than or equal        | `ZF` = 1 or `SF` != `OF`    |
| `jnl`     | Jump if not less than             | `SF` = `OF`                 |
| `jnle`    | Jump if not less than or equal    | `ZF` = 0 and `SF` = `OF`    |
| `jg`      | Jump if greater                   | `ZF` = 0 and `SF` = `OF`    |
| `jge`     | Jump if greater or equal          | `SF` = `OF`                 |
| `jng`     | Jump if equal                     | `ZF` = 1 or `SF` != `OF`    |
| `jnge`    | Jump if not greater than or equal | `SF` != `OF`                |
| `jb`      | Jump if below                     | `CF` = 1                    |
| `jbe`     | Jump if below or equal            | `CF` = 1 or `ZF` = 1        |
| `jnb`     | Jump if not below                 | `CF` = 0                    |
| `jnbe`    | Jump if not below or equal        | `CF` = 0 and `ZF` != 0      |
| `ja`      | Jump if above                     | `CF` = 0 and `ZF` = 0       |
| `jae`     | Jump if above or equal            | `CF` = 0                    |
| `jna`     | Jump if not above                 | `CF` = 1 or `ZF` = 1        |
| `jnae`    | Jump if not above or equal        | `CF` = 1                    |
| `js`      | Jump if signed                    | `SF` = 1                    |
| `jns`     | Jump if not signed                | `SF` = 0                    |
| `jc`      | Jump if carry                     | `CF` = 1                    |
| `jnc`     | Jump if not carry                 | `CF` = 0                    |
| `jo`      | Jump if overflow                  | `OF` = 1                    |
| `jno`     | Jump if not overflow              | `OF` = 0                    |
| `jp`      | Jump if parity                    | `PF` = 1                    |
| `jpe`     | Jump if parity even               | `PF` = 1                    |
| `jnp`     | Jump if not parity                | `PF` = 0                    |
| `jpo`     | Jump if parity odd                | `PF` = 0                    |
| `jcxz`    | Jump if `cx` is 0                 | `cx` = 0                    |
| `jecxz`   | Jump if `ecx` is 0                | `ecx` = 0                   |
| `jrcxz`   | Jump if `rcx` is 0                | `rcx` = 0                   |

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    Note that some of the instructions are identical logical and in machine
    code and just have multiple names for convenience. For example, `je` and
    `jz` are the same and either can be used logically. The same for `jl` and
    `jnge`.
</span></span>

<span class="box-green"><span class="bar-green">
    💲 Tip   
</span><span class="inner">
    You can use `test` on a register and then use the `js` to jump if the value
    is negative.
</span></span>

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    If you are comparing numbers that are supposed to be able to be negative,
    you HAVE to use `jb` and `ja` series NOT `jl` and `jg` series. `jl` and
    `jg` series treat numbers as unsigned, so `0xff` (`255`) is greater than
    `0`, but `jb` and `ja` series treat numbers as signed, so `0xff` (`-1`) is
    less than `0`.
</span></span>

Example:

``` x86asm

    mov cl, 1                   ; cl = 1.

    cmp cl, 2                   ; Compare cl and 2. Sets flags.
    jle .lessThanOrEqualTo2     ; Is cl <= 2? If true, goto .lessThanOrEqualTo2.
    jmp .greaterThanTwo         ; Else goto .greaterThanTwo.

    .lessThanOrEqualTo2:
        test cl, cl             ; Test cl. Sets flags.
        jz .zero                ; Is cl == 0? If true, goto .zero.

        mov cl, 250             ; Else cl = 250.

    .greaterThanTwo:
        cmp cl, 2               ; Compare cl and 2. Sets flags.
        jbe .lessThan2Signed    ; Is cl <= 2? If true, goto .lessThan2Signed.
        jmp .greaterThan2Signed ; Else goto .greaterThan2Signed

        .lessThan2Signed:
            test cl, cl         ; Test cl. Sets flags.
            js .negative        ; Is cl negative? If true, goto .negative.
            jz .zero            ; Else is cl == 0? If true goto .zero.

        .greaterThan2Signed:    ; Else move 25 into rax.
            mov rax, 25
            ret

    .negative:
        xor rax, rax
        inc rax
        ret

    .zero:
        xor rax, rax
        ret
```

What will the value of `rax` be when this function returns?


## Other `cc` Instructions

There are other conditional instructions as well such as `setcc` which sets 
the destination operand byte to `1` if condition is true or to `0` if false; 
`cmovcc` which move a source operand into a destination operand if condition 
is true (and not if it is false); `repcc` which repeats an instruction if a 
condition is not met; and there are others. You do not have to learn all these 
now, but you can look into them if you want.


## Sources

1. *CMP - Compare Two Operands*. 
https://www.felixcloutier.com/x86/cmp.
2. *Assembly - Conditions*. 
https://www.tutorialspoint.com/assembly_programming/assembly_conditions.htm.
3. *JMP - Jump*. 
https://www.felixcloutier.com/x86/jmp.
4. *Jcc - Jump If Condition is Met*. 
https://www.felixcloutier.com/x86/jcc.


## Required Additional Readings

1. None.


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
