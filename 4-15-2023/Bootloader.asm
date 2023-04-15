BITS 16

start:
    mov ax, 0x07C0      ; set up segments
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFF

    mov bx, 0x8000      ; load kernel to 0x8000
    mov dh, 0x00
    mov dl, 0x00
    mov cx, 0x0002
    mov ax, 0x0200
    int 0x13

    jmp 0x8000          ; jump to kernel

times 510-($-$$) db 0  ; fill the rest of the sector with zeros
dw 0xAA55             ; add boot signature
