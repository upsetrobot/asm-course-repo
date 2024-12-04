
# Assembly Course - README

## Course Overview

This is the `x86 64-bit Linux NASM Assembly` Course where students learn basic
assembly programming from Zero to Hero. The section is structured in a way that
first teaches students the basics of a specific topic using `Markdown` files in
every folder, known as a learning `Module`. The learning modules then test
student knowledge by having them complete knowledge checks and applications.
After several modules, or topics, their combined use is tested in the form of a
`competency` module. Each of the competency modules challenges the student more
than the basic application challenges in the learning modules preceding it. All
coding challenges are graded using an competency or application test in each
directory. All the students (and graders) must do to test the code is run
application or competency test (for students) and application or competency
test verifier (for instructors) in the module directory. 

Most of the modules can be testing using `pytest` or `make` commands.

## Requirements

This course requires a `64-bit Linux` environment, `Python 3.10` (may work on some 
lower versions), and the `pytest` Python module.

You should be able to install python with `apt` if you have `apt` such as 
users of `Debian` and `Ubuntu` systems:

``` sh
sudo apt install python
```

or 

``` sh
sudo apt install python3
```

Once Python is installed, you should be able to install `pytest` using `pip`:

``` sh
pip install pytest
```

or sometimes:

``` sh
pip3 install pytest
```

`pytest` does not run correctly from the `course` directory, so you can use 
the `pytest_mods.sh` script provided to test all modules.


## Table of Contents

Complete the following sections (Enter an 'x' when complete):

1. `[ ]` [3-00 Fundamentals](3-00_fundamentals/README.md).  
Explains what assembly is, introduces different types of assembly, how 
assembly works, and the different applications of assembly programming.

2. `[ ]` [3-01 Tools](3-01_tools/README.md).  
Introduces tools used in assembly programming and tools used in this course.

3. `[ ]` [3-02 Syntax](3-02_syntax/README.md).  
Introduces basic NASM syntax and assembly syntaxes.

4. `[ ]` [3-03 Registers](3-03_registers/README.md).  
Introduces assembly registers and register types used in x86 assembly.

5. `[ ]` [3-04 Data Types](3-04_data_types/README.md).  
Introduces data sizes, constants, immediates, and variables in assembly.

6. `[ ]` [3-05 Basic Operations](3-05_basic_operations/README.md).  
Introduces `mov`, `add`, and `sub` instructions.

7. `[ ]` [3-06 Basic Debugging](3-06_basic_debugging/README.md).  
Introduces debugging using `gdb`, the `int3` instruction, and debugging 
techniques.

8. `[ ]` [3-07 Arithmetic Operations](3-07_arithmetic_operations/README.md).  
Introduces `inc`, `dec`, `mul`, `imul`, `div`, `idiv`, `cbw`, `cwde`, `cdqe`,
`cwd`, `cdq`, `cqo`, `lea`, and `xchg` instructions.

9. `[ ]` [***3-08 Competency 1 Speed***](./3-08_competency_1_speed/README.md).  
Tests competency with basic assembly syntax, basic instructions, and 
arithmetic instructions.

10. `[ ]` [3-09 Bit Operations](3-09_bit_operations/README.md).  
Introduces `shl`, `shr`, `sar`, `sal`, `rcr`, `rcl`, `ror`, and `rol` 
instructions.

11. `[ ]` [3-10 Boolean Operations](3-10_boolean_operations/README.md).  
Introduces `and`, `or`, `xor`, `not`, and `test` instructions.

12. `[ ]` [***3-11 Competency 2 Its a Bomb!***](
    3-11_competency_2_its_a_bomb/README.md).  
Tests competency with arithmetic, bitwise manipulation, and boolean 
instructions.

13. `[ ]` [3-12 Flow Operations](3-12_flow_operations/README.md).  
Introduces `jmp`, `cmp`, and `jcc` instructions.

14. `[ ]` [3-13 Control Flow](3-13_control_flow/README.md).  
Explains how to do control statements in assembly like branching, `if` 
statements, `if-else` statements, `switch` statements, and `goto` statements.

15. `[ ]` [3-14 Loop Operations](3-14_loop_operations/README.md).  
Introduces `loop` and `loopcc` instructions.

16. `[ ]` [3-15 Loops](3-15_loops/README.md).  
Explains loop statements like `for` loops, `while` loops, `do-while` loops, 
and custom loops.

17. `[ ]` [***3-16 Competency 3 FizzBuzz***](
    3-16_competency_3_fizzbuzz/README.md).  
Tests competency with control flow and loop problems in assembly.

18. `[ ]` [3-17 Stack](3-17_stack/README.md).  
Explains the stack and stack concepts such as local variables, passing 
arguments, saving values, and stack frames. Introduces `push`, `pop`, `pushf`, 
and `popf` instructions.

19. `[ ]` [3-18 Memory](3-18_memory/README.md).  
Explains memory concepts for assembly including memory sections and addressing 
constructs.

20. `[ ]` [3-19 Strings](3-19_strings/README.md).  
Introduces string manipulation, initialization, and use in assembly. Discusses 
ASCII encoding and dealing with ASCII numbers in assembly. Introduces `rep`, 
`repcc`, `cld`, `std`, `movs`, `lods`, `stos`, `cmps`, and `scas` instructions.

21. `[ ]` [***3-20 Competency 4 Stumped***](3-20_competency_4_stumped/README.md).  
Tests competency stack operations, arrays, and strings.

22. `[ ]` [3-21 Functions](3-21_functions/README.md).  
Introduces functions and procedure concepts in assembly including stack frames, 
scope, importing, exporting, recursion, and calling conventions. Introduces 
`call`, `ret`, `enter`, and `leave` instructions.

23. `[ ]` [***3-22 Competency 5 Locked Up***](3-22_competency_5_locked_up/README.md). 
Tests competency with functions.

24. `[ ]` [3-23 Interrupts and Syscalls](
    3-23_interrupts_and_syscalls/README.md).  
Explains interrupts and syscalls. Introduces `syscall`, `sysenter`, and 
`int 0x80` instructions.

25. `[ ]` [***3-24 Competency 6 Its About Time***](3-24_competency_6_its_about_time/README.md).  
Tests competency with syscalls.

26. `[ ]` [Supplemental 3-25 File Handling](
    supplemental/3-25_file_handling/README.md).  
Explains file handling in assembly. 

27. `[ ]` [Supplemental 3-26 ASM Programming](
    supplemental/3-26_asm_programming/README.md).  
Discusses broader concepts of assembly programming including compilations, 
architectures, relative and absolute addressing, and macros.

28. `[ ]` [Supplemental 3-27 Structs](supplemental/3-27_structs/README.md).  
Introduces structures in assembly and gives a linked list example.

If you don't have a Linux Operating System (OS) either as a host, a virtual 
environment (like `wsl`) or inside a Virtual Machine (VM), please inform an 
instructor.


<!--- End of file. --->
