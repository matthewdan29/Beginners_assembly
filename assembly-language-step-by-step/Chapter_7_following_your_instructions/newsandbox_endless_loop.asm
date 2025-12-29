section	.data
section	.text

		global _start

_start: 
	nop 
; Put your experiments between the tow nops...
			
			mov eax, 5
		DoMore: dec eax
			Jmp DoMore

; Put you experiments between the two nops...
	nop

section .bss

