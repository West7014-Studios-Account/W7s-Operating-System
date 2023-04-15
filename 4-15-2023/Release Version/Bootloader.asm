bits 16
org 0x7c00

; Define data segments
section .data
KERNEL_OFFSET   equ 0x1000    ; kernel offset in memory
BOOT_MAGIC      dw 0x55aa     ; boot signature

; Define code segments
section .text
global _start

_start:
    ; Set up stack pointer
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xffff

    ; Load kernel into memory
    mov bx, KERNEL_OFFSET
    mov dh, 0x00
    mov dl, 0x80
    mov ch, 0x00
    mov cl, 0x02
    mov ah, 0x02
    int 0x13

    ; Load boot splash screen
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Display loading animation
    ; TODO: implement loading animation

    ; Jump to kernel
    jmp KERNEL_OFFSET

; Fill remaining bytes with boot signature
times 510-($-$$) db 0
dw BOOT_MAGIC
