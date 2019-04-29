mov ax, 0x0000
mov ss, ax
mov sp, 0xffff
mov bp, 0xffff
mov ax, 0x0000

jmp near Code

PrintfStr:
push ds
push es
push ax
push di
push si

mov ds, word[ss:bp-2]
mov si, word[ss:bp-4]
mov ax, 0xb800
mov es, ax
mov di, word[ds:DisPlayIndex]

PrintLoop
mov al, byte[ds:si]
cmp al, 0
jz near PrintEnd
mov byte[es:di], al
inc di
mov byte[es:di], 0x07
inc di
inc si
jmp near PrintLoop



PrintEnd:
mov word[ds:DisPlayIndex], di
pop si	;大量的清理是为了别的程序使用寄存器的时候，因为有值污染了人家的代码
pop di
pop ax
pop es
pop ds
retf



ret 

Str1:
db '1234567890', 0x00 	;定一个边界，是一种协议，一种标志。这样在内存中就有一个边界。

DisPlayIndex:
dw 0x0000					;打印起始位置


Code:
push 0x07c0 ;只记录了段地址与偏移地址，下一行是偏移地址，只要能找到就行。不必记录全
push Str1
call 0x07c0:PrintfStr ;这里面动了内存栈里面，在之前的基础上加了一点东西
add sp, 4 


End:
jmp near End

times 510-($-$$) db 0x00
dw 0xAA55























