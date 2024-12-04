
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-27 Structs - Lab Solution
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
;;    █████\  ███████ /███   /███
;;   ██\  ██\ ██::::/ /████ /████
;;   ███████\ ███████ /██ ████/██
;;   ██\  ██\ \::::██ /██ /██ /██
;;   ██\  ██\ ███████ /██     /██
;;   \\\  \\\ \:::::/ ///     ///
;;    \\\  \\\ \\|// ///     /// 
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


struc hacker 

    .handle:        resb 16
    .exp:           resq 1
    .crypto_curr:   resq 1
    .coin:          resd 1
    .speed:         resd 1
    .power:         resd 1
    .charisma:      resd 1
    .life:          resw 1
    .weapon:        resw 1
    .ammo:          resd 1
    .affiliate:     resb 16
    .typing_skl:    resd 1
    .re_skl:        resd 1
    .vuln_skl:      resd 1
    .net_skl:       resd 1
    .os_skl:        resd 1
    .prog_skl:      resd 1
    .intrus_skl:    resd 1
    .trav_skl:      resd 1
    .crypto_skl:    resd 1

endstruc


section .bss

    new_hacker:     resb    hacker_size



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



; 1. Iterate Struct Array.
;
; unsigned long long studentFunction1(struct hacker* hxr_arr, size_t num_hxrs);
;
; @brief    Function iterates the given struct array and adds up the 
;           experience of all the hackers. It then returns the sum.
;
; @param    hxr_arr             Pointer to the hacker array.
; @return   unsigned long long  Returns the sum of the `exp` of all the 
;                               hackers in the hacker array.
;
; TODO: Implement this function.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------
    push rbp
    mov rbp, rsp

    test rsi, rsi
    jz .none

    mov rcx, rsi
    xor rax, rax

    .loop:
        add rax, [rdi + hacker.exp]
        add rdi, hacker_size
        loop .loop

    jmp .end

    .none:
        xor rax, rax

    .end:
        leave
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction1.



; 2. New Struct.
;
; struct hacker* studentFunction2(char* handle, int power)
;
; @brief    Function allocates a new hacker struct and populates with the 
;           given data and the default data and returns a pointer to it.
;
;           Default data:
;               handle:         Must be defined upon creation.
;               exp:            `0`
;               crypto_curr:    `0`
;               coin:           `0`
;               speed:          `1`
;               power:          `1`
;               charisma:       `1`
;               life:           `10`
;               weapon:         `0`
;               ammo:           `0`
;               affiliate:      "`NONE`"
;               typing_skl:     `1`
;               vuln_skl:       `1`
;               re_skl:         `1`
;               net_skl:        `1`
;               os_skl:         `0`
;               prog_skl:       `2`
;               intrus_skl:     `1`
;               trav_skl:       `0`
;               crypto_skl:     `1`
;
;           `new_hacker` is a global you can use so you do NOT have to do 
;           dynamic allocation.
;
; @param    handle          String to copy to the hacker struct handle. If 
;                           `handle` points to a string greater than 15
;                           characters, the rest of the string will be
;                           truncated.
; @param    power           Power level to assign to the hacker struct.
; @return   struct hacker*  Returns a pointer to the new struct.
;
; TODO: Implement this function.
;
studentFunction2:
    ; --- Add your solution below this line -----------------------------------
    push rbp
    mov rbp, rsp

    ; Copy power.
    mov rdx, new_hacker
    mov dword [rdx + hacker.power], esi

    ; Copy handle.
    mov rsi, rdi
    lea rdi, [rdx + hacker.handle]
    cld
    mov rcx, 15
    repnz movsb
    mov byte [rdi], 0

    ; Populate defaults.
    mov dword [rdx + hacker.speed], 1
    mov dword [rdx + hacker.charisma], 1
    mov word [rdx + hacker.life], 10
    mov dword [rdx + hacker.typing_skl], 1
    mov dword [rdx + hacker.re_skl], 1
    mov dword [rdx + hacker.vuln_skl], 1
    mov dword [rdx + hacker.net_skl], 1
    mov dword [rdx + hacker.prog_skl], 2
    mov dword [rdx + hacker.intrus_skl], 1
    mov dword [rdx + hacker.crypto_skl], 1
    mov dword [rdx + hacker.affiliate], 'ENON'

    mov rax, rdx
    leave
    ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction2.



