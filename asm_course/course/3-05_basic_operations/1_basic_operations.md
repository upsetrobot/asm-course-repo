
# 🧑‍💻 3-05 Basic Operations - Knowledge

<span style="color:lightcoral">*"Of course machines can't think as people do. 
A machine is different from a person. Hence, they think differently."*</span>
 ~-~ Alan Turing

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Operations](#operations)
- [`mov` Instruction](#mov-instruction)
- [`add` Instruction](#add-instruction)
- [`sub` Instruction](#sub-instruction)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Operations

The first three operations that will be introduced are the `mov`, `add`, and 
`sub` instructions.  These are basic instructions for loading a value into a 
register, adding a value to a register's value, and subtracting a value from 
a register's value.  These will help you get accustomed to assembly syntax.


## `mov` Instruction

The `mov` instruction typically takes two operands. In Intel syntax, the first 
operand is a register or memory location to move something to (aka the 
destination).  The second operand is what is being moved (either an immediate 
value, the value of another register, or a value at a memory location). 
Like all operations, you can see information on each instruction in the Intel 
Architecture Manual. More will be discussed on memory locations in a future 
module.

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    Note that you cannot move from a memory location to another memory location
    directly. You have to move a value from memory into a register and then
    move the value from the register to a new memory location.  
</span></span>

Example:

``` x86asm
	mov rax, 15			; Moves 15 into rax.
	mov rbx, rax		; Moves the contents or rax into rbx (which is 15).
	mov byte [rax], 15	; Moves 15 (as one byte) into the location pointed to by rax.
```

Examples of Invalid moves:

``` x86asm
	mov 15, rax					; Cannot move into an immediate value.
	mov byte [rax], byte [rbx] 	; Cannot move from memory to memory.
	mov [rax], 15				; Assembler does not know how many bytes to move.
```

<span class="box-orange"><span class="bar-orange">
    ⚠️ Warning   
</span><span class="inner">
    In 64-bit, **operations on 32-bit registers like `eax` will ZERO the upper
    bits of the 64-bit register**. It is very important to remember this. So,
    if you `mov rax, 0xffffffffaabbccdd` and then `mov eax, 0x11112222`, `rax`
    will have a value of `0x11112222` - not `0xffffffff11112222`! One way to
    get around this will be explained in the boolean operations module.
</span></span>


## `add` Instruction

The `add` instruction simply adds a value to the value in a given register or 
memory location.

Adds the destination operand (first operand) and the source operand (second 
operand) and then stores the result in the destination operand. The 
destination operand can be a register or a memory location; the source operand 
can be an immediate, a register, or a memory location. (However, two memory 
operands cannot be used in one instruction.) When an immediate value is used 
as an operand, it is sign-extended to the length of the destination operand 
format [[1]](#sources).

The `ADD` instruction performs integer addition. It evaluates the result for 
both signed and unsigned integer operands and sets the `OF` and `CF` flags to 
indicate a carry (overflow) in the signed or unsigned result, respectively. 
The `SF` flag indicates the sign of the signed result [[1]](#sources).

Example:

``` x86asm
	mov	rax, 1				; Moves 1 into rax.
	mov rbx, 1				; Moves 1 into rbx.
	add rax, 22				; Adds 22 into rax (rax has 23 now).
	add rbx, rax			; Adds rax (23) into rbx (1) (rbx has 24 now).
	add dword [rdi], rbx	; Adds rbx (24) to the memory location pointed to by rdi.
```


## `sub` Instruction

The `sub` instruction simply subtracts a value from the given register or 
memory location.

Subtracts the second operand (source operand) from the first operand 
(destination operand) and stores the result in the destination operand. The 
destination operand can be a register or a memory location; the source operand 
can be an immediate, register, or memory location. (However, two memory 
operands cannot be used in one instruction.) When an immediate value is used 
as an operand, it is sign-extended to the length of the destination operand 
format [[2]](#sources).

The `SUB` instruction performs integer subtraction. It evaluates the result for 
both signed and unsigned integer operands and sets the `OF` and `CF` flags to 
indicate an overflow in the signed or unsigned result, respectively. The `SF` 
flag indicates the sign of the signed result [[2]](#sources).

Example:

``` x86asm
   mov   rax, 10           ; Moves 10 into rax.
   mov   rbx, 20           ; Moves 20 into rbx.
   sub   rax, 22           ; Subtracts 22 from rax to rax (rax has -12 now).
   sub   rbx, rax          ; Subtracts rax (-12) from rbx (20) (rbx has 32 now).
   sub   dword [rdi], rbx  ; Subtracts rbx (32) from the memory location pointed to by rdi.
```


## Sources

1. *ADD - Add*. 
https://www.felixcloutier.com/x86/add.
2. *SUB - Subtract*. 
https://www.felixcloutier.com/x86/sub.


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
