
# 3-01 Tools - Application

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[ ]` Assemble [`4_assemble_me.asm`](4_assemble_me.asm).
2. `[ ]` Record number given in program. 
3. `[ ]` Run [5_application_test.py](5_application_test.py) or run `make` to 
use [Makefile](makefile) to validate program.

```
INSTRUCTOR COMMENTS:  
```


## 1. Assemble the Assembly Program.

Assemble the given assembly file using the following commands:

``` sh
nasm -f elf64 <file_to_assemble.asm> [-o <obj_filename.o>]
```

<span class="box-blue"><span class="bar-blue">
    <span class="blue">🖉</span>&nbsp; Note   
</span><span class="inner">
    You can use whatever file extension for assembly source files you want.
    Some common ones include `.asm`, `.nasm`, `.masm`, etc. But this course
    uses `.asm` because it is recognized by some of the VS Code features and
    extensions.  
</span></span>

Notice you can choose to manipulate the object file name with the `-o` output 
flag. This will create an object file.  Now, link the file to create and 
executable file. Name your executable `runme` so the application tester can 
test it.

``` sh
ld <object_file.o> -o runme
```

This should create an executable 64-bit ELF file.  Run it and record the 
number given.


## 2. Record the Given Number

```
ANSWER: 
```


## 3. Run Application Test

Run application test and check for passing.

``` sh
chmod +x 5_application_test.py
./5_application_test.py
```

or 

``` sh
python3 5_application_test.py
```

or

``` sh
pytest
```

or 

``` sh
make
```

Output of the test will tell you if the test passed or not.  If the test did 
not pass, fix any errors and try again.

Note the output and fix any errors if needed.  If you need help, ask an 
instructor.

These commands will produce files. You can remove them manually or use the 
make file provided to clean up. Just use the `make` command in the directory.

``` sh
make
```

`make` will not delete your binary. But `make clean` will.

``` sh
make clean
```


[Back to README](README.md)

<link rel="stylesheet" href="../.css/boxes.css">


<!--- End of file. --->
