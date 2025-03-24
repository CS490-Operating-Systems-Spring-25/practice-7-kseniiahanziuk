.section .data
    prompt:
        .asciz "Enter color codes (max 16): "
    
    input_buffer:
        .fill 20, 1, 0
    
    // ANSI color escape sequences
    black:
        .asciz "\033[40m "
    red:
        .asciz "\033[41m "
    green:
        .asciz "\033[42m "
    blue:
        .asciz "\033[44m "
    yellow:
        .asciz "\033[43m "
    white:
        .asciz "\033[47m "
    cyan:
        .asciz "\033[46m "
    magenta:
        .asciz "\033[45m "
    
    reset:
        .asciz "\033[0m"
    
    newline:
        .asciz "\n"

.section .text
    .global _start

_start:
    // prompt
    mov x0, #1
    ldr x1, =prompt
    mov x2, #26
    mov x8, #64
    svc #0

    // read input
    mov x0, #0
    ldr x1, =input_buffer
    mov x2, #17
    mov x8, #63
    svc #0
    
    // save the number of read bytes
    mov x19, x0
    
    // initialize loop
    mov x20, #0
    
process_next_char:
    cmp x20, x19
    bge exit_program
    
    // load current char
    ldr x21, =input_buffer
    add x21, x21, x20
    ldrb w22, [x21]
    
    // check for \n
    cmp w22, #10
    beq exit_program
    
    // process based on inputted char
    cmp w22, #'B'
    beq print_black
    cmp w22, #'r'
    beq print_red
    cmp w22, #'g'
    beq print_green
    cmp w22, #'b'
    beq print_blue
    cmp w22, #'y'
    beq print_yellow
    cmp w22, #'w'
    beq print_white
    cmp w22, #'c'
    beq print_cyan
    cmp w22, #'m'
    beq print_magenta
    b skip_char
    
print_black:
    mov x0, #1
    ldr x1, =black
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_red:
    mov x0, #1
    ldr x1, =red
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_green:
    mov x0, #1
    ldr x1, =green
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_blue:
    mov x0, #1
    ldr x1, =blue
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_yellow:
    mov x0, #1
    ldr x1, =yellow
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_white:
    mov x0, #1
    ldr x1, =white
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_cyan:
    mov x0, #1
    ldr x1, =cyan
    mov x2, #6
    mov x8, #64
    svc #0
    b skip_char
    
print_magenta:
    mov x0, #1
    ldr x1, =magenta
    mov x2, #6
    mov x8, #64
    svc #0
    
skip_char:
    // move to next char
    add x20, x20, #1
    b process_next_char
    
exit_program:
    // reset colors in terminal
    mov x0, #1
    ldr x1, =reset
    mov x2, #4
    mov x8, #64
    svc #0
    
    // newline
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    // exit
    mov x0, #0
    mov x8, #93
    svc #0
