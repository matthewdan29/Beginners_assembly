; Executable name	: uppercase2
; Version 		: 1.0
; Created date		: 12/23/25
; Last update		: 12/23/25
; Author 		: Matthew K. Daniels (in respects to Jeff Duntemann)
; Description		: A simple program in assembly for Linux, using NASM 2.05. 
; 			  demostrating simple text file I/O (though redirection) for reading an input file to a buffer
; 			  in blocks, forcing lowercase character to uppercase, and writing the modified buffer to an 
; 			  output file.
; Run it this way: 
; 	uppercase2 > (output file) < (input fil)
;
;	./uppercaser2 > allupper.txt < uppercaser2.asm
; 
; Build using these commands: 
;	nasm -f elf -g -F stabs uppercase2.asm
; 	id -o uppercaser2 uppercaser2.o

SECTION .bss					; Section containing uninitialized data
	BUFFLEN equ 1024			; Length of buffer
	Buff: 	resb BUFFLEN			; Text buffer itself

SECTION .data					; Section containing initialised data 

SECTION .text					; Section containing code 

global _start					; Linker needs this to fiind the entry point!

_start: 	
	nop 					; This no-op keeps gbd happy...


; Read a buffer full of text from stdin: 
read: 	

	mov eax, 3				; Specify sys_read call
	mov ebx, 0				; specify File Descriptor 0: Standard Input
	mov ecx, Buff				; Pass offset of the buffer to read to 
	mov edx, BUFFLEN			; Pass number of bytes to read at one pass
	int 80h					; Call sys_read to fill the buffer
	mov esi, eax				; Copy sys_read to fill the buffer
	cmp eax, 0				; If eax=0, sys_read reached EOF on stdin 
	je Done					; Jump If Equal (to 0, from compare)

; Set up the registers for the process buffer step:

	mov ecx, esi 				; Place the number of bytes read into ecx
	mov ebp, Buff				; Place address of buffer into ebp
	dec ebp					; Adjust count of offset

; Go through the buffer and convert lowercase to uppercase characters: 
Scan: 
	cmp byte [ebp+ecx], 61h 			; Test input char against lowercase 'a'
	jb Next 				; If below 'a' in ASCII, not lowercase
	cmp byte [ebp+ecx], 7AH			; Test input char against lowercase 'z'
	ja Next 				; If above 'z' in ASCII, not lowercase 
						; At this point, we have a lowercase char 
	sub byte [ebp+ecx], 20h			; Subtract 20h to give uppercase...
Next:	dec ecx					; Decrement counter
	jnz Scan 				; If characters remain, loop back 

; Write the buffer full of processed text to stdout: 
Write: 

	mov eax, 4				; Specify sys_write call
	mov ebx, 1				; Specify File Descriptor 1: Standard output
	mov ecx, Buff				; Pass offset of the buffer
	mov edx, esi				; Pass the # of bytes of data in the buffer
	int 80h					; Make sys_write kernel call
	jmp read 				; Loop back and load another buffer full 

; All done! 
Done: 	

	mov eax, 1				; Code for Exit Syscall
	mov ebx, 0				; Return a code of zero 
	int 80H					; Make sys_exit kernel call
