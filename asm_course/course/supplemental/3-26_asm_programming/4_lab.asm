
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3-26 ASM Programming - Application Lab
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
;;
;; TODO: Write a program that takes a filename as an argument, and then 
;;       attempts to open the file with the given filename and then prints the 
;;       contents of the file and then exits. If there is an error, 
;;       Program should print "Error".
;;
;;       You can use either method to compile.  Weather you use `gcc` or `ld`, 
;;       ensure you use the correct entry point as applicable.
;;
;;       Program must be compiled as `4_lab` for the executable name.
;;
;;       You can use any libraries if you want.
;;
;;       Your program will only be tested on text, so you don't have to worry 
;;       about binary.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; --- Add your solution below this line --------------------------------------



; --- Do not edit below this line ---------------------------------------------



; End of file.
