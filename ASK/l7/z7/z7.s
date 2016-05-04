	.comm buffer, 4048, 32
	
	.global main
	.type main, @function
	.text
char:
	movq %rax, %rdx				
	movl $buffer, %edi
	movl $0x81, %eax	
	movb (%rdi), %cl 		
	cmpb $0, %cl 			
	je write
loop:
	cmpb $91, %cl
	jl	duza
	cmpb $97, %cl
	jl powrot
	cmpb $123, %cl
	jl mala
	jmp powrot
	
mala:
	subb $32, %cl
	
powrot:
	movb %cl, (%rdi)		
	incq %rdi 				
	movb (%rdi), %cl 		
	cmpb $0, %cl 			
	jne loop
	jmp write

duza:
	cmpb $64, %cl
	jl powrot
	addb $32, %cl
	jmp powrot
write:
	movq $1, %rax
	movq %rax, %rdi
	movl $buffer, %esi
	syscall	
	retq
main:
	movq $0, %rdi				#0 w %rax przy syscall to read, 1 to write
	movq %rdi, %rax	
	movl $buffer, %esi
	movq $4048, %rdx
	syscall
	cmpq $0, %rax
	jne char
	retq 
