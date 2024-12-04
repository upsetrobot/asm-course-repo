
# 3-09 Bit Operations - Knowledge Check Solution

[Back to README](README.md)

1. What is the difference, if any, between `shl` and `sal`?
    ```
    ANSWER: The shift arithmetic left (`sal`) and shift logical left (`shl`) 
    instructions perform the same operation; they shift the bits in the 
    destination operand to the left (toward more significant bit locations). 
    ```

2. What is the difference, if any, between `shr` and `sar`?
    ```
    ANSWER: `sar` will perform a right shift while preserving the sign bit of 
    a signed number, whereas `shr` will just fill the most significant bit 
    locations with zeros regardless of sign.

    ACCEPTABLE: The `SAR` and `SHR` instructions can be used to perform signed 
    or unsigned division, respectively, of the destination operand by powers 
    of 2. 
    ```

3. Mathematically, what does a left bit-shift do to a number (in most cases)?
    ```
    ANSWER: Multiply it by two.
    ```

4. Mathematically, what does a right bit-shift do to a number (in most cases)?
    ```
    ANSWER: Divide it by two.
    ```

5. What is the value of the register `al` after `rol al, 3` if `al` has a 
value of `0b 0110 0101`?
    ```
    ANSWER: 0b 0010 1011
    ```

6. What is the value of the register `al` after `rcr al, 3` if `al` has a 
value of `0b 0110 0101` and the carry flag is not set?
    ```
    ANSWER: 0b 0100 1100, CF: 1
    ```

[Back to README](README.md)


<!--- End of file. --->
