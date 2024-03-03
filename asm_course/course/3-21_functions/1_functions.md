
# ⚙️ 3-21 Functions - Knowledge

[Back to README](README.md)


## Primer Contents

In this tutorial, we will go over the following topics:

- [Functions in Assembly](#functions-in-assembly)
- [`global` and `extern` Functions](#global-and-extern-functions)
- [Library Calls](#library-calls)
- [Calling Conventions](#calling-conventions)
- [Frames and the Stack](#frames-and-the-stack)
- [`call` Instruction](#call-instruction)
- [`ret` Instruction](#ret-instruction)
- [`enter` Instruction](#enter-instruction)
- [`leave` Instruction](#leave-instruction)
- [Sources](#sources)
- [Required Additional Readings](#required-additional-readings)
- [Resources](#resources)


## Functions in Assembly

Procedures or subroutines are very important in assembly language, as the
assembly language programs tend to be large in size. Procedures are identified
by a name. Following this name, the body of the procedure is described which
performs a well-defined job. End of the procedure is indicated by a return
statement [[1]](#sources).

``` x86asm
proc_name:
   procedure body
   ...
   ret
```

The procedure is called from another function by using the `CALL` instruction.
The `CALL` instruction should have the name of the called procedure as an
argument. The called procedure returns the control to the calling procedure by 
using the `RET` instruction [[1]](#sources).

Let us write a very simple procedure named `sum` that adds the variables 
stored in the `ECX` and `EDX` register and returns the sum in the `EAX` 
register [[1]](#sources):

``` x86asm
sum:
   mov     eax, ecx
   add     eax, edx
   ret
```

A recursive procedure is one that calls itself. There are two kind of
recursion: direct and indirect. In direct recursion, the procedure calls itself
and in indirect recursion, the first procedure calls a second procedure, which
in turn calls the first procedure [[2]](#sources).

Recursion could be observed in numerous mathematical algorithms. For example,
consider the case of calculating the factorial of a number. Factorial of a
number is given by the equation [[2]](#sources):

```
Fact (n) = n * fact (n-1) for n > 0
```

For example: factorial of `5` is `1 x 2 x 3 x 4 x 5` which is equal to `5 x
factorial of 4` and this can be a good example of showing a recursive
procedure. Every recursive algorithm must have an ending condition, i.e., the
recursive calling of the program should be stopped when a condition is
fulfilled. In the case of factorial algorithm, the end condition is reached
when `n` is `0` [[2]](#sources).

The following program shows how "factorial n" is implemented in assembly
language. To keep the program simple, we will calculate factorial `3`
[[2]](#sources):

``` x86asm
section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point

   mov   bx, 3           ;for calculating factorial 3
   call  proc_fact
   add   ax, 30h
   mov   [fact], ax
    
   mov	  edx,len        ;message length
   mov	  ecx,msg        ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel

   mov    edx,1          ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel
    
   mov	  eax,1          ;system call number (sys_exit)
   int	  0x80           ;call kernel
	
proc_fact:
   cmp   bl, 1
   jg    do_calculation
   mov   ax, 1
   ret
	
do_calculation:
   dec   bl
   call  proc_fact
   inc   bl
   mul   bl        ;ax = al * bl
   ret

section	.data
msg db 'Factorial 3 is:',0xa	
len equ $ - msg			

section .bss
fact resb 1
```
[[2]](#sources)


## `global` and `extern` Functions

In NASM, the keyword `global` is used to declare a function ("symbol") that 
is exported to be executed by other code (such as in `_start` which the linker 
has called to start your program after process initialization routines 
happen). `extern` is used to declare a function that is imported to be called 
in your program (such as a `libc` call).

`EXTERN` is similar to the `MASM` directive `EXTRN` and the C keyword `extern`:
it is used to declare a symbol which is not defined anywhere in the module
being assembled, but is assumed to be defined in some other module and needs to
be referred to by this one. Not every object-file format can support external
variables: the `bin` format cannot [[3]](#sources).

The `EXTERN` directive takes as many arguments as you like. Each argument is
the name of a symbol [[3]](#sources):

``` x86asm
extern  _printf 
extern  _sscanf,_fscanf
```
[[3]](#sources)
 
`GLOBAL` is the other end of `EXTERN`: if one module declares a symbol as
`EXTERN` and refers to it, then in order to prevent linker errors, some other
module must actually define the symbol and declare it as `GLOBAL`. Some
assemblers use the name `PUBLIC` for this purpose [[3]](#sources).

`GLOBAL` uses the same syntax as `EXTERN`, except that it must refer to symbols
which are defined in the same module as the `GLOBAL` directive. For example
[[3]](#sources):

``` x86asm
global _main 
_main: 
        ; some code.
```
[[3]](#sources)


## Library Calls

Library calls in assembly is as simple as declaring and `extern` for the 
symbol and then calling the function or using the variable. The library may 
be needed to be linked using the linker or by using the `%include` directive. 
The `%include` directive is to include assembly source files as if they were 
in the same file (so `extern` is not needed), but the file to be included 
needs to be in the current directory or in the directory specified by the `-i` 
option for the `nasm` command. 

``` x86asm
%include "<mylib.nasm>"
...     ; some code.
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
Note that Linux loads `libc` automatically, so you can use `libc` functions by 
using the `extern` declarations.
</span></span>


## Calling Conventions

Calling conventions are how assembly functions will interact with each other 
and the operating system. There are many different calling conventions for 
different architectures and operating systems. The main differences to keep in
mind for x86 assembly is that there is a standard calling convention for Unix
32-bit, Unix 64-bit, Windows 64-bit, and several for Windows 32-bit. These can
all be mixed and matched as needed and you can even implement or use your own.
It can be confusing at first, but calling conventions are critical to assembly
programming as you will have to interact with the operating system or other
functions. Calling conventions include conventions for argument passing to
functions, volatile and non-volatile register designations, stack frame setup
and usage, stack alignment rules, and the order of parameters. 

If you would like to learn more about 32-bit (x8086) calling conventions such 
as `cdecl` (Unix and Windows), `syscall`, or Windows 32-bit calling 
conventions (such as `stdcall`, `fastcall`, `thiscall`, and `vectorcall`), 
the [Wikipedia page](https://en.wikipedia.org/wiki/X86_calling_conventions) 
provides some useful information. 


### Passing Arguments

We will go over two examples of standard calling conventions - Unix x64 and 
Windows x64. 

The Microsoft x64 calling convention is followed on Windows and pre-boot UEFI
(for long mode on x86-64). The first four arguments are placed onto the
registers. That means `RCX`, `RDX`, `R8`, `R9` (in that order) for integer,
struct or pointer arguments, and `XMM0`, `XMM1`, `XMM2`, `XMM3` for floating
point arguments. Additional arguments are pushed onto the stack (right to
left). Integer return values (similar to x86) are returned in `RAX` if 64 bits
or less. Floating point return values are returned in `XMM0`. Parameters less
than 64 bits long are not zero extended; the high bits are not zeroed
[[4]](#sources).

The calling convention of the System V AMD64 ABI is followed on Solaris, Linux,
FreeBSD, macOS, and is the de facto standard among Unix and Unix-like operating
systems. The OpenVMS Calling Standard on x86-64 is based on the System V ABI
with some extensions needed for backwards compatibility. The first six integer
or pointer arguments are passed in registers `RDI`, `RSI`, `RDX`, `RCX`, `R8`,
`R9` (`R10` is used as a static chain pointer in case of nested functions),
while `XMM0`, `XMM1`, `XMM2`, `XMM3`, `XMM4`, `XMM5`, `XMM6` and `XMM7` are
used for the first floating point arguments. As in the Microsoft x64 calling
convention, additional arguments are passed on the stack. Integer return values
up to 64 bits in size are stored in `RAX` while values up to 128 bit are stored
in `RAX` and `RDX`. Floating-point return values are similarly stored in `XMM0`
and `XMM1`. The wider `YMM` and `ZMM` registers are used for passing and
returning wider values in place of `XMM` when they exist [[4]](#sources).


### Volatile and Nonvolatile Registers

Volatile registers are registers that the caller cannot depend on being 
constant after the call, so the calling function would have to save them 
before calling a function. Non-volatile registers are registers that the 
caller can count on being the same after the call, so the callee function 
would have to save them before using them. 

For example:

``` x86asm
myFunction:
    push r12        ; Callee must save this non-volatile register if this 
                    ; myFunction wants to use this register.
    ...

    mov r12, 5      ; <-- Nonvolatile register (callee-saved), so does not
                    ; have to be saved before calling aFunction.

    push rdi        ; <-- Volatile register (caller-saved), so has to be saved 
                    ; if value needs to be preserved.
    push rsi        ; Saving volatile register.
    push rdx        ; Saving volatile register.
    mov rdi, 1
    mov rsi, 2
    mov rdx, 3
    mov rcx, 4      ; In this case, myFunction does not care if this register
                    ; is clobbered or not (as implied by not saving it 
                    ; eventhough it is volatile).
    call aFunction  ; Call clobbers volatile registers, but not non-volatile 
                    ; ones.

    pop rdx         ; Restore volatile register.
    pop rsi         ; Restore volatile register.
    pop rdi         ; Restore volatile register.

    ...

    pop r12         ; Restore non-volatile registers for caller before 
                    ; returning.
    ret
```

For Microsoft x64, the registers `RAX`, `RCX`, `RDX`, `R8`, `R9`, `R10`, `R11`
are considered ***volatile*** (caller-saved). The registers `RBX`, `RBP`,
`RDI`, `RSI`, `RSP`, `R12`, `R13`, `R14`, and `R15` are considered
***nonvolatile*** (callee-saved). In x86-64, Visual Studio 2008 stores floating
point numbers in `XMM6` and `XMM7` (as well as `XMM8` through `XMM15`);
consequently, for x86-64, user-written assembly language routines must preserve
`XMM6` and `XMM7` (as compared to x86 wherein user-written assembly language
routines did not need to preserve `XMM6` and `XMM7`). In other words,
user-written assembly language routines must be updated to save/restore `XMM6`
and `XMM7` before/after the function when being ported from x86 to x86-64
[[4]](#sources).

For Unix, if the callee wishes to use registers `RBX`, `RSP`, `RBP`, and
`R12`–`R15`, it must restore their original values before returning control to
the caller (***nonvolatile***). All other registers must be saved by the caller
if it wishes to preserve their values (***volatile***) [[4]](#sources).


### Stack Rules

Some calling conventions have rules for stack alignment or stack slack space. 
We will not go over most of these as they should not impact x64 programming 
very much. There are, of course, exceptions and particular case scenarios. For 
example, sometimes a program will crash on a `movaps` instruction. This is 
due to a stack alignment issue which can be corrected by adding or subtracting 
8 bytes from the stack typically (to align the stack to 16 bytes). 

In the Microsoft x64 calling convention, it is the caller's responsibility to
allocate 32 bytes of "shadow space" on the stack right before calling the
function (regardless of the actual number of parameters used), and to pop the
stack after the call. The shadow space is used to spill `RCX`, `RDX`, `R8`, and
`R9`, but must be made available to all functions, even those with fewer than
four parameters. For example, a function taking `5` integer arguments will take
the first to fourth in registers, and the fifth will be pushed on top of the
shadow space. So when the called function is entered, the stack will be
composed of (in ascending order) the return address, followed by the shadow
space (32 bytes) followed by the fifth parameter [[4]](#sources).

For example:

``` x86asm
    ; NOTE THIS IS WINDOWS x64 ASSEMBLY.
    ...
    push rcx        ; Save volatile registers.

    mov rcx, 1      ; Load arguments.
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    push qword 5    ; Put fifth argument on the stack.

    sub rsp, 0x20   ; Create shadow space.

    call aFunction

    add rsp, 0x20   ; Destroy shadow space.

    add rsp, 8      ; Get rid of fifth argument.

    pop rcx         ; Restore volatile register.
    ...
```


## Frames and the Stack

Stack frames are areas of a stack that is marked for each function call. So, a 
new function can establish a new stack frame. They are typically marked with 
base pointers being pushed onto the stack after the return address is placed 
on the stack by the `call` function. Stack frames are sometimes used by 
debuggers to map stack traces (list of all the functions that were called to 
get to the current function) and exception handlers. Stack frames can be 
omitted (call "frame pointer omission") or customized for a calling 
convention or for some other reason. Stack frames also can act as a reference 
point for accessing arguments or local variables. 

This module has a [mandatory reading entry
](https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames) on 
stack frames. 

To create a stack frame, you can use this approach:

``` x86asm
myFunction:
    push rbp            ; Save old frame base pointer.
    mov rbp, rsp        ; Create new base pointer.

    sub rsp, <number>   ; Create space for local variables if needed.

    ...

    mov rsp, rbp        ; Restore old frame.
    pop rbp             ; Remove base pointer.
    ret
```

Or you can use this:

``` x86asm
myFunction:
    enter               ; Create new stack frame.

    sub rsp, <number>   ; Create space for local variables if needed.

    ...

    leave               ; Restore old stack frame.
    ret
```

Or:

``` x86asm
myFunction:
    enter 0x20          ; Create stack frame and allocate local variables.

    ...

    leave               ; Restore old stack frame.
    ret
```

Or you can avoid using frames:

``` x86asm
myFunction:
    sub rsp, <number>   ; Allocate local variables.

    ...

    add rsp, <number>   ; Restore stack to state it was when entered.
    ret
```

If you use stack frames, you can access local variables by using `rbp` as a 
reference, instead of using `rsp` which is useful when using the stack a lot.


## `call` Instruction

Saves procedure linking information on the stack and branches to the called
procedure specified using the target operand. The target operand specifies the
address of the first instruction in the called procedure. The operand can be an
immediate value, a general-purpose register, or a memory location
[[5]](#sources).

This instruction can be used to execute four types of calls [[5]](#sources):

- Near Call — A call to a procedure in the current code segment (the segment
currently pointed to by the `CS` register), sometimes referred to as an
intra-segment call [[5]](#sources).
- Far Call — A call to a procedure located in a different segment than the
current code segment, sometimes referred to as an inter-segment call
[[5]](#sources).
- Inter-privilege-level far call — A far call to a procedure in a segment at a
different privilege level than that of the currently executing program or
procedure [[5]](#sources).
- Task switch — A call to a procedure located in a different task
[[5]](#sources).

When executing a near call, the processor pushes the value of the `EIP`
register (which contains the offset of the instruction following the `CALL`
instruction) on the stack (for use later as a return-instruction pointer). The
processor then branches to the address in the current code segment specified by
the target operand. The target operand specifies either an absolute offset in
the code segment (an offset from the base of the code segment) or a relative
offset (a signed displacement relative to the current value of the instruction
pointer in the `EIP` register; this value points to the instruction following
the `CALL` instruction). The `CS` register is not changed on near calls
[[5]](#sources).

For a near call absolute, an absolute offset is specified indirectly in a
general-purpose register or a memory location (r/m16, r/m32, or r/m64). The
operand-size attribute determines the size of the target operand (16, 32 or 64
bits). When in 64-bit mode, the operand size for near call (and all near
branches) is forced to 64-bits. Absolute offsets are loaded directly into the
`EIP(RIP)` register. If the operand size attribute is 16, the upper two bytes
of the `EIP` register are cleared, resulting in a maximum instruction pointer
size of 16 bits. When accessing an absolute offset indirectly using the stack
pointer `[ESP]` as the base register, the base value used is the value of the
`ESP` before the instruction executes [[5]](#sources).

A relative offset (rel16 or rel32) is generally specified as a label in
assembly code. But at the machine code level, it is encoded as a signed, 16- or
32-bit immediate value. This value is added to the value in the `EIP(RIP)`
register. In 64-bit mode the relative offset is always a 32-bit immediate value
which is sign extended to 64-bits before it is added to the value in the `RIP`
register for the target calculation. As with absolute offsets, the operand-size
attribute determines the size of the target operand (16, 32, or 64 bits). In
64-bit mode the target operand will always be 64-bits because the operand size
is forced to 64-bits for near branches [[5]](#sources).

More information on different processor modes for the call instruction can be
found at the [source](#sources).

Example:

``` x86asm
myFunction:
    ...

    call myOtherFunction    ; Pushes next instruction address to stack, the 
                            ; runs code from myOtherFunction and then returns 
                            ; back here to the next instruction.
    ...                     ; <-- Next instruction.
    ...
    ret

; End myFunction.

myOtherFunction:
    ...
    ret                     ; Pop next instruction in calling function off the 
                            ; stack, then resumes execution of next 
                            ; instruction in myFunction.

; End myOtherFunction.
```


## `ret` Instruction

Transfers program control to a return address located on the top of the stack.
The address is usually placed on the stack by a `CALL` instruction, and the
return is made to the instruction that follows the `CALL` instruction
[[6]](#sources).

The optional source operand specifies the number of stack bytes to be released
after the return address is popped; the default is none. This operand can be
used to release parameters from the stack that were passed to the called
procedure and are no longer needed. It must be used when the `CALL` instruction
used to switch to a new procedure uses a call gate with a non-zero word count
to access the new procedure. Here, the source operand for the `RET` instruction
must specify the same number of bytes as is specified in the word count field
of the call gate [[6]](#sources).

The `RET` instruction can be used to execute three different types of returns
[[6]](#sources):

- Near return — A return to a calling procedure within the current code segment
(the segment currently pointed to by the `CS` register), sometimes referred to
as an intrasegment return [[6]](#sources).
- Far return — A return to a calling procedure located in a different segment
than the current code segment, sometimes referred to as an intersegment return
[[6]](#sources).
- Inter-privilege-level far return — A far return to a different privilege
level than that of the currently executing program or procedure
[[6]](#sources).

When executing a near return, the processor pops the return instruction pointer
(offset) from the top of the stack into the `EIP` register and begins program
execution at the new instruction pointer. The `CS` register is unchanged
[[6]](#sources).

When executing a far return, the processor pops the return instruction pointer
from the top of the stack into the `EIP` register, then pops the segment
selector from the top of the stack into the `CS` register. The processor then
begins program execution in the new code segment at the new instruction pointer
[[6]](#sources).

In 64-bit mode, the default operation size of this instruction is the
stack-address size, i.e., 64 bits. This applies to near returns, not far
returns; the default operation size of far returns is 32 bits.

More information on different processor modes for the call instruction can be
found at the [source](#sources).

See the [`call` Instruction](#call-instruction) section for an example.


## `enter` Instruction

Creates a stack frame (comprising of space for dynamic storage and 1-32 frame
pointer storage) for a procedure. The first operand (imm16) specifies the size
of the dynamic storage in the stack frame (that is, the number of bytes of
dynamically allocated on the stack for the procedure). The second operand
(imm8) gives the lexical nesting level (0 to 31) of the procedure. The nesting
level (imm8 mod 32) and the OperandSize attribute determine the size in bytes
of the storage space for frame pointers [[7]](#sources).

The nesting level determines the number of frame pointers that are copied into
the “display area” of the new stack frame from the preceding frame. The default
size of the frame pointer is the StackAddrSize attribute, but can be overridden
using the 66H prefix. Thus, the OperandSize attribute determines the size of
each frame pointer that will be copied into the stack frame and the data being
transferred from `SP/ESP/RSP` register into the `BP/EBP/RBP` register
[[7]](#sources).

The `ENTER` and companion `LEAVE` instructions are provided to support block
structured languages. The `ENTER` instruction (when used) is typically the
first instruction in a procedure and is used to set up a new stack frame for a
procedure. The `LEAVE` instruction is then used at the end of the procedure
(just before the `RET` instruction) to release the stack frame [[7]](#sources).

If the nesting level is 0, the processor pushes the frame pointer from the`
BP/EBP/RBP` register onto the stack, copies the current stack pointer from the
`SP/ESP/RSP` register into the `BP/EBP/RBP` register, and loads the
`SP/ESP/RSP` register with the current stack-pointer value minus the value in
the size operand. For nesting levels of 1 or greater, the processor pushes
additional frame pointers on the stack before adjusting the stack pointer.
These additional frame pointers provide the called procedure with access points
to other nested frames on the stack. See “Procedure Calls for Block-Structured
Languages” in Chapter 6 of the Intel® 64 and IA-32 Architectures Software
Developer’s Manual, Volume 1, for more information about the actions of the
`ENTER` instruction [[7]](#sources).

See the [Frames and the Stack](#frames-and-the-stack) section for examples.


## `leave` Instruction

Releases the stack frame set up by an earlier `ENTER` instruction. The `LEAVE`
instruction copies the frame pointer (in the `EBP` register) into the stack
pointer register (`ESP`), which releases the stack space allocated to the stack
frame. The old frame pointer (the frame pointer for the calling procedure that
was saved by the `ENTER` instruction) is then popped from the stack into the
`EBP` register, restoring the calling procedure’s stack frame [[8]](#sources).

A `RET` instruction is commonly executed following a `LEAVE` instruction to
return program control to the calling procedure [[8]](#sources).

See the [Frames and the Stack](#frames-and-the-stack) section for examples.


## Sources

1. *Assembly - Procedures*. 
https://www.tutorialspoint.com/assembly_programming/assembly_procedures.htm.
2. *Assembly - Recursion*. 
https://www.tutorialspoint.com/assembly_programming/assembly_recursion.htm.
3. *Chapter 7: Assembler Directives*.
https://www.nasm.us/doc/nasmdoc7.html#section-7.5.
4. *x86 calling conventions*.
https://en.wikipedia.org/wiki/X86_calling_conventions#x86-64_calling_conventions.
5. *CALL — Call Procedure*.
https://www.felixcloutier.com/x86/call.
6. *RET — Return From Procedure*.
https://www.felixcloutier.com/x86/ret.
7. *ENTER — Make Stack Frame for Procedure Parameters*.
https://www.felixcloutier.com/x86/enter.
8. *LEAVE — High Level Procedure Exit*.
https://www.felixcloutier.com/x86/leave.


## Required Additional Readings

1. **x86 Disassembly/Functions and Stack Frames**.
https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames.
Reading on stack frames with good examples.


## Resources

None.


[Back to Contents](#primer-contents)

[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">



<!--- End of file. --->
