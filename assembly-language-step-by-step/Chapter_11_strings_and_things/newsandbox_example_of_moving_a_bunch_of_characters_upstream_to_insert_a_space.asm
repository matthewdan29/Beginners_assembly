section	.data

	EditBuff: 	db 'abcdefghijklm
	ENDPOS		equ 12 
	INSRTPOS	equ 5
section	.text

		global _start

_start: 
	nop 
; Put your experiments between the tow nops...

	std				; down-memory transfer
	mov ebx, EditBuff+INSRTPOS	; Save address of insert point
	mov esi, EditBuff+ENDPOS	; Start at end of text 
	mov edi, EditBuff+ENDPOS+1	; Bump text right by 1
	mov ecx, ENDPOS-INSRTPOS+1	; # of chars to bump 
	rep movsb			; Move 'em!
	mov byte byte [ebx], ' '	; Write a space at insert point
; Put you experiments between the two nops...
	nop

section .bss

