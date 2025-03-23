.section .data
    // allocating buffer of size 256 bytes
    buffer:
        .fill 256, 1, 0
    
    newline:
        .asciz "\n"
    
    filename:
        .asciz "test.txt"
    
    message:
        .asciz "Bello!"
    
    content_read_buffer:
        .fill 100, 1, 0

.section .text
    .global _start

_start:
    // get current working directory
    ldr x0, =buffer
    mov x1, #256
    mov x8, #17
    svc #0
    
    // print the directory
    mov x0, #1
    ldr x1, =buffer
    mov x2, #256
    mov x8, #64
    svc #0
    
    // newline print
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0
    
    // open a file for writing
    ldr x0, =filename
    mov x1, #0102
    mov x2, #0666
    mov x8, #56
    svc #0
    mov x19, x0
    
    // write to the file
    mov x0, x19
    ldr x1, =message
    mov x2, #6
    mov x8, #64
    svc #0
    
    // close the file
    mov x0, x19
    mov x8, #57
    svc #0
    
    // open the file for reading
    ldr x0, =filename
    mov x1, #0
    mov x8, #56
    svc #0
    mov x19, x0
    
    // read from the file
    mov x0, x19
    ldr x1, =content_read_buffer
    mov x2, #100
    mov x8, #63
    svc #0
    mov x20, x0
    
    // print the read content
    mov x0, #1
    ldr x1, =content_read_buffer
    mov x2, x20
    mov x8, #64
    svc #0
    
    // close the file
    mov x0, x19
    mov x8, #57
    svc #0
    
    // change file permissions
    ldr x0, =filename
    mov x1, #0755               // rwxr-xr-x
    mov x8, #52
    svc #0
    
    // exit with code 1
    mov x0, #1
    mov x8, #93
    svc #0
    