section	.data
section	.text

		global _start

_start: 
	nop 
; Put your experiments between the tow nops...

		mov eax, 447

		mov ebx, 1739

		mul ebx

		mov eax, 0FFFFFFFFh

		mov ebx, 03B72h

		mul ebx

; Put you experiments between the two nops...
	nop

section .bss

