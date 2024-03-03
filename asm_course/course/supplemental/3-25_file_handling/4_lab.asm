
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-25 File Handling - Application Lab
;;
;; This file is module specific and houses assembly application labs for 
;; students. Students should edit this file and run `make` to test their 
;; solutions.
;;
;; @file        4_lab.asm
;; @author      upsetrobot
;; @brief       Application lab assignment.
;; @version     1.0.1
;; @date        17 Feb 2024
;; @copyright   Copyright (c) 2024
;;
;; Student TODO:    Complete the lab assignment below.
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


section .data

    filename    db  "testing_data.bin", 0



section .bss

    buffer: resb 1024



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



; 1. Open and Print a File.
;
; int studentFunction1(char* filename);
;
; @brief    Function opens a file and prints the file contents to the screen.
;           Returns -1 if file could not be opened. 
;
;           You can assume the file is less than 1024 bytes long. In reality, 
;           you would either buffer read it till you printed everything or 
;           you would use `stat` or `lseek` to get the file size and then 
;           allocate a buffer for the file or use some other method. 
;
; @param    char*   Name of file to open.
; @return   int     Returns `0` if successful; else returns `-1`.
;
; TODO: Implement this function.
;
studentFunction1:
    ; --- Add your solution below this line -----------------------------------
    
        
        
    ; --- Do not edit below this line -----------------------------------------
; End studentFunction1.



; 2. Open a Binary File and add Array of Numbers.
;
; long long studentFunction2()
;
; @brief    Function opens a file named `testing_data.bin` from the current 
;           working directory and reads the file into a buffer. The contents
;           are interpreted as a long long array of 10 or less numbers. The 
;           numbers are added together and the sum is returned. If there is a 
;           file error, the function returns `0`.
;
; @return   long long   Returns the sum of the array of `long long`s from the 
;                       `testing_data.bin` file.
;
; TODO: Implement this function.
;
studentFunction2:
    ; --- Add your solution below this line -----------------------------------
    


    ; --- Do not edit below this line -----------------------------------------
; End studentFunction2.



; 3. Save a File.
;
; int studentFunction3(char* str, char* filename);
;
; @brief    Function copies and appends the string `str` to a file given by  
;           `filename`. If the file does not exist, it will be created. The
;           function returns `-1` if there is an error; otherwise returns `0`.
;
; @param    str         String to append to file.
; @param    filename    Name of file to append string to.
; @return   int         `0` if success; else `-1`.
;
; TODO: Implement this function.
;
studentFunction3:
    ; --- Add your solution below this line -----------------------------------
    


    ; --- Do not edit below this line -----------------------------------------
; End studentFunction3.



; ********************************* NOT USED **********************************
studentFunction4: ret
studentFunction5: ret
studentFunction6: ret
studentFunction7: ret
studentFunction8: ret
studentFunction9: ret
studentFunction10: ret



; End of file.
