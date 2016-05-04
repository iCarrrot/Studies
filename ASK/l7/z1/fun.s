
	.text
	.global fun
	.type fun, @function
fun:
	cmp	$0, %rdi
	je		End
	cmp	$0xffffffffffffffff, %rdi
	je		End2
	mov	$32,	%r10
	mov	$32,	%r9
	xor	%rsi,	%rsi
Loop1:
	sar	%r10
	mov	%rdi,	%r14
	mov	%r9b,	%cl
	sar	%cl,	%r14
	cmp	$0,	%r14
	jne	Else
	mov	$64,	%rax
	sub	%r9,	%rax
	sub	%r10,	%r9
	jmp	Loop2
Else:
	add	%r10,	%r9
Loop2:
	add	$1,	%rsi
	cmp	$7,	%rsi
	jl Loop1
	ret
End:	
	mov $64, %rax
	ret
End2:
	mov $0,	%rax
	ret

