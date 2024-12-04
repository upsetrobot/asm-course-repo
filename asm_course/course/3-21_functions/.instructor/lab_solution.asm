
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-21 Functions - Lab Solution
;;
;; This file is module specific and contains solutions for the module lab.
;;
;; @file        lab_solution.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        02 Mar 2024
;; @copyright   Copyright (c) 2024
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   _____/\\\\\\\\\________/\\\\\\\\\\\____/\\\\____________/\\\\_        
;;    ___/\\\\\\\\\\\\\____/\\\/////////\\\_\/\\\\\\________/\\\\\\_       
;;     __/\\\/////////\\\__\//\\\______\///__\/\\\//\\\____/\\\//\\\_      
;;      _\/\\\_______\/\\\___\////\\\_________\/\\\\///\\\/\\\/_\/\\\_     
;;       _\/\\\\\\\\\\\\\\\______\////\\\______\/\\\__\///\\\/___\/\\\_    
;;        _\/\\\/////////\\\_________\////\\\___\/\\\____\///_____\/\\\_   
;;         _\/\\\_______\/\\\__/\\\______\//\\\__\/\\\_____________\/\\\_  
;;          _\/\\\_______\/\\\_\///\\\\\\\\\\\/___\/\\\_____________\/\\\_ 
;;           _\///________\///____\///////////_____\///______________\///__
;; 
;; The basics of the Linux x64 calling convention:
;;
;;     - Arguments are passed in `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`, in 
;;       that order and any additional arguments are passed on the stack.
;;     - The return value is stored in rax.
;;
;; You can reference the System V ABI manual for more details.
;; The Intel Manual, Volume 2 has detailed information about how each
;; instruction behaves.
;;
;; Good luck! Have fun!
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


section .data

    hash_msg1   db  "String to hash: '%s'", 10, 0
    hash_msg2   db  "Hash: 0x%016llx", 10, 0



section .text

global studentFunction1
global studentFunction2
global studentFunction3
global studentFunction4
global studentFunction5
global studentFunction6
global studentFunction7
global studentFunction8
global studentFunction9
global studentFunction10

extern printf



; 1. Unsigned Modulus.
;
;  unsigned long long studentFunction1(unsigned long long a, unsigned long long b);
;
; @brief    Function returns the modulus of `a` modulo `b` where `a` and `b` 
;           are positive unsigned long long integers. Division by zero results 
;           in `-1`. 
;
;           Note modulus in this context is just the remainder after `a` 
;           intergral divided by `b` (remainder of `a // b`).
;
;           Pseudocode: `return a % b if b != 0 else -1` or `return a mod b
;                       if b != 0 else -1`.
;
; @param    a                   The dividend.
; @param    b                   The divisor.
; @return   unsigned long long  Returns the modulus of `a` divided by `b` or 
;                               `-1` (UINT64_MAX) if `b` is 0.
;
; TODO: Implement this function.
; TODO: Use whatever stack frame system you desire.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------

    push rbp
    mov rbp, rsp

    or rax, -1
    test rsi, rsi
    jz .end

    mov rax, rdi
    xor rdx, rdx
    div rsi
    mov rax, rdx

    .end:
        leave
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction1.



; 2. Sum of Decrementing Moduli.
;
; unsigned long long studentFunction2(unsgined long long a, unsigned long long b);
;
; @brief    Function returns the sum of `a` and the moduli of `a` divided by 
;           `b` and all decrements of `b`. So, the function returns of `a` mod
;           `b` added to `a` mod `b-1` for all `n` where `n = b` to `n = 1`. If
;           `b` is `0`, function returns `0`.
;
;           Example:    `sudentFunction2(10, 4) = 10 + (10 % 4) + (10 % 3) + 
;                       (10 % 2) + (10 % 1) = 10 + 2 + 1 + 0 + 0 = 13.
;
;           Pseudocode: 
;               `return a + sum([a % n for n in range(1, b + 1)])`.
;
;           Use `studentFunction1` to calculate each modulus.
;
; @param    a           The dividend.
; @param    b           The maximum divisor.
; @return   long long   Returns the sum of `a` and all moduli of `a` and all 
;                       divisors from `1` to `b` or returns `0` if `b` is `0`.
;
; TODO: Implement this function.
; TODO: Create a stack frame for this function by ensuring `rbp` is pushed to 
;       the stack at the beginning of the function and popped off before 
;       returning.
; TODO: Ensure you call `studentFunction1` for your modulus operation.
;
studentFunction2:
    ; --- Add your solution below this line -----------------------------------

    push rbp
    mov rbp, rsp

    xor rax, rax
    test rsi, rsi               ; If `b` = `0`, return `0`.
    jz .end

    mov rcx, rsi
    mov rdx, rdi

    .loop:
        mov rsi, rcx
        push rcx                ; Probably not needed, but just in case.
        push rdx
        call studentFunction1   ; `a` % `n`.

        pop rdx
        pop rcx                 ; Restore counter in case it was clobbered.
        add rdx, rax            ; `ret += a % n`.
        loop .loop

    mov rax, rdx

    .end:
        mov rsp, rbp
        pop rbp
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction2.



; 3. Factorial.
; 
; unsigned long long studentFunction3(unsigned long long a);
;
; @brief    Function calculates the factorial of `a`. Assumes input is 
;           positive and accepts unsigned long long values (64-bit). Returns 
;           `1` if `a` is `0` (or `1` for that matter). 
;
;           You will not be tested on overflow, but that may be something to
;           think about in the future if you wanted.
;
;           Psuedocode: `return math.factorial(a)` or math notation: `a!`.
;           Example: `studentFunction3(4) = 4*3*2*1 = 24.
;
; @param    a                   Operand of the factorial operation.
; @return   unsigned long long  Returns factorial of `a`.
;
; TODO: Implement this function.
; TODO: Use a recursive implementation.
;
studentFunction3:
    ; --- Add your solution below this line -----------------------------------

    push rbp
    mov rbp, rsp

    xor rax, rax
    inc rax

    test rdi, rdi
    jz .end

    cmp rdi, 1
    je .end

    push rdi
    dec rdi
    call studentFunction3

    pop rdi
    mul rdi

    .end:
        leave
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction3.