struc hxr_node

    .next:  resq 1
    .id:    resd 1
    .hxr:   resb hacker_size

endstruc


; 3. Find Hacker in List.
;
; struct hacker* studentFunction3(char* handle, struct hxr_node* list);
;
; @brief    Function searches `list` for a `hacker` with the given `handle`.
;           Function returns a pointer to the `hacker` struct if found; else 
;           returns NULL.
;
; @param    handle          Pointer to string to search hacker handles for.
; @param    list            Pointer to first node in a singly-linked list of 
;                           `hxr_node`s.
; @return   struct hacker*  Pointer to `hacker` struct if found; else returns 
;                           NULL.
;
; TODO: Implement this function.
;
studentFunction3:
    ; --- Add your solution below this line -----------------------------------
    push rbp
    mov rbp, rsp

    ; Check for NULL pointer.
    test rdi, rdi
    jz .err

    test rsi, rsi
    jz .err

    ; Get string length of handle.
    push rdi
    cld
    xor rcx, rcx
    not rcx
    mov al, 0
    repnz scasb
    pop rdi
    not rcx

    ; Check length for 15 chars.
    cmp rcx, 16             ; 16 to include NULL.
    jl .while

    mov rcx, 16
    
    .while:
        test rsi, rsi
        jz .err

        ; Compare strings.
        lea rax, [rsi + hxr_node.hxr]
        push rdi
        push rsi
        push rcx
        
        mov rsi, rdi
        lea rdi, [rax + hacker.handle]
        repe cmpsb
        pop rdx
        pop rsi
        pop rdi
        jrcxz .end

        mov rcx, rdx
        mov rsi, [rsi + hxr_node.next]
        jmp .while

    .err:
        xor rax, rax

    .end:
        leave
        ret

    ; --- Do not edit below this line -----------------------------------------
; End studentFunction3.



section .data

    list    db  0x28, 0x51, 0x40, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0,
    db 0x43, 0x32, 0x34, 0x35, 0x68, 0x30, 0x76, 0x33, 0x32, 0x32, 0x31, 0x64,
    db 0x33, 0x0, 0x0, 0x0, 0xa0, 0x86, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0xe8, 0x3,
    db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0,
    db 0x63, 0x0, 0x0, 0x0, 0x14, 0x0, 0x0, 0x0, 0xa, 0x0, 0x63, 0x0, 0x5, 0x0,
    db 0x0, 0x0, 0x4e, 0x4f, 0x4e, 0x45, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    db 0x0, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x32, 0x0,
    db 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x32, 0x0, 0x0, 0x0, 0x14, 0x0, 0x0, 0x0,
    db 0x63, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x32, 0x0, 0x0, 0x0, 0xa0, 0x51,
    db 0x40, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x0, 0x4e, 0x45, 0x4f, 0x0,
    db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xff, 0xff,
    db 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    db 0x0, 0x0, 0x0, 0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x63,
    db 0x0, 0x0, 0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x5a, 0x49,
    db 0x4f, 0x4e, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    db 0xa, 0x0, 0x0, 0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    db 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    db 0xff, 0xff, 0xff, 0x0, 0xca, 0x9a, 0x3b, 0x0, 0xca, 0x9a, 0x3b, 0x0, 0x0,
    db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x0, 0x0, 0x0, 0x6d, 0x61, 0x74, 0x74,
    db 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x40, 0x42,
    db 0xf, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xe8,
    db 0x3, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0, 0x0, 0x63, 0x0, 0x0,
    db 0x0, 0x1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x41, 0x6e, 0x61, 0x72, 0x63,
    db 0x68, 0x79, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0,
    db 0x0, 0x64, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0, 0x0, 0x64,
    db 0x0, 0x0, 0x0, 0x64, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0, 0x0, 0x64, 0x0, 0x0,
    db 0x0, 0x64, 0x0, 0x0, 0x0 



; ********************************* NOT USED **********************************
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
