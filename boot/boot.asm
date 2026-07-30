; Alles-OS BIOS Bootloader
; Phase 1 starter

bits 16
org 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, boot_msg
.print:
    lodsb
    or al, al
    jz load
    mov ah, 0x0E
    int 0x10
    jmp .print

load:
    ; Kernel loading will be added in the next phase
    cli
.hang:
    hlt
    jmp .hang

boot_msg db 'Alles OS Bootloader',0

times 510-($-$$) db 0
dw 0xAA55
