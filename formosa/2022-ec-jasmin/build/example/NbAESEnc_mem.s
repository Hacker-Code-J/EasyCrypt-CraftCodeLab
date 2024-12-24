	.att_syntax
	.text
	.p2align	5
	.globl	_dec
	.globl	dec
	.globl	_enc
	.globl	enc
_dec:
dec:
	vmovdqu	(%rsi), %xmm2
	vmovdqu	(%rdx), %xmm0
	vmovdqu	%xmm2, %xmm1
	vpxor	%xmm3, %xmm3, %xmm3
	vaeskeygenassist	$1, %xmm2, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm2, %xmm3, %xmm3
	vpxor	%xmm3, %xmm2, %xmm2
	vshufps	$140, %xmm2, %xmm3, %xmm3
	vpxor	%xmm3, %xmm2, %xmm2
	vpxor	%xmm4, %xmm2, %xmm4
	vmovdqu	%xmm4, %xmm2
	vaeskeygenassist	$2, %xmm4, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm4, %xmm3, %xmm3
	vpxor	%xmm3, %xmm4, %xmm4
	vshufps	$140, %xmm4, %xmm3, %xmm6
	vpxor	%xmm6, %xmm4, %xmm3
	vpxor	%xmm5, %xmm3, %xmm4
	vmovdqu	%xmm4, %xmm3
	vaeskeygenassist	$4, %xmm4, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm4, %xmm6, %xmm6
	vpxor	%xmm6, %xmm4, %xmm4
	vshufps	$140, %xmm4, %xmm6, %xmm6
	vpxor	%xmm6, %xmm4, %xmm4
	vpxor	%xmm5, %xmm4, %xmm5
	vmovdqu	%xmm5, %xmm4
	vaeskeygenassist	$8, %xmm5, %xmm7
	vpshufd	$255, %xmm7, %xmm7
	vshufps	$16, %xmm5, %xmm6, %xmm6
	vpxor	%xmm6, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm6, %xmm6
	vpxor	%xmm6, %xmm5, %xmm5
	vpxor	%xmm7, %xmm5, %xmm7
	vmovdqu	%xmm7, %xmm5
	vaeskeygenassist	$16, %xmm7, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm7, %xmm6, %xmm6
	vpxor	%xmm6, %xmm7, %xmm7
	vshufps	$140, %xmm7, %xmm6, %xmm9
	vpxor	%xmm9, %xmm7, %xmm6
	vpxor	%xmm8, %xmm6, %xmm7
	vmovdqu	%xmm7, %xmm6
	vaeskeygenassist	$32, %xmm7, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm7, %xmm9, %xmm9
	vpxor	%xmm9, %xmm7, %xmm7
	vshufps	$140, %xmm7, %xmm9, %xmm9
	vpxor	%xmm9, %xmm7, %xmm7
	vpxor	%xmm8, %xmm7, %xmm8
	vmovdqu	%xmm8, %xmm7
	vaeskeygenassist	$64, %xmm8, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm8, %xmm9, %xmm9
	vpxor	%xmm9, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm9, %xmm9
	vpxor	%xmm9, %xmm8, %xmm8
	vpxor	%xmm10, %xmm8, %xmm10
	vmovdqu	%xmm10, %xmm8
	vaeskeygenassist	$128, %xmm10, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm10, %xmm9, %xmm9
	vpxor	%xmm9, %xmm10, %xmm10
	vshufps	$140, %xmm10, %xmm9, %xmm9
	vpxor	%xmm9, %xmm10, %xmm10
	vpxor	%xmm11, %xmm10, %xmm12
	vmovdqu	%xmm12, %xmm10
	vaeskeygenassist	$27, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm9, %xmm9
	vpxor	%xmm9, %xmm12, %xmm12
	vshufps	$140, %xmm12, %xmm9, %xmm9
	vpxor	%xmm9, %xmm12, %xmm12
	vpxor	%xmm11, %xmm12, %xmm13
	vmovdqu	%xmm13, %xmm11
	vaeskeygenassist	$54, %xmm13, %xmm12
	vpshufd	$255, %xmm12, %xmm12
	vshufps	$16, %xmm13, %xmm9, %xmm9
	vpxor	%xmm9, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm9, %xmm9
	vpxor	%xmm9, %xmm13, %xmm9
	vpxor	%xmm12, %xmm9, %xmm9
	vpxor	%xmm1, %xmm0, %xmm0
	aesenc	%xmm2, %xmm0
	aesenc	%xmm3, %xmm0
	aesenc	%xmm4, %xmm0
	aesenc	%xmm5, %xmm0
	aesenc	%xmm6, %xmm0
	aesenc	%xmm7, %xmm0
	aesenc	%xmm8, %xmm0
	aesenc	%xmm10, %xmm0
	aesenc	%xmm11, %xmm0
	aesenclast	%xmm9, %xmm0
	vmovdqu	(%rcx), %xmm1
	vpxor	%xmm1, %xmm0, %xmm0
	vmovdqu	%xmm0, (%rdi)
	ret
