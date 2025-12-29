section	.data
section	.text

		Snippet db "KANGAROO"

		global _start

_start: 
	nop 
; Put your experiments between the tow nops...
	
		mov ebx, Snippet
		mov eax, 8
	DoMore: add byte [ebx], 32
		inc ebx
		dec eax
		jnz DoMore

; Put you experiments between the two nops...
	nop

section .bss

