.model small
.stack 100h
.8086

.data
  searchWord db '*.*$', 0            ; search for all files
  dta db 128 dup(?) 13, 10, '$'      ; disk transfer area

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Set dos to disk transfer area adress
    lea dx, dta
    mov ah, 1Ah
    int 21h

    ; Search for all files
    lea dx, searchWord
    mov ah, 4Eh
    int 21h
    jc exit

print_file:
    ; Print the file name and get the next file
    lea si, dta+1Eh
    mov cx, 13
loop_file_null:
    lodsb
    or al, al
    jz exit_loop
    loop loop_file_null
exit_loop:
    ; add new line with termination
    mov byte ptr [si], 13
    mov byte ptr [si+1], 10
    mov byte ptr [si+2], '$'

    lea dx, dta+1Eh
    mov ah, 09h
    int 21h

    ; Search for the next file
    mov ah, 4Fh
    int 21h
    jnc print_file
    
exit:
    ; Exit to DOS
    mov ah, 4Ch
    mov al, 0
    int 21h
  
main endp
end main
