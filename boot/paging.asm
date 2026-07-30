; Alles-OS Paging
; Creates minimal identity map for first 2MB

bits 64

section .bss
align 4096

pml4:
    resq 512
pdpt:
    resq 512
pd:
    resq 512

section .text

global setup_paging

setup_paging:
    mov rax, pd
    or rax, 0x3
    mov [pdpt], rax

    mov rax, pdpt
    or rax, 0x3
    mov [pml4], rax

    mov ecx, 0
.map:
    mov eax, ecx
    shl rax, 21
    or rax, 0x83
    mov [pd + rcx*8], rax
    inc ecx
    cmp ecx, 512
    jne .map

    mov rax, pml4
    mov cr3, rax
    ret
