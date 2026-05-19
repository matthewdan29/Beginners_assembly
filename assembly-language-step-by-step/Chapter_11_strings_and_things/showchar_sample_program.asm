_start: 
	nop 			; This no-op gdb happy...

; Get the console and text display text buffer ready to go: 
	
	ClearTerminal 		; Send terminal clear string to console
	call ClrVid		; Init/clear the video buffer 

; show a 64-character ruler above the table display: 
	
	mov eax, 1		; Start ruler at display position 1,1
	mov ebx, 1		
	mov ecx, 32		; Make ruler 32 characters wide 
	call Ruler 		; Generate the ruler

; Now lets generate the chart itself: 

	mov edi, VidBuff		; Start with buffer address in EDI 
	add edi, COLS*CHRTROW		; Begin table display down CHRTROW lines 
	mov ecx, 224			; Show 256 chars minus first 32
	mov al, 32			; Start with char 32; other won't show 
	mov al, 32			; Start with char 32; others won't show
.DoLn: 	mov bl, CHRTLEN			; Each line will consist of 32 chars 
.DoChr: stosb				; Note that there's no REP prefix
	jcxz AllDone			; When the full set is printed, quit
	inc al				; Bump the character value in AL up by 1
	inc al 				; Bump the charater value in AL up by 1
	dec bl 				; Decrement the line counter by one
	loopnz .DoChr			; Go back & do another char until BL goes to 0
	add edi, (COLS-CHRTLEN)		; Move EDI to start of next line
	jmp .DoLn			; Start display of the next line

; Having written all that to the buffer, send the buffer to the console: 
AllDone: 	
	call Show 			; Refresh the buffer to the console
	
Exit: 	mov eax, 1			; Code for Exit Syscall
	mov ebx, 0			; Return a code of zero
	int 80H				; Make kernel call
