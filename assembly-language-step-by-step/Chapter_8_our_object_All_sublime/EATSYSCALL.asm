; Executable name	: Eatsyscall
; Version 		: 1.0
; Created data		: 12/19/25
; Last Updated		: 12/19/25
; Author		: Matthew copied from Jeff Duntemann's Book
; Discription		: A simple assembly app for Linux using NASM 2.05+, demonstrating the use of Linux INT 80H syscalls to display text
; 
; 
; Build using these commands: 
; nasm -f elf -g -F stabs eatsyscall.asm
; ld -o eatsyscall eatsystemcall.o
; 

SECTION .data				; Section containing initialized data

EatMsg: 	db "Eat at Joe's!",10
EatLen: 	equ $EatMsg

SECTION	.bss				; Section containing unitialized data

SECTION .text				; Section containing code

global _start				; Linker needs this to find the entry point!

_start: 	

	nop 				; This no-op keeps gdb happy (see text)

	mov eax, 4			; Specify sys_write syscall

	mov ebx, 1			; Specify FIle Descriptor 1: Standard Output

	mov ecx, EatMsg			; Pass offset of the message 

	mov edx, EatLen			; pass the length of the message 

	int 80H				; Make syscall to output the text to stdout

	
	mov eax, 1			; Specify Exit syscall

	mov ebx, 0			; Return a code of zero 

	int 80H				; Make syscall to terminate the program
