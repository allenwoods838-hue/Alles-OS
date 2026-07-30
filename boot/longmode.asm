; Alles-OS Long Mode Setup

bits 32

section .text

global enter_long_mode
extern kernel_main
extern setup_paging

enter_long_mode:
    call setup_paging

    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    lgdt [gdt64_pointer]
    jmp 0x08:long_mode_start

bits 64

long_mode_start:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax

    call kernel_main

.hang:
    hlt
    jmp .hang

section .data

gdt64_pointer:
    dw 0
    dq 0
