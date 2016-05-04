
	.text
	.global nww_nwd
	.type nww_nwd, @function
nww_nwd:
	mov %rdi,	%r8
	mov %rsi,	%r9
	cmp %r9,	%r8
	je	Fin
Begin:
	cmp %r8,	%r9
	jge .Else
	sub %r9,	%r8
	jmp .AfterElse
.Else:
	sub %r8,	%r9
.AfterElse:
	cmp %r9,	%r8
	jne Begin
Fin:
	mov	%rsi,	%rax
	xor	%rdx,	%rdx
	div	%r8
	mul	%rdi
	mov	%r8,	%rdx
	ret
.size nww_nwd, .-nww_nwd

