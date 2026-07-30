; Alles-OS GDT
; Global Descriptor Table

bits 64

section .text

global gdt_flush

gdt_flush:
    lgdt [rdi]
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    ret

section .data
align 8

gdt_start:
    dq 0

; 64-bit code segment
    dw 0xffff
    dw 0
    db 0
    db 10011010b
    db 00100000b
    db 0

; 64-bit data segment
    dw 0xffff
    dw 0
    db 0
    db 10010010b
    db 00000000b
    db 0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dq gdt_start