; 4. Weird Hash Function.
;
; unsigned long long studentFunction4(char* str_to_hash);
;
; @brief    Function returns a weird 8-byte hash of given null-terminated 
;           string. The hash is the sum of the following for each character in 
;           the string: the algorithm finds the factorial of the modulus of 
;           the value of the value of the character and `30` and adds `12`. 
;           Then it calculates the looping decrementing modulus sum of that 
;           value and the position of the character plus `10000`. After all 
;           calculations have been summed for all characters, the result is 
;           8-byte weird hash.
;
;           For example, If the string is 'A' (`0x41`), the function will 
;           calculate `0x41 mod 30` and add `12`. Then the function will 
;           calculate the factorial of the result, then the function will 
;           call `studentFunction2(result, 1 + 10000)` (`1` because `A` is in 
;           the first position). The function would save the result and do the 
;           calculation of the next character and sum the results together.
;
;           Returns `0` if `str_to_hash` is NULL.
;
;           Psuedocode: `return sum([studentFunction2(math.factorial((
;                       ord(v) % 30) + 12), i + 1 + 10000) for i, v in 
;                       enumerate(str_to_hash)])` (if using Python, you have 
;                       to use `& 0xffffffffffffffff` on result to account for 
;                       overflow). 
;
;           Psuedocode 2:
;               `return_value = 0
;               position = 1
;               for char in str_to_hash:
;                   a = studentFunction3((char % 30) + 12)
;                   return_value += studentFunction2(a, position + 10000)
;                   position++
;               printWeirdHash(str_to_hash, return_value)
;               return return_value`.
;
;           NOTE:   This function is JUST an example of weird hash-like 
;                   function and may not be collision-safe and may or may not 
;                   be reversible (probably not for larger strings). It is 
;                   also only 8 bytes and would not be safe to use as a 
;                   password hasher.
;
; @param    str_to_hash         String to find hash of.
; @return   unsigned long long  Returns weird 8-byte hash of `str_to_hash`.
;
; TODO: Implement this function.
; TODO: Call `printWeirdHash` at the end of your function to print the hash.
;       `printWeirdHash` uses standard calling convention and requires the 
;       string and the hash to be passed in and will return the hash value you 
;       gave it.
; HINT: If you get a seg-fault due to a `movaps` in `printf`, try pushing a 
;       dummy value to the stack to create 16-byte stack alignment.
;
studentFunction4:
    ; --- Add your solution below this line -----------------------------------

    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi            ; str_to_hash.
    xor r13, r13            ; Return value.
    test rdi, rdi
    jz .end

    xor rcx, rcx

    .for:
        xor rax, rax
        mov al, [r12 + rcx]
        test al, al         ; If char == NULL: break.
        jz .endFor

        push rcx            ; Save position.
        xor rdx, rdx        
        mov ecx, 30
        div ecx             ; char // 30.
        add rdx, 12         ; (char % 30) + 12.

        mov rdi, rdx
        call studentFunction3       ; factorial((char % 30) + 12)

        mov rdi, rax
        mov rsi, [rsp]
        add rsi, 10000              ; position + 10000.
        inc rsi
        call studentFunction2       ; studentFunction2(fac((char % 30) + 12), position + 10000).

        add r13, rax        ; return_value += result.
        pop rcx             ; Restore position.
        inc rcx             ; position++.
        jmp .for

    .endFor:

    .end:
        mov rdi, r12
        mov rsi, r13
        push 0
        call printWeirdHash
        pop rdi

    pop r13
    pop r12
    leave
    ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction4.



; ************************* DO NOT EDIT THIS FUNCTION. *************************
;
; unsigned long long printWeirdHash(char* str, unsigned long long hash);
;
printWeirdHash:
    push rbp
    mov rbp, rsp
    push rsi
    mov rsi, rdi
    mov rdi, hash_msg1
    call printf
    mov rdi, hash_msg2
    mov rsi, [rsp]
    call printf
    pop rax
    leave
    ret

; End printWeirdHash.



; ********************************* NOT USED **********************************
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
