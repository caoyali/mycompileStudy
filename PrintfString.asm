mov ax, 0x0000
mov ss, ax
mov sp, 0xffff
mov bp, 0xffff
mov ax, 0x0000

jmp near Code

PrintfStr:
ret 

Str1:
db '1234567890'

Code:
push 0x07c0 ;只记录了段地址与偏移地址，下一行是偏移地址，只要能找到就行。不必记录全
push Str1
call 0x07c0:PrintfStr
add sp, 4 


End:
jmp near End

times 510-($-$$) db 0x00
dw 0xAA55
