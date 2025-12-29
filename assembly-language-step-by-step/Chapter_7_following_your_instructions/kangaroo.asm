SECTION .data

; SECTION .bss

	Snippet db "KANGAROO"
SECTION .text 

global _start

_start:

	nop 
; Put your exeriments between the two nops...

	mov ebx, Snippet

	move eax, 8

DeMore: add byte [ebx], 32

	inc ebx

	dec eax

	jnz DoMore

; Put your experiments between the two nop

	nop
