	.att_syntax
	.text
	.p2align	5
	.globl	_dec
	.globl	dec
	.globl	_enc
	.globl	enc
_dec:
dec:
	vmovdqu	%xmm0, %xmm3
	vpxor	%xmm4, %xmm4, %xmm4
	vaeskeygenassist	$1, %xmm0, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm0, %xmm4, %xmm4
	vpxor	%xmm4, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm4, %xmm4
	vpxor	%xmm4, %xmm0, %xmm0
	vpxor	%xmm5, %xmm0, %xmm5
	vmovdqu	%xmm5, %xmm0
	vaeskeygenassist	$2, %xmm5, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm5, %xmm4, %xmm4
	vpxor	%xmm4, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm4, %xmm7
	vpxor	%xmm7, %xmm5, %xmm4
	vpxor	%xmm6, %xmm4, %xmm5
	vmovdqu	%xmm5, %xmm4
	vaeskeygenassist	$4, %xmm5, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm5, %xmm7, %xmm7
	vpxor	%xmm7, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm7, %xmm7
	vpxor	%xmm7, %xmm5, %xmm5
	vpxor	%xmm6, %xmm5, %xmm6
	vmovdqu	%xmm6, %xmm5
	vaeskeygenassist	$8, %xmm6, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm6, %xmm7, %xmm7
	vpxor	%xmm7, %xmm6, %xmm6
	vshufps	$140, %xmm6, %xmm7, %xmm7
	vpxor	%xmm7, %xmm6, %xmm6
	vpxor	%xmm8, %xmm6, %xmm8
	vmovdqu	%xmm8, %xmm6
	vaeskeygenassist	$16, %xmm8, %xmm9
	vpshufd	$255, %xmm9, %xmm9
	vshufps	$16, %xmm8, %xmm7, %xmm7
	vpxor	%xmm7, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm7, %xmm10
	vpxor	%xmm10, %xmm8, %xmm7
	vpxor	%xmm9, %xmm7, %xmm8
	vmovdqu	%xmm8, %xmm7
	vaeskeygenassist	$32, %xmm8, %xmm9
	vpshufd	$255, %xmm9, %xmm9
	vshufps	$16, %xmm8, %xmm10, %xmm10
	vpxor	%xmm10, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm10, %xmm10
	vpxor	%xmm10, %xmm8, %xmm8
	vpxor	%xmm9, %xmm8, %xmm9
	vmovdqu	%xmm9, %xmm8
	vaeskeygenassist	$64, %xmm9, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm9, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vshufps	$140, %xmm9, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vpxor	%xmm11, %xmm9, %xmm12
	vmovdqu	%xmm12, %xmm9
	vaeskeygenassist	$128, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm10, %xmm10
	vpxor	%xmm10, %xmm12, %xmm13
	vshufps	$140, %xmm13, %xmm10, %xmm12
	vpxor	%xmm12, %xmm13, %xmm10
	vpxor	%xmm11, %xmm10, %xmm13
	vmovdqu	%xmm13, %xmm10
	vaeskeygenassist	$27, %xmm13, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm13, %xmm12, %xmm12
	vpxor	%xmm12, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm12, %xmm12
	vpxor	%xmm12, %xmm13, %xmm13
	vpxor	%xmm11, %xmm13, %xmm11
	vmovdqu	%xmm11, %xmm13
	vaeskeygenassist	$54, %xmm11, %xmm14
	vpshufd	$255, %xmm14, %xmm14
	vshufps	$16, %xmm11, %xmm12, %xmm12
	vpxor	%xmm12, %xmm11, %xmm11
	vshufps	$140, %xmm11, %xmm12, %xmm12
	vpxor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm14, %xmm11, %xmm11
	vpxor	%xmm3, %xmm1, %xmm1
	aesenc	%xmm0, %xmm1
	aesenc	%xmm4, %xmm1
	aesenc	%xmm5, %xmm1
	aesenc	%xmm6, %xmm1
	aesenc	%xmm7, %xmm1
	aesenc	%xmm8, %xmm1
	aesenc	%xmm9, %xmm1
	aesenc	%xmm10, %xmm1
	aesenc	%xmm13, %xmm1
	aesenclast	%xmm11, %xmm1
	vpxor	%xmm2, %xmm1, %xmm0
	ret