_enc:
enc:
	vmovdqu	(%rsi), %xmm2
	vmovdqu	(%rdx), %xmm0
	vmovdqu	%xmm2, %xmm1
	vpxor	%xmm3, %xmm3, %xmm3
	vaeskeygenassist	$1, %xmm2, %xmm4
	vpshufd	$255, %xmm4, %xmm4
	vshufps	$16, %xmm2, %xmm3, %xmm3
	vpxor	%xmm3, %xmm2, %xmm2
	vshufps	$140, %xmm2, %xmm3, %xmm3
	vpxor	%xmm3, %xmm2, %xmm2
	vpxor	%xmm4, %xmm2, %xmm4
	vmovdqu	%xmm4, %xmm2
	vaeskeygenassist	$2, %xmm4, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm4, %xmm3, %xmm3
	vpxor	%xmm3, %xmm4, %xmm4
	vshufps	$140, %xmm4, %xmm3, %xmm6
	vpxor	%xmm6, %xmm4, %xmm3
	vpxor	%xmm5, %xmm3, %xmm4
	vmovdqu	%xmm4, %xmm3
	vaeskeygenassist	$4, %xmm4, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm4, %xmm6, %xmm6
	vpxor	%xmm6, %xmm4, %xmm4
	vshufps	$140, %xmm4, %xmm6, %xmm6
	vpxor	%xmm6, %xmm4, %xmm4
	vpxor	%xmm5, %xmm4, %xmm5
	vmovdqu	%xmm5, %xmm4
	vaeskeygenassist	$8, %xmm5, %xmm7
	vpshufd	$255, %xmm7, %xmm7
	vshufps	$16, %xmm5, %xmm6, %xmm6
	vpxor	%xmm6, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm6, %xmm6
	vpxor	%xmm6, %xmm5, %xmm5
	vpxor	%xmm7, %xmm5, %xmm7
	vmovdqu	%xmm7, %xmm5
	vaeskeygenassist	$16, %xmm7, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm7, %xmm6, %xmm6
	vpxor	%xmm6, %xmm7, %xmm7
	vshufps	$140, %xmm7, %xmm6, %xmm9
	vpxor	%xmm9, %xmm7, %xmm6
	vpxor	%xmm8, %xmm6, %xmm7
	vmovdqu	%xmm7, %xmm6
	vaeskeygenassist	$32, %xmm7, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm7, %xmm9, %xmm9
	vpxor	%xmm9, %xmm7, %xmm7
	vshufps	$140, %xmm7, %xmm9, %xmm9
	vpxor	%xmm9, %xmm7, %xmm7
	vpxor	%xmm8, %xmm7, %xmm8
	vmovdqu	%xmm8, %xmm7
	vaeskeygenassist	$64, %xmm8, %xmm10
	vpshufd	$255, %xmm10, %xmm10
	vshufps	$16, %xmm8, %xmm9, %xmm9
	vpxor	%xmm9, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm9, %xmm9
	vpxor	%xmm9, %xmm8, %xmm8
	vpxor	%xmm10, %xmm8, %xmm10
	vmovdqu	%xmm10, %xmm8
	vaeskeygenassist	$128, %xmm10, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm10, %xmm9, %xmm9
	vpxor	%xmm9, %xmm10, %xmm10
	vshufps	$140, %xmm10, %xmm9, %xmm9
	vpxor	%xmm9, %xmm10, %xmm10
	vpxor	%xmm11, %xmm10, %xmm12
	vmovdqu	%xmm12, %xmm10
	vaeskeygenassist	$27, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm9, %xmm9
	vpxor	%xmm9, %xmm12, %xmm12
	vshufps	$140, %xmm12, %xmm9, %xmm9
	vpxor	%xmm9, %xmm12, %xmm12
	vpxor	%xmm11, %xmm12, %xmm13
	vmovdqu	%xmm13, %xmm11
	vaeskeygenassist	$54, %xmm13, %xmm12
	vpshufd	$255, %xmm12, %xmm12
	vshufps	$16, %xmm13, %xmm9, %xmm9
	vpxor	%xmm9, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm9, %xmm9
	vpxor	%xmm9, %xmm13, %xmm9
	vpxor	%xmm12, %xmm9, %xmm9
	vpxor	%xmm1, %xmm0, %xmm0
	aesenc	%xmm2, %xmm0
	aesenc	%xmm3, %xmm0
	aesenc	%xmm4, %xmm0
	aesenc	%xmm5, %xmm0
	aesenc	%xmm6, %xmm0
	aesenc	%xmm7, %xmm0
	aesenc	%xmm8, %xmm0
	aesenc	%xmm10, %xmm0
	aesenc	%xmm11, %xmm0
	aesenclast	%xmm9, %xmm0
	vmovdqu	(%rcx), %xmm1
	vpxor	%xmm1, %xmm0, %xmm0
	vmovdqu	%xmm0, (%rdi)
	ret
