
# 3-26 ASM Programming - Application Solution

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[x]` Complete [lab](../4_lab.asm).
2. `[x]` Compile your program as `4_lab` using `nasm` and `gcc` or `ld`.
3. `[x]` Run [application test](../5_application_test.py) to test your program.


## 1. Complete Lab

Student should complete the lab. You can check the 
[lab solution](lab_solution.asm) if needed.


## 2. Build Program

Student should run the following commands if their program is using a `_start` 
function with an `exit` syscall:

``` sh
nasm -f elf64 4_lab.asm
ld 4_lab.o -o 4_lab
```

Or if the student has a `main` function, they can use the following commands:

``` sh
nasm -f elf64 4_lab.asm
gcc -no-pie 4_lab.o -o 4_lab
```


## 3. Run Application Test

The student should test their application by running `5_application_test.py`.

``` sh
./5_application_test.py
```

or 

``` sh
python3 5_application_test.py
```

Expected output is should have a `CONGRATULATIONS! ALL TESTS PASSED!` message.


[Back to README](README.md)


<!--- End of file. --->
