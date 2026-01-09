; Newlines: 		Sends between 1-15 newlines to the Linux console
; UPDATED: 		1/2/26
; IN: 			EDX: # of newlines to send, from 1 to 15
; RETURNS: 		Nothing
; MODIFIES: 		Nothing. All caller registers preserved. 
; CALLS: 		Kernel sys_write
; DISCRIPTION: 		The number of newline characters (0Ah) specified in EDX is sent to stdout using INT 80h
; 			sys_write. This procedure demonstrates placeing constant data in the procedure defintion itself,; 			rather than in the .data or .bss sections. 
; 
Newlines: 
	Pushad 		; Save all caller's registers
	cmp edx, 15	; Make sure caller didn't ask for more than 15
	ja, .exit	; If so, exit without doing anything
	mov ecx, EOLs	; Put address of EOLs table into ECX
	mov eax, 4	; Specify sys_write
	mov ebx, 1	; Specify stdout
	int 80h		; Make the kernel call
.exit	popad		; Restore all caller's registers 
	ret		; Go home!
EOLs db 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