_enc:
enc:
	vmovdqu	%xmm0, %xmm3
	vpxor	%xmm4, %xmm4, %xmm4
	vaeskeygenassist	$1, %xmm0, %xmm5
	vpshufd	$255, %xmm5, %xmm5
	vshufps	$16, %xmm0, %xmm4, %xmm4
	vpxor	%xmm4, %xmm0, %xmm0
	vshufps	$140, %xmm0, %xmm4, %xmm4
	vpxor	%xmm4, %xmm0, %xmm0
	vpxor	%xmm5, %xmm0, %xmm5
	vmovdqu	%xmm5, %xmm0
	vaeskeygenassist	$2, %xmm5, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm5, %xmm4, %xmm4
	vpxor	%xmm4, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm4, %xmm7
	vpxor	%xmm7, %xmm5, %xmm4
	vpxor	%xmm6, %xmm4, %xmm5
	vmovdqu	%xmm5, %xmm4
	vaeskeygenassist	$4, %xmm5, %xmm6
	vpshufd	$255, %xmm6, %xmm6
	vshufps	$16, %xmm5, %xmm7, %xmm7
	vpxor	%xmm7, %xmm5, %xmm5
	vshufps	$140, %xmm5, %xmm7, %xmm7
	vpxor	%xmm7, %xmm5, %xmm5
	vpxor	%xmm6, %xmm5, %xmm6
	vmovdqu	%xmm6, %xmm5
	vaeskeygenassist	$8, %xmm6, %xmm8
	vpshufd	$255, %xmm8, %xmm8
	vshufps	$16, %xmm6, %xmm7, %xmm7
	vpxor	%xmm7, %xmm6, %xmm6
	vshufps	$140, %xmm6, %xmm7, %xmm7
	vpxor	%xmm7, %xmm6, %xmm6
	vpxor	%xmm8, %xmm6, %xmm8
	vmovdqu	%xmm8, %xmm6
	vaeskeygenassist	$16, %xmm8, %xmm9
	vpshufd	$255, %xmm9, %xmm9
	vshufps	$16, %xmm8, %xmm7, %xmm7
	vpxor	%xmm7, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm7, %xmm10
	vpxor	%xmm10, %xmm8, %xmm7
	vpxor	%xmm9, %xmm7, %xmm8
	vmovdqu	%xmm8, %xmm7
	vaeskeygenassist	$32, %xmm8, %xmm9
	vpshufd	$255, %xmm9, %xmm9
	vshufps	$16, %xmm8, %xmm10, %xmm10
	vpxor	%xmm10, %xmm8, %xmm8
	vshufps	$140, %xmm8, %xmm10, %xmm10
	vpxor	%xmm10, %xmm8, %xmm8
	vpxor	%xmm9, %xmm8, %xmm9
	vmovdqu	%xmm9, %xmm8
	vaeskeygenassist	$64, %xmm9, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm9, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vshufps	$140, %xmm9, %xmm10, %xmm10
	vpxor	%xmm10, %xmm9, %xmm9
	vpxor	%xmm11, %xmm9, %xmm12
	vmovdqu	%xmm12, %xmm9
	vaeskeygenassist	$128, %xmm12, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm12, %xmm10, %xmm10
	vpxor	%xmm10, %xmm12, %xmm13
	vshufps	$140, %xmm13, %xmm10, %xmm12
	vpxor	%xmm12, %xmm13, %xmm10
	vpxor	%xmm11, %xmm10, %xmm13
	vmovdqu	%xmm13, %xmm10
	vaeskeygenassist	$27, %xmm13, %xmm11
	vpshufd	$255, %xmm11, %xmm11
	vshufps	$16, %xmm13, %xmm12, %xmm12
	vpxor	%xmm12, %xmm13, %xmm13
	vshufps	$140, %xmm13, %xmm12, %xmm12
	vpxor	%xmm12, %xmm13, %xmm13
	vpxor	%xmm11, %xmm13, %xmm11
	vmovdqu	%xmm11, %xmm13
	vaeskeygenassist	$54, %xmm11, %xmm14
	vpshufd	$255, %xmm14, %xmm14
	vshufps	$16, %xmm11, %xmm12, %xmm12
	vpxor	%xmm12, %xmm11, %xmm11
	vshufps	$140, %xmm11, %xmm12, %xmm12
	vpxor	%xmm12, %xmm11, %xmm11
	vpxor	%xmm14, %xmm11, %xmm11
	vpxor	%xmm3, %xmm1, %xmm1
	aesenc	%xmm0, %xmm1
	aesenc	%xmm4, %xmm1
	aesenc	%xmm5, %xmm1
	aesenc	%xmm6, %xmm1
	aesenc	%xmm7, %xmm1
	aesenc	%xmm8, %xmm1
	aesenc	%xmm9, %xmm1
	aesenc	%xmm10, %xmm1
	aesenc	%xmm13, %xmm1
	aesenclast	%xmm11, %xmm1
	vpxor	%xmm2, %xmm1, %xmm0
	ret
