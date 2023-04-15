section .text
global kmain

kmain:
    ; Set up stack pointer
    mov esp, stack

    ; Set up data segments
    mov eax, data
    mov ds, eax
    mov es, eax

    ; Set up video mode
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Print message to console
    mov eax, message
    call print_string

    ; Loop forever
    cli
.endloop:
    hlt
    jmp .endloop

print_string:
    push ebp
    mov ebp, esp
    push eax

.loop:
    mov al, [eax]
    cmp al, 0
    je .done
    mov ah, 0x0e
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    inc eax
    jmp .loop

.done:
    pop eax
    mov esp, ebp
    pop ebp
    ret

section .data
message db 'Hello, world!', 0

section .bss
stack resb 4096
