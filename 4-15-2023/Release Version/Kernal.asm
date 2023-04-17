BITS 32

global _start

_start:
    ; set up stack pointer
    mov esp, stack

    ; set up data segments
    mov eax, data
    mov ds, eax
    mov es, eax

    ; print message to console
    mov eax, message
    call print_string

    ; loop forever
    cli
.endloop:
    hlt
    jmp .endloop

print_string:
    push ebp
    mov ebp, esp
    push ebx

.loop:
    mov bl, [eax]
    cmp bl, 0
    je .done
    mov ah, 0x0e
    mov bh, 0x00
    mov al, bl
    int 0x10
    inc eax
    jmp .loop

.done:
    pop ebx
    mov esp, ebp
    pop ebp
    ret

section .data
message db 'Hello, world!', 0

section .bss
stack resb 4096
