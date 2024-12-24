	.att_syntax
	.text
	.p2align	5
	.globl	_invaes_jazz
	.globl	invaes_jazz
	.globl	_aes_jazz
	.globl	aes_jazz
_invaes_jazz:
invaes_jazz:
	movq	%rsp, %rsi
	leaq	-16(%rsp), %rsp
	andq	$-16, %rsp
	vmovdqu	%xmm0, %xmm2
	vpxor	%xmm3, %xmm3, %xmm3
	vaeskeygenassist	$1, %xmm0, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm0, %xmm3, %xmm3
	vpxor	%xmm3, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm3, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm4, %xmm0, %xmm0
	aesimc	%xmm0, %xmm3
	vaeskeygenassist	$2, %xmm0, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm4, %xmm0, %xmm0
	aesimc	%xmm0, %xmm4
	vaeskeygenassist	$4, %xmm0, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm5, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm0
	aesimc	%xmm0, %xmm5
	vaeskeygenassist	$8, %xmm0, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm0
	aesimc	%xmm0, %xmm6
	vaeskeygenassist	$16, %xmm0, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm7, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vpxor	%xmm8, %xmm0, %xmm0
	aesimc	%xmm0, %xmm7
	vaeskeygenassist	$32, %xmm0, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vpxor	%xmm8, %xmm0, %xmm0
	aesimc	%xmm0, %xmm8
	vaeskeygenassist	$64, %xmm0, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm9, %xmm11
	vpxor	%xmm11, %xmm0, %xmm0
	vpxor	%xmm10, %xmm0, %xmm0
	aesimc	%xmm0, %xmm9
	vaeskeygenassist	$128, %xmm0, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm0, %xmm11, %xmm11
	vpxor	%xmm11, %xmm0, %xmm12
	vshufps	$140, %xmm12, %xmm11, %xmm0
	vpxor	%xmm0, %xmm12, %xmm11
	vpxor	%xmm10, %xmm11, %xmm12
	aesimc	%xmm12, %xmm10
	vaeskeygenassist	$27, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm0, %xmm0
	vpxor	%xmm0, %xmm12, %xmm12
	vshufps	$140, %xmm12, %xmm0, %xmm0
	vpxor	%xmm0, %xmm12, %xmm12
	vpxor	%xmm11, %xmm12, %xmm13
	aesimc	%xmm13, %xmm11
	vaeskeygenassist	$54, %xmm13, %xmm12
	vpshufd	$255, %xmm12, %xmm12
	vshufps	$16, %xmm13, %xmm0, %xmm0
	vpxor	%xmm0, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm0, %xmm0
	vpxor	%xmm0, %xmm13, %xmm0
	vpxor	%xmm12, %xmm0, %xmm0
	vmovdqu	%xmm0, (%rsp)
	vpxor	(%rsp), %xmm1, %xmm0
	aesdec	%xmm11, %xmm0
	aesdec	%xmm10, %xmm0
	aesdec	%xmm9, %xmm0
	aesdec	%xmm8, %xmm0
	aesdec	%xmm7, %xmm0
	aesdec	%xmm6, %xmm0
	aesdec	%xmm5, %xmm0
	aesdec	%xmm4, %xmm0
	aesdec	%xmm3, %xmm0
	aesdeclast	%xmm2, %xmm0
	movq	%rsi, %rsp
	ret
_aes_jazz:
aes_jazz:
	vmovdqu	%xmm0, %xmm2
	vpxor	%xmm3, %xmm3, %xmm3
	vaeskeygenassist	$1, %xmm0, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm0, %xmm3, %xmm3
	vpxor	%xmm3, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm3, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm4, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm3
	vaeskeygenassist	$2, %xmm0, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm4, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm4
	vaeskeygenassist	$4, %xmm0, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm0, %xmm5, %xmm5
	vpxor	%xmm5, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm5, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm5
	vaeskeygenassist	$8, %xmm0, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm6
	vaeskeygenassist	$16, %xmm0, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm0, %xmm7, %xmm7
	vpxor	%xmm7, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm7, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vpxor	%xmm8, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm7
	vaeskeygenassist	$32, %xmm0, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vpxor	%xmm8, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm8
	vaeskeygenassist	$64, %xmm0, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm0, %xmm9, %xmm9
	vpxor	%xmm9, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm9, %xmm11
	vpxor	%xmm11, %xmm0, %xmm0
	vpxor	%xmm10, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm9
	vaeskeygenassist	$128, %xmm0, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm0, %xmm11, %xmm11
	vpxor	%xmm11, %xmm0, %xmm12
	vshufps	$140, %xmm12, %xmm11, %xmm0
	vpxor	%xmm0, %xmm12, %xmm11
	vpxor	%xmm10, %xmm11, %xmm12
	vmovdqu	%xmm12, %xmm10
	vaeskeygenassist	$27, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm0, %xmm0
	vpxor	%xmm0, %xmm12, %xmm12
	vshufps	$140, %xmm12, %xmm0, %xmm0
	vpxor	%xmm0, %xmm12, %xmm12
	vpxor	%xmm11, %xmm12, %xmm13
	vmovdqu	%xmm13, %xmm11
	vaeskeygenassist	$54, %xmm13, %xmm12
	vpshufd	$255, %xmm12, %xmm12
	vshufps	$16, %xmm13, %xmm0, %xmm0
	vpxor	%xmm0, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm0, %xmm0
	vpxor	%xmm0, %xmm13, %xmm0
	vpxor	%xmm12, %xmm0, %xmm0
	vmovdqu	%xmm0, %xmm12
	vpxor	%xmm2, %xmm1, %xmm0
	aesenc	%xmm3, %xmm0
	aesenc	%xmm4, %xmm0
	aesenc	%xmm5, %xmm0
	aesenc	%xmm6, %xmm0
	aesenc	%xmm7, %xmm0
	aesenc	%xmm8, %xmm0
	aesenc	%xmm9, %xmm0
	aesenc	%xmm10, %xmm0
	aesenc	%xmm11, %xmm0
	aesenclast	%xmm12, %xmm0
	ret
