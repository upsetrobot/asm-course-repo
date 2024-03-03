
# 3-01 Tools - Application

[Back to README](README.md)

Complete the following tasks:

(Enter an 'x' when complete.)

1. `[x]` Assemble [`4_assemble_me.asm`](../4_assemble_me.asm).
2. `[x]` Record number given in program. 
3. `[x]` Run [5_application_test.py](../5_application_test.py) or run `make` 
to use [Makefile](../makefile) to validate program.


## 1. Assemble the Assembly Program.

Student should run the following commands:

``` sh
nasm -f elf64 5_assemble_me.asm
ld 5_assemble_me.o -o runme
./runme
```

Expected output is:

``` sh
Hello, Welcome Assembler! Your Number is: 31337
```


## 2. Record the Given Number

```
ANSWER: 31337     
```


## 3. Run Application Test

Student should run the following commands:

``` sh
chmod +x 5_application_test.py
./5_application_test.py
```

Expected output is:

``` sh
CONGRATULATIONS! TEST PASSED!
```

Alternatively, student could run `pytest` with passing 1 test.

``` sh
pytest
```

Expected output is:

``` sh
============================= test session starts ==============================
platform linux -- Python 3.10.12, pytest-7.4.0, pluggy-1.3.0
rootdir: [REDACTED]/3.1_tools
plugins: web3-5.31.3
collected 1 item                                                               

5_application_test.py .                                                   [100%]

============================== 1 passed in 0.00s ===============================
```

Or the student could run `make`

``` sh
make
```

Expected output is:

``` sh
./5_application_test.py
CONGRATULATIONS! TEST PASSED!
rm -fr *.o runme __pycache__ .pytest_cache
```


[Back to README](README.md)


<!--- End of file. --->
