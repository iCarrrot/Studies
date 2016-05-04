	.globl app_sqrt 
	
	.text
app_sqrt: 	
	movsd %xmm0, %xmm3		
	movsd %xmm3, %xmm4		
loop:
	movsd %xmm0, %xmm2		
	divsd %xmm3, %xmm2		
	addsd %xmm2, %xmm4		
	mulsd half, %xmm4		
	ucomisd %xmm3, %xmm4		
	jae bigger
	movsd %xmm3, %xmm5		
	subsd %xmm4, %xmm5		
	jmp compare
bigger:
	movsd %xmm4, %xmm5		
	subsd %xmm3, %xmm5		
compare:
	ucomisd %xmm1, %xmm5		
	jb end
	movsd %xmm4, %xmm3		
	jmp loop
end:
	movsd %xmm3, %xmm0
	ret
	
.section .rodata
half: .double 0.5
