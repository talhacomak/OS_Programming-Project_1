segment .bss
size1 resd 1
size2 resd 1
n resd 1
str1 resd 1
str2 resd 1
set1 resb 1000000
set2 resb 1000000

segment .data
i dd 0
j dd 0
k dd 0
inters dd 0

segment .text
global n_gram
extern is_equal


n_gram:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]  ; location of str1
    mov dword [str1], eax
    mov eax, [ebp+12]
    mov [size1], eax
    mov eax, [ebp+16]  ; location of str2
    mov dword [str2], eax
    mov eax, [ebp+20]
    mov [size2], eax
    mov ecx, [ebp+24]
    mov [n], ecx
    sub [size1], ecx
    inc dword [size1]
    sub [size2], ecx
    inc dword [size2]
    push ebx
    
    mov dword [i], 0        ;element
floop1:
    mov eax, [i]
    cmp eax, [size1]
    jnl part2
    mov dword [j], 0        ;c
floop2: 
    mov eax, [j]  
    cmp eax, [n]
    jnl fnext
    mov eax, [i]
    mul dword [n]
    add eax, [j]
    
    mov ecx, [str1]
    add ecx, [i]
    add ecx, [j]
    mov edx, [ecx]
    mov [set1 + eax], edx
    inc dword [j]
    jmp floop2

fnext:
    mov dword [k], 0    ;old_element
floop2_2:
    mov eax, [k]  
    cmp eax, [i]
    jnl finci

    push dword [n]
    push dword [k]
    push set1
    push dword [i]
    push set1
    call is_equal
    add esp, 20
    cmp eax, 1
    jne finck
    dec dword [i]
    dec dword [size1]
    jmp finci

finck:
    inc dword [k]
    jmp floop2_2

finci:
    inc dword [i]
    jmp floop1

    ;-------------PART2----------------
part2:
    mov dword [i], 0        ;element
loop1:
    mov eax, [i]
    cmp eax, [size2]
    jnl go
    mov dword [j], 0        ;c
loop2: 
    mov eax, [j]  
    cmp eax, [n]
    jnl next
    mov eax, [i]
    mul dword [n]
    add eax, [j]
    
    mov ecx, [str2]
    add ecx, [i]
    add ecx, [j]
    mov edx, [ecx]
    mov [set2 + eax], edx
    inc dword [j]
    jmp loop2

next:
    mov dword [k], 0    ;old_element
loop2_2:
    mov eax, [k]  
    cmp eax, [i]
    jnl inci

    push dword [n]
    push dword [k]
    push set2
    push dword [i]
    push set2
    call is_equal
    add esp, 20
    cmp eax, 1
    jne inck
    dec dword [i]
    dec dword [size2]
    jmp inci

inck:
    inc dword [k]
    jmp loop2_2

inci:
    inc dword [i]
    jmp loop1

go:
    mov dword [inters], 0
    mov dword [i], 0
loop3_1:
    mov eax, [i]
    cmp eax, [size1]
    jnl go2
    
    mov dword [j], 0
loop3_2:
    mov eax, [j]
    cmp eax, [size2]
    jnl inci2

    push dword [n]
    push dword [j]
    push set2
    push dword [i]
    push set1
    call is_equal
    add esp, 20
    cmp eax, 1
    jne next2
    inc dword [inters]
next2:
    inc dword [j]
    jmp loop3_2
inci2:
    inc dword [i]
    jmp loop3_1

go2:
    
    mov ecx, 0
    add ecx, [size2]
    add ecx, [size1]
    sub ecx, [inters]
    mov eax, 100
    mul dword [inters]
    div ecx
    
    pop ebx
    
    mov esp, ebp
    pop ebp
    
    ret
