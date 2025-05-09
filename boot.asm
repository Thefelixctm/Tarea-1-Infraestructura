[BITS 16]
[ORG 0x7C00]

start:
    ; Configuración básica
    mov ax, 0x0003  ; Modo texto 80x25
    int 0x10
    
    ; Ocultar cursor
    mov ah, 0x01
    mov cx, 0x2607
    int 0x10

    ; ===== RECUADRO CON MENSAJE =====
    mov si, box_top
    call print_centered
    
    mov si, box_empty
    call print_centered
    
    mov si, box_text
    call print_centered
    
    mov si, box_empty
    call print_centered
    
    mov si, box_bottom
    call print_centered

    ; ===== LÍNEA VACÍA EXPLÍCITA =====
    mov si, empty_line  ; Esta línea solo contiene un espacio
    call print_centered

    ; ===== CORAZÓN ASCII =====
    mov si, heart_line1
    call print_centered
    mov si, heart_line2
    call print_centered
    mov si, heart_line3
    call print_centered
    mov si, heart_line4
    call print_centered
    mov si, heart_line5
    call print_centered
    mov si, heart_line6
    call print_centered
    mov si, heart_line7
    call print_centered
    mov si, heart_line8
    call print_centered

    ; Detener
    cli
    hlt

; ===== FUNCIONES =====
new_line:
    mov ah, 0x0E
    mov al, 0x0D  ; Retorno de carro
    int 0x10
    mov al, 0x0A  ; Salto de línea
    int 0x10
    ret

print_centered:
    ; Calcular longitud del string
    mov di, si
    xor cx, cx
.str_len:
    lodsb
    test al, al
    jz .got_len
    inc cx
    jmp .str_len
.got_len:
    mov si, di
    
    ; Posicionar cursor (centrado)
    mov ah, 0x02
    xor bh, bh
    mov dh, [current_row]
    mov dl, 40      ; Centro de 80 columnas
    sub dl, cl
    shr dl, 1       ; Dividir entre 2
    int 0x10
    
    ; Imprimir string
    mov ah, 0x0E
.print_char:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .print_char
.done:
    inc byte [current_row]
    ret

; ===== DATOS =====
current_row db 10   ; Fila inicial

; Recuadro perfectamente centrado
box_top     db '+---------------+', 0
box_empty   db '|               |', 0
box_text    db '| Estoy dentro! |', 0
box_bottom  db '+---------------+', 0

; Línea vacía explícita para separación
empty_line  db ' ', 0  ; Solo contiene un espacio

; Corazón ASCII exacto como lo pediste
heart_line1 db '  ***   ***  ', 0
heart_line2 db ' ***** ***** ', 0
heart_line3 db '***********', 0
heart_line4 db ' ********* ', 0
heart_line5 db '  *******  ', 0
heart_line6 db '   *****   ', 0
heart_line7 db '    ***    ', 0
heart_line8 db '     *     ', 0

; Relleno y firma de arranque
times 510-($-$$) db 0
dw 0xAA55