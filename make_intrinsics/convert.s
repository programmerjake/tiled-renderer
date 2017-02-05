	.text
	.file	"convert.cpp"
	.globl	convert_float_float_2
	.align	16, 0x90
	.type	convert_float_float_2,@function
convert_float_float_2:                  # @convert_float_float_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end0:
	.size	convert_float_float_2, .Lfunc_end0-convert_float_float_2
	.cfi_endproc

	.globl	convert_float_float_4
	.align	16, 0x90
	.type	convert_float_float_4,@function
convert_float_float_4:                  # @convert_float_float_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end1:
	.size	convert_float_float_4, .Lfunc_end1-convert_float_float_4
	.cfi_endproc

	.globl	convert_float_float_8
	.align	16, 0x90
	.type	convert_float_float_8,@function
convert_float_float_8:                  # @convert_float_float_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end2:
	.size	convert_float_float_8, .Lfunc_end2-convert_float_float_8
	.cfi_endproc

	.globl	convert_float_float_16
	.align	16, 0x90
	.type	convert_float_float_16,@function
convert_float_float_16:                 # @convert_float_float_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end3:
	.size	convert_float_float_16, .Lfunc_end3-convert_float_float_16
	.cfi_endproc

	.globl	convert_double_float_2
	.align	16, 0x90
	.type	convert_double_float_2,@function
convert_double_float_2:                 # @convert_double_float_2
	.cfi_startproc
# BB#0:
	cvtpd2ps	(%rsi), %xmm0
	movlpd	%xmm0, (%rdi)
	retq
.Lfunc_end4:
	.size	convert_double_float_2, .Lfunc_end4-convert_double_float_2
	.cfi_endproc

	.globl	convert_double_float_4
	.align	16, 0x90
	.type	convert_double_float_4,@function
convert_double_float_4:                 # @convert_double_float_4
	.cfi_startproc
# BB#0:
	cvtpd2ps	16(%rsi), %xmm0
	cvtpd2ps	(%rsi), %xmm1
	unpcklpd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movapd	%xmm1, (%rdi)
	retq
.Lfunc_end5:
	.size	convert_double_float_4, .Lfunc_end5-convert_double_float_4
	.cfi_endproc

	.globl	convert_double_float_8
	.align	16, 0x90
	.type	convert_double_float_8,@function
convert_double_float_8:                 # @convert_double_float_8
	.cfi_startproc
# BB#0:
	cvtpd2ps	16(%rsi), %xmm0
	cvtpd2ps	(%rsi), %xmm1
	unpcklpd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	cvtpd2ps	48(%rsi), %xmm0
	cvtpd2ps	32(%rsi), %xmm2
	unpcklpd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movapd	%xmm2, 16(%rdi)
	movapd	%xmm1, (%rdi)
	retq
.Lfunc_end6:
	.size	convert_double_float_8, .Lfunc_end6-convert_double_float_8
	.cfi_endproc

	.globl	convert_double_float_16
	.align	16, 0x90
	.type	convert_double_float_16,@function
convert_double_float_16:                # @convert_double_float_16
	.cfi_startproc
# BB#0:
	cvtpd2ps	16(%rsi), %xmm0
	cvtpd2ps	(%rsi), %xmm1
	unpcklpd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	cvtpd2ps	48(%rsi), %xmm0
	cvtpd2ps	32(%rsi), %xmm2
	unpcklpd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	cvtpd2ps	80(%rsi), %xmm0
	cvtpd2ps	64(%rsi), %xmm3
	unpcklpd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	cvtpd2ps	112(%rsi), %xmm0
	cvtpd2ps	96(%rsi), %xmm4
	unpcklpd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movapd	%xmm4, 48(%rdi)
	movapd	%xmm3, 32(%rdi)
	movapd	%xmm2, 16(%rdi)
	movapd	%xmm1, (%rdi)
	retq
.Lfunc_end7:
	.size	convert_double_float_16, .Lfunc_end7-convert_double_float_16
	.cfi_endproc

	.globl	convert_uint8_t_float_2
	.align	16, 0x90
	.type	convert_uint8_t_float_2,@function
convert_uint8_t_float_2:                # @convert_uint8_t_float_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2ps	%xmm0, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end8:
	.size	convert_uint8_t_float_2, .Lfunc_end8-convert_uint8_t_float_2
	.cfi_endproc

	.globl	convert_uint8_t_float_4
	.align	16, 0x90
	.type	convert_uint8_t_float_4,@function
convert_uint8_t_float_4:                # @convert_uint8_t_float_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end9:
	.size	convert_uint8_t_float_4, .Lfunc_end9-convert_uint8_t_float_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI10_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_float_8
	.align	16, 0x90
	.type	convert_uint8_t_float_8,@function
convert_uint8_t_float_8:                # @convert_uint8_t_float_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movdqa	.LCPI10_0(%rip), %xmm2  # xmm2 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	pand	%xmm2, %xmm1
	cvtdq2ps	%xmm1, %xmm1
	punpckhwd	%xmm0, %xmm0    # xmm0 = xmm0[4,4,5,5,6,6,7,7]
	pand	%xmm2, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, 16(%rdi)
	movaps	%xmm1, (%rdi)
	retq
.Lfunc_end10:
	.size	convert_uint8_t_float_8, .Lfunc_end10-convert_uint8_t_float_8
	.cfi_endproc

	.globl	convert_uint8_t_float_16
	.align	16, 0x90
	.type	convert_uint8_t_float_16,@function
convert_uint8_t_float_16:               # @convert_uint8_t_float_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	cvtdq2ps	%xmm3, %xmm3
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	cvtdq2ps	%xmm2, %xmm2
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm4
	punpcklwd	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3]
	cvtdq2ps	%xmm4, %xmm4
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, 48(%rdi)
	movaps	%xmm4, 32(%rdi)
	movaps	%xmm2, 16(%rdi)
	movaps	%xmm3, (%rdi)
	retq
.Lfunc_end11:
	.size	convert_uint8_t_float_16, .Lfunc_end11-convert_uint8_t_float_16
	.cfi_endproc

	.globl	convert_uint16_t_float_2
	.align	16, 0x90
	.type	convert_uint16_t_float_2,@function
convert_uint16_t_float_2:               # @convert_uint16_t_float_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2ps	%xmm0, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end12:
	.size	convert_uint16_t_float_2, .Lfunc_end12-convert_uint16_t_float_2
	.cfi_endproc

	.globl	convert_uint16_t_float_4
	.align	16, 0x90
	.type	convert_uint16_t_float_4,@function
convert_uint16_t_float_4:               # @convert_uint16_t_float_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end13:
	.size	convert_uint16_t_float_4, .Lfunc_end13-convert_uint16_t_float_4
	.cfi_endproc

	.globl	convert_uint16_t_float_8
	.align	16, 0x90
	.type	convert_uint16_t_float_8,@function
convert_uint16_t_float_8:               # @convert_uint16_t_float_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	cvtdq2ps	%xmm2, %xmm2
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, 16(%rdi)
	movaps	%xmm2, (%rdi)
	retq
.Lfunc_end14:
	.size	convert_uint16_t_float_8, .Lfunc_end14-convert_uint16_t_float_8
	.cfi_endproc

	.globl	convert_uint16_t_float_16
	.align	16, 0x90
	.type	convert_uint16_t_float_16,@function
convert_uint16_t_float_16:              # @convert_uint16_t_float_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	cvtdq2ps	%xmm3, %xmm3
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	cvtdq2ps	%xmm0, %xmm0
	movdqa	%xmm1, %xmm4
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	cvtdq2ps	%xmm4, %xmm4
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	cvtdq2ps	%xmm1, %xmm1
	movaps	%xmm1, 48(%rdi)
	movaps	%xmm4, 32(%rdi)
	movaps	%xmm0, 16(%rdi)
	movaps	%xmm3, (%rdi)
	retq
.Lfunc_end15:
	.size	convert_uint16_t_float_16, .Lfunc_end15-convert_uint16_t_float_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI16_0:
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
.LCPI16_1:
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
.LCPI16_2:
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
.LCPI16_3:
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.text
	.globl	convert_uint32_t_float_2
	.align	16, 0x90
	.type	convert_uint32_t_float_2,@function
convert_uint32_t_float_2:               # @convert_uint32_t_float_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	movdqa	.LCPI16_0(%rip), %xmm1  # xmm1 = [65535,65535,65535,65535]
	pand	%xmm0, %xmm1
	por	.LCPI16_1(%rip), %xmm1
	psrld	$16, %xmm0
	por	.LCPI16_2(%rip), %xmm0
	addps	.LCPI16_3(%rip), %xmm0
	addps	%xmm1, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end16:
	.size	convert_uint32_t_float_2, .Lfunc_end16-convert_uint32_t_float_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI17_0:
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
.LCPI17_1:
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
.LCPI17_2:
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
.LCPI17_3:
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.text
	.globl	convert_uint32_t_float_4
	.align	16, 0x90
	.type	convert_uint32_t_float_4,@function
convert_uint32_t_float_4:               # @convert_uint32_t_float_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	.LCPI17_0(%rip), %xmm1  # xmm1 = [65535,65535,65535,65535]
	pand	%xmm0, %xmm1
	por	.LCPI17_1(%rip), %xmm1
	psrld	$16, %xmm0
	por	.LCPI17_2(%rip), %xmm0
	addps	.LCPI17_3(%rip), %xmm0
	addps	%xmm1, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end17:
	.size	convert_uint32_t_float_4, .Lfunc_end17-convert_uint32_t_float_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI18_0:
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
.LCPI18_1:
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
.LCPI18_2:
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
.LCPI18_3:
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.text
	.globl	convert_uint32_t_float_8
	.align	16, 0x90
	.type	convert_uint32_t_float_8,@function
convert_uint32_t_float_8:               # @convert_uint32_t_float_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	.LCPI18_0(%rip), %xmm2  # xmm2 = [65535,65535,65535,65535]
	movdqa	%xmm0, %xmm3
	pand	%xmm2, %xmm3
	movdqa	.LCPI18_1(%rip), %xmm4  # xmm4 = [1258291200,1258291200,1258291200,1258291200]
	por	%xmm4, %xmm3
	psrld	$16, %xmm0
	movdqa	.LCPI18_2(%rip), %xmm5  # xmm5 = [1392508928,1392508928,1392508928,1392508928]
	por	%xmm5, %xmm0
	movaps	.LCPI18_3(%rip), %xmm6  # xmm6 = [-5.497642e+11,-5.497642e+11,-5.497642e+11,-5.497642e+11]
	addps	%xmm6, %xmm0
	addps	%xmm3, %xmm0
	pand	%xmm1, %xmm2
	por	%xmm4, %xmm2
	psrld	$16, %xmm1
	por	%xmm5, %xmm1
	addps	%xmm6, %xmm1
	addps	%xmm2, %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end18:
	.size	convert_uint32_t_float_8, .Lfunc_end18-convert_uint32_t_float_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI19_0:
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
.LCPI19_1:
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
	.long	1258291200              # 0x4b000000
.LCPI19_2:
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
	.long	1392508928              # 0x53000000
.LCPI19_3:
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.long	3539992704              # float -5.49764202E+11
	.text
	.globl	convert_uint32_t_float_16
	.align	16, 0x90
	.type	convert_uint32_t_float_16,@function
convert_uint32_t_float_16:              # @convert_uint32_t_float_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm5
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	movdqa	.LCPI19_0(%rip), %xmm4  # xmm4 = [65535,65535,65535,65535]
	movdqa	%xmm5, %xmm0
	pand	%xmm4, %xmm0
	movdqa	.LCPI19_1(%rip), %xmm8  # xmm8 = [1258291200,1258291200,1258291200,1258291200]
	por	%xmm8, %xmm0
	psrld	$16, %xmm5
	movdqa	.LCPI19_2(%rip), %xmm6  # xmm6 = [1392508928,1392508928,1392508928,1392508928]
	por	%xmm6, %xmm5
	movaps	.LCPI19_3(%rip), %xmm7  # xmm7 = [-5.497642e+11,-5.497642e+11,-5.497642e+11,-5.497642e+11]
	addps	%xmm7, %xmm5
	addps	%xmm0, %xmm5
	movdqa	%xmm1, %xmm0
	pand	%xmm4, %xmm0
	por	%xmm8, %xmm0
	psrld	$16, %xmm1
	por	%xmm6, %xmm1
	addps	%xmm7, %xmm1
	addps	%xmm0, %xmm1
	movdqa	%xmm2, %xmm0
	pand	%xmm4, %xmm0
	por	%xmm8, %xmm0
	psrld	$16, %xmm2
	por	%xmm6, %xmm2
	addps	%xmm7, %xmm2
	addps	%xmm0, %xmm2
	pand	%xmm3, %xmm4
	por	%xmm8, %xmm4
	psrld	$16, %xmm3
	por	%xmm6, %xmm3
	addps	%xmm7, %xmm3
	addps	%xmm4, %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm5, (%rdi)
	retq
.Lfunc_end19:
	.size	convert_uint32_t_float_16, .Lfunc_end19-convert_uint32_t_float_16
	.cfi_endproc

	.globl	convert_uint64_t_float_2
	.align	16, 0x90
	.type	convert_uint64_t_float_2,@function
convert_uint64_t_float_2:               # @convert_uint64_t_float_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm1
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB20_1
# BB#2:
	cvtsi2ssq	%rax, %xmm0
	jmp	.LBB20_3
.LBB20_1:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm0
	addss	%xmm0, %xmm0
.LBB20_3:
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB20_4
# BB#5:
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	jmp	.LBB20_6
.LBB20_4:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rcx, %xmm1
	addss	%xmm1, %xmm1
.LBB20_6:
	unpcklps	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end20:
	.size	convert_uint64_t_float_2, .Lfunc_end20-convert_uint64_t_float_2
	.cfi_endproc

	.globl	convert_uint64_t_float_4
	.align	16, 0x90
	.type	convert_uint64_t_float_4,@function
convert_uint64_t_float_4:               # @convert_uint64_t_float_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm3
	movd	%xmm3, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB21_1
# BB#2:
	cvtsi2ssq	%rax, %xmm2
	jmp	.LBB21_3
.LBB21_1:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm2
	addss	%xmm2, %xmm2
.LBB21_3:
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB21_4
# BB#5:
	cvtsi2ssq	%rax, %xmm1
	jmp	.LBB21_6
.LBB21_4:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm1
	addss	%xmm1, %xmm1
.LBB21_6:
	pshufd	$78, %xmm3, %xmm3       # xmm3 = xmm3[2,3,0,1]
	movd	%xmm3, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB21_7
# BB#8:
	xorps	%xmm3, %xmm3
	cvtsi2ssq	%rax, %xmm3
	jmp	.LBB21_9
.LBB21_7:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm3, %xmm3
	cvtsi2ssq	%rcx, %xmm3
	addss	%xmm3, %xmm3
.LBB21_9:
	unpcklps	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB21_10
# BB#11:
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.LBB21_12
.LBB21_10:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rcx, %xmm0
	addss	%xmm0, %xmm0
.LBB21_12:
	unpcklps	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
	unpcklps	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movaps	%xmm1, (%rdi)
	retq
.Lfunc_end21:
	.size	convert_uint64_t_float_4, .Lfunc_end21-convert_uint64_t_float_4
	.cfi_endproc

	.globl	convert_uint64_t_float_8
	.align	16, 0x90
	.type	convert_uint64_t_float_8,@function
convert_uint64_t_float_8:               # @convert_uint64_t_float_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm5
	movdqa	32(%rsi), %xmm0
	movdqa	48(%rsi), %xmm2
	movd	%xmm5, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_1
# BB#2:
	cvtsi2ssq	%rax, %xmm3
	jmp	.LBB22_3
.LBB22_1:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm3
	addss	%xmm3, %xmm3
.LBB22_3:
	movd	%xmm4, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_4
# BB#5:
	cvtsi2ssq	%rax, %xmm1
	jmp	.LBB22_6
.LBB22_4:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm1
	addss	%xmm1, %xmm1
.LBB22_6:
	pshufd	$78, %xmm5, %xmm5       # xmm5 = xmm5[2,3,0,1]
	movd	%xmm5, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_7
# BB#8:
	xorps	%xmm5, %xmm5
	cvtsi2ssq	%rax, %xmm5
	jmp	.LBB22_9
.LBB22_7:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm5, %xmm5
	cvtsi2ssq	%rcx, %xmm5
	addss	%xmm5, %xmm5
.LBB22_9:
	pshufd	$78, %xmm4, %xmm4       # xmm4 = xmm4[2,3,0,1]
	movd	%xmm4, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_10
# BB#11:
	xorps	%xmm4, %xmm4
	cvtsi2ssq	%rax, %xmm4
	jmp	.LBB22_12
.LBB22_10:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm4, %xmm4
	cvtsi2ssq	%rcx, %xmm4
	addss	%xmm4, %xmm4
.LBB22_12:
	movd	%xmm2, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_13
# BB#14:
	cvtsi2ssq	%rax, %xmm7
	jmp	.LBB22_15
.LBB22_13:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm7
	addss	%xmm7, %xmm7
.LBB22_15:
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_16
# BB#17:
	cvtsi2ssq	%rax, %xmm6
	jmp	.LBB22_18
.LBB22_16:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm6
	addss	%xmm6, %xmm6
.LBB22_18:
	unpcklps	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	unpcklps	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
	pshufd	$78, %xmm2, %xmm2       # xmm2 = xmm2[2,3,0,1]
	movd	%xmm2, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_19
# BB#20:
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	jmp	.LBB22_21
.LBB22_19:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rcx, %xmm2
	addss	%xmm2, %xmm2
.LBB22_21:
	unpcklps	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
	unpcklps	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB22_22
# BB#23:
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.LBB22_24
.LBB22_22:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rcx, %xmm0
	addss	%xmm0, %xmm0
.LBB22_24:
	unpcklps	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	unpcklps	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0],xmm6[1],xmm0[1]
	movaps	%xmm6, 16(%rdi)
	movaps	%xmm1, (%rdi)
	retq
.Lfunc_end22:
	.size	convert_uint64_t_float_8, .Lfunc_end22-convert_uint64_t_float_8
	.cfi_endproc

	.globl	convert_uint64_t_float_16
	.align	16, 0x90
	.type	convert_uint64_t_float_16,@function
convert_uint64_t_float_16:              # @convert_uint64_t_float_16
	.cfi_startproc
# BB#0:
	movdqa	96(%rsi), %xmm4
	movdqa	112(%rsi), %xmm2
	movdqa	64(%rsi), %xmm12
	movdqa	80(%rsi), %xmm13
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm6
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_1
# BB#2:
	cvtsi2ssq	%rax, %xmm5
	jmp	.LBB23_3
.LBB23_1:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm5
	addss	%xmm5, %xmm5
.LBB23_3:
	movaps	%xmm5, -24(%rsp)        # 16-byte Spill
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_4
# BB#5:
	cvtsi2ssq	%rax, %xmm9
	jmp	.LBB23_6
.LBB23_4:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm9
	addss	%xmm9, %xmm9
.LBB23_6:
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_7
# BB#8:
	cvtsi2ssq	%rax, %xmm11
	jmp	.LBB23_9
.LBB23_7:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm11
	addss	%xmm11, %xmm11
.LBB23_9:
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_10
# BB#11:
	cvtsi2ssq	%rax, %xmm8
	jmp	.LBB23_12
.LBB23_10:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm8
	addss	%xmm8, %xmm8
.LBB23_12:
	movd	%xmm6, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_13
# BB#14:
	cvtsi2ssq	%rax, %xmm14
	jmp	.LBB23_15
.LBB23_13:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm14
	addss	%xmm14, %xmm14
.LBB23_15:
	movd	%xmm3, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_16
# BB#17:
	cvtsi2ssq	%rax, %xmm5
	jmp	.LBB23_18
.LBB23_16:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm5
	addss	%xmm5, %xmm5
.LBB23_18:
	pshufd	$78, %xmm6, %xmm0       # xmm0 = xmm6[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_19
# BB#20:
	cvtsi2ssq	%rax, %xmm15
	jmp	.LBB23_21
.LBB23_19:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm15
	addss	%xmm15, %xmm15
.LBB23_21:
	pshufd	$78, %xmm3, %xmm0       # xmm0 = xmm3[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_22
# BB#23:
	cvtsi2ssq	%rax, %xmm3
	jmp	.LBB23_24
.LBB23_22:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm3
	addss	%xmm3, %xmm3
.LBB23_24:
	movd	%xmm13, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_25
# BB#26:
	cvtsi2ssq	%rax, %xmm10
	jmp	.LBB23_27
.LBB23_25:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm10
	addss	%xmm10, %xmm10
.LBB23_27:
	movd	%xmm12, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_28
# BB#29:
	cvtsi2ssq	%rax, %xmm7
	jmp	.LBB23_30
.LBB23_28:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm7
	addss	%xmm7, %xmm7
.LBB23_30:
	pshufd	$78, %xmm13, %xmm1      # xmm1 = xmm13[2,3,0,1]
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_31
# BB#32:
	cvtsi2ssq	%rax, %xmm6
	jmp	.LBB23_33
.LBB23_31:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm6
	addss	%xmm6, %xmm6
.LBB23_33:
	movdqa	%xmm2, %xmm0
	pshufd	$78, %xmm12, %xmm1      # xmm1 = xmm12[2,3,0,1]
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_34
# BB#35:
	cvtsi2ssq	%rax, %xmm2
	jmp	.LBB23_36
.LBB23_34:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm2
	addss	%xmm2, %xmm2
.LBB23_36:
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_37
# BB#38:
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	jmp	.LBB23_39
.LBB23_37:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rcx, %xmm1
	addss	%xmm1, %xmm1
.LBB23_39:
	movd	%xmm4, %rax
	movdqa	%xmm4, %xmm12
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_40
# BB#41:
	cvtsi2ssq	%rax, %xmm4
	jmp	.LBB23_42
.LBB23_40:
	shrq	%rax
	orq	%rax, %rcx
	cvtsi2ssq	%rcx, %xmm4
	addss	%xmm4, %xmm4
.LBB23_42:
	unpcklps	-24(%rsp), %xmm9 # 16-byte Folded Reload
                                        # xmm9 = xmm9[0],mem[0],xmm9[1],mem[1]
	unpcklps	%xmm11, %xmm8   # xmm8 = xmm8[0],xmm11[0],xmm8[1],xmm11[1]
	unpcklps	%xmm14, %xmm5   # xmm5 = xmm5[0],xmm14[0],xmm5[1],xmm14[1]
	unpcklps	%xmm15, %xmm3   # xmm3 = xmm3[0],xmm15[0],xmm3[1],xmm15[1]
	unpcklps	%xmm10, %xmm7   # xmm7 = xmm7[0],xmm10[0],xmm7[1],xmm10[1]
	unpcklps	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1]
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_43
# BB#44:
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.LBB23_45
.LBB23_43:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rcx, %xmm0
	addss	%xmm0, %xmm0
.LBB23_45:
	unpcklps	%xmm8, %xmm9    # xmm9 = xmm9[0],xmm8[0],xmm9[1],xmm8[1]
	unpcklps	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
	unpcklps	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	unpcklps	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	pshufd	$78, %xmm12, %xmm1      # xmm1 = xmm12[2,3,0,1]
	movd	%xmm1, %rax
	movl	%eax, %ecx
	andl	$1, %ecx
	testq	%rax, %rax
	js	.LBB23_46
# BB#47:
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	jmp	.LBB23_48
.LBB23_46:
	shrq	%rax
	orq	%rax, %rcx
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rcx, %xmm1
	addss	%xmm1, %xmm1
.LBB23_48:
	unpcklps	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	unpcklps	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	movaps	%xmm4, 48(%rdi)
	movaps	%xmm7, 32(%rdi)
	movaps	%xmm5, 16(%rdi)
	movaps	%xmm9, (%rdi)
	retq
.Lfunc_end23:
	.size	convert_uint64_t_float_16, .Lfunc_end23-convert_uint64_t_float_16
	.cfi_endproc

	.globl	convert_int8_t_float_2
	.align	16, 0x90
	.type	convert_int8_t_float_2,@function
convert_int8_t_float_2:                 # @convert_int8_t_float_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end24:
	.size	convert_int8_t_float_2, .Lfunc_end24-convert_int8_t_float_2
	.cfi_endproc

	.globl	convert_int8_t_float_4
	.align	16, 0x90
	.type	convert_int8_t_float_4,@function
convert_int8_t_float_4:                 # @convert_int8_t_float_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end25:
	.size	convert_int8_t_float_4, .Lfunc_end25-convert_int8_t_float_4
	.cfi_endproc

	.globl	convert_int8_t_float_8
	.align	16, 0x90
	.type	convert_int8_t_float_8,@function
convert_int8_t_float_8:                 # @convert_int8_t_float_8
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	cvtdq2ps	%xmm1, %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end26:
	.size	convert_int8_t_float_8, .Lfunc_end26-convert_int8_t_float_8
	.cfi_endproc

	.globl	convert_int8_t_float_16
	.align	16, 0x90
	.type	convert_int8_t_float_16,@function
convert_int8_t_float_16:                # @convert_int8_t_float_16
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	cvtdq2ps	%xmm1, %xmm1
	movd	8(%rsi), %xmm2          # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm2
	cvtdq2ps	%xmm2, %xmm2
	movd	12(%rsi), %xmm3         # xmm3 = mem[0],zero,zero,zero
	punpcklbw	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm3
	cvtdq2ps	%xmm3, %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end27:
	.size	convert_int8_t_float_16, .Lfunc_end27-convert_int8_t_float_16
	.cfi_endproc

	.globl	convert_int16_t_float_2
	.align	16, 0x90
	.type	convert_int16_t_float_2,@function
convert_int16_t_float_2:                # @convert_int16_t_float_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end28:
	.size	convert_int16_t_float_2, .Lfunc_end28-convert_int16_t_float_2
	.cfi_endproc

	.globl	convert_int16_t_float_4
	.align	16, 0x90
	.type	convert_int16_t_float_4,@function
convert_int16_t_float_4:                # @convert_int16_t_float_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end29:
	.size	convert_int16_t_float_4, .Lfunc_end29-convert_int16_t_float_4
	.cfi_endproc

	.globl	convert_int16_t_float_8
	.align	16, 0x90
	.type	convert_int16_t_float_8,@function
convert_int16_t_float_8:                # @convert_int16_t_float_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	cvtdq2ps	%xmm1, %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end30:
	.size	convert_int16_t_float_8, .Lfunc_end30-convert_int16_t_float_8
	.cfi_endproc

	.globl	convert_int16_t_float_16
	.align	16, 0x90
	.type	convert_int16_t_float_16,@function
convert_int16_t_float_16:               # @convert_int16_t_float_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	cvtdq2ps	%xmm0, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	cvtdq2ps	%xmm1, %xmm1
	movq	16(%rsi), %xmm2         # xmm2 = mem[0],zero
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm2
	cvtdq2ps	%xmm2, %xmm2
	movq	24(%rsi), %xmm3         # xmm3 = mem[0],zero
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm3
	cvtdq2ps	%xmm3, %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end31:
	.size	convert_int16_t_float_16, .Lfunc_end31-convert_int16_t_float_16
	.cfi_endproc

	.globl	convert_int32_t_float_2
	.align	16, 0x90
	.type	convert_int32_t_float_2,@function
convert_int32_t_float_2:                # @convert_int32_t_float_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	cvtdq2ps	%xmm0, %xmm0
	movlps	%xmm0, (%rdi)
	retq
.Lfunc_end32:
	.size	convert_int32_t_float_2, .Lfunc_end32-convert_int32_t_float_2
	.cfi_endproc

	.globl	convert_int32_t_float_4
	.align	16, 0x90
	.type	convert_int32_t_float_4,@function
convert_int32_t_float_4:                # @convert_int32_t_float_4
	.cfi_startproc
# BB#0:
	cvtdq2ps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end33:
	.size	convert_int32_t_float_4, .Lfunc_end33-convert_int32_t_float_4
	.cfi_endproc

	.globl	convert_int32_t_float_8
	.align	16, 0x90
	.type	convert_int32_t_float_8,@function
convert_int32_t_float_8:                # @convert_int32_t_float_8
	.cfi_startproc
# BB#0:
	cvtdq2ps	16(%rsi), %xmm0
	cvtdq2ps	(%rsi), %xmm1
	movaps	%xmm1, (%rdi)
	movaps	%xmm0, 16(%rdi)
	retq
.Lfunc_end34:
	.size	convert_int32_t_float_8, .Lfunc_end34-convert_int32_t_float_8
	.cfi_endproc

	.globl	convert_int32_t_float_16
	.align	16, 0x90
	.type	convert_int32_t_float_16,@function
convert_int32_t_float_16:               # @convert_int32_t_float_16
	.cfi_startproc
# BB#0:
	cvtdq2ps	32(%rsi), %xmm0
	cvtdq2ps	(%rsi), %xmm1
	cvtdq2ps	16(%rsi), %xmm2
	cvtdq2ps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 16(%rdi)
	movaps	%xmm1, (%rdi)
	movaps	%xmm0, 32(%rdi)
	retq
.Lfunc_end35:
	.size	convert_int32_t_float_16, .Lfunc_end35-convert_int32_t_float_16
	.cfi_endproc

	.globl	convert_int64_t_float_2
	.align	16, 0x90
	.type	convert_int64_t_float_2,@function
convert_int64_t_float_2:                # @convert_int64_t_float_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movd	%xmm0, %rax
	cvtsi2ssq	%rax, %xmm1
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	unpcklps	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movlps	%xmm1, (%rdi)
	retq
.Lfunc_end36:
	.size	convert_int64_t_float_2, .Lfunc_end36-convert_int64_t_float_2
	.cfi_endproc

	.globl	convert_int64_t_float_4
	.align	16, 0x90
	.type	convert_int64_t_float_4,@function
convert_int64_t_float_4:                # @convert_int64_t_float_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movd	%xmm1, %rax
	cvtsi2ssq	%rax, %xmm2
	movd	%xmm0, %rax
	cvtsi2ssq	%rax, %xmm3
	unpcklps	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	unpcklps	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	unpcklps	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1]
	movaps	%xmm3, (%rdi)
	retq
.Lfunc_end37:
	.size	convert_int64_t_float_4, .Lfunc_end37-convert_int64_t_float_4
	.cfi_endproc

	.globl	convert_int64_t_float_8
	.align	16, 0x90
	.type	convert_int64_t_float_8,@function
convert_int64_t_float_8:                # @convert_int64_t_float_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	movd	%xmm1, %rax
	cvtsi2ssq	%rax, %xmm4
	movd	%xmm0, %rax
	cvtsi2ssq	%rax, %xmm5
	unpcklps	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	unpcklps	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	unpcklps	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0],xmm5[1],xmm0[1]
	movd	%xmm3, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movd	%xmm2, %rax
	xorps	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	unpcklps	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	pshufd	$78, %xmm3, %xmm0       # xmm0 = xmm3[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	pshufd	$78, %xmm2, %xmm2       # xmm2 = xmm2[2,3,0,1]
	movd	%xmm2, %rax
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	unpcklps	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	unpcklps	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm5, (%rdi)
	retq
.Lfunc_end38:
	.size	convert_int64_t_float_8, .Lfunc_end38-convert_int64_t_float_8
	.cfi_endproc

	.globl	convert_int64_t_float_16
	.align	16, 0x90
	.type	convert_int64_t_float_16,@function
convert_int64_t_float_16:               # @convert_int64_t_float_16
	.cfi_startproc
# BB#0:
	movdqa	96(%rsi), %xmm8
	movdqa	112(%rsi), %xmm9
	movdqa	64(%rsi), %xmm3
	movdqa	80(%rsi), %xmm5
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm6
	movdqa	32(%rsi), %xmm7
	movdqa	48(%rsi), %xmm0
	movd	%xmm6, %rax
	cvtsi2ssq	%rax, %xmm2
	movd	%xmm4, %rax
	cvtsi2ssq	%rax, %xmm1
	unpcklps	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	pshufd	$78, %xmm6, %xmm2       # xmm2 = xmm6[2,3,0,1]
	movd	%xmm2, %rax
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	pshufd	$78, %xmm4, %xmm4       # xmm4 = xmm4[2,3,0,1]
	movd	%xmm4, %rax
	xorps	%xmm4, %xmm4
	cvtsi2ssq	%rax, %xmm4
	unpcklps	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	unpcklps	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
	movd	%xmm0, %rax
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	movd	%xmm7, %rax
	xorps	%xmm4, %xmm4
	cvtsi2ssq	%rax, %xmm4
	unpcklps	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	pshufd	$78, %xmm7, %xmm2       # xmm2 = xmm7[2,3,0,1]
	movd	%xmm2, %rax
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	unpcklps	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	unpcklps	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	movd	%xmm5, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movd	%xmm3, %rax
	xorps	%xmm2, %xmm2
	cvtsi2ssq	%rax, %xmm2
	unpcklps	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	pshufd	$78, %xmm3, %xmm3       # xmm3 = xmm3[2,3,0,1]
	movd	%xmm3, %rax
	xorps	%xmm3, %xmm3
	cvtsi2ssq	%rax, %xmm3
	unpcklps	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1]
	unpcklps	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
	movd	%xmm9, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	movd	%xmm8, %rax
	xorps	%xmm3, %xmm3
	cvtsi2ssq	%rax, %xmm3
	unpcklps	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1]
	pshufd	$78, %xmm9, %xmm0       # xmm0 = xmm9[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	pshufd	$78, %xmm8, %xmm5       # xmm5 = xmm8[2,3,0,1]
	movd	%xmm5, %rax
	xorps	%xmm5, %xmm5
	cvtsi2ssq	%rax, %xmm5
	unpcklps	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0],xmm5[1],xmm0[1]
	unpcklps	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0],xmm3[1],xmm5[1]
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm4, 16(%rdi)
	movaps	%xmm1, (%rdi)
	retq
.Lfunc_end39:
	.size	convert_int64_t_float_16, .Lfunc_end39-convert_int64_t_float_16
	.cfi_endproc

	.globl	convert_float_double_2
	.align	16, 0x90
	.type	convert_float_double_2,@function
convert_float_double_2:                 # @convert_float_double_2
	.cfi_startproc
# BB#0:
	cvtps2pd	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end40:
	.size	convert_float_double_2, .Lfunc_end40-convert_float_double_2
	.cfi_endproc

	.globl	convert_float_double_4
	.align	16, 0x90
	.type	convert_float_double_4,@function
convert_float_double_4:                 # @convert_float_double_4
	.cfi_startproc
# BB#0:
	cvtps2pd	(%rsi), %xmm0
	cvtps2pd	8(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end41:
	.size	convert_float_double_4, .Lfunc_end41-convert_float_double_4
	.cfi_endproc

	.globl	convert_float_double_8
	.align	16, 0x90
	.type	convert_float_double_8,@function
convert_float_double_8:                 # @convert_float_double_8
	.cfi_startproc
# BB#0:
	cvtps2pd	(%rsi), %xmm0
	cvtps2pd	8(%rsi), %xmm1
	cvtps2pd	16(%rsi), %xmm2
	cvtps2pd	24(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end42:
	.size	convert_float_double_8, .Lfunc_end42-convert_float_double_8
	.cfi_endproc

	.globl	convert_float_double_16
	.align	16, 0x90
	.type	convert_float_double_16,@function
convert_float_double_16:                # @convert_float_double_16
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	movapd	32(%rsi), %xmm2
	movapd	48(%rsi), %xmm3
	cvtps2pd	%xmm0, %xmm4
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvtps2pd	%xmm0, %xmm0
	cvtps2pd	%xmm1, %xmm5
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvtps2pd	%xmm1, %xmm1
	cvtps2pd	%xmm2, %xmm6
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvtps2pd	%xmm2, %xmm2
	cvtps2pd	%xmm3, %xmm7
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvtps2pd	%xmm3, %xmm3
	movaps	%xmm7, 96(%rdi)
	movaps	%xmm6, 64(%rdi)
	movaps	%xmm5, 32(%rdi)
	movaps	%xmm4, (%rdi)
	movaps	%xmm3, 112(%rdi)
	movaps	%xmm2, 80(%rdi)
	movaps	%xmm1, 48(%rdi)
	movaps	%xmm0, 16(%rdi)
	retq
.Lfunc_end43:
	.size	convert_float_double_16, .Lfunc_end43-convert_float_double_16
	.cfi_endproc

	.globl	convert_double_double_2
	.align	16, 0x90
	.type	convert_double_double_2,@function
convert_double_double_2:                # @convert_double_double_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end44:
	.size	convert_double_double_2, .Lfunc_end44-convert_double_double_2
	.cfi_endproc

	.globl	convert_double_double_4
	.align	16, 0x90
	.type	convert_double_double_4,@function
convert_double_double_4:                # @convert_double_double_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end45:
	.size	convert_double_double_4, .Lfunc_end45-convert_double_double_4
	.cfi_endproc

	.globl	convert_double_double_8
	.align	16, 0x90
	.type	convert_double_double_8,@function
convert_double_double_8:                # @convert_double_double_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end46:
	.size	convert_double_double_8, .Lfunc_end46-convert_double_double_8
	.cfi_endproc

	.globl	convert_double_double_16
	.align	16, 0x90
	.type	convert_double_double_16,@function
convert_double_double_16:               # @convert_double_double_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end47:
	.size	convert_double_double_16, .Lfunc_end47-convert_double_double_16
	.cfi_endproc

	.globl	convert_uint8_t_double_2
	.align	16, 0x90
	.type	convert_uint8_t_double_2,@function
convert_uint8_t_double_2:               # @convert_uint8_t_double_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end48:
	.size	convert_uint8_t_double_2, .Lfunc_end48-convert_uint8_t_double_2
	.cfi_endproc

	.globl	convert_uint8_t_double_4
	.align	16, 0x90
	.type	convert_uint8_t_double_4,@function
convert_uint8_t_double_4:               # @convert_uint8_t_double_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end49:
	.size	convert_uint8_t_double_4, .Lfunc_end49-convert_uint8_t_double_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI50_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_double_8
	.align	16, 0x90
	.type	convert_uint8_t_double_8,@function
convert_uint8_t_double_8:               # @convert_uint8_t_double_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movdqa	.LCPI50_0(%rip), %xmm2  # xmm2 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	punpckhwd	%xmm0, %xmm0    # xmm0 = xmm0[4,4,5,5,6,6,7,7]
	pand	%xmm2, %xmm0
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, 32(%rdi)
	movaps	%xmm1, (%rdi)
	movaps	%xmm2, 48(%rdi)
	movaps	%xmm3, 16(%rdi)
	retq
.Lfunc_end50:
	.size	convert_uint8_t_double_8, .Lfunc_end50-convert_uint8_t_double_8
	.cfi_endproc

	.globl	convert_uint8_t_double_16
	.align	16, 0x90
	.type	convert_uint8_t_double_16,@function
convert_uint8_t_double_16:              # @convert_uint8_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	pshufd	$78, %xmm3, %xmm4       # xmm4 = xmm3[2,3,0,1]
	cvtdq2pd	%xmm4, %xmm4
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	pshufd	$78, %xmm2, %xmm5       # xmm5 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm5, %xmm5
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm6
	punpcklwd	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0],xmm6[1],xmm1[1],xmm6[2],xmm1[2],xmm6[3],xmm1[3]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	cvtdq2pd	%xmm7, %xmm7
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm3, %xmm3
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm6, %xmm6
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, 96(%rdi)
	movaps	%xmm6, 64(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm3, (%rdi)
	movaps	%xmm1, 112(%rdi)
	movaps	%xmm7, 80(%rdi)
	movaps	%xmm5, 48(%rdi)
	movaps	%xmm4, 16(%rdi)
	retq
.Lfunc_end51:
	.size	convert_uint8_t_double_16, .Lfunc_end51-convert_uint8_t_double_16
	.cfi_endproc

	.globl	convert_uint16_t_double_2
	.align	16, 0x90
	.type	convert_uint16_t_double_2,@function
convert_uint16_t_double_2:              # @convert_uint16_t_double_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end52:
	.size	convert_uint16_t_double_2, .Lfunc_end52-convert_uint16_t_double_2
	.cfi_endproc

	.globl	convert_uint16_t_double_4
	.align	16, 0x90
	.type	convert_uint16_t_double_4,@function
convert_uint16_t_double_4:              # @convert_uint16_t_double_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end53:
	.size	convert_uint16_t_double_4, .Lfunc_end53-convert_uint16_t_double_4
	.cfi_endproc

	.globl	convert_uint16_t_double_8
	.align	16, 0x90
	.type	convert_uint16_t_double_8,@function
convert_uint16_t_double_8:              # @convert_uint16_t_double_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	pshufd	$78, %xmm2, %xmm3       # xmm3 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, 32(%rdi)
	movaps	%xmm2, (%rdi)
	movaps	%xmm1, 48(%rdi)
	movaps	%xmm3, 16(%rdi)
	retq
.Lfunc_end54:
	.size	convert_uint16_t_double_8, .Lfunc_end54-convert_uint16_t_double_8
	.cfi_endproc

	.globl	convert_uint16_t_double_16
	.align	16, 0x90
	.type	convert_uint16_t_double_16,@function
convert_uint16_t_double_16:             # @convert_uint16_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	pshufd	$78, %xmm3, %xmm4       # xmm4 = xmm3[2,3,0,1]
	cvtdq2pd	%xmm4, %xmm4
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	pshufd	$78, %xmm0, %xmm5       # xmm5 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm5, %xmm5
	movdqa	%xmm1, %xmm6
	punpcklwd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	cvtdq2pd	%xmm7, %xmm7
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	pshufd	$78, %xmm1, %xmm2       # xmm2 = xmm1[2,3,0,1]
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm3, %xmm3
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm6, %xmm6
	cvtdq2pd	%xmm1, %xmm1
	movaps	%xmm1, 96(%rdi)
	movaps	%xmm6, 64(%rdi)
	movaps	%xmm0, 32(%rdi)
	movaps	%xmm3, (%rdi)
	movaps	%xmm2, 112(%rdi)
	movaps	%xmm7, 80(%rdi)
	movaps	%xmm5, 48(%rdi)
	movaps	%xmm4, 16(%rdi)
	retq
.Lfunc_end55:
	.size	convert_uint16_t_double_16, .Lfunc_end55-convert_uint16_t_double_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI56_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI56_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint32_t_double_2
	.align	16, 0x90
	.type	convert_uint32_t_double_2,@function
convert_uint32_t_double_2:              # @convert_uint32_t_double_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	.LCPI56_0(%rip), %xmm1  # xmm1 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movapd	.LCPI56_1(%rip), %xmm3  # xmm3 = [4.503600e+15,1.934281e+25]
	subpd	%xmm3, %xmm0
	pshufd	$78, %xmm0, %xmm4       # xmm4 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	subpd	%xmm3, %xmm2
	pshufd	$78, %xmm2, %xmm0       # xmm0 = xmm2[2,3,0,1]
	addpd	%xmm2, %xmm0
	unpcklpd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movapd	%xmm4, (%rdi)
	retq
.Lfunc_end56:
	.size	convert_uint32_t_double_2, .Lfunc_end56-convert_uint32_t_double_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI57_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI57_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint32_t_double_4
	.align	16, 0x90
	.type	convert_uint32_t_double_4,@function
convert_uint32_t_double_4:              # @convert_uint32_t_double_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	movdqa	.LCPI57_0(%rip), %xmm3  # xmm3 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm2, %xmm4       # xmm4 = xmm2[2,3,0,1]
	punpckldq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
	movapd	.LCPI57_1(%rip), %xmm5  # xmm5 = [4.503600e+15,1.934281e+25]
	subpd	%xmm5, %xmm2
	pshufd	$78, %xmm2, %xmm6       # xmm6 = xmm2[2,3,0,1]
	addpd	%xmm2, %xmm6
	punpckldq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
	subpd	%xmm5, %xmm4
	pshufd	$78, %xmm4, %xmm2       # xmm2 = xmm4[2,3,0,1]
	addpd	%xmm4, %xmm2
	unpcklpd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	punpckldq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
	subpd	%xmm5, %xmm0
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm2
	punpckldq	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	subpd	%xmm5, %xmm1
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm0
	unpcklpd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movapd	%xmm2, 16(%rdi)
	movapd	%xmm6, (%rdi)
	retq
.Lfunc_end57:
	.size	convert_uint32_t_double_4, .Lfunc_end57-convert_uint32_t_double_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI58_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI58_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint32_t_double_8
	.align	16, 0x90
	.type	convert_uint32_t_double_8,@function
convert_uint32_t_double_8:              # @convert_uint32_t_double_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm6
	movdqa	16(%rsi), %xmm1
	pxor	%xmm8, %xmm8
	movdqa	%xmm6, %xmm5
	punpckldq	%xmm8, %xmm5    # xmm5 = xmm5[0],xmm8[0],xmm5[1],xmm8[1]
	movdqa	.LCPI58_0(%rip), %xmm2  # xmm2 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm5, %xmm7       # xmm7 = xmm5[2,3,0,1]
	punpckldq	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1]
	movapd	.LCPI58_1(%rip), %xmm3  # xmm3 = [4.503600e+15,1.934281e+25]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm0
	punpckldq	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm5       # xmm5 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm5
	unpcklpd	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0]
	punpckhdq	%xmm8, %xmm6    # xmm6 = xmm6[2],xmm8[2],xmm6[3],xmm8[3]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	punpckldq	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm5       # xmm5 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm5
	punpckldq	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm6       # xmm6 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm6
	unpcklpd	%xmm6, %xmm5    # xmm5 = xmm5[0],xmm6[0]
	movdqa	%xmm1, %xmm6
	punpckldq	%xmm8, %xmm6    # xmm6 = xmm6[0],xmm8[0],xmm6[1],xmm8[1]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	punpckldq	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm4       # xmm4 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm4
	punpckldq	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm6       # xmm6 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm6
	unpcklpd	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0]
	punpckhdq	%xmm8, %xmm1    # xmm1 = xmm1[2],xmm8[2],xmm1[3],xmm8[3]
	pshufd	$78, %xmm1, %xmm6       # xmm6 = xmm1[2,3,0,1]
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	subpd	%xmm3, %xmm1
	pshufd	$78, %xmm1, %xmm7       # xmm7 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm7
	punpckldq	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm1       # xmm1 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm1
	unpcklpd	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0]
	movapd	%xmm7, 48(%rdi)
	movapd	%xmm4, 32(%rdi)
	movapd	%xmm5, 16(%rdi)
	movapd	%xmm0, (%rdi)
	retq
.Lfunc_end58:
	.size	convert_uint32_t_double_8, .Lfunc_end58-convert_uint32_t_double_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI59_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI59_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint32_t_double_16
	.align	16, 0x90
	.type	convert_uint32_t_double_16,@function
convert_uint32_t_double_16:             # @convert_uint32_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm0
	movdqa	32(%rsi), %xmm7
	movdqa	48(%rsi), %xmm1
	pxor	%xmm8, %xmm8
	movdqa	%xmm4, %xmm5
	punpckldq	%xmm8, %xmm5    # xmm5 = xmm5[0],xmm8[0],xmm5[1],xmm8[1]
	movdqa	.LCPI59_0(%rip), %xmm12 # xmm12 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm5, %xmm6       # xmm6 = xmm5[2,3,0,1]
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	movapd	.LCPI59_1(%rip), %xmm3  # xmm3 = [4.503600e+15,1.934281e+25]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm9       # xmm9 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm9
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm5       # xmm5 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm5
	unpcklpd	%xmm5, %xmm9    # xmm9 = xmm9[0],xmm5[0]
	punpckhdq	%xmm8, %xmm4    # xmm4 = xmm4[2],xmm8[2],xmm4[3],xmm8[3]
	pshufd	$78, %xmm4, %xmm5       # xmm5 = xmm4[2,3,0,1]
	punpckldq	%xmm12, %xmm4   # xmm4 = xmm4[0],xmm12[0],xmm4[1],xmm12[1]
	subpd	%xmm3, %xmm4
	pshufd	$78, %xmm4, %xmm10      # xmm10 = xmm4[2,3,0,1]
	addpd	%xmm4, %xmm10
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm4       # xmm4 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm4
	unpcklpd	%xmm4, %xmm10   # xmm10 = xmm10[0],xmm4[0]
	movdqa	%xmm0, %xmm4
	punpckldq	%xmm8, %xmm4    # xmm4 = xmm4[0],xmm8[0],xmm4[1],xmm8[1]
	pshufd	$78, %xmm4, %xmm5       # xmm5 = xmm4[2,3,0,1]
	punpckldq	%xmm12, %xmm4   # xmm4 = xmm4[0],xmm12[0],xmm4[1],xmm12[1]
	subpd	%xmm3, %xmm4
	pshufd	$78, %xmm4, %xmm11      # xmm11 = xmm4[2,3,0,1]
	addpd	%xmm4, %xmm11
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm4       # xmm4 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm4
	unpcklpd	%xmm4, %xmm11   # xmm11 = xmm11[0],xmm4[0]
	punpckhdq	%xmm8, %xmm0    # xmm0 = xmm0[2],xmm8[2],xmm0[3],xmm8[3]
	pshufd	$78, %xmm0, %xmm5       # xmm5 = xmm0[2,3,0,1]
	punpckldq	%xmm12, %xmm0   # xmm0 = xmm0[0],xmm12[0],xmm0[1],xmm12[1]
	subpd	%xmm3, %xmm0
	pshufd	$78, %xmm0, %xmm4       # xmm4 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm4
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm0
	unpcklpd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm7, %xmm5
	punpckldq	%xmm8, %xmm5    # xmm5 = xmm5[0],xmm8[0],xmm5[1],xmm8[1]
	pshufd	$78, %xmm5, %xmm6       # xmm6 = xmm5[2,3,0,1]
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm0
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm5       # xmm5 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm5
	unpcklpd	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0]
	punpckhdq	%xmm8, %xmm7    # xmm7 = xmm7[2],xmm8[2],xmm7[3],xmm8[3]
	pshufd	$78, %xmm7, %xmm6       # xmm6 = xmm7[2,3,0,1]
	punpckldq	%xmm12, %xmm7   # xmm7 = xmm7[0],xmm12[0],xmm7[1],xmm12[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm5       # xmm5 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm5
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm7
	unpcklpd	%xmm7, %xmm5    # xmm5 = xmm5[0],xmm7[0]
	movdqa	%xmm1, %xmm6
	punpckldq	%xmm8, %xmm6    # xmm6 = xmm6[0],xmm8[0],xmm6[1],xmm8[1]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm2       # xmm2 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm2
	punpckldq	%xmm12, %xmm7   # xmm7 = xmm7[0],xmm12[0],xmm7[1],xmm12[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm6       # xmm6 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm6
	unpcklpd	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0]
	punpckhdq	%xmm8, %xmm1    # xmm1 = xmm1[2],xmm8[2],xmm1[3],xmm8[3]
	pshufd	$78, %xmm1, %xmm6       # xmm6 = xmm1[2,3,0,1]
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm3, %xmm1
	pshufd	$78, %xmm1, %xmm7       # xmm7 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm7
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm1       # xmm1 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm1
	unpcklpd	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0]
	movapd	%xmm7, 112(%rdi)
	movapd	%xmm2, 96(%rdi)
	movapd	%xmm5, 80(%rdi)
	movapd	%xmm0, 64(%rdi)
	movapd	%xmm4, 48(%rdi)
	movapd	%xmm11, 32(%rdi)
	movapd	%xmm10, 16(%rdi)
	movapd	%xmm9, (%rdi)
	retq
.Lfunc_end59:
	.size	convert_uint32_t_double_16, .Lfunc_end59-convert_uint32_t_double_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI60_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI60_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint64_t_double_2
	.align	16, 0x90
	.type	convert_uint64_t_double_2,@function
convert_uint64_t_double_2:              # @convert_uint64_t_double_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	.LCPI60_0(%rip), %xmm1  # xmm1 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movapd	.LCPI60_1(%rip), %xmm3  # xmm3 = [4.503600e+15,1.934281e+25]
	subpd	%xmm3, %xmm0
	pshufd	$78, %xmm0, %xmm4       # xmm4 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	subpd	%xmm3, %xmm2
	pshufd	$78, %xmm2, %xmm0       # xmm0 = xmm2[2,3,0,1]
	addpd	%xmm2, %xmm0
	unpcklpd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movapd	%xmm4, (%rdi)
	retq
.Lfunc_end60:
	.size	convert_uint64_t_double_2, .Lfunc_end60-convert_uint64_t_double_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI61_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI61_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint64_t_double_4
	.align	16, 0x90
	.type	convert_uint64_t_double_4,@function
convert_uint64_t_double_4:              # @convert_uint64_t_double_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	.LCPI61_0(%rip), %xmm2  # xmm2 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm0, %xmm3       # xmm3 = xmm0[2,3,0,1]
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	movapd	.LCPI61_1(%rip), %xmm4  # xmm4 = [4.503600e+15,1.934281e+25]
	subpd	%xmm4, %xmm0
	pshufd	$78, %xmm0, %xmm5       # xmm5 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm5
	punpckldq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
	subpd	%xmm4, %xmm3
	pshufd	$78, %xmm3, %xmm0       # xmm0 = xmm3[2,3,0,1]
	addpd	%xmm3, %xmm0
	unpcklpd	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	subpd	%xmm4, %xmm1
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm3
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	subpd	%xmm4, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm1
	unpcklpd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0]
	movapd	%xmm3, 16(%rdi)
	movapd	%xmm5, (%rdi)
	retq
.Lfunc_end61:
	.size	convert_uint64_t_double_4, .Lfunc_end61-convert_uint64_t_double_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI62_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI62_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint64_t_double_8
	.align	16, 0x90
	.type	convert_uint64_t_double_8,@function
convert_uint64_t_double_8:              # @convert_uint64_t_double_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm4
	movdqa	16(%rsi), %xmm6
	movdqa	32(%rsi), %xmm5
	movdqa	48(%rsi), %xmm2
	movdqa	.LCPI62_0(%rip), %xmm1  # xmm1 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm4, %xmm7       # xmm7 = xmm4[2,3,0,1]
	punpckldq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	movapd	.LCPI62_1(%rip), %xmm3  # xmm3 = [4.503600e+15,1.934281e+25]
	subpd	%xmm3, %xmm4
	pshufd	$78, %xmm4, %xmm0       # xmm0 = xmm4[2,3,0,1]
	addpd	%xmm4, %xmm0
	punpckldq	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0],xmm7[1],xmm1[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm4       # xmm4 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm4
	unpcklpd	%xmm4, %xmm0    # xmm0 = xmm0[0],xmm4[0]
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	punpckldq	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0],xmm6[1],xmm1[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm4       # xmm4 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm4
	punpckldq	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0],xmm7[1],xmm1[1]
	subpd	%xmm3, %xmm7
	pshufd	$78, %xmm7, %xmm6       # xmm6 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm6
	unpcklpd	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0]
	pshufd	$78, %xmm5, %xmm6       # xmm6 = xmm5[2,3,0,1]
	punpckldq	%xmm1, %xmm5    # xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm7       # xmm7 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm7
	punpckldq	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0],xmm6[1],xmm1[1]
	subpd	%xmm3, %xmm6
	pshufd	$78, %xmm6, %xmm5       # xmm5 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm5
	unpcklpd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0]
	pshufd	$78, %xmm2, %xmm5       # xmm5 = xmm2[2,3,0,1]
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	subpd	%xmm3, %xmm2
	pshufd	$78, %xmm2, %xmm6       # xmm6 = xmm2[2,3,0,1]
	addpd	%xmm2, %xmm6
	punpckldq	%xmm1, %xmm5    # xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
	subpd	%xmm3, %xmm5
	pshufd	$78, %xmm5, %xmm1       # xmm1 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm1
	unpcklpd	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0]
	movapd	%xmm6, 48(%rdi)
	movapd	%xmm7, 32(%rdi)
	movapd	%xmm4, 16(%rdi)
	movapd	%xmm0, (%rdi)
	retq
.Lfunc_end62:
	.size	convert_uint64_t_double_8, .Lfunc_end62-convert_uint64_t_double_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI63_0:
	.long	1127219200              # 0x43300000
	.long	1160773632              # 0x45300000
	.long	0                       # 0x0
	.long	0                       # 0x0
.LCPI63_1:
	.quad	4841369599423283200     # double 4503599627370496
	.quad	4985484787499139072     # double 1.9342813113834067E+25
	.text
	.globl	convert_uint64_t_double_16
	.align	16, 0x90
	.type	convert_uint64_t_double_16,@function
convert_uint64_t_double_16:             # @convert_uint64_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	112(%rsi), %xmm11
	movdqa	96(%rsi), %xmm5
	movdqa	80(%rsi), %xmm7
	movdqa	64(%rsi), %xmm4
	movdqa	(%rsi), %xmm1
	movdqa	16(%rsi), %xmm2
	movdqa	32(%rsi), %xmm0
	movdqa	48(%rsi), %xmm6
	movdqa	.LCPI63_0(%rip), %xmm12 # xmm12 = [1127219200,1160773632,0,0]
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	movapd	.LCPI63_1(%rip), %xmm13 # xmm13 = [4.503600e+15,1.934281e+25]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm8       # xmm8 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm8
	punpckldq	%xmm12, %xmm3   # xmm3 = xmm3[0],xmm12[0],xmm3[1],xmm12[1]
	subpd	%xmm13, %xmm3
	pshufd	$78, %xmm3, %xmm1       # xmm1 = xmm3[2,3,0,1]
	addpd	%xmm3, %xmm1
	unpcklpd	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0]
	pshufd	$78, %xmm2, %xmm1       # xmm1 = xmm2[2,3,0,1]
	punpckldq	%xmm12, %xmm2   # xmm2 = xmm2[0],xmm12[0],xmm2[1],xmm12[1]
	subpd	%xmm13, %xmm2
	pshufd	$78, %xmm2, %xmm9       # xmm9 = xmm2[2,3,0,1]
	addpd	%xmm2, %xmm9
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm2       # xmm2 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm2
	unpcklpd	%xmm2, %xmm9    # xmm9 = xmm9[0],xmm2[0]
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	punpckldq	%xmm12, %xmm0   # xmm0 = xmm0[0],xmm12[0],xmm0[1],xmm12[1]
	subpd	%xmm13, %xmm0
	pshufd	$78, %xmm0, %xmm10      # xmm10 = xmm0[2,3,0,1]
	addpd	%xmm0, %xmm10
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm0
	unpcklpd	%xmm0, %xmm10   # xmm10 = xmm10[0],xmm0[0]
	pshufd	$78, %xmm6, %xmm1       # xmm1 = xmm6[2,3,0,1]
	punpckldq	%xmm12, %xmm6   # xmm6 = xmm6[0],xmm12[0],xmm6[1],xmm12[1]
	subpd	%xmm13, %xmm6
	pshufd	$78, %xmm6, %xmm0       # xmm0 = xmm6[2,3,0,1]
	addpd	%xmm6, %xmm0
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm2       # xmm2 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm2
	unpcklpd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pshufd	$78, %xmm4, %xmm1       # xmm1 = xmm4[2,3,0,1]
	punpckldq	%xmm12, %xmm4   # xmm4 = xmm4[0],xmm12[0],xmm4[1],xmm12[1]
	subpd	%xmm13, %xmm4
	pshufd	$78, %xmm4, %xmm6       # xmm6 = xmm4[2,3,0,1]
	addpd	%xmm4, %xmm6
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm2       # xmm2 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm2
	unpcklpd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0]
	pshufd	$78, %xmm7, %xmm1       # xmm1 = xmm7[2,3,0,1]
	punpckldq	%xmm12, %xmm7   # xmm7 = xmm7[0],xmm12[0],xmm7[1],xmm12[1]
	subpd	%xmm13, %xmm7
	pshufd	$78, %xmm7, %xmm4       # xmm4 = xmm7[2,3,0,1]
	addpd	%xmm7, %xmm4
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm2       # xmm2 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm2
	unpcklpd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0]
	pshufd	$78, %xmm5, %xmm1       # xmm1 = xmm5[2,3,0,1]
	punpckldq	%xmm12, %xmm5   # xmm5 = xmm5[0],xmm12[0],xmm5[1],xmm12[1]
	subpd	%xmm13, %xmm5
	pshufd	$78, %xmm5, %xmm2       # xmm2 = xmm5[2,3,0,1]
	addpd	%xmm5, %xmm2
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm3
	unpcklpd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	pshufd	$78, %xmm11, %xmm1      # xmm1 = xmm11[2,3,0,1]
	punpckldq	%xmm12, %xmm11  # xmm11 = xmm11[0],xmm12[0],xmm11[1],xmm12[1]
	subpd	%xmm13, %xmm11
	pshufd	$78, %xmm11, %xmm3      # xmm3 = xmm11[2,3,0,1]
	addpd	%xmm11, %xmm3
	punpckldq	%xmm12, %xmm1   # xmm1 = xmm1[0],xmm12[0],xmm1[1],xmm12[1]
	subpd	%xmm13, %xmm1
	pshufd	$78, %xmm1, %xmm5       # xmm5 = xmm1[2,3,0,1]
	addpd	%xmm1, %xmm5
	unpcklpd	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0]
	movapd	%xmm3, 112(%rdi)
	movapd	%xmm2, 96(%rdi)
	movapd	%xmm4, 80(%rdi)
	movapd	%xmm6, 64(%rdi)
	movapd	%xmm0, 48(%rdi)
	movapd	%xmm10, 32(%rdi)
	movapd	%xmm9, 16(%rdi)
	movapd	%xmm8, (%rdi)
	retq
.Lfunc_end63:
	.size	convert_uint64_t_double_16, .Lfunc_end63-convert_uint64_t_double_16
	.cfi_endproc

	.globl	convert_int8_t_double_2
	.align	16, 0x90
	.type	convert_int8_t_double_2,@function
convert_int8_t_double_2:                # @convert_int8_t_double_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end64:
	.size	convert_int8_t_double_2, .Lfunc_end64-convert_int8_t_double_2
	.cfi_endproc

	.globl	convert_int8_t_double_4
	.align	16, 0x90
	.type	convert_int8_t_double_4,@function
convert_int8_t_double_4:                # @convert_int8_t_double_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end65:
	.size	convert_int8_t_double_4, .Lfunc_end65-convert_int8_t_double_4
	.cfi_endproc

	.globl	convert_int8_t_double_8
	.align	16, 0x90
	.type	convert_int8_t_double_8,@function
convert_int8_t_double_8:                # @convert_int8_t_double_8
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	movd	4(%rsi), %xmm2          # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm2
	pshufd	$78, %xmm2, %xmm3       # xmm3 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm2, %xmm2
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm0, (%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end66:
	.size	convert_int8_t_double_8, .Lfunc_end66-convert_int8_t_double_8
	.cfi_endproc

	.globl	convert_int8_t_double_16
	.align	16, 0x90
	.type	convert_int8_t_double_16,@function
convert_int8_t_double_16:               # @convert_int8_t_double_16
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	psrad	$24, %xmm1
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	cvtdq2pd	%xmm0, %xmm0
	movd	4(%rsi), %xmm2          # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm2
	pshufd	$78, %xmm2, %xmm3       # xmm3 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	movd	8(%rsi), %xmm4          # xmm4 = mem[0],zero,zero,zero
	punpcklbw	%xmm4, %xmm4    # xmm4 = xmm4[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm4, %xmm4    # xmm4 = xmm4[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm4
	pshufd	$78, %xmm4, %xmm5       # xmm5 = xmm4[2,3,0,1]
	cvtdq2pd	%xmm5, %xmm5
	movd	12(%rsi), %xmm6         # xmm6 = mem[0],zero,zero,zero
	punpcklbw	%xmm6, %xmm6    # xmm6 = xmm6[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm6, %xmm6    # xmm6 = xmm6[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm6
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	cvtdq2pd	%xmm7, %xmm7
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm4, %xmm4
	cvtdq2pd	%xmm6, %xmm6
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, (%rdi)
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm0, 16(%rdi)
	retq
.Lfunc_end67:
	.size	convert_int8_t_double_16, .Lfunc_end67-convert_int8_t_double_16
	.cfi_endproc

	.globl	convert_int16_t_double_2
	.align	16, 0x90
	.type	convert_int16_t_double_2,@function
convert_int16_t_double_2:               # @convert_int16_t_double_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end68:
	.size	convert_int16_t_double_2, .Lfunc_end68-convert_int16_t_double_2
	.cfi_endproc

	.globl	convert_int16_t_double_4
	.align	16, 0x90
	.type	convert_int16_t_double_4,@function
convert_int16_t_double_4:               # @convert_int16_t_double_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end69:
	.size	convert_int16_t_double_4, .Lfunc_end69-convert_int16_t_double_4
	.cfi_endproc

	.globl	convert_int16_t_double_8
	.align	16, 0x90
	.type	convert_int16_t_double_8,@function
convert_int16_t_double_8:               # @convert_int16_t_double_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	movq	8(%rsi), %xmm2          # xmm2 = mem[0],zero
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm2
	pshufd	$78, %xmm2, %xmm3       # xmm3 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm2, %xmm2
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm0, (%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end70:
	.size	convert_int16_t_double_8, .Lfunc_end70-convert_int16_t_double_8
	.cfi_endproc

	.globl	convert_int16_t_double_16
	.align	16, 0x90
	.type	convert_int16_t_double_16,@function
convert_int16_t_double_16:              # @convert_int16_t_double_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	movq	8(%rsi), %xmm2          # xmm2 = mem[0],zero
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm2
	pshufd	$78, %xmm2, %xmm3       # xmm3 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	movq	16(%rsi), %xmm4         # xmm4 = mem[0],zero
	punpcklwd	%xmm4, %xmm4    # xmm4 = xmm4[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm4
	pshufd	$78, %xmm4, %xmm5       # xmm5 = xmm4[2,3,0,1]
	cvtdq2pd	%xmm5, %xmm5
	movq	24(%rsi), %xmm6         # xmm6 = mem[0],zero
	punpcklwd	%xmm6, %xmm6    # xmm6 = xmm6[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm6
	pshufd	$78, %xmm6, %xmm7       # xmm7 = xmm6[2,3,0,1]
	cvtdq2pd	%xmm7, %xmm7
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm4, %xmm4
	cvtdq2pd	%xmm6, %xmm6
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm0, (%rdi)
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end71:
	.size	convert_int16_t_double_16, .Lfunc_end71-convert_int16_t_double_16
	.cfi_endproc

	.globl	convert_int32_t_double_2
	.align	16, 0x90
	.type	convert_int32_t_double_2,@function
convert_int32_t_double_2:               # @convert_int32_t_double_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end72:
	.size	convert_int32_t_double_2, .Lfunc_end72-convert_int32_t_double_2
	.cfi_endproc

	.globl	convert_int32_t_double_4
	.align	16, 0x90
	.type	convert_int32_t_double_4,@function
convert_int32_t_double_4:               # @convert_int32_t_double_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, (%rdi)
	movaps	%xmm1, 16(%rdi)
	retq
.Lfunc_end73:
	.size	convert_int32_t_double_4, .Lfunc_end73-convert_int32_t_double_4
	.cfi_endproc

	.globl	convert_int32_t_double_8
	.align	16, 0x90
	.type	convert_int32_t_double_8,@function
convert_int32_t_double_8:               # @convert_int32_t_double_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm2, %xmm2
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	cvtdq2pd	%xmm3, %xmm3
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm1, %xmm1
	movaps	%xmm1, 32(%rdi)
	movaps	%xmm0, (%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 16(%rdi)
	retq
.Lfunc_end74:
	.size	convert_int32_t_double_8, .Lfunc_end74-convert_int32_t_double_8
	.cfi_endproc

	.globl	convert_int32_t_double_16
	.align	16, 0x90
	.type	convert_int32_t_double_16,@function
convert_int32_t_double_16:              # @convert_int32_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pshufd	$78, %xmm0, %xmm4       # xmm4 = xmm0[2,3,0,1]
	cvtdq2pd	%xmm4, %xmm4
	pshufd	$78, %xmm1, %xmm5       # xmm5 = xmm1[2,3,0,1]
	cvtdq2pd	%xmm5, %xmm5
	pshufd	$78, %xmm2, %xmm6       # xmm6 = xmm2[2,3,0,1]
	cvtdq2pd	%xmm6, %xmm6
	pshufd	$78, %xmm3, %xmm7       # xmm7 = xmm3[2,3,0,1]
	cvtdq2pd	%xmm7, %xmm7
	cvtdq2pd	%xmm0, %xmm0
	cvtdq2pd	%xmm1, %xmm1
	cvtdq2pd	%xmm2, %xmm2
	cvtdq2pd	%xmm3, %xmm3
	movaps	%xmm3, 96(%rdi)
	movaps	%xmm2, 64(%rdi)
	movaps	%xmm1, 32(%rdi)
	movaps	%xmm0, (%rdi)
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 80(%rdi)
	movaps	%xmm5, 48(%rdi)
	movaps	%xmm4, 16(%rdi)
	retq
.Lfunc_end75:
	.size	convert_int32_t_double_16, .Lfunc_end75-convert_int32_t_double_16
	.cfi_endproc

	.globl	convert_int64_t_double_2
	.align	16, 0x90
	.type	convert_int64_t_double_2,@function
convert_int64_t_double_2:               # @convert_int64_t_double_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movd	%xmm0, %rax
	cvtsi2sdq	%rax, %xmm1
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	unpcklpd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movapd	%xmm1, (%rdi)
	retq
.Lfunc_end76:
	.size	convert_int64_t_double_2, .Lfunc_end76-convert_int64_t_double_2
	.cfi_endproc

	.globl	convert_int64_t_double_4
	.align	16, 0x90
	.type	convert_int64_t_double_4,@function
convert_int64_t_double_4:               # @convert_int64_t_double_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movd	%xmm0, %rax
	cvtsi2sdq	%rax, %xmm2
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	unpcklpd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movd	%xmm1, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	unpcklpd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movapd	%xmm0, 16(%rdi)
	movapd	%xmm2, (%rdi)
	retq
.Lfunc_end77:
	.size	convert_int64_t_double_4, .Lfunc_end77-convert_int64_t_double_4
	.cfi_endproc

	.globl	convert_int64_t_double_8
	.align	16, 0x90
	.type	convert_int64_t_double_8,@function
convert_int64_t_double_8:               # @convert_int64_t_double_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	movd	%xmm0, %rax
	cvtsi2sdq	%rax, %xmm4
	pshufd	$78, %xmm0, %xmm0       # xmm0 = xmm0[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	unpcklpd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movd	%xmm1, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	unpcklpd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movd	%xmm2, %rax
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	pshufd	$78, %xmm2, %xmm2       # xmm2 = xmm2[2,3,0,1]
	movd	%xmm2, %rax
	xorps	%xmm2, %xmm2
	cvtsi2sdq	%rax, %xmm2
	unpcklpd	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movd	%xmm3, %rax
	xorps	%xmm2, %xmm2
	cvtsi2sdq	%rax, %xmm2
	pshufd	$78, %xmm3, %xmm3       # xmm3 = xmm3[2,3,0,1]
	movd	%xmm3, %rax
	xorps	%xmm3, %xmm3
	cvtsi2sdq	%rax, %xmm3
	unpcklpd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movapd	%xmm2, 48(%rdi)
	movapd	%xmm1, 32(%rdi)
	movapd	%xmm0, 16(%rdi)
	movapd	%xmm4, (%rdi)
	retq
.Lfunc_end78:
	.size	convert_int64_t_double_8, .Lfunc_end78-convert_int64_t_double_8
	.cfi_endproc

	.globl	convert_int64_t_double_16
	.align	16, 0x90
	.type	convert_int64_t_double_16,@function
convert_int64_t_double_16:              # @convert_int64_t_double_16
	.cfi_startproc
# BB#0:
	movdqa	112(%rsi), %xmm8
	movdqa	96(%rsi), %xmm3
	movdqa	80(%rsi), %xmm5
	movdqa	64(%rsi), %xmm7
	movdqa	(%rsi), %xmm2
	movdqa	16(%rsi), %xmm4
	movdqa	32(%rsi), %xmm6
	movdqa	48(%rsi), %xmm1
	movd	%xmm2, %rax
	cvtsi2sdq	%rax, %xmm9
	pshufd	$78, %xmm2, %xmm2       # xmm2 = xmm2[2,3,0,1]
	movd	%xmm2, %rax
	xorps	%xmm2, %xmm2
	cvtsi2sdq	%rax, %xmm2
	unpcklpd	%xmm2, %xmm9    # xmm9 = xmm9[0],xmm2[0]
	movd	%xmm4, %rax
	xorps	%xmm2, %xmm2
	cvtsi2sdq	%rax, %xmm2
	pshufd	$78, %xmm4, %xmm4       # xmm4 = xmm4[2,3,0,1]
	movd	%xmm4, %rax
	xorps	%xmm4, %xmm4
	cvtsi2sdq	%rax, %xmm4
	unpcklpd	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0]
	movd	%xmm6, %rax
	xorps	%xmm4, %xmm4
	cvtsi2sdq	%rax, %xmm4
	pshufd	$78, %xmm6, %xmm6       # xmm6 = xmm6[2,3,0,1]
	movd	%xmm6, %rax
	xorps	%xmm6, %xmm6
	cvtsi2sdq	%rax, %xmm6
	unpcklpd	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0]
	movd	%xmm1, %rax
	xorps	%xmm6, %xmm6
	cvtsi2sdq	%rax, %xmm6
	pshufd	$78, %xmm1, %xmm1       # xmm1 = xmm1[2,3,0,1]
	movd	%xmm1, %rax
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	unpcklpd	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0]
	movd	%xmm7, %rax
	xorps	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	pshufd	$78, %xmm7, %xmm7       # xmm7 = xmm7[2,3,0,1]
	movd	%xmm7, %rax
	xorps	%xmm7, %xmm7
	cvtsi2sdq	%rax, %xmm7
	unpcklpd	%xmm7, %xmm1    # xmm1 = xmm1[0],xmm7[0]
	movd	%xmm5, %rax
	xorps	%xmm7, %xmm7
	cvtsi2sdq	%rax, %xmm7
	pshufd	$78, %xmm5, %xmm5       # xmm5 = xmm5[2,3,0,1]
	movd	%xmm5, %rax
	xorps	%xmm5, %xmm5
	cvtsi2sdq	%rax, %xmm5
	unpcklpd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0]
	movd	%xmm3, %rax
	xorps	%xmm5, %xmm5
	cvtsi2sdq	%rax, %xmm5
	pshufd	$78, %xmm3, %xmm3       # xmm3 = xmm3[2,3,0,1]
	movd	%xmm3, %rax
	xorps	%xmm3, %xmm3
	cvtsi2sdq	%rax, %xmm3
	unpcklpd	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movd	%xmm8, %rax
	xorps	%xmm3, %xmm3
	cvtsi2sdq	%rax, %xmm3
	pshufd	$78, %xmm8, %xmm0       # xmm0 = xmm8[2,3,0,1]
	movd	%xmm0, %rax
	xorps	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	unpcklpd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movapd	%xmm3, 112(%rdi)
	movapd	%xmm5, 96(%rdi)
	movapd	%xmm7, 80(%rdi)
	movapd	%xmm1, 64(%rdi)
	movapd	%xmm6, 48(%rdi)
	movapd	%xmm4, 32(%rdi)
	movapd	%xmm2, 16(%rdi)
	movapd	%xmm9, (%rdi)
	retq
.Lfunc_end79:
	.size	convert_int64_t_double_16, .Lfunc_end79-convert_int64_t_double_16
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI80_0:
	.long	1593835520              # float 9.22337203E+18
	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI80_1:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_float_uint8_t_2
	.align	16, 0x90
	.type	convert_float_uint8_t_2,@function
convert_float_uint8_t_2:                # @convert_float_uint8_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movss	.LCPI80_0(%rip), %xmm1  # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm3
	subss	%xmm1, %xmm3
	cvttss2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rcx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pand	.LCPI80_1(%rip), %xmm2
	packuswb	%xmm2, %xmm2
	packuswb	%xmm2, %xmm2
	packuswb	%xmm2, %xmm2
	movd	%xmm2, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end80:
	.size	convert_float_uint8_t_2, .Lfunc_end80-convert_float_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI81_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_float_uint8_t_4
	.align	16, 0x90
	.type	convert_float_uint8_t_4,@function
convert_float_uint8_t_4:                # @convert_float_uint8_t_4
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	pand	.LCPI81_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end81:
	.size	convert_float_uint8_t_4, .Lfunc_end81-convert_float_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI82_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_float_uint8_t_8
	.align	16, 0x90
	.type	convert_float_uint8_t_8,@function
convert_float_uint8_t_8:                # @convert_float_uint8_t_8
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI82_0(%rip), %xmm1
	packuswb	%xmm1, %xmm1
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end82:
	.size	convert_float_uint8_t_8, .Lfunc_end82-convert_float_uint8_t_8
	.cfi_endproc

	.globl	convert_float_uint8_t_16
	.align	16, 0x90
	.type	convert_float_uint8_t_16,@function
convert_float_uint8_t_16:               # @convert_float_uint8_t_16
	.cfi_startproc
# BB#0:
	cvttps2dq	48(%rsi), %xmm1
	movdqa	%xmm1, -56(%rsp)
	cvttps2dq	16(%rsi), %xmm2
	movdqa	%xmm2, -40(%rsp)
	cvttps2dq	32(%rsi), %xmm3
	movdqa	%xmm3, -24(%rsp)
	cvttps2dq	(%rsi), %xmm0
	movdqa	%xmm0, -72(%rsp)
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpcklbw	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3],xmm0[4],xmm3[4],xmm0[5],xmm3[5],xmm0[6],xmm3[6],xmm0[7],xmm3[7]
	punpcklbw	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3],xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movd	-52(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-36(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	movd	-48(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	movd	-32(%rsp), %xmm4        # xmm4 = mem[0],zero,zero,zero
	punpcklbw	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3],xmm4[4],xmm3[4],xmm4[5],xmm3[5],xmm4[6],xmm3[6],xmm4[7],xmm3[7]
	movd	-20(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	movd	-68(%rsp), %xmm5        # xmm5 = mem[0],zero,zero,zero
	movd	-16(%rsp), %xmm6        # xmm6 = mem[0],zero,zero,zero
	movd	-64(%rsp), %xmm7        # xmm7 = mem[0],zero,zero,zero
	punpcklbw	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3],xmm7[4],xmm6[4],xmm7[5],xmm6[5],xmm7[6],xmm6[6],xmm7[7],xmm6[7]
	punpcklbw	%xmm4, %xmm7    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1],xmm7[2],xmm4[2],xmm7[3],xmm4[3],xmm7[4],xmm4[4],xmm7[5],xmm4[5],xmm7[6],xmm4[6],xmm7[7],xmm4[7]
	punpcklbw	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3],xmm0[4],xmm7[4],xmm0[5],xmm7[5],xmm0[6],xmm7[6],xmm0[7],xmm7[7]
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpcklbw	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3],xmm5[4],xmm3[4],xmm5[5],xmm3[5],xmm5[6],xmm3[6],xmm5[7],xmm3[7]
	punpcklbw	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1],xmm5[2],xmm2[2],xmm5[3],xmm2[3],xmm5[4],xmm2[4],xmm5[5],xmm2[5],xmm5[6],xmm2[6],xmm5[7],xmm2[7]
	movd	-44(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-28(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movd	-12(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-60(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3],xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
	punpcklbw	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	punpcklbw	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3],xmm5[4],xmm3[4],xmm5[5],xmm3[5],xmm5[6],xmm3[6],xmm5[7],xmm3[7]
	punpcklbw	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1],xmm0[2],xmm5[2],xmm0[3],xmm5[3],xmm0[4],xmm5[4],xmm0[5],xmm5[5],xmm0[6],xmm5[6],xmm0[7],xmm5[7]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end83:
	.size	convert_float_uint8_t_16, .Lfunc_end83-convert_float_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI84_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI84_1:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_double_uint8_t_2
	.align	16, 0x90
	.type	convert_double_uint8_t_2,@function
convert_double_uint8_t_2:               # @convert_double_uint8_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movsd	.LCPI84_0(%rip), %xmm1  # xmm1 = mem[0],zero
	movapd	%xmm0, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rcx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pand	.LCPI84_1(%rip), %xmm2
	packuswb	%xmm2, %xmm2
	packuswb	%xmm2, %xmm2
	packuswb	%xmm2, %xmm2
	movd	%xmm2, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end84:
	.size	convert_double_uint8_t_2, .Lfunc_end84-convert_double_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI85_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_double_uint8_t_4
	.align	16, 0x90
	.type	convert_double_uint8_t_4,@function
convert_double_uint8_t_4:               # @convert_double_uint8_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	pand	.LCPI85_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end85:
	.size	convert_double_uint8_t_4, .Lfunc_end85-convert_double_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI86_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI86_1:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_double_uint8_t_8
	.align	16, 0x90
	.type	convert_double_uint8_t_8,@function
convert_double_uint8_t_8:               # @convert_double_uint8_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm5
	movapd	32(%rsi), %xmm4
	movapd	48(%rsi), %xmm3
	movsd	.LCPI86_0(%rip), %xmm1  # xmm1 = mem[0],zero
	movapd	%xmm3, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movapd	%xmm5, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	punpcklqdq	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0]
	movapd	%xmm4, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	movapd	%xmm0, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	pextrw	$4, %xmm3, %ecx
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpcklqdq	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0]
	movd	%rdx, %xmm4
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rdx
	xorq	%rax, %rdx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rdx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	pextrw	$4, %xmm4, %eax
	punpcklwd	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1],xmm4[2],xmm5[2],xmm4[3],xmm5[3]
	punpcklwd	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	pextrw	$4, %xmm2, %edx
	movd	%edx, %xmm0
	movd	%ecx, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	pextrw	$4, %xmm5, %ecx
	movd	%ecx, %xmm0
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	pand	.LCPI86_1(%rip), %xmm4
	packuswb	%xmm4, %xmm4
	movq	%xmm4, (%rdi)
	retq
.Lfunc_end86:
	.size	convert_double_uint8_t_8, .Lfunc_end86-convert_double_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI87_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint8_t_16
	.align	16, 0x90
	.type	convert_double_uint8_t_16,@function
convert_double_uint8_t_16:              # @convert_double_uint8_t_16
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp0:
	.cfi_def_cfa_offset 16
	movapd	64(%rsi), %xmm12
	movapd	96(%rsi), %xmm2
	movapd	80(%rsi), %xmm7
	movapd	(%rsi), %xmm11
	movapd	16(%rsi), %xmm6
	movapd	32(%rsi), %xmm5
	movapd	48(%rsi), %xmm4
	movapd	112(%rsi), %xmm3
	movsd	.LCPI87_0(%rip), %xmm1  # xmm1 = mem[0],zero
	movapd	%xmm3, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm8
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm8    # xmm8 = xmm8[0],xmm0[0]
	movdqa	%xmm8, -96(%rsp)
	movapd	%xmm4, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm10
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm10   # xmm10 = xmm10[0],xmm0[0]
	movdqa	%xmm10, -64(%rsp)
	movapd	%xmm7, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm9
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	movapd	%xmm7, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm9    # xmm9 = xmm9[0],xmm0[0]
	movdqa	%xmm9, -80(%rsp)
	movapd	%xmm6, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm7
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	movapd	%xmm6, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm7    # xmm7 = xmm7[0],xmm0[0]
	movdqa	%xmm7, -48(%rsp)
	movapd	%xmm2, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm6
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	movapd	%xmm2, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	movdqa	%xmm6, -112(%rsp)
	movapd	%xmm5, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, -32(%rsp)
	movapd	%xmm12, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm12, %rdx
	ucomisd	%xmm1, %xmm12
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm12, %xmm12      # xmm12 = xmm12[1,0]
	movapd	%xmm12, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm12, %rdx
	ucomisd	%xmm1, %xmm12
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	movdqa	%xmm5, -16(%rsp)
	movapd	%xmm11, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rdx
	ucomisd	%xmm1, %xmm11
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm11, %xmm11      # xmm11 = xmm11[1,0]
	movapd	%xmm11, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rax
	ucomisd	%xmm1, %xmm11
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movdqa	%xmm3, -128(%rsp)
	punpcklbw	%xmm8, %xmm10   # xmm10 = xmm10[0],xmm8[0],xmm10[1],xmm8[1],xmm10[2],xmm8[2],xmm10[3],xmm8[3],xmm10[4],xmm8[4],xmm10[5],xmm8[5],xmm10[6],xmm8[6],xmm10[7],xmm8[7]
	punpcklbw	%xmm9, %xmm7    # xmm7 = xmm7[0],xmm9[0],xmm7[1],xmm9[1],xmm7[2],xmm9[2],xmm7[3],xmm9[3],xmm7[4],xmm9[4],xmm7[5],xmm9[5],xmm7[6],xmm9[6],xmm7[7],xmm9[7]
	punpcklbw	%xmm10, %xmm7   # xmm7 = xmm7[0],xmm10[0],xmm7[1],xmm10[1],xmm7[2],xmm10[2],xmm7[3],xmm10[3],xmm7[4],xmm10[4],xmm7[5],xmm10[5],xmm7[6],xmm10[6],xmm7[7],xmm10[7]
	punpcklbw	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3],xmm2[4],xmm6[4],xmm2[5],xmm6[5],xmm2[6],xmm6[6],xmm2[7],xmm6[7]
	punpcklbw	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0],xmm3[1],xmm5[1],xmm3[2],xmm5[2],xmm3[3],xmm5[3],xmm3[4],xmm5[4],xmm3[5],xmm5[5],xmm3[6],xmm5[6],xmm3[7],xmm5[7]
	punpcklbw	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	punpcklbw	%xmm7, %xmm3    # xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1],xmm3[2],xmm7[2],xmm3[3],xmm7[3],xmm3[4],xmm7[4],xmm3[5],xmm7[5],xmm3[6],xmm7[6],xmm3[7],xmm7[7]
	movd	-88(%rsp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-56(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
	movd	-72(%rsp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-40(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movd	-104(%rsp), %xmm0       # xmm0 = mem[0],zero,zero,zero
	movd	-24(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
	movd	-8(%rsp), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movd	-120(%rsp), %xmm4       # xmm4 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3],xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
	punpcklbw	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3],xmm4[4],xmm1[4],xmm4[5],xmm1[5],xmm4[6],xmm1[6],xmm4[7],xmm1[7]
	punpcklbw	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3],xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
	punpcklbw	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1],xmm3[2],xmm4[2],xmm3[3],xmm4[3],xmm3[4],xmm4[4],xmm3[5],xmm4[5],xmm3[6],xmm4[6],xmm3[7],xmm4[7]
	movdqa	%xmm3, (%rdi)
	popq	%rax
	retq
.Lfunc_end87:
	.size	convert_double_uint8_t_16, .Lfunc_end87-convert_double_uint8_t_16
	.cfi_endproc

	.globl	convert_uint8_t_uint8_t_2
	.align	16, 0x90
	.type	convert_uint8_t_uint8_t_2,@function
convert_uint8_t_uint8_t_2:              # @convert_uint8_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	retq
.Lfunc_end88:
	.size	convert_uint8_t_uint8_t_2, .Lfunc_end88-convert_uint8_t_uint8_t_2
	.cfi_endproc

	.globl	convert_uint8_t_uint8_t_4
	.align	16, 0x90
	.type	convert_uint8_t_uint8_t_4,@function
convert_uint8_t_uint8_t_4:              # @convert_uint8_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end89:
	.size	convert_uint8_t_uint8_t_4, .Lfunc_end89-convert_uint8_t_uint8_t_4
	.cfi_endproc

	.globl	convert_uint8_t_uint8_t_8
	.align	16, 0x90
	.type	convert_uint8_t_uint8_t_8,@function
convert_uint8_t_uint8_t_8:              # @convert_uint8_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end90:
	.size	convert_uint8_t_uint8_t_8, .Lfunc_end90-convert_uint8_t_uint8_t_8
	.cfi_endproc

	.globl	convert_uint8_t_uint8_t_16
	.align	16, 0x90
	.type	convert_uint8_t_uint8_t_16,@function
convert_uint8_t_uint8_t_16:             # @convert_uint8_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end91:
	.size	convert_uint8_t_uint8_t_16, .Lfunc_end91-convert_uint8_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI92_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint16_t_uint8_t_2
	.align	16, 0x90
	.type	convert_uint16_t_uint8_t_2,@function
convert_uint16_t_uint8_t_2:             # @convert_uint16_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pshufd	$196, %xmm0, %xmm0      # xmm0 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	.LCPI92_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end92:
	.size	convert_uint16_t_uint8_t_2, .Lfunc_end92-convert_uint16_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI93_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_uint16_t_uint8_t_4
	.align	16, 0x90
	.type	convert_uint16_t_uint8_t_4,@function
convert_uint16_t_uint8_t_4:             # @convert_uint16_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pand	.LCPI93_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end93:
	.size	convert_uint16_t_uint8_t_4, .Lfunc_end93-convert_uint16_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI94_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_uint16_t_uint8_t_8
	.align	16, 0x90
	.type	convert_uint16_t_uint8_t_8,@function
convert_uint16_t_uint8_t_8:             # @convert_uint16_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI94_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end94:
	.size	convert_uint16_t_uint8_t_8, .Lfunc_end94-convert_uint16_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI95_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_uint16_t_uint8_t_16
	.align	16, 0x90
	.type	convert_uint16_t_uint8_t_16,@function
convert_uint16_t_uint8_t_16:            # @convert_uint16_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI95_0(%rip), %xmm0  # xmm0 = [255,255,255,255,255,255,255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end95:
	.size	convert_uint16_t_uint8_t_16, .Lfunc_end95-convert_uint16_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI96_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint32_t_uint8_t_2
	.align	16, 0x90
	.type	convert_uint32_t_uint8_t_2,@function
convert_uint32_t_uint8_t_2:             # @convert_uint32_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pand	.LCPI96_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end96:
	.size	convert_uint32_t_uint8_t_2, .Lfunc_end96-convert_uint32_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI97_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_uint32_t_uint8_t_4
	.align	16, 0x90
	.type	convert_uint32_t_uint8_t_4,@function
convert_uint32_t_uint8_t_4:             # @convert_uint32_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI97_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end97:
	.size	convert_uint32_t_uint8_t_4, .Lfunc_end97-convert_uint32_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI98_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint32_t_uint8_t_8
	.align	16, 0x90
	.type	convert_uint32_t_uint8_t_8,@function
convert_uint32_t_uint8_t_8:             # @convert_uint32_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI98_0(%rip), %xmm0  # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end98:
	.size	convert_uint32_t_uint8_t_8, .Lfunc_end98-convert_uint32_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI99_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint32_t_uint8_t_16
	.align	16, 0x90
	.type	convert_uint32_t_uint8_t_16,@function
convert_uint32_t_uint8_t_16:            # @convert_uint32_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI99_0(%rip), %xmm0  # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end99:
	.size	convert_uint32_t_uint8_t_16, .Lfunc_end99-convert_uint32_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI100_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint64_t_uint8_t_2
	.align	16, 0x90
	.type	convert_uint64_t_uint8_t_2,@function
convert_uint64_t_uint8_t_2:             # @convert_uint64_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI100_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end100:
	.size	convert_uint64_t_uint8_t_2, .Lfunc_end100-convert_uint64_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI101_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint64_t_uint8_t_4
	.align	16, 0x90
	.type	convert_uint64_t_uint8_t_4,@function
convert_uint64_t_uint8_t_4:             # @convert_uint64_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movdqa	.LCPI101_0(%rip), %xmm0 # xmm0 = [255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end101:
	.size	convert_uint64_t_uint8_t_4, .Lfunc_end101-convert_uint64_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI102_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint64_t_uint8_t_8
	.align	16, 0x90
	.type	convert_uint64_t_uint8_t_8,@function
convert_uint64_t_uint8_t_8:             # @convert_uint64_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI102_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end102:
	.size	convert_uint64_t_uint8_t_8, .Lfunc_end102-convert_uint64_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI103_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint64_t_uint8_t_16
	.align	16, 0x90
	.type	convert_uint64_t_uint8_t_16,@function
convert_uint64_t_uint8_t_16:            # @convert_uint64_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI103_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	112(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	96(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	80(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	64(%rsi), %xmm3
	pand	%xmm0, %xmm3
	packuswb	%xmm1, %xmm3
	packuswb	%xmm2, %xmm3
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm3, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end103:
	.size	convert_uint64_t_uint8_t_16, .Lfunc_end103-convert_uint64_t_uint8_t_16
	.cfi_endproc

	.globl	convert_int8_t_uint8_t_2
	.align	16, 0x90
	.type	convert_int8_t_uint8_t_2,@function
convert_int8_t_uint8_t_2:               # @convert_int8_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	retq
.Lfunc_end104:
	.size	convert_int8_t_uint8_t_2, .Lfunc_end104-convert_int8_t_uint8_t_2
	.cfi_endproc

	.globl	convert_int8_t_uint8_t_4
	.align	16, 0x90
	.type	convert_int8_t_uint8_t_4,@function
convert_int8_t_uint8_t_4:               # @convert_int8_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end105:
	.size	convert_int8_t_uint8_t_4, .Lfunc_end105-convert_int8_t_uint8_t_4
	.cfi_endproc

	.globl	convert_int8_t_uint8_t_8
	.align	16, 0x90
	.type	convert_int8_t_uint8_t_8,@function
convert_int8_t_uint8_t_8:               # @convert_int8_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end106:
	.size	convert_int8_t_uint8_t_8, .Lfunc_end106-convert_int8_t_uint8_t_8
	.cfi_endproc

	.globl	convert_int8_t_uint8_t_16
	.align	16, 0x90
	.type	convert_int8_t_uint8_t_16,@function
convert_int8_t_uint8_t_16:              # @convert_int8_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end107:
	.size	convert_int8_t_uint8_t_16, .Lfunc_end107-convert_int8_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI108_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int16_t_uint8_t_2
	.align	16, 0x90
	.type	convert_int16_t_uint8_t_2,@function
convert_int16_t_uint8_t_2:              # @convert_int16_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pshufd	$196, %xmm0, %xmm0      # xmm0 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	.LCPI108_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end108:
	.size	convert_int16_t_uint8_t_2, .Lfunc_end108-convert_int16_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI109_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_int16_t_uint8_t_4
	.align	16, 0x90
	.type	convert_int16_t_uint8_t_4,@function
convert_int16_t_uint8_t_4:              # @convert_int16_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pand	.LCPI109_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end109:
	.size	convert_int16_t_uint8_t_4, .Lfunc_end109-convert_int16_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI110_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_int16_t_uint8_t_8
	.align	16, 0x90
	.type	convert_int16_t_uint8_t_8,@function
convert_int16_t_uint8_t_8:              # @convert_int16_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI110_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end110:
	.size	convert_int16_t_uint8_t_8, .Lfunc_end110-convert_int16_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI111_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_int16_t_uint8_t_16
	.align	16, 0x90
	.type	convert_int16_t_uint8_t_16,@function
convert_int16_t_uint8_t_16:             # @convert_int16_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI111_0(%rip), %xmm0 # xmm0 = [255,255,255,255,255,255,255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end111:
	.size	convert_int16_t_uint8_t_16, .Lfunc_end111-convert_int16_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI112_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int32_t_uint8_t_2
	.align	16, 0x90
	.type	convert_int32_t_uint8_t_2,@function
convert_int32_t_uint8_t_2:              # @convert_int32_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pand	.LCPI112_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end112:
	.size	convert_int32_t_uint8_t_2, .Lfunc_end112-convert_int32_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI113_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_int32_t_uint8_t_4
	.align	16, 0x90
	.type	convert_int32_t_uint8_t_4,@function
convert_int32_t_uint8_t_4:              # @convert_int32_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI113_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end113:
	.size	convert_int32_t_uint8_t_4, .Lfunc_end113-convert_int32_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI114_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int32_t_uint8_t_8
	.align	16, 0x90
	.type	convert_int32_t_uint8_t_8,@function
convert_int32_t_uint8_t_8:              # @convert_int32_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI114_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end114:
	.size	convert_int32_t_uint8_t_8, .Lfunc_end114-convert_int32_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI115_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int32_t_uint8_t_16
	.align	16, 0x90
	.type	convert_int32_t_uint8_t_16,@function
convert_int32_t_uint8_t_16:             # @convert_int32_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI115_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end115:
	.size	convert_int32_t_uint8_t_16, .Lfunc_end115-convert_int32_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI116_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int64_t_uint8_t_2
	.align	16, 0x90
	.type	convert_int64_t_uint8_t_2,@function
convert_int64_t_uint8_t_2:              # @convert_int64_t_uint8_t_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI116_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end116:
	.size	convert_int64_t_uint8_t_2, .Lfunc_end116-convert_int64_t_uint8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI117_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int64_t_uint8_t_4
	.align	16, 0x90
	.type	convert_int64_t_uint8_t_4,@function
convert_int64_t_uint8_t_4:              # @convert_int64_t_uint8_t_4
	.cfi_startproc
# BB#0:
	movdqa	.LCPI117_0(%rip), %xmm0 # xmm0 = [255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end117:
	.size	convert_int64_t_uint8_t_4, .Lfunc_end117-convert_int64_t_uint8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI118_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int64_t_uint8_t_8
	.align	16, 0x90
	.type	convert_int64_t_uint8_t_8,@function
convert_int64_t_uint8_t_8:              # @convert_int64_t_uint8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI118_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end118:
	.size	convert_int64_t_uint8_t_8, .Lfunc_end118-convert_int64_t_uint8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI119_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int64_t_uint8_t_16
	.align	16, 0x90
	.type	convert_int64_t_uint8_t_16,@function
convert_int64_t_uint8_t_16:             # @convert_int64_t_uint8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI119_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	112(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	96(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	80(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	64(%rsi), %xmm3
	pand	%xmm0, %xmm3
	packuswb	%xmm1, %xmm3
	packuswb	%xmm2, %xmm3
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm3, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end119:
	.size	convert_int64_t_uint8_t_16, .Lfunc_end119-convert_int64_t_uint8_t_16
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI120_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint16_t_2
	.align	16, 0x90
	.type	convert_float_uint16_t_2,@function
convert_float_uint16_t_2:               # @convert_float_uint16_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movss	.LCPI120_0(%rip), %xmm1 # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm3
	subss	%xmm1, %xmm3
	cvttss2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rcx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end120:
	.size	convert_float_uint16_t_2, .Lfunc_end120-convert_float_uint16_t_2
	.cfi_endproc

	.globl	convert_float_uint16_t_4
	.align	16, 0x90
	.type	convert_float_uint16_t_4,@function
convert_float_uint16_t_4:               # @convert_float_uint16_t_4
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end121:
	.size	convert_float_uint16_t_4, .Lfunc_end121-convert_float_uint16_t_4
	.cfi_endproc

	.globl	convert_float_uint16_t_8
	.align	16, 0x90
	.type	convert_float_uint16_t_8,@function
convert_float_uint16_t_8:               # @convert_float_uint16_t_8
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end122:
	.size	convert_float_uint16_t_8, .Lfunc_end122-convert_float_uint16_t_8
	.cfi_endproc

	.globl	convert_float_uint16_t_16
	.align	16, 0x90
	.type	convert_float_uint16_t_16,@function
convert_float_uint16_t_16:              # @convert_float_uint16_t_16
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	cvttps2dq	48(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	32(%rsi), %xmm2
	pshuflw	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end123:
	.size	convert_float_uint16_t_16, .Lfunc_end123-convert_float_uint16_t_16
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI124_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint16_t_2
	.align	16, 0x90
	.type	convert_double_uint16_t_2,@function
convert_double_uint16_t_2:              # @convert_double_uint16_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movsd	.LCPI124_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm0, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rcx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end124:
	.size	convert_double_uint16_t_2, .Lfunc_end124-convert_double_uint16_t_2
	.cfi_endproc

	.globl	convert_double_uint16_t_4
	.align	16, 0x90
	.type	convert_double_uint16_t_4,@function
convert_double_uint16_t_4:              # @convert_double_uint16_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end125:
	.size	convert_double_uint16_t_4, .Lfunc_end125-convert_double_uint16_t_4
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI126_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint16_t_8
	.align	16, 0x90
	.type	convert_double_uint16_t_8,@function
convert_double_uint16_t_8:              # @convert_double_uint16_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm5
	movapd	32(%rsi), %xmm4
	movapd	48(%rsi), %xmm3
	movsd	.LCPI126_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm3, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movapd	%xmm5, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	punpcklqdq	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0]
	movapd	%xmm4, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	movapd	%xmm0, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	pextrw	$4, %xmm3, %ecx
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpcklqdq	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0]
	movd	%rdx, %xmm4
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rdx
	xorq	%rax, %rdx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rdx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	pextrw	$4, %xmm4, %eax
	punpcklwd	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1],xmm4[2],xmm5[2],xmm4[3],xmm5[3]
	punpcklwd	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	pextrw	$4, %xmm2, %edx
	movd	%edx, %xmm0
	movd	%ecx, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	pextrw	$4, %xmm5, %ecx
	movd	%ecx, %xmm0
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	movdqa	%xmm4, (%rdi)
	retq
.Lfunc_end126:
	.size	convert_double_uint16_t_8, .Lfunc_end126-convert_double_uint16_t_8
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI127_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint16_t_16
	.align	16, 0x90
	.type	convert_double_uint16_t_16,@function
convert_double_uint16_t_16:             # @convert_double_uint16_t_16
	.cfi_startproc
# BB#0:
	movapd	64(%rsi), %xmm8
	movapd	96(%rsi), %xmm11
	movapd	80(%rsi), %xmm3
	movapd	112(%rsi), %xmm5
	movapd	(%rsi), %xmm7
	movapd	16(%rsi), %xmm6
	movapd	32(%rsi), %xmm4
	movapd	48(%rsi), %xmm2
	movsd	.LCPI127_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm2, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm9
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	movapd	%xmm2, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm9    # xmm9 = xmm9[0],xmm0[0]
	movapd	%xmm6, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	movapd	%xmm6, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movapd	%xmm4, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm6
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm10
	movapd	%xmm7, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	movapd	%xmm7, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	pextrw	$4, %xmm0, %ecx
	punpcklwd	%xmm9, %xmm0    # xmm0 = xmm0[0],xmm9[0],xmm0[1],xmm9[1],xmm0[2],xmm9[2],xmm0[3],xmm9[3]
	punpcklqdq	%xmm10, %xmm6   # xmm6 = xmm6[0],xmm10[0]
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0]
	pextrw	$4, %xmm9, %edx
	movd	%edx, %xmm2
	pextrw	$4, %xmm4, %edx
	punpcklwd	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1],xmm4[2],xmm6[2],xmm4[3],xmm6[3]
	punpcklwd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3]
	movd	%ecx, %xmm0
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	pextrw	$4, %xmm6, %ecx
	movd	%ecx, %xmm2
	movd	%edx, %xmm6
	punpcklwd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	punpcklwd	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0],xmm6[1],xmm0[1],xmm6[2],xmm0[2],xmm6[3],xmm0[3]
	punpcklwd	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1],xmm4[2],xmm6[2],xmm4[3],xmm6[3]
	movapd	%xmm5, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm6
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	movapd	%xmm3, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	movapd	%xmm11, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rdx
	ucomisd	%xmm1, %xmm11
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm11, %xmm11      # xmm11 = xmm11[1,0]
	movapd	%xmm11, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rdx
	ucomisd	%xmm1, %xmm11
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	movapd	%xmm8, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm8, %rdx
	ucomisd	%xmm1, %xmm8
	cmovaeq	%rcx, %rdx
	pextrw	$4, %xmm5, %ecx
	punpcklwd	%xmm6, %xmm5    # xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1],xmm5[2],xmm6[2],xmm5[3],xmm6[3]
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movd	%rdx, %xmm2
	shufpd	$1, %xmm8, %xmm8        # xmm8 = xmm8[1,0]
	movapd	%xmm8, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rdx
	xorq	%rax, %rdx
	cvttsd2si	%xmm8, %rax
	ucomisd	%xmm1, %xmm8
	cmovaeq	%rdx, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pextrw	$4, %xmm2, %eax
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1],xmm2[2],xmm5[2],xmm2[3],xmm5[3]
	pextrw	$4, %xmm6, %edx
	movd	%edx, %xmm1
	movd	%ecx, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	pextrw	$4, %xmm0, %ecx
	movd	%ecx, %xmm0
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	punpcklwd	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm4, (%rdi)
	retq
.Lfunc_end127:
	.size	convert_double_uint16_t_16, .Lfunc_end127-convert_double_uint16_t_16
	.cfi_endproc

	.globl	convert_uint8_t_uint16_t_2
	.align	16, 0x90
	.type	convert_uint8_t_uint16_t_2,@function
convert_uint8_t_uint16_t_2:             # @convert_uint8_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end128:
	.size	convert_uint8_t_uint16_t_2, .Lfunc_end128-convert_uint8_t_uint16_t_2
	.cfi_endproc

	.globl	convert_uint8_t_uint16_t_4
	.align	16, 0x90
	.type	convert_uint8_t_uint16_t_4,@function
convert_uint8_t_uint16_t_4:             # @convert_uint8_t_uint16_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end129:
	.size	convert_uint8_t_uint16_t_4, .Lfunc_end129-convert_uint8_t_uint16_t_4
	.cfi_endproc

	.globl	convert_uint8_t_uint16_t_8
	.align	16, 0x90
	.type	convert_uint8_t_uint16_t_8,@function
convert_uint8_t_uint16_t_8:             # @convert_uint8_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end130:
	.size	convert_uint8_t_uint16_t_8, .Lfunc_end130-convert_uint8_t_uint16_t_8
	.cfi_endproc

	.globl	convert_uint8_t_uint16_t_16
	.align	16, 0x90
	.type	convert_uint8_t_uint16_t_16,@function
convert_uint8_t_uint16_t_16:            # @convert_uint8_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end131:
	.size	convert_uint8_t_uint16_t_16, .Lfunc_end131-convert_uint8_t_uint16_t_16
	.cfi_endproc

	.globl	convert_uint16_t_uint16_t_2
	.align	16, 0x90
	.type	convert_uint16_t_uint16_t_2,@function
convert_uint16_t_uint16_t_2:            # @convert_uint16_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end132:
	.size	convert_uint16_t_uint16_t_2, .Lfunc_end132-convert_uint16_t_uint16_t_2
	.cfi_endproc

	.globl	convert_uint16_t_uint16_t_4
	.align	16, 0x90
	.type	convert_uint16_t_uint16_t_4,@function
convert_uint16_t_uint16_t_4:            # @convert_uint16_t_uint16_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end133:
	.size	convert_uint16_t_uint16_t_4, .Lfunc_end133-convert_uint16_t_uint16_t_4
	.cfi_endproc

	.globl	convert_uint16_t_uint16_t_8
	.align	16, 0x90
	.type	convert_uint16_t_uint16_t_8,@function
convert_uint16_t_uint16_t_8:            # @convert_uint16_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end134:
	.size	convert_uint16_t_uint16_t_8, .Lfunc_end134-convert_uint16_t_uint16_t_8
	.cfi_endproc

	.globl	convert_uint16_t_uint16_t_16
	.align	16, 0x90
	.type	convert_uint16_t_uint16_t_16,@function
convert_uint16_t_uint16_t_16:           # @convert_uint16_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end135:
	.size	convert_uint16_t_uint16_t_16, .Lfunc_end135-convert_uint16_t_uint16_t_16
	.cfi_endproc

	.globl	convert_uint32_t_uint16_t_2
	.align	16, 0x90
	.type	convert_uint32_t_uint16_t_2,@function
convert_uint32_t_uint16_t_2:            # @convert_uint32_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end136:
	.size	convert_uint32_t_uint16_t_2, .Lfunc_end136-convert_uint32_t_uint16_t_2
	.cfi_endproc

	.globl	convert_uint32_t_uint16_t_4
	.align	16, 0x90
	.type	convert_uint32_t_uint16_t_4,@function
convert_uint32_t_uint16_t_4:            # @convert_uint32_t_uint16_t_4
	.cfi_startproc
# BB#0:
	pshuflw	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end137:
	.size	convert_uint32_t_uint16_t_4, .Lfunc_end137-convert_uint32_t_uint16_t_4
	.cfi_endproc

	.globl	convert_uint32_t_uint16_t_8
	.align	16, 0x90
	.type	convert_uint32_t_uint16_t_8,@function
convert_uint32_t_uint16_t_8:            # @convert_uint32_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end138:
	.size	convert_uint32_t_uint16_t_8, .Lfunc_end138-convert_uint32_t_uint16_t_8
	.cfi_endproc

	.globl	convert_uint32_t_uint16_t_16
	.align	16, 0x90
	.type	convert_uint32_t_uint16_t_16,@function
convert_uint32_t_uint16_t_16:           # @convert_uint32_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	pslld	$16, %xmm3
	psrad	$16, %xmm3
	pslld	$16, %xmm2
	psrad	$16, %xmm2
	packssdw	%xmm3, %xmm2
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end139:
	.size	convert_uint32_t_uint16_t_16, .Lfunc_end139-convert_uint32_t_uint16_t_16
	.cfi_endproc

	.globl	convert_uint64_t_uint16_t_2
	.align	16, 0x90
	.type	convert_uint64_t_uint16_t_2,@function
convert_uint64_t_uint16_t_2:            # @convert_uint64_t_uint16_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end140:
	.size	convert_uint64_t_uint16_t_2, .Lfunc_end140-convert_uint64_t_uint16_t_2
	.cfi_endproc

	.globl	convert_uint64_t_uint16_t_4
	.align	16, 0x90
	.type	convert_uint64_t_uint16_t_4,@function
convert_uint64_t_uint16_t_4:            # @convert_uint64_t_uint16_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end141:
	.size	convert_uint64_t_uint16_t_4, .Lfunc_end141-convert_uint64_t_uint16_t_4
	.cfi_endproc

	.globl	convert_uint64_t_uint16_t_8
	.align	16, 0x90
	.type	convert_uint64_t_uint16_t_8,@function
convert_uint64_t_uint16_t_8:            # @convert_uint64_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm5
	punpcklwd	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1],xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	pextrw	$4, %xmm2, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1],xmm6[2],xmm4[2],xmm6[3],xmm4[3]
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1],xmm0[2],xmm6[2],xmm0[3],xmm6[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end142:
	.size	convert_uint64_t_uint16_t_8, .Lfunc_end142-convert_uint64_t_uint16_t_8
	.cfi_endproc

	.globl	convert_uint64_t_uint16_t_16
	.align	16, 0x90
	.type	convert_uint64_t_uint16_t_16,@function
convert_uint64_t_uint16_t_16:           # @convert_uint64_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm4
	movdqa	96(%rsi), %xmm5
	movdqa	64(%rsi), %xmm2
	movdqa	112(%rsi), %xmm6
	movdqa	80(%rsi), %xmm7
	pextrw	$4, %xmm7, %eax
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1],xmm2[2],xmm5[2],xmm2[3],xmm5[3]
	punpcklwd	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1],xmm2[2],xmm7[2],xmm2[3],xmm7[3]
	pextrw	$4, %xmm6, %edx
	movd	%edx, %xmm6
	movd	%eax, %xmm7
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm5, %eax
	movd	%eax, %xmm5
	movd	%ecx, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
	punpcklwd	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
	pextrw	$4, %xmm4, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm7
	punpcklwd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0],xmm7[1],xmm5[1],xmm7[2],xmm5[2],xmm7[3],xmm5[3]
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	punpcklwd	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end143:
	.size	convert_uint64_t_uint16_t_16, .Lfunc_end143-convert_uint64_t_uint16_t_16
	.cfi_endproc

	.globl	convert_int8_t_uint16_t_2
	.align	16, 0x90
	.type	convert_int8_t_uint16_t_2,@function
convert_int8_t_uint16_t_2:              # @convert_int8_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end144:
	.size	convert_int8_t_uint16_t_2, .Lfunc_end144-convert_int8_t_uint16_t_2
	.cfi_endproc

	.globl	convert_int8_t_uint16_t_4
	.align	16, 0x90
	.type	convert_int8_t_uint16_t_4,@function
convert_int8_t_uint16_t_4:              # @convert_int8_t_uint16_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end145:
	.size	convert_int8_t_uint16_t_4, .Lfunc_end145-convert_int8_t_uint16_t_4
	.cfi_endproc

	.globl	convert_int8_t_uint16_t_8
	.align	16, 0x90
	.type	convert_int8_t_uint16_t_8,@function
convert_int8_t_uint16_t_8:              # @convert_int8_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end146:
	.size	convert_int8_t_uint16_t_8, .Lfunc_end146-convert_int8_t_uint16_t_8
	.cfi_endproc

	.globl	convert_int8_t_uint16_t_16
	.align	16, 0x90
	.type	convert_int8_t_uint16_t_16,@function
convert_int8_t_uint16_t_16:             # @convert_int8_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end147:
	.size	convert_int8_t_uint16_t_16, .Lfunc_end147-convert_int8_t_uint16_t_16
	.cfi_endproc

	.globl	convert_int16_t_uint16_t_2
	.align	16, 0x90
	.type	convert_int16_t_uint16_t_2,@function
convert_int16_t_uint16_t_2:             # @convert_int16_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end148:
	.size	convert_int16_t_uint16_t_2, .Lfunc_end148-convert_int16_t_uint16_t_2
	.cfi_endproc

	.globl	convert_int16_t_uint16_t_4
	.align	16, 0x90
	.type	convert_int16_t_uint16_t_4,@function
convert_int16_t_uint16_t_4:             # @convert_int16_t_uint16_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end149:
	.size	convert_int16_t_uint16_t_4, .Lfunc_end149-convert_int16_t_uint16_t_4
	.cfi_endproc

	.globl	convert_int16_t_uint16_t_8
	.align	16, 0x90
	.type	convert_int16_t_uint16_t_8,@function
convert_int16_t_uint16_t_8:             # @convert_int16_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end150:
	.size	convert_int16_t_uint16_t_8, .Lfunc_end150-convert_int16_t_uint16_t_8
	.cfi_endproc

	.globl	convert_int16_t_uint16_t_16
	.align	16, 0x90
	.type	convert_int16_t_uint16_t_16,@function
convert_int16_t_uint16_t_16:            # @convert_int16_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end151:
	.size	convert_int16_t_uint16_t_16, .Lfunc_end151-convert_int16_t_uint16_t_16
	.cfi_endproc

	.globl	convert_int32_t_uint16_t_2
	.align	16, 0x90
	.type	convert_int32_t_uint16_t_2,@function
convert_int32_t_uint16_t_2:             # @convert_int32_t_uint16_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end152:
	.size	convert_int32_t_uint16_t_2, .Lfunc_end152-convert_int32_t_uint16_t_2
	.cfi_endproc

	.globl	convert_int32_t_uint16_t_4
	.align	16, 0x90
	.type	convert_int32_t_uint16_t_4,@function
convert_int32_t_uint16_t_4:             # @convert_int32_t_uint16_t_4
	.cfi_startproc
# BB#0:
	pshuflw	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end153:
	.size	convert_int32_t_uint16_t_4, .Lfunc_end153-convert_int32_t_uint16_t_4
	.cfi_endproc

	.globl	convert_int32_t_uint16_t_8
	.align	16, 0x90
	.type	convert_int32_t_uint16_t_8,@function
convert_int32_t_uint16_t_8:             # @convert_int32_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end154:
	.size	convert_int32_t_uint16_t_8, .Lfunc_end154-convert_int32_t_uint16_t_8
	.cfi_endproc

	.globl	convert_int32_t_uint16_t_16
	.align	16, 0x90
	.type	convert_int32_t_uint16_t_16,@function
convert_int32_t_uint16_t_16:            # @convert_int32_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	pslld	$16, %xmm3
	psrad	$16, %xmm3
	pslld	$16, %xmm2
	psrad	$16, %xmm2
	packssdw	%xmm3, %xmm2
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end155:
	.size	convert_int32_t_uint16_t_16, .Lfunc_end155-convert_int32_t_uint16_t_16
	.cfi_endproc

	.globl	convert_int64_t_uint16_t_2
	.align	16, 0x90
	.type	convert_int64_t_uint16_t_2,@function
convert_int64_t_uint16_t_2:             # @convert_int64_t_uint16_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end156:
	.size	convert_int64_t_uint16_t_2, .Lfunc_end156-convert_int64_t_uint16_t_2
	.cfi_endproc

	.globl	convert_int64_t_uint16_t_4
	.align	16, 0x90
	.type	convert_int64_t_uint16_t_4,@function
convert_int64_t_uint16_t_4:             # @convert_int64_t_uint16_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end157:
	.size	convert_int64_t_uint16_t_4, .Lfunc_end157-convert_int64_t_uint16_t_4
	.cfi_endproc

	.globl	convert_int64_t_uint16_t_8
	.align	16, 0x90
	.type	convert_int64_t_uint16_t_8,@function
convert_int64_t_uint16_t_8:             # @convert_int64_t_uint16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm5
	punpcklwd	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1],xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	pextrw	$4, %xmm2, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1],xmm6[2],xmm4[2],xmm6[3],xmm4[3]
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1],xmm0[2],xmm6[2],xmm0[3],xmm6[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end158:
	.size	convert_int64_t_uint16_t_8, .Lfunc_end158-convert_int64_t_uint16_t_8
	.cfi_endproc

	.globl	convert_int64_t_uint16_t_16
	.align	16, 0x90
	.type	convert_int64_t_uint16_t_16,@function
convert_int64_t_uint16_t_16:            # @convert_int64_t_uint16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm4
	movdqa	96(%rsi), %xmm5
	movdqa	64(%rsi), %xmm2
	movdqa	112(%rsi), %xmm6
	movdqa	80(%rsi), %xmm7
	pextrw	$4, %xmm7, %eax
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1],xmm2[2],xmm5[2],xmm2[3],xmm5[3]
	punpcklwd	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1],xmm2[2],xmm7[2],xmm2[3],xmm7[3]
	pextrw	$4, %xmm6, %edx
	movd	%edx, %xmm6
	movd	%eax, %xmm7
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm5, %eax
	movd	%eax, %xmm5
	movd	%ecx, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
	punpcklwd	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
	pextrw	$4, %xmm4, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm7
	punpcklwd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0],xmm7[1],xmm5[1],xmm7[2],xmm5[2],xmm7[3],xmm5[3]
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	punpcklwd	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end159:
	.size	convert_int64_t_uint16_t_16, .Lfunc_end159-convert_int64_t_uint16_t_16
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI160_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint32_t_2
	.align	16, 0x90
	.type	convert_float_uint32_t_2,@function
convert_float_uint32_t_2:               # @convert_float_uint32_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movss	.LCPI160_0(%rip), %xmm1 # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm3
	subss	%xmm1, %xmm3
	cvttss2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rcx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end160:
	.size	convert_float_uint32_t_2, .Lfunc_end160-convert_float_uint32_t_2
	.cfi_endproc

	.globl	convert_float_uint32_t_4
	.align	16, 0x90
	.type	convert_float_uint32_t_4,@function
convert_float_uint32_t_4:               # @convert_float_uint32_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, %xmm1
	shufps	$231, %xmm1, %xmm1      # xmm1 = xmm1[3,1,2,3]
	cvttss2si	%xmm1, %rax
	movd	%eax, %xmm1
	movaps	%xmm0, %xmm2
	shufps	$229, %xmm2, %xmm2      # xmm2 = xmm2[1,1,2,3]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm2
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm0
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end161:
	.size	convert_float_uint32_t_4, .Lfunc_end161-convert_float_uint32_t_4
	.cfi_endproc

	.globl	convert_float_uint32_t_8
	.align	16, 0x90
	.type	convert_float_uint32_t_8,@function
convert_float_uint32_t_8:               # @convert_float_uint32_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm2
	movaps	16(%rsi), %xmm0
	movaps	%xmm2, %xmm1
	shufps	$231, %xmm1, %xmm1      # xmm1 = xmm1[3,1,2,3]
	cvttss2si	%xmm1, %rax
	movd	%eax, %xmm1
	movaps	%xmm2, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%eax, %xmm3
	punpckldq	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm1
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm2
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	punpckldq	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	movaps	%xmm0, %xmm2
	shufps	$231, %xmm2, %xmm2      # xmm2 = xmm2[3,1,2,3]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm2
	movaps	%xmm0, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%eax, %xmm3
	punpckldq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm0
	punpckldq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	punpckldq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end162:
	.size	convert_float_uint32_t_8, .Lfunc_end162-convert_float_uint32_t_8
	.cfi_endproc

	.globl	convert_float_uint32_t_16
	.align	16, 0x90
	.type	convert_float_uint32_t_16,@function
convert_float_uint32_t_16:              # @convert_float_uint32_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm3
	movaps	16(%rsi), %xmm4
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm0
	movaps	%xmm3, %xmm1
	shufps	$231, %xmm1, %xmm1      # xmm1 = xmm1[3,1,2,3]
	cvttss2si	%xmm1, %rax
	movd	%eax, %xmm1
	movaps	%xmm3, %xmm5
	shufps	$229, %xmm5, %xmm5      # xmm5 = xmm5[1,1,2,3]
	cvttss2si	%xmm5, %rax
	movd	%eax, %xmm5
	punpckldq	%xmm1, %xmm5    # xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
	cvttss2si	%xmm3, %rax
	movd	%eax, %xmm1
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttss2si	%xmm3, %rax
	movd	%eax, %xmm3
	punpckldq	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	punpckldq	%xmm5, %xmm1    # xmm1 = xmm1[0],xmm5[0],xmm1[1],xmm5[1]
	movaps	%xmm4, %xmm3
	shufps	$231, %xmm3, %xmm3      # xmm3 = xmm3[3,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%eax, %xmm3
	movaps	%xmm4, %xmm5
	shufps	$229, %xmm5, %xmm5      # xmm5 = xmm5[1,1,2,3]
	cvttss2si	%xmm5, %rax
	movd	%eax, %xmm5
	punpckldq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
	cvttss2si	%xmm4, %rax
	movd	%eax, %xmm3
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttss2si	%xmm4, %rax
	movd	%eax, %xmm4
	punpckldq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
	punpckldq	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0],xmm3[1],xmm5[1]
	movaps	%xmm2, %xmm4
	shufps	$231, %xmm4, %xmm4      # xmm4 = xmm4[3,1,2,3]
	cvttss2si	%xmm4, %rax
	movd	%eax, %xmm4
	movaps	%xmm2, %xmm5
	shufps	$229, %xmm5, %xmm5      # xmm5 = xmm5[1,1,2,3]
	cvttss2si	%xmm5, %rax
	movd	%eax, %xmm5
	punpckldq	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm4
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm2
	punpckldq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	punpckldq	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
	movaps	%xmm0, %xmm2
	shufps	$231, %xmm2, %xmm2      # xmm2 = xmm2[3,1,2,3]
	cvttss2si	%xmm2, %rax
	movd	%eax, %xmm2
	movaps	%xmm0, %xmm5
	shufps	$229, %xmm5, %xmm5      # xmm5 = xmm5[1,1,2,3]
	cvttss2si	%xmm5, %rax
	movd	%eax, %xmm5
	punpckldq	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttss2si	%xmm0, %rax
	movd	%eax, %xmm0
	punpckldq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	punpckldq	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1]
	movdqa	%xmm2, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end163:
	.size	convert_float_uint32_t_16, .Lfunc_end163-convert_float_uint32_t_16
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI164_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint32_t_2
	.align	16, 0x90
	.type	convert_double_uint32_t_2,@function
convert_double_uint32_t_2:              # @convert_double_uint32_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movsd	.LCPI164_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm0, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rcx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end164:
	.size	convert_double_uint32_t_2, .Lfunc_end164-convert_double_uint32_t_2
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI165_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint32_t_4
	.align	16, 0x90
	.type	convert_double_uint32_t_4,@function
convert_double_uint32_t_4:              # @convert_double_uint32_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm2
	movsd	.LCPI165_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm2, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	movapd	%xmm2, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0]
	pshufd	$232, %xmm3, %xmm2      # xmm2 = xmm3[0,2,2,3]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, %xmm3, %xmm0      # xmm0 = xmm3[0,2,2,3]
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end165:
	.size	convert_double_uint32_t_4, .Lfunc_end165-convert_double_uint32_t_4
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI166_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint32_t_8
	.align	16, 0x90
	.type	convert_double_uint32_t_8,@function
convert_double_uint32_t_8:              # @convert_double_uint32_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm3
	movapd	16(%rsi), %xmm4
	movapd	32(%rsi), %xmm0
	movapd	48(%rsi), %xmm2
	movsd	.LCPI166_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm4, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0]
	pshufd	$232, %xmm5, %xmm4      # xmm4 = xmm5[0,2,2,3]
	movapd	%xmm3, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	pshufd	$232, %xmm5, %xmm3      # xmm3 = xmm5[0,2,2,3]
	punpcklqdq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0]
	movapd	%xmm2, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	movapd	%xmm2, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm2, %rdx
	ucomisd	%xmm1, %xmm2
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0]
	pshufd	$232, %xmm4, %xmm2      # xmm2 = xmm4[0,2,2,3]
	movapd	%xmm0, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	pshufd	$232, %xmm4, %xmm0      # xmm0 = xmm4[0,2,2,3]
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end166:
	.size	convert_double_uint32_t_8, .Lfunc_end166-convert_double_uint32_t_8
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI167_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint32_t_16
	.align	16, 0x90
	.type	convert_double_uint32_t_16,@function
convert_double_uint32_t_16:             # @convert_double_uint32_t_16
	.cfi_startproc
# BB#0:
	movapd	96(%rsi), %xmm8
	movapd	112(%rsi), %xmm9
	movapd	64(%rsi), %xmm10
	movapd	80(%rsi), %xmm5
	movapd	(%rsi), %xmm3
	movapd	16(%rsi), %xmm4
	movapd	32(%rsi), %xmm6
	movapd	48(%rsi), %xmm7
	movsd	.LCPI167_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm4, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movapd	%xmm3, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	pshufd	$232, %xmm2, %xmm3      # xmm3 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movapd	%xmm7, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	movapd	%xmm7, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm1, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movapd	%xmm6, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	movapd	%xmm6, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm1, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0]
	pshufd	$232, %xmm2, %xmm6      # xmm6 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	movapd	%xmm5, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movapd	%xmm10, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm10, %rdx
	ucomisd	%xmm1, %xmm10
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm10, %xmm10      # xmm10 = xmm10[1,0]
	movapd	%xmm10, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm10, %rdx
	ucomisd	%xmm1, %xmm10
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0]
	pshufd	$232, %xmm2, %xmm4      # xmm4 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movapd	%xmm9, %xmm0
	subsd	%xmm1, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm9, %rdx
	ucomisd	%xmm1, %xmm9
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm9, %xmm9        # xmm9 = xmm9[1,0]
	movapd	%xmm9, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm9, %rdx
	ucomisd	%xmm1, %xmm9
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movapd	%xmm8, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm8, %rdx
	ucomisd	%xmm1, %xmm8
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm8, %xmm8        # xmm8 = xmm8[1,0]
	movapd	%xmm8, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm8, %rax
	ucomisd	%xmm1, %xmm8
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm6, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end167:
	.size	convert_double_uint32_t_16, .Lfunc_end167-convert_double_uint32_t_16
	.cfi_endproc

	.globl	convert_uint8_t_uint32_t_2
	.align	16, 0x90
	.type	convert_uint8_t_uint32_t_2,@function
convert_uint8_t_uint32_t_2:             # @convert_uint8_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end168:
	.size	convert_uint8_t_uint32_t_2, .Lfunc_end168-convert_uint8_t_uint32_t_2
	.cfi_endproc

	.globl	convert_uint8_t_uint32_t_4
	.align	16, 0x90
	.type	convert_uint8_t_uint32_t_4,@function
convert_uint8_t_uint32_t_4:             # @convert_uint8_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end169:
	.size	convert_uint8_t_uint32_t_4, .Lfunc_end169-convert_uint8_t_uint32_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI170_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_uint32_t_8
	.align	16, 0x90
	.type	convert_uint8_t_uint32_t_8,@function
convert_uint8_t_uint32_t_8:             # @convert_uint8_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movdqa	.LCPI170_0(%rip), %xmm2 # xmm2 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	pand	%xmm2, %xmm1
	punpckhwd	%xmm0, %xmm0    # xmm0 = xmm0[4,4,5,5,6,6,7,7]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end170:
	.size	convert_uint8_t_uint32_t_8, .Lfunc_end170-convert_uint8_t_uint32_t_8
	.cfi_endproc

	.globl	convert_uint8_t_uint32_t_16
	.align	16, 0x90
	.type	convert_uint8_t_uint32_t_16,@function
convert_uint8_t_uint32_t_16:            # @convert_uint8_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm4
	punpcklwd	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end171:
	.size	convert_uint8_t_uint32_t_16, .Lfunc_end171-convert_uint8_t_uint32_t_16
	.cfi_endproc

	.globl	convert_uint16_t_uint32_t_2
	.align	16, 0x90
	.type	convert_uint16_t_uint32_t_2,@function
convert_uint16_t_uint32_t_2:            # @convert_uint16_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end172:
	.size	convert_uint16_t_uint32_t_2, .Lfunc_end172-convert_uint16_t_uint32_t_2
	.cfi_endproc

	.globl	convert_uint16_t_uint32_t_4
	.align	16, 0x90
	.type	convert_uint16_t_uint32_t_4,@function
convert_uint16_t_uint32_t_4:            # @convert_uint16_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end173:
	.size	convert_uint16_t_uint32_t_4, .Lfunc_end173-convert_uint16_t_uint32_t_4
	.cfi_endproc

	.globl	convert_uint16_t_uint32_t_8
	.align	16, 0x90
	.type	convert_uint16_t_uint32_t_8,@function
convert_uint16_t_uint32_t_8:            # @convert_uint16_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end174:
	.size	convert_uint16_t_uint32_t_8, .Lfunc_end174-convert_uint16_t_uint32_t_8
	.cfi_endproc

	.globl	convert_uint16_t_uint32_t_16
	.align	16, 0x90
	.type	convert_uint16_t_uint32_t_16,@function
convert_uint16_t_uint32_t_16:           # @convert_uint16_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movdqa	%xmm1, %xmm4
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end175:
	.size	convert_uint16_t_uint32_t_16, .Lfunc_end175-convert_uint16_t_uint32_t_16
	.cfi_endproc

	.globl	convert_uint32_t_uint32_t_2
	.align	16, 0x90
	.type	convert_uint32_t_uint32_t_2,@function
convert_uint32_t_uint32_t_2:            # @convert_uint32_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end176:
	.size	convert_uint32_t_uint32_t_2, .Lfunc_end176-convert_uint32_t_uint32_t_2
	.cfi_endproc

	.globl	convert_uint32_t_uint32_t_4
	.align	16, 0x90
	.type	convert_uint32_t_uint32_t_4,@function
convert_uint32_t_uint32_t_4:            # @convert_uint32_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end177:
	.size	convert_uint32_t_uint32_t_4, .Lfunc_end177-convert_uint32_t_uint32_t_4
	.cfi_endproc

	.globl	convert_uint32_t_uint32_t_8
	.align	16, 0x90
	.type	convert_uint32_t_uint32_t_8,@function
convert_uint32_t_uint32_t_8:            # @convert_uint32_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end178:
	.size	convert_uint32_t_uint32_t_8, .Lfunc_end178-convert_uint32_t_uint32_t_8
	.cfi_endproc

	.globl	convert_uint32_t_uint32_t_16
	.align	16, 0x90
	.type	convert_uint32_t_uint32_t_16,@function
convert_uint32_t_uint32_t_16:           # @convert_uint32_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end179:
	.size	convert_uint32_t_uint32_t_16, .Lfunc_end179-convert_uint32_t_uint32_t_16
	.cfi_endproc

	.globl	convert_uint64_t_uint32_t_2
	.align	16, 0x90
	.type	convert_uint64_t_uint32_t_2,@function
convert_uint64_t_uint32_t_2:            # @convert_uint64_t_uint32_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end180:
	.size	convert_uint64_t_uint32_t_2, .Lfunc_end180-convert_uint64_t_uint32_t_2
	.cfi_endproc

	.globl	convert_uint64_t_uint32_t_4
	.align	16, 0x90
	.type	convert_uint64_t_uint32_t_4,@function
convert_uint64_t_uint32_t_4:            # @convert_uint64_t_uint32_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end181:
	.size	convert_uint64_t_uint32_t_4, .Lfunc_end181-convert_uint64_t_uint32_t_4
	.cfi_endproc

	.globl	convert_uint64_t_uint32_t_8
	.align	16, 0x90
	.type	convert_uint64_t_uint32_t_8,@function
convert_uint64_t_uint32_t_8:            # @convert_uint64_t_uint32_t_8
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end182:
	.size	convert_uint64_t_uint32_t_8, .Lfunc_end182-convert_uint64_t_uint32_t_8
	.cfi_endproc

	.globl	convert_uint64_t_uint32_t_16
	.align	16, 0x90
	.type	convert_uint64_t_uint32_t_16,@function
convert_uint64_t_uint32_t_16:           # @convert_uint64_t_uint32_t_16
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, 80(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 64(%rsi), %xmm3   # xmm3 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, 112(%rsi), %xmm0  # xmm0 = mem[0,2,2,3]
	pshufd	$232, 96(%rsi), %xmm4   # xmm4 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end183:
	.size	convert_uint64_t_uint32_t_16, .Lfunc_end183-convert_uint64_t_uint32_t_16
	.cfi_endproc

	.globl	convert_int8_t_uint32_t_2
	.align	16, 0x90
	.type	convert_int8_t_uint32_t_2,@function
convert_int8_t_uint32_t_2:              # @convert_int8_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end184:
	.size	convert_int8_t_uint32_t_2, .Lfunc_end184-convert_int8_t_uint32_t_2
	.cfi_endproc

	.globl	convert_int8_t_uint32_t_4
	.align	16, 0x90
	.type	convert_int8_t_uint32_t_4,@function
convert_int8_t_uint32_t_4:              # @convert_int8_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end185:
	.size	convert_int8_t_uint32_t_4, .Lfunc_end185-convert_int8_t_uint32_t_4
	.cfi_endproc

	.globl	convert_int8_t_uint32_t_8
	.align	16, 0x90
	.type	convert_int8_t_uint32_t_8,@function
convert_int8_t_uint32_t_8:              # @convert_int8_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end186:
	.size	convert_int8_t_uint32_t_8, .Lfunc_end186-convert_int8_t_uint32_t_8
	.cfi_endproc

	.globl	convert_int8_t_uint32_t_16
	.align	16, 0x90
	.type	convert_int8_t_uint32_t_16,@function
convert_int8_t_uint32_t_16:             # @convert_int8_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	movd	8(%rsi), %xmm2          # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm2
	movd	12(%rsi), %xmm3         # xmm3 = mem[0],zero,zero,zero
	punpcklbw	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm3
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end187:
	.size	convert_int8_t_uint32_t_16, .Lfunc_end187-convert_int8_t_uint32_t_16
	.cfi_endproc

	.globl	convert_int16_t_uint32_t_2
	.align	16, 0x90
	.type	convert_int16_t_uint32_t_2,@function
convert_int16_t_uint32_t_2:             # @convert_int16_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end188:
	.size	convert_int16_t_uint32_t_2, .Lfunc_end188-convert_int16_t_uint32_t_2
	.cfi_endproc

	.globl	convert_int16_t_uint32_t_4
	.align	16, 0x90
	.type	convert_int16_t_uint32_t_4,@function
convert_int16_t_uint32_t_4:             # @convert_int16_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end189:
	.size	convert_int16_t_uint32_t_4, .Lfunc_end189-convert_int16_t_uint32_t_4
	.cfi_endproc

	.globl	convert_int16_t_uint32_t_8
	.align	16, 0x90
	.type	convert_int16_t_uint32_t_8,@function
convert_int16_t_uint32_t_8:             # @convert_int16_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end190:
	.size	convert_int16_t_uint32_t_8, .Lfunc_end190-convert_int16_t_uint32_t_8
	.cfi_endproc

	.globl	convert_int16_t_uint32_t_16
	.align	16, 0x90
	.type	convert_int16_t_uint32_t_16,@function
convert_int16_t_uint32_t_16:            # @convert_int16_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	movq	16(%rsi), %xmm2         # xmm2 = mem[0],zero
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm2
	movq	24(%rsi), %xmm3         # xmm3 = mem[0],zero
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm3
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end191:
	.size	convert_int16_t_uint32_t_16, .Lfunc_end191-convert_int16_t_uint32_t_16
	.cfi_endproc

	.globl	convert_int32_t_uint32_t_2
	.align	16, 0x90
	.type	convert_int32_t_uint32_t_2,@function
convert_int32_t_uint32_t_2:             # @convert_int32_t_uint32_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end192:
	.size	convert_int32_t_uint32_t_2, .Lfunc_end192-convert_int32_t_uint32_t_2
	.cfi_endproc

	.globl	convert_int32_t_uint32_t_4
	.align	16, 0x90
	.type	convert_int32_t_uint32_t_4,@function
convert_int32_t_uint32_t_4:             # @convert_int32_t_uint32_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end193:
	.size	convert_int32_t_uint32_t_4, .Lfunc_end193-convert_int32_t_uint32_t_4
	.cfi_endproc

	.globl	convert_int32_t_uint32_t_8
	.align	16, 0x90
	.type	convert_int32_t_uint32_t_8,@function
convert_int32_t_uint32_t_8:             # @convert_int32_t_uint32_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end194:
	.size	convert_int32_t_uint32_t_8, .Lfunc_end194-convert_int32_t_uint32_t_8
	.cfi_endproc

	.globl	convert_int32_t_uint32_t_16
	.align	16, 0x90
	.type	convert_int32_t_uint32_t_16,@function
convert_int32_t_uint32_t_16:            # @convert_int32_t_uint32_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end195:
	.size	convert_int32_t_uint32_t_16, .Lfunc_end195-convert_int32_t_uint32_t_16
	.cfi_endproc

	.globl	convert_int64_t_uint32_t_2
	.align	16, 0x90
	.type	convert_int64_t_uint32_t_2,@function
convert_int64_t_uint32_t_2:             # @convert_int64_t_uint32_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end196:
	.size	convert_int64_t_uint32_t_2, .Lfunc_end196-convert_int64_t_uint32_t_2
	.cfi_endproc

	.globl	convert_int64_t_uint32_t_4
	.align	16, 0x90
	.type	convert_int64_t_uint32_t_4,@function
convert_int64_t_uint32_t_4:             # @convert_int64_t_uint32_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end197:
	.size	convert_int64_t_uint32_t_4, .Lfunc_end197-convert_int64_t_uint32_t_4
	.cfi_endproc

	.globl	convert_int64_t_uint32_t_8
	.align	16, 0x90
	.type	convert_int64_t_uint32_t_8,@function
convert_int64_t_uint32_t_8:             # @convert_int64_t_uint32_t_8
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end198:
	.size	convert_int64_t_uint32_t_8, .Lfunc_end198-convert_int64_t_uint32_t_8
	.cfi_endproc

	.globl	convert_int64_t_uint32_t_16
	.align	16, 0x90
	.type	convert_int64_t_uint32_t_16,@function
convert_int64_t_uint32_t_16:            # @convert_int64_t_uint32_t_16
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, 80(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 64(%rsi), %xmm3   # xmm3 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, 112(%rsi), %xmm0  # xmm0 = mem[0,2,2,3]
	pshufd	$232, 96(%rsi), %xmm4   # xmm4 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end199:
	.size	convert_int64_t_uint32_t_16, .Lfunc_end199-convert_int64_t_uint32_t_16
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI200_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint64_t_2
	.align	16, 0x90
	.type	convert_float_uint64_t_2,@function
convert_float_uint64_t_2:               # @convert_float_uint64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movss	.LCPI200_0(%rip), %xmm1 # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm3
	subss	%xmm1, %xmm3
	cvttss2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rcx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end200:
	.size	convert_float_uint64_t_2, .Lfunc_end200-convert_float_uint64_t_2
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI201_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint64_t_4
	.align	16, 0x90
	.type	convert_float_uint64_t_4,@function
convert_float_uint64_t_4:               # @convert_float_uint64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movss	.LCPI201_0(%rip), %xmm1 # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	movaps	%xmm0, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	movaps	%xmm3, %xmm4
	subss	%xmm1, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movaps	%xmm0, %xmm3
	shufps	$231, %xmm3, %xmm3      # xmm3 = xmm3[3,1,2,3]
	movaps	%xmm3, %xmm4
	subss	%xmm1, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm4
	subss	%xmm1, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rax
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end201:
	.size	convert_float_uint64_t_4, .Lfunc_end201-convert_float_uint64_t_4
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI202_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint64_t_8
	.align	16, 0x90
	.type	convert_float_uint64_t_8,@function
convert_float_uint64_t_8:               # @convert_float_uint64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm3
	movaps	16(%rsi), %xmm0
	movss	.LCPI202_0(%rip), %xmm1 # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm3, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	movaps	%xmm3, %xmm4
	shufps	$229, %xmm4, %xmm4      # xmm4 = xmm4[1,1,2,3]
	movaps	%xmm4, %xmm5
	subss	%xmm1, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm4, %rdx
	ucomiss	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0]
	movaps	%xmm3, %xmm4
	shufps	$231, %xmm4, %xmm4      # xmm4 = xmm4[3,1,2,3]
	movaps	%xmm4, %xmm5
	subss	%xmm1, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm4, %rdx
	ucomiss	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm5
	subss	%xmm1, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0]
	movaps	%xmm0, %xmm4
	subss	%xmm1, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	movaps	%xmm0, %xmm5
	shufps	$229, %xmm5, %xmm5      # xmm5 = xmm5[1,1,2,3]
	movaps	%xmm5, %xmm6
	subss	%xmm1, %xmm6
	cvttss2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm5, %rdx
	ucomiss	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	punpcklqdq	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0]
	movaps	%xmm0, %xmm5
	shufps	$231, %xmm5, %xmm5      # xmm5 = xmm5[3,1,2,3]
	movaps	%xmm5, %xmm6
	subss	%xmm1, %xmm6
	cvttss2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm5, %rdx
	ucomiss	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm6
	subss	%xmm1, %xmm6
	cvttss2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rax
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0]
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end202:
	.size	convert_float_uint64_t_8, .Lfunc_end202-convert_float_uint64_t_8
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.align	4
.LCPI203_0:
	.long	1593835520              # float 9.22337203E+18
	.text
	.globl	convert_float_uint64_t_16
	.align	16, 0x90
	.type	convert_float_uint64_t_16,@function
convert_float_uint64_t_16:              # @convert_float_uint64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm3
	movaps	16(%rsi), %xmm6
	movaps	32(%rsi), %xmm1
	movaps	48(%rsi), %xmm9
	movss	.LCPI203_0(%rip), %xmm2 # xmm2 = mem[0],zero,zero,zero
	movaps	%xmm3, %xmm0
	subss	%xmm2, %xmm0
	cvttss2si	%xmm0, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm2, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm8
	movaps	%xmm3, %xmm0
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm5
	subss	%xmm2, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm8    # xmm8 = xmm8[0],xmm0[0]
	movaps	%xmm3, %xmm0
	shufps	$231, %xmm0, %xmm0      # xmm0 = xmm0[3,1,2,3]
	movaps	%xmm0, %xmm5
	subss	%xmm2, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm5
	subss	%xmm2, %xmm5
	cvttss2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm2, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm10
	punpcklqdq	%xmm0, %xmm10   # xmm10 = xmm10[0],xmm0[0]
	movaps	%xmm6, %xmm0
	subss	%xmm2, %xmm0
	cvttss2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm6, %rdx
	ucomiss	%xmm2, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	movaps	%xmm6, %xmm0
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	movaps	%xmm0, %xmm7
	subss	%xmm2, %xmm7
	cvttss2si	%xmm7, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	movaps	%xmm6, %xmm0
	shufps	$231, %xmm0, %xmm0      # xmm0 = xmm0[3,1,2,3]
	movaps	%xmm0, %xmm7
	subss	%xmm2, %xmm7
	cvttss2si	%xmm7, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	movapd	%xmm6, %xmm7
	subss	%xmm2, %xmm7
	cvttss2si	%xmm7, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm6, %rdx
	ucomiss	%xmm2, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm6
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	movaps	%xmm1, %xmm0
	subss	%xmm2, %xmm0
	cvttss2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm1, %rdx
	ucomiss	%xmm2, %xmm1
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm7
	movaps	%xmm1, %xmm4
	shufps	$229, %xmm4, %xmm4      # xmm4 = xmm4[1,1,2,3]
	movaps	%xmm4, %xmm0
	subss	%xmm2, %xmm0
	cvttss2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm4, %rdx
	ucomiss	%xmm2, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm7    # xmm7 = xmm7[0],xmm0[0]
	movaps	%xmm1, %xmm0
	shufps	$231, %xmm0, %xmm0      # xmm0 = xmm0[3,1,2,3]
	movaps	%xmm0, %xmm4
	subss	%xmm2, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rdx
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	movapd	%xmm1, %xmm4
	subss	%xmm2, %xmm4
	cvttss2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm1, %rdx
	ucomiss	%xmm2, %xmm1
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movaps	%xmm9, %xmm0
	subss	%xmm2, %xmm0
	cvttss2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm9, %rdx
	ucomiss	%xmm2, %xmm9
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	movaps	%xmm9, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	movaps	%xmm3, %xmm1
	subss	%xmm2, %xmm1
	cvttss2si	%xmm1, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm3, %rdx
	ucomiss	%xmm2, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm1
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movaps	%xmm9, %xmm1
	shufps	$231, %xmm1, %xmm1      # xmm1 = xmm1[3,1,2,3]
	movaps	%xmm1, %xmm3
	subss	%xmm2, %xmm3
	cvttss2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm1, %rdx
	ucomiss	%xmm2, %xmm1
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm1
	shufpd	$1, %xmm9, %xmm9        # xmm9 = xmm9[1,0]
	movapd	%xmm9, %xmm3
	subss	%xmm2, %xmm3
	cvttss2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttss2si	%xmm9, %rax
	ucomiss	%xmm2, %xmm9
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	movdqa	%xmm2, 112(%rdi)
	movdqa	%xmm0, 96(%rdi)
	movdqa	%xmm4, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm6, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm10, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end203:
	.size	convert_float_uint64_t_16, .Lfunc_end203-convert_float_uint64_t_16
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI204_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint64_t_2
	.align	16, 0x90
	.type	convert_double_uint64_t_2,@function
convert_double_uint64_t_2:              # @convert_double_uint64_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movsd	.LCPI204_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm0, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rax
	xorq	%rcx, %rax
	cvttsd2si	%xmm0, %rcx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rax, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end204:
	.size	convert_double_uint64_t_2, .Lfunc_end204-convert_double_uint64_t_2
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI205_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint64_t_4
	.align	16, 0x90
	.type	convert_double_uint64_t_4,@function
convert_double_uint64_t_4:              # @convert_double_uint64_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm3
	movapd	16(%rsi), %xmm0
	movsd	.LCPI205_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm3, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end205:
	.size	convert_double_uint64_t_4, .Lfunc_end205-convert_double_uint64_t_4
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI206_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint64_t_8
	.align	16, 0x90
	.type	convert_double_uint64_t_8,@function
convert_double_uint64_t_8:              # @convert_double_uint64_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm4
	movapd	16(%rsi), %xmm5
	movapd	32(%rsi), %xmm3
	movapd	48(%rsi), %xmm0
	movsd	.LCPI206_0(%rip), %xmm1 # xmm1 = mem[0],zero
	movapd	%xmm4, %xmm2
	subsd	%xmm1, %xmm2
	cvttsd2si	%xmm2, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm2
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm1, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	punpcklqdq	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0]
	movapd	%xmm5, %xmm4
	subsd	%xmm1, %xmm4
	cvttsd2si	%xmm4, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm1, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	punpcklqdq	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0]
	movapd	%xmm3, %xmm5
	subsd	%xmm1, %xmm5
	cvttsd2si	%xmm5, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm1, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movapd	%xmm0, %xmm3
	subsd	%xmm1, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rdx
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm3
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	movapd	%xmm0, %xmm6
	subsd	%xmm1, %xmm6
	cvttsd2si	%xmm6, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm0, %rax
	ucomisd	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm4, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end206:
	.size	convert_double_uint64_t_8, .Lfunc_end206-convert_double_uint64_t_8
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI207_0:
	.quad	4890909195324358656     # double 9.2233720368547758E+18
	.text
	.globl	convert_double_uint64_t_16
	.align	16, 0x90
	.type	convert_double_uint64_t_16,@function
convert_double_uint64_t_16:             # @convert_double_uint64_t_16
	.cfi_startproc
# BB#0:
	movapd	112(%rsi), %xmm10
	movapd	96(%rsi), %xmm11
	movapd	80(%rsi), %xmm5
	movapd	64(%rsi), %xmm7
	movapd	(%rsi), %xmm3
	movapd	16(%rsi), %xmm6
	movapd	32(%rsi), %xmm1
	movapd	48(%rsi), %xmm4
	movsd	.LCPI207_0(%rip), %xmm2 # xmm2 = mem[0],zero
	movapd	%xmm3, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	movabsq	$-9223372036854775808, %rax # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm2, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm8
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	movapd	%xmm3, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm3, %rdx
	ucomisd	%xmm2, %xmm3
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm8    # xmm8 = xmm8[0],xmm0[0]
	movapd	%xmm6, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm2, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm9
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	movapd	%xmm6, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm6, %rdx
	ucomisd	%xmm2, %xmm6
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm9    # xmm9 = xmm9[0],xmm0[0]
	movapd	%xmm1, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm1, %rdx
	ucomisd	%xmm2, %xmm1
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm6
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	movapd	%xmm1, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm1, %rdx
	ucomisd	%xmm2, %xmm1
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	movapd	%xmm4, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm2, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm1
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	movapd	%xmm4, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm4, %rdx
	ucomisd	%xmm2, %xmm4
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movapd	%xmm7, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm2, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm4
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	movapd	%xmm7, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm7, %rdx
	ucomisd	%xmm2, %xmm7
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movapd	%xmm5, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm2, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm7
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	movapd	%xmm5, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm5, %rdx
	ucomisd	%xmm2, %xmm5
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm7    # xmm7 = xmm7[0],xmm0[0]
	movapd	%xmm11, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rdx
	ucomisd	%xmm2, %xmm11
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm5
	shufpd	$1, %xmm11, %xmm11      # xmm11 = xmm11[1,0]
	movapd	%xmm11, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm11, %rdx
	ucomisd	%xmm2, %xmm11
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	movapd	%xmm10, %xmm0
	subsd	%xmm2, %xmm0
	cvttsd2si	%xmm0, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm10, %rdx
	ucomisd	%xmm2, %xmm10
	cmovaeq	%rcx, %rdx
	movd	%rdx, %xmm0
	shufpd	$1, %xmm10, %xmm10      # xmm10 = xmm10[1,0]
	movapd	%xmm10, %xmm3
	subsd	%xmm2, %xmm3
	cvttsd2si	%xmm3, %rcx
	xorq	%rax, %rcx
	cvttsd2si	%xmm10, %rax
	ucomisd	%xmm2, %xmm10
	cmovaeq	%rcx, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm5, 96(%rdi)
	movdqa	%xmm7, 80(%rdi)
	movdqa	%xmm4, 64(%rdi)
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm6, 32(%rdi)
	movdqa	%xmm9, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end207:
	.size	convert_double_uint64_t_16, .Lfunc_end207-convert_double_uint64_t_16
	.cfi_endproc

	.globl	convert_uint8_t_uint64_t_2
	.align	16, 0x90
	.type	convert_uint8_t_uint64_t_2,@function
convert_uint8_t_uint64_t_2:             # @convert_uint8_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end208:
	.size	convert_uint8_t_uint64_t_2, .Lfunc_end208-convert_uint8_t_uint64_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI209_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_uint64_t_4
	.align	16, 0x90
	.type	convert_uint8_t_uint64_t_4,@function
convert_uint8_t_uint64_t_4:             # @convert_uint8_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pshufd	$212, %xmm0, %xmm1      # xmm1 = xmm0[0,1,1,3]
	movdqa	.LCPI209_0(%rip), %xmm2 # xmm2 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$246, %xmm0, %xmm0      # xmm0 = xmm0[2,1,3,3]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end209:
	.size	convert_uint8_t_uint64_t_4, .Lfunc_end209-convert_uint8_t_uint64_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI210_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_uint64_t_8
	.align	16, 0x90
	.type	convert_uint8_t_uint64_t_8,@function
convert_uint8_t_uint64_t_8:             # @convert_uint8_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshufd	$196, %xmm0, %xmm1      # xmm1 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,5,5,6,7]
	movdqa	.LCPI210_0(%rip), %xmm2 # xmm2 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$213, %xmm0, %xmm3      # xmm3 = xmm0[1,1,1,3]
	pshufhw	$229, %xmm3, %xmm3      # xmm3 = xmm3[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm3
	pshufd	$230, %xmm0, %xmm4      # xmm4 = xmm0[2,1,2,3]
	pshufhw	$229, %xmm4, %xmm4      # xmm4 = xmm4[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm4
	pshufd	$247, %xmm0, %xmm0      # xmm0 = xmm0[3,1,3,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end210:
	.size	convert_uint8_t_uint64_t_8, .Lfunc_end210-convert_uint8_t_uint64_t_8
	.cfi_endproc

	.globl	convert_uint8_t_uint64_t_16
	.align	16, 0x90
	.type	convert_uint8_t_uint64_t_16,@function
convert_uint8_t_uint64_t_16:            # @convert_uint8_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	movdqa	%xmm3, %xmm8
	punpckldq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0],xmm8[1],xmm1[1]
	punpckhdq	%xmm1, %xmm3    # xmm3 = xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm5
	punpckldq	%xmm1, %xmm5    # xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
	punpckhdq	%xmm1, %xmm2    # xmm2 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm6
	punpcklwd	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0],xmm6[1],xmm1[1],xmm6[2],xmm1[2],xmm6[3],xmm1[3]
	movdqa	%xmm6, %xmm7
	punpckldq	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0],xmm7[1],xmm1[1]
	punpckhdq	%xmm1, %xmm6    # xmm6 = xmm6[2],xmm1[2],xmm6[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm4, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm2, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end211:
	.size	convert_uint8_t_uint64_t_16, .Lfunc_end211-convert_uint8_t_uint64_t_16
	.cfi_endproc

	.globl	convert_uint16_t_uint64_t_2
	.align	16, 0x90
	.type	convert_uint16_t_uint64_t_2,@function
convert_uint16_t_uint64_t_2:            # @convert_uint16_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end212:
	.size	convert_uint16_t_uint64_t_2, .Lfunc_end212-convert_uint16_t_uint64_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI213_0:
	.short	65535                   # 0xffff
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	65535                   # 0xffff
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.text
	.globl	convert_uint16_t_uint64_t_4
	.align	16, 0x90
	.type	convert_uint16_t_uint64_t_4,@function
convert_uint16_t_uint64_t_4:            # @convert_uint16_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pshufd	$212, %xmm0, %xmm1      # xmm1 = xmm0[0,1,1,3]
	movdqa	.LCPI213_0(%rip), %xmm2 # xmm2 = [65535,0,0,0,65535,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$246, %xmm0, %xmm0      # xmm0 = xmm0[2,1,3,3]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end213:
	.size	convert_uint16_t_uint64_t_4, .Lfunc_end213-convert_uint16_t_uint64_t_4
	.cfi_endproc

	.globl	convert_uint16_t_uint64_t_8
	.align	16, 0x90
	.type	convert_uint16_t_uint64_t_8,@function
convert_uint16_t_uint64_t_8:            # @convert_uint16_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movdqa	%xmm2, %xmm3
	punpckldq	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	punpckhdq	%xmm1, %xmm2    # xmm2 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end214:
	.size	convert_uint16_t_uint64_t_8, .Lfunc_end214-convert_uint16_t_uint64_t_8
	.cfi_endproc

	.globl	convert_uint16_t_uint64_t_16
	.align	16, 0x90
	.type	convert_uint16_t_uint64_t_16,@function
convert_uint16_t_uint64_t_16:           # @convert_uint16_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movdqa	%xmm3, %xmm8
	punpckldq	%xmm2, %xmm8    # xmm8 = xmm8[0],xmm2[0],xmm8[1],xmm2[1]
	punpckhdq	%xmm2, %xmm3    # xmm3 = xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movdqa	%xmm0, %xmm5
	punpckldq	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1]
	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movdqa	%xmm1, %xmm6
	punpcklwd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	movdqa	%xmm6, %xmm7
	punpckldq	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	punpckhdq	%xmm2, %xmm6    # xmm6 = xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	movdqa	%xmm1, %xmm4
	punpckldq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	punpckhdq	%xmm2, %xmm1    # xmm1 = xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	movdqa	%xmm1, 112(%rdi)
	movdqa	%xmm4, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end215:
	.size	convert_uint16_t_uint64_t_16, .Lfunc_end215-convert_uint16_t_uint64_t_16
	.cfi_endproc

	.globl	convert_uint32_t_uint64_t_2
	.align	16, 0x90
	.type	convert_uint32_t_uint64_t_2,@function
convert_uint32_t_uint64_t_2:            # @convert_uint32_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end216:
	.size	convert_uint32_t_uint64_t_2, .Lfunc_end216-convert_uint32_t_uint64_t_2
	.cfi_endproc

	.globl	convert_uint32_t_uint64_t_4
	.align	16, 0x90
	.type	convert_uint32_t_uint64_t_4,@function
convert_uint32_t_uint64_t_4:            # @convert_uint32_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end217:
	.size	convert_uint32_t_uint64_t_4, .Lfunc_end217-convert_uint32_t_uint64_t_4
	.cfi_endproc

	.globl	convert_uint32_t_uint64_t_8
	.align	16, 0x90
	.type	convert_uint32_t_uint64_t_8,@function
convert_uint32_t_uint64_t_8:            # @convert_uint32_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpckldq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movdqa	%xmm1, %xmm4
	punpckldq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	punpckhdq	%xmm2, %xmm1    # xmm1 = xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end218:
	.size	convert_uint32_t_uint64_t_8, .Lfunc_end218-convert_uint32_t_uint64_t_8
	.cfi_endproc

	.globl	convert_uint32_t_uint64_t_16
	.align	16, 0x90
	.type	convert_uint32_t_uint64_t_16,@function
convert_uint32_t_uint64_t_16:           # @convert_uint32_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm5
	pxor	%xmm4, %xmm4
	movdqa	%xmm0, %xmm8
	punpckldq	%xmm4, %xmm8    # xmm8 = xmm8[0],xmm4[0],xmm8[1],xmm4[1]
	punpckhdq	%xmm4, %xmm0    # xmm0 = xmm0[2],xmm4[2],xmm0[3],xmm4[3]
	movdqa	%xmm1, %xmm6
	punpckldq	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1]
	punpckhdq	%xmm4, %xmm1    # xmm1 = xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	movdqa	%xmm2, %xmm7
	punpckldq	%xmm4, %xmm7    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	punpckhdq	%xmm4, %xmm2    # xmm2 = xmm2[2],xmm4[2],xmm2[3],xmm4[3]
	movdqa	%xmm5, %xmm3
	punpckldq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
	punpckhdq	%xmm4, %xmm5    # xmm5 = xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	movdqa	%xmm5, 112(%rdi)
	movdqa	%xmm3, 96(%rdi)
	movdqa	%xmm2, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm6, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end219:
	.size	convert_uint32_t_uint64_t_16, .Lfunc_end219-convert_uint32_t_uint64_t_16
	.cfi_endproc

	.globl	convert_uint64_t_uint64_t_2
	.align	16, 0x90
	.type	convert_uint64_t_uint64_t_2,@function
convert_uint64_t_uint64_t_2:            # @convert_uint64_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end220:
	.size	convert_uint64_t_uint64_t_2, .Lfunc_end220-convert_uint64_t_uint64_t_2
	.cfi_endproc

	.globl	convert_uint64_t_uint64_t_4
	.align	16, 0x90
	.type	convert_uint64_t_uint64_t_4,@function
convert_uint64_t_uint64_t_4:            # @convert_uint64_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end221:
	.size	convert_uint64_t_uint64_t_4, .Lfunc_end221-convert_uint64_t_uint64_t_4
	.cfi_endproc

	.globl	convert_uint64_t_uint64_t_8
	.align	16, 0x90
	.type	convert_uint64_t_uint64_t_8,@function
convert_uint64_t_uint64_t_8:            # @convert_uint64_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end222:
	.size	convert_uint64_t_uint64_t_8, .Lfunc_end222-convert_uint64_t_uint64_t_8
	.cfi_endproc

	.globl	convert_uint64_t_uint64_t_16
	.align	16, 0x90
	.type	convert_uint64_t_uint64_t_16,@function
convert_uint64_t_uint64_t_16:           # @convert_uint64_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end223:
	.size	convert_uint64_t_uint64_t_16, .Lfunc_end223-convert_uint64_t_uint64_t_16
	.cfi_endproc

	.globl	convert_int8_t_uint64_t_2
	.align	16, 0x90
	.type	convert_int8_t_uint64_t_2,@function
convert_int8_t_uint64_t_2:              # @convert_int8_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	psrad	$24, %xmm0
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end224:
	.size	convert_int8_t_uint64_t_2, .Lfunc_end224-convert_int8_t_uint64_t_2
	.cfi_endproc

	.globl	convert_int8_t_uint64_t_4
	.align	16, 0x90
	.type	convert_int8_t_uint64_t_4,@function
convert_int8_t_uint64_t_4:              # @convert_int8_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end225:
	.size	convert_int8_t_uint64_t_4, .Lfunc_end225-convert_int8_t_uint64_t_4
	.cfi_endproc

	.globl	convert_int8_t_uint64_t_8
	.align	16, 0x90
	.type	convert_int8_t_uint64_t_8,@function
convert_int8_t_uint64_t_8:              # @convert_int8_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movsbq	5(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	4(%rsi), %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movsbq	7(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	6(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end226:
	.size	convert_int8_t_uint64_t_8, .Lfunc_end226-convert_int8_t_uint64_t_8
	.cfi_endproc

	.globl	convert_int8_t_uint64_t_16
	.align	16, 0x90
	.type	convert_int8_t_uint64_t_16,@function
convert_int8_t_uint64_t_16:             # @convert_int8_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm1
	movsbq	(%rsi), %rax
	movd	%rax, %xmm8
	punpcklqdq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm2
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movsbq	5(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movsbq	7(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	6(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	movsbq	9(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	8(%rsi), %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movsbq	11(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	10(%rsi), %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm3, %xmm6    # xmm6 = xmm6[0],xmm3[0]
	movsbq	13(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	12(%rsi), %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm3, %xmm7    # xmm7 = xmm7[0],xmm3[0]
	movsbq	15(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	14(%rsi), %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm7, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm5, 64(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end227:
	.size	convert_int8_t_uint64_t_16, .Lfunc_end227-convert_int8_t_uint64_t_16
	.cfi_endproc

	.globl	convert_int16_t_uint64_t_2
	.align	16, 0x90
	.type	convert_int16_t_uint64_t_2,@function
convert_int16_t_uint64_t_2:             # @convert_int16_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	psrad	$16, %xmm0
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end228:
	.size	convert_int16_t_uint64_t_2, .Lfunc_end228-convert_int16_t_uint64_t_2
	.cfi_endproc

	.globl	convert_int16_t_uint64_t_4
	.align	16, 0x90
	.type	convert_int16_t_uint64_t_4,@function
convert_int16_t_uint64_t_4:             # @convert_int16_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm0
	movswq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm0
	movswq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end229:
	.size	convert_int16_t_uint64_t_4, .Lfunc_end229-convert_int16_t_uint64_t_4
	.cfi_endproc

	.globl	convert_int16_t_uint64_t_8
	.align	16, 0x90
	.type	convert_int16_t_uint64_t_8,@function
convert_int16_t_uint64_t_8:             # @convert_int16_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm0
	movswq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm0
	movswq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movswq	10(%rsi), %rax
	movd	%rax, %xmm0
	movswq	8(%rsi), %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movswq	14(%rsi), %rax
	movd	%rax, %xmm0
	movswq	12(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end230:
	.size	convert_int16_t_uint64_t_8, .Lfunc_end230-convert_int16_t_uint64_t_8
	.cfi_endproc

	.globl	convert_int16_t_uint64_t_16
	.align	16, 0x90
	.type	convert_int16_t_uint64_t_16,@function
convert_int16_t_uint64_t_16:            # @convert_int16_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm1
	movswq	(%rsi), %rax
	movd	%rax, %xmm8
	punpcklqdq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm2
	movswq	4(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movswq	10(%rsi), %rax
	movd	%rax, %xmm3
	movswq	8(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movswq	14(%rsi), %rax
	movd	%rax, %xmm3
	movswq	12(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	movswq	18(%rsi), %rax
	movd	%rax, %xmm3
	movswq	16(%rsi), %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movswq	22(%rsi), %rax
	movd	%rax, %xmm3
	movswq	20(%rsi), %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm3, %xmm6    # xmm6 = xmm6[0],xmm3[0]
	movswq	26(%rsi), %rax
	movd	%rax, %xmm3
	movswq	24(%rsi), %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm3, %xmm7    # xmm7 = xmm7[0],xmm3[0]
	movswq	30(%rsi), %rax
	movd	%rax, %xmm3
	movswq	28(%rsi), %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm7, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm5, 64(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end231:
	.size	convert_int16_t_uint64_t_16, .Lfunc_end231-convert_int16_t_uint64_t_16
	.cfi_endproc

	.globl	convert_int32_t_uint64_t_2
	.align	16, 0x90
	.type	convert_int32_t_uint64_t_2,@function
convert_int32_t_uint64_t_2:             # @convert_int32_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end232:
	.size	convert_int32_t_uint64_t_2, .Lfunc_end232-convert_int32_t_uint64_t_2
	.cfi_endproc

	.globl	convert_int32_t_uint64_t_4
	.align	16, 0x90
	.type	convert_int32_t_uint64_t_4,@function
convert_int32_t_uint64_t_4:             # @convert_int32_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	movdqa	%xmm1, %xmm2
	psrad	$31, %xmm2
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	movdqa	%xmm0, %xmm2
	psrad	$31, %xmm2
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	retq
.Lfunc_end233:
	.size	convert_int32_t_uint64_t_4, .Lfunc_end233-convert_int32_t_uint64_t_4
	.cfi_endproc

	.globl	convert_int32_t_uint64_t_8
	.align	16, 0x90
	.type	convert_int32_t_uint64_t_8,@function
convert_int32_t_uint64_t_8:             # @convert_int32_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	movdqa	%xmm2, %xmm3
	psrad	$31, %xmm3
	punpckldq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	movdqa	%xmm3, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
	movdqa	%xmm0, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm0    # xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1]
	movdqa	%xmm1, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
	movdqa	%xmm1, 32(%rdi)
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 16(%rdi)
	retq
.Lfunc_end234:
	.size	convert_int32_t_uint64_t_8, .Lfunc_end234-convert_int32_t_uint64_t_8
	.cfi_endproc

	.globl	convert_int32_t_uint64_t_16
	.align	16, 0x90
	.type	convert_int32_t_uint64_t_16,@function
convert_int32_t_uint64_t_16:            # @convert_int32_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm1
	movdqa	16(%rsi), %xmm2
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm5
	pshufd	$78, %xmm1, %xmm8       # xmm8 = xmm1[2,3,0,1]
	movdqa	%xmm8, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm8    # xmm8 = xmm8[0],xmm4[0],xmm8[1],xmm4[1]
	pshufd	$78, %xmm2, %xmm4       # xmm4 = xmm2[2,3,0,1]
	movdqa	%xmm4, %xmm6
	psrad	$31, %xmm6
	punpckldq	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1]
	pshufd	$78, %xmm3, %xmm6       # xmm6 = xmm3[2,3,0,1]
	movdqa	%xmm6, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	movdqa	%xmm0, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1]
	movdqa	%xmm1, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm1    # xmm1 = xmm1[0],xmm7[0],xmm1[1],xmm7[1]
	movdqa	%xmm2, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1]
	movdqa	%xmm3, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm3    # xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1]
	movdqa	%xmm5, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm5    # xmm5 = xmm5[0],xmm7[0],xmm5[1],xmm7[1]
	movdqa	%xmm5, 96(%rdi)
	movdqa	%xmm3, 64(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, (%rdi)
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm8, 16(%rdi)
	retq
.Lfunc_end235:
	.size	convert_int32_t_uint64_t_16, .Lfunc_end235-convert_int32_t_uint64_t_16
	.cfi_endproc

	.globl	convert_int64_t_uint64_t_2
	.align	16, 0x90
	.type	convert_int64_t_uint64_t_2,@function
convert_int64_t_uint64_t_2:             # @convert_int64_t_uint64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end236:
	.size	convert_int64_t_uint64_t_2, .Lfunc_end236-convert_int64_t_uint64_t_2
	.cfi_endproc

	.globl	convert_int64_t_uint64_t_4
	.align	16, 0x90
	.type	convert_int64_t_uint64_t_4,@function
convert_int64_t_uint64_t_4:             # @convert_int64_t_uint64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end237:
	.size	convert_int64_t_uint64_t_4, .Lfunc_end237-convert_int64_t_uint64_t_4
	.cfi_endproc

	.globl	convert_int64_t_uint64_t_8
	.align	16, 0x90
	.type	convert_int64_t_uint64_t_8,@function
convert_int64_t_uint64_t_8:             # @convert_int64_t_uint64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end238:
	.size	convert_int64_t_uint64_t_8, .Lfunc_end238-convert_int64_t_uint64_t_8
	.cfi_endproc

	.globl	convert_int64_t_uint64_t_16
	.align	16, 0x90
	.type	convert_int64_t_uint64_t_16,@function
convert_int64_t_uint64_t_16:            # @convert_int64_t_uint64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end239:
	.size	convert_int64_t_uint64_t_16, .Lfunc_end239-convert_int64_t_uint64_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI240_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_float_int8_t_2
	.align	16, 0x90
	.type	convert_float_int8_t_2,@function
convert_float_int8_t_2:                 # @convert_float_int8_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI240_0(%rip), %xmm1
	packuswb	%xmm1, %xmm1
	packuswb	%xmm1, %xmm1
	packuswb	%xmm1, %xmm1
	movd	%xmm1, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end240:
	.size	convert_float_int8_t_2, .Lfunc_end240-convert_float_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI241_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_float_int8_t_4
	.align	16, 0x90
	.type	convert_float_int8_t_4,@function
convert_float_int8_t_4:                 # @convert_float_int8_t_4
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	pand	.LCPI241_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end241:
	.size	convert_float_int8_t_4, .Lfunc_end241-convert_float_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI242_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_float_int8_t_8
	.align	16, 0x90
	.type	convert_float_int8_t_8,@function
convert_float_int8_t_8:                 # @convert_float_int8_t_8
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI242_0(%rip), %xmm1
	packuswb	%xmm1, %xmm1
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end242:
	.size	convert_float_int8_t_8, .Lfunc_end242-convert_float_int8_t_8
	.cfi_endproc

	.globl	convert_float_int8_t_16
	.align	16, 0x90
	.type	convert_float_int8_t_16,@function
convert_float_int8_t_16:                # @convert_float_int8_t_16
	.cfi_startproc
# BB#0:
	cvttps2dq	48(%rsi), %xmm1
	movdqa	%xmm1, -56(%rsp)
	cvttps2dq	16(%rsi), %xmm2
	movdqa	%xmm2, -40(%rsp)
	cvttps2dq	32(%rsi), %xmm3
	movdqa	%xmm3, -24(%rsp)
	cvttps2dq	(%rsi), %xmm0
	movdqa	%xmm0, -72(%rsp)
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpcklbw	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3],xmm0[4],xmm3[4],xmm0[5],xmm3[5],xmm0[6],xmm3[6],xmm0[7],xmm3[7]
	punpcklbw	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3],xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movd	-52(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-36(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	movd	-48(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	movd	-32(%rsp), %xmm4        # xmm4 = mem[0],zero,zero,zero
	punpcklbw	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3],xmm4[4],xmm3[4],xmm4[5],xmm3[5],xmm4[6],xmm3[6],xmm4[7],xmm3[7]
	movd	-20(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	movd	-68(%rsp), %xmm5        # xmm5 = mem[0],zero,zero,zero
	movd	-16(%rsp), %xmm6        # xmm6 = mem[0],zero,zero,zero
	movd	-64(%rsp), %xmm7        # xmm7 = mem[0],zero,zero,zero
	punpcklbw	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3],xmm7[4],xmm6[4],xmm7[5],xmm6[5],xmm7[6],xmm6[6],xmm7[7],xmm6[7]
	punpcklbw	%xmm4, %xmm7    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1],xmm7[2],xmm4[2],xmm7[3],xmm4[3],xmm7[4],xmm4[4],xmm7[5],xmm4[5],xmm7[6],xmm4[6],xmm7[7],xmm4[7]
	punpcklbw	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3],xmm0[4],xmm7[4],xmm0[5],xmm7[5],xmm0[6],xmm7[6],xmm0[7],xmm7[7]
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpcklbw	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3],xmm5[4],xmm3[4],xmm5[5],xmm3[5],xmm5[6],xmm3[6],xmm5[7],xmm3[7]
	punpcklbw	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1],xmm5[2],xmm2[2],xmm5[3],xmm2[3],xmm5[4],xmm2[4],xmm5[5],xmm2[5],xmm5[6],xmm2[6],xmm5[7],xmm2[7]
	movd	-44(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-28(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movd	-12(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	movd	-60(%rsp), %xmm3        # xmm3 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3],xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
	punpcklbw	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	punpcklbw	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3],xmm5[4],xmm3[4],xmm5[5],xmm3[5],xmm5[6],xmm3[6],xmm5[7],xmm3[7]
	punpcklbw	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1],xmm0[2],xmm5[2],xmm0[3],xmm5[3],xmm0[4],xmm5[4],xmm0[5],xmm5[5],xmm0[6],xmm5[6],xmm0[7],xmm5[7]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end243:
	.size	convert_float_int8_t_16, .Lfunc_end243-convert_float_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI244_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_double_int8_t_2
	.align	16, 0x90
	.type	convert_double_int8_t_2,@function
convert_double_int8_t_2:                # @convert_double_int8_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pand	.LCPI244_0(%rip), %xmm1
	packuswb	%xmm1, %xmm1
	packuswb	%xmm1, %xmm1
	packuswb	%xmm1, %xmm1
	movd	%xmm1, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end244:
	.size	convert_double_int8_t_2, .Lfunc_end244-convert_double_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI245_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_double_int8_t_4
	.align	16, 0x90
	.type	convert_double_int8_t_4,@function
convert_double_int8_t_4:                # @convert_double_int8_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	pand	.LCPI245_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end245:
	.size	convert_double_int8_t_4, .Lfunc_end245-convert_double_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI246_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_double_int8_t_8
	.align	16, 0x90
	.type	convert_double_int8_t_8,@function
convert_double_int8_t_8:                # @convert_double_int8_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm3
	movapd	32(%rsi), %xmm2
	movapd	48(%rsi), %xmm4
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	pextrw	$4, %xmm4, %eax
	punpcklwd	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3]
	cvttsd2si	%xmm2, %rcx
	movd	%rcx, %xmm3
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rcx
	movd	%rcx, %xmm2
	punpcklqdq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0]
	cvttsd2si	%xmm0, %rcx
	movd	%rcx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pextrw	$4, %xmm1, %ecx
	movd	%ecx, %xmm0
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1],xmm2[2],xmm3[2],xmm2[3],xmm3[3]
	punpcklwd	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0],xmm2[1],xmm4[1],xmm2[2],xmm4[2],xmm2[3],xmm4[3]
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm0
	movd	%ecx, %xmm3
	punpcklwd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpcklwd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1],xmm2[2],xmm3[2],xmm2[3],xmm3[3]
	pand	.LCPI246_0(%rip), %xmm2
	packuswb	%xmm2, %xmm2
	movq	%xmm2, (%rdi)
	retq
.Lfunc_end246:
	.size	convert_double_int8_t_8, .Lfunc_end246-convert_double_int8_t_8
	.cfi_endproc

	.globl	convert_double_int8_t_16
	.align	16, 0x90
	.type	convert_double_int8_t_16,@function
convert_double_int8_t_16:               # @convert_double_int8_t_16
	.cfi_startproc
# BB#0:
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	movapd	64(%rsi), %xmm3
	movapd	96(%rsi), %xmm7
	movapd	80(%rsi), %xmm4
	movapd	(%rsi), %xmm1
	movapd	16(%rsi), %xmm0
	movapd	32(%rsi), %xmm6
	movapd	48(%rsi), %xmm5
	movapd	112(%rsi), %xmm2
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm8
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm8    # xmm8 = xmm8[0],xmm2[0]
	movdqa	%xmm8, -96(%rsp)
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0]
	movdqa	%xmm2, -64(%rsp)
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm5
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0]
	movdqa	%xmm5, -80(%rsp)
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, -48(%rsp)
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0]
	movdqa	%xmm0, -112(%rsp)
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm7
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0]
	movdqa	%xmm7, -32(%rsp)
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm6    # xmm6 = xmm6[0],xmm3[0]
	movdqa	%xmm6, -16(%rsp)
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0]
	movdqa	%xmm3, -128(%rsp)
	punpcklbw	%xmm8, %xmm2    # xmm2 = xmm2[0],xmm8[0],xmm2[1],xmm8[1],xmm2[2],xmm8[2],xmm2[3],xmm8[3],xmm2[4],xmm8[4],xmm2[5],xmm8[5],xmm2[6],xmm8[6],xmm2[7],xmm8[7]
	punpcklbw	%xmm5, %xmm4    # xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1],xmm4[2],xmm5[2],xmm4[3],xmm5[3],xmm4[4],xmm5[4],xmm4[5],xmm5[5],xmm4[6],xmm5[6],xmm4[7],xmm5[7]
	punpcklbw	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3],xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
	punpcklbw	%xmm0, %xmm7    # xmm7 = xmm7[0],xmm0[0],xmm7[1],xmm0[1],xmm7[2],xmm0[2],xmm7[3],xmm0[3],xmm7[4],xmm0[4],xmm7[5],xmm0[5],xmm7[6],xmm0[6],xmm7[7],xmm0[7]
	punpcklbw	%xmm6, %xmm3    # xmm3 = xmm3[0],xmm6[0],xmm3[1],xmm6[1],xmm3[2],xmm6[2],xmm3[3],xmm6[3],xmm3[4],xmm6[4],xmm3[5],xmm6[5],xmm3[6],xmm6[6],xmm3[7],xmm6[7]
	punpcklbw	%xmm7, %xmm3    # xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1],xmm3[2],xmm7[2],xmm3[3],xmm7[3],xmm3[4],xmm7[4],xmm3[5],xmm7[5],xmm3[6],xmm7[6],xmm3[7],xmm7[7]
	punpcklbw	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1],xmm3[2],xmm4[2],xmm3[3],xmm4[3],xmm3[4],xmm4[4],xmm3[5],xmm4[5],xmm3[6],xmm4[6],xmm3[7],xmm4[7]
	movd	-88(%rsp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-56(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
	movd	-72(%rsp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-40(%rsp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movd	-104(%rsp), %xmm0       # xmm0 = mem[0],zero,zero,zero
	movd	-24(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
	movd	-8(%rsp), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movd	-120(%rsp), %xmm4       # xmm4 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3],xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
	punpcklbw	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3],xmm4[4],xmm1[4],xmm4[5],xmm1[5],xmm4[6],xmm1[6],xmm4[7],xmm1[7]
	punpcklbw	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3],xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
	punpcklbw	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1],xmm3[2],xmm4[2],xmm3[3],xmm4[3],xmm3[4],xmm4[4],xmm3[5],xmm4[5],xmm3[6],xmm4[6],xmm3[7],xmm4[7]
	movdqa	%xmm3, (%rdi)
	popq	%rax
	retq
.Lfunc_end247:
	.size	convert_double_int8_t_16, .Lfunc_end247-convert_double_int8_t_16
	.cfi_endproc

	.globl	convert_uint8_t_int8_t_2
	.align	16, 0x90
	.type	convert_uint8_t_int8_t_2,@function
convert_uint8_t_int8_t_2:               # @convert_uint8_t_int8_t_2
	.cfi_startproc
# BB#0:
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	retq
.Lfunc_end248:
	.size	convert_uint8_t_int8_t_2, .Lfunc_end248-convert_uint8_t_int8_t_2
	.cfi_endproc

	.globl	convert_uint8_t_int8_t_4
	.align	16, 0x90
	.type	convert_uint8_t_int8_t_4,@function
convert_uint8_t_int8_t_4:               # @convert_uint8_t_int8_t_4
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end249:
	.size	convert_uint8_t_int8_t_4, .Lfunc_end249-convert_uint8_t_int8_t_4
	.cfi_endproc

	.globl	convert_uint8_t_int8_t_8
	.align	16, 0x90
	.type	convert_uint8_t_int8_t_8,@function
convert_uint8_t_int8_t_8:               # @convert_uint8_t_int8_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end250:
	.size	convert_uint8_t_int8_t_8, .Lfunc_end250-convert_uint8_t_int8_t_8
	.cfi_endproc

	.globl	convert_uint8_t_int8_t_16
	.align	16, 0x90
	.type	convert_uint8_t_int8_t_16,@function
convert_uint8_t_int8_t_16:              # @convert_uint8_t_int8_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end251:
	.size	convert_uint8_t_int8_t_16, .Lfunc_end251-convert_uint8_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI252_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint16_t_int8_t_2
	.align	16, 0x90
	.type	convert_uint16_t_int8_t_2,@function
convert_uint16_t_int8_t_2:              # @convert_uint16_t_int8_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pshufd	$196, %xmm0, %xmm0      # xmm0 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	.LCPI252_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end252:
	.size	convert_uint16_t_int8_t_2, .Lfunc_end252-convert_uint16_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI253_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_uint16_t_int8_t_4
	.align	16, 0x90
	.type	convert_uint16_t_int8_t_4,@function
convert_uint16_t_int8_t_4:              # @convert_uint16_t_int8_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pand	.LCPI253_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end253:
	.size	convert_uint16_t_int8_t_4, .Lfunc_end253-convert_uint16_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI254_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_uint16_t_int8_t_8
	.align	16, 0x90
	.type	convert_uint16_t_int8_t_8,@function
convert_uint16_t_int8_t_8:              # @convert_uint16_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI254_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end254:
	.size	convert_uint16_t_int8_t_8, .Lfunc_end254-convert_uint16_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI255_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_uint16_t_int8_t_16
	.align	16, 0x90
	.type	convert_uint16_t_int8_t_16,@function
convert_uint16_t_int8_t_16:             # @convert_uint16_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI255_0(%rip), %xmm0 # xmm0 = [255,255,255,255,255,255,255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end255:
	.size	convert_uint16_t_int8_t_16, .Lfunc_end255-convert_uint16_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI256_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint32_t_int8_t_2
	.align	16, 0x90
	.type	convert_uint32_t_int8_t_2,@function
convert_uint32_t_int8_t_2:              # @convert_uint32_t_int8_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pand	.LCPI256_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end256:
	.size	convert_uint32_t_int8_t_2, .Lfunc_end256-convert_uint32_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI257_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_uint32_t_int8_t_4
	.align	16, 0x90
	.type	convert_uint32_t_int8_t_4,@function
convert_uint32_t_int8_t_4:              # @convert_uint32_t_int8_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI257_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end257:
	.size	convert_uint32_t_int8_t_4, .Lfunc_end257-convert_uint32_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI258_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint32_t_int8_t_8
	.align	16, 0x90
	.type	convert_uint32_t_int8_t_8,@function
convert_uint32_t_int8_t_8:              # @convert_uint32_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI258_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end258:
	.size	convert_uint32_t_int8_t_8, .Lfunc_end258-convert_uint32_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI259_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint32_t_int8_t_16
	.align	16, 0x90
	.type	convert_uint32_t_int8_t_16,@function
convert_uint32_t_int8_t_16:             # @convert_uint32_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI259_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end259:
	.size	convert_uint32_t_int8_t_16, .Lfunc_end259-convert_uint32_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI260_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint64_t_int8_t_2
	.align	16, 0x90
	.type	convert_uint64_t_int8_t_2,@function
convert_uint64_t_int8_t_2:              # @convert_uint64_t_int8_t_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI260_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end260:
	.size	convert_uint64_t_int8_t_2, .Lfunc_end260-convert_uint64_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI261_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_uint64_t_int8_t_4
	.align	16, 0x90
	.type	convert_uint64_t_int8_t_4,@function
convert_uint64_t_int8_t_4:              # @convert_uint64_t_int8_t_4
	.cfi_startproc
# BB#0:
	movdqa	.LCPI261_0(%rip), %xmm0 # xmm0 = [255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end261:
	.size	convert_uint64_t_int8_t_4, .Lfunc_end261-convert_uint64_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI262_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint64_t_int8_t_8
	.align	16, 0x90
	.type	convert_uint64_t_int8_t_8,@function
convert_uint64_t_int8_t_8:              # @convert_uint64_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI262_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end262:
	.size	convert_uint64_t_int8_t_8, .Lfunc_end262-convert_uint64_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI263_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint64_t_int8_t_16
	.align	16, 0x90
	.type	convert_uint64_t_int8_t_16,@function
convert_uint64_t_int8_t_16:             # @convert_uint64_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI263_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	112(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	96(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	80(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	64(%rsi), %xmm3
	pand	%xmm0, %xmm3
	packuswb	%xmm1, %xmm3
	packuswb	%xmm2, %xmm3
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm3, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end263:
	.size	convert_uint64_t_int8_t_16, .Lfunc_end263-convert_uint64_t_int8_t_16
	.cfi_endproc

	.globl	convert_int8_t_int8_t_2
	.align	16, 0x90
	.type	convert_int8_t_int8_t_2,@function
convert_int8_t_int8_t_2:                # @convert_int8_t_int8_t_2
	.cfi_startproc
# BB#0:
	movw	(%rsi), %ax
	movw	%ax, (%rdi)
	retq
.Lfunc_end264:
	.size	convert_int8_t_int8_t_2, .Lfunc_end264-convert_int8_t_int8_t_2
	.cfi_endproc

	.globl	convert_int8_t_int8_t_4
	.align	16, 0x90
	.type	convert_int8_t_int8_t_4,@function
convert_int8_t_int8_t_4:                # @convert_int8_t_int8_t_4
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end265:
	.size	convert_int8_t_int8_t_4, .Lfunc_end265-convert_int8_t_int8_t_4
	.cfi_endproc

	.globl	convert_int8_t_int8_t_8
	.align	16, 0x90
	.type	convert_int8_t_int8_t_8,@function
convert_int8_t_int8_t_8:                # @convert_int8_t_int8_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end266:
	.size	convert_int8_t_int8_t_8, .Lfunc_end266-convert_int8_t_int8_t_8
	.cfi_endproc

	.globl	convert_int8_t_int8_t_16
	.align	16, 0x90
	.type	convert_int8_t_int8_t_16,@function
convert_int8_t_int8_t_16:               # @convert_int8_t_int8_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end267:
	.size	convert_int8_t_int8_t_16, .Lfunc_end267-convert_int8_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI268_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int16_t_int8_t_2
	.align	16, 0x90
	.type	convert_int16_t_int8_t_2,@function
convert_int16_t_int8_t_2:               # @convert_int16_t_int8_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pshufd	$196, %xmm0, %xmm0      # xmm0 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	.LCPI268_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end268:
	.size	convert_int16_t_int8_t_2, .Lfunc_end268-convert_int16_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI269_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_int16_t_int8_t_4
	.align	16, 0x90
	.type	convert_int16_t_int8_t_4,@function
convert_int16_t_int8_t_4:               # @convert_int16_t_int8_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pand	.LCPI269_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end269:
	.size	convert_int16_t_int8_t_4, .Lfunc_end269-convert_int16_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI270_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_int16_t_int8_t_8
	.align	16, 0x90
	.type	convert_int16_t_int8_t_8,@function
convert_int16_t_int8_t_8:               # @convert_int16_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI270_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end270:
	.size	convert_int16_t_int8_t_8, .Lfunc_end270-convert_int16_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI271_0:
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.short	255                     # 0xff
	.text
	.globl	convert_int16_t_int8_t_16
	.align	16, 0x90
	.type	convert_int16_t_int8_t_16,@function
convert_int16_t_int8_t_16:              # @convert_int16_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI271_0(%rip), %xmm0 # xmm0 = [255,255,255,255,255,255,255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end271:
	.size	convert_int16_t_int8_t_16, .Lfunc_end271-convert_int16_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI272_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int32_t_int8_t_2
	.align	16, 0x90
	.type	convert_int32_t_int8_t_2,@function
convert_int32_t_int8_t_2:               # @convert_int32_t_int8_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pand	.LCPI272_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end272:
	.size	convert_int32_t_int8_t_2, .Lfunc_end272-convert_int32_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI273_0:
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.long	255                     # 0xff
	.text
	.globl	convert_int32_t_int8_t_4
	.align	16, 0x90
	.type	convert_int32_t_int8_t_4,@function
convert_int32_t_int8_t_4:               # @convert_int32_t_int8_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI273_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end273:
	.size	convert_int32_t_int8_t_4, .Lfunc_end273-convert_int32_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI274_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int32_t_int8_t_8
	.align	16, 0x90
	.type	convert_int32_t_int8_t_8,@function
convert_int32_t_int8_t_8:               # @convert_int32_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI274_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end274:
	.size	convert_int32_t_int8_t_8, .Lfunc_end274-convert_int32_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI275_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int32_t_int8_t_16
	.align	16, 0x90
	.type	convert_int32_t_int8_t_16,@function
convert_int32_t_int8_t_16:              # @convert_int32_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI275_0(%rip), %xmm0 # xmm0 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end275:
	.size	convert_int32_t_int8_t_16, .Lfunc_end275-convert_int32_t_int8_t_16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI276_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int64_t_int8_t_2
	.align	16, 0x90
	.type	convert_int64_t_int8_t_2,@function
convert_int64_t_int8_t_2:               # @convert_int64_t_int8_t_2
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pand	.LCPI276_0(%rip), %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, %eax
	movw	%ax, (%rdi)
	retq
.Lfunc_end276:
	.size	convert_int64_t_int8_t_2, .Lfunc_end276-convert_int64_t_int8_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI277_0:
	.quad	255                     # 0xff
	.quad	255                     # 0xff
	.text
	.globl	convert_int64_t_int8_t_4
	.align	16, 0x90
	.type	convert_int64_t_int8_t_4,@function
convert_int64_t_int8_t_4:               # @convert_int64_t_int8_t_4
	.cfi_startproc
# BB#0:
	movdqa	.LCPI277_0(%rip), %xmm0 # xmm0 = [255,255]
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm0, %xmm0
	packuswb	%xmm0, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end277:
	.size	convert_int64_t_int8_t_4, .Lfunc_end277-convert_int64_t_int8_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI278_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int64_t_int8_t_8
	.align	16, 0x90
	.type	convert_int64_t_int8_t_8,@function
convert_int64_t_int8_t_8:               # @convert_int64_t_int8_t_8
	.cfi_startproc
# BB#0:
	movdqa	.LCPI278_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm0, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end278:
	.size	convert_int64_t_int8_t_8, .Lfunc_end278-convert_int64_t_int8_t_8
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI279_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_int64_t_int8_t_16
	.align	16, 0x90
	.type	convert_int64_t_int8_t_16,@function
convert_int64_t_int8_t_16:              # @convert_int64_t_int8_t_16
	.cfi_startproc
# BB#0:
	movdqa	.LCPI279_0(%rip), %xmm0 # xmm0 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	movdqa	112(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	96(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	80(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	64(%rsi), %xmm3
	pand	%xmm0, %xmm3
	packuswb	%xmm1, %xmm3
	packuswb	%xmm2, %xmm3
	movdqa	48(%rsi), %xmm1
	pand	%xmm0, %xmm1
	movdqa	32(%rsi), %xmm2
	pand	%xmm0, %xmm2
	packuswb	%xmm1, %xmm2
	movdqa	16(%rsi), %xmm1
	pand	%xmm0, %xmm1
	pand	(%rsi), %xmm0
	packuswb	%xmm1, %xmm0
	packuswb	%xmm2, %xmm0
	packuswb	%xmm3, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end279:
	.size	convert_int64_t_int8_t_16, .Lfunc_end279-convert_int64_t_int8_t_16
	.cfi_endproc

	.globl	convert_float_int16_t_2
	.align	16, 0x90
	.type	convert_float_int16_t_2,@function
convert_float_int16_t_2:                # @convert_float_int16_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, %xmm1, %xmm0      # xmm0 = xmm1[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end280:
	.size	convert_float_int16_t_2, .Lfunc_end280-convert_float_int16_t_2
	.cfi_endproc

	.globl	convert_float_int16_t_4
	.align	16, 0x90
	.type	convert_float_int16_t_4,@function
convert_float_int16_t_4:                # @convert_float_int16_t_4
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end281:
	.size	convert_float_int16_t_4, .Lfunc_end281-convert_float_int16_t_4
	.cfi_endproc

	.globl	convert_float_int16_t_8
	.align	16, 0x90
	.type	convert_float_int16_t_8,@function
convert_float_int16_t_8:                # @convert_float_int16_t_8
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end282:
	.size	convert_float_int16_t_8, .Lfunc_end282-convert_float_int16_t_8
	.cfi_endproc

	.globl	convert_float_int16_t_16
	.align	16, 0x90
	.type	convert_float_int16_t_16,@function
convert_float_int16_t_16:               # @convert_float_int16_t_16
	.cfi_startproc
# BB#0:
	cvttps2dq	16(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	(%rsi), %xmm1
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	cvttps2dq	48(%rsi), %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttps2dq	32(%rsi), %xmm2
	pshuflw	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end283:
	.size	convert_float_int16_t_16, .Lfunc_end283-convert_float_int16_t_16
	.cfi_endproc

	.globl	convert_double_int16_t_2
	.align	16, 0x90
	.type	convert_double_int16_t_2,@function
convert_double_int16_t_2:               # @convert_double_int16_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, %xmm1, %xmm0      # xmm0 = xmm1[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end284:
	.size	convert_double_int16_t_2, .Lfunc_end284-convert_double_int16_t_2
	.cfi_endproc

	.globl	convert_double_int16_t_4
	.align	16, 0x90
	.type	convert_double_int16_t_4,@function
convert_double_int16_t_4:               # @convert_double_int16_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end285:
	.size	convert_double_int16_t_4, .Lfunc_end285-convert_double_int16_t_4
	.cfi_endproc

	.globl	convert_double_int16_t_8
	.align	16, 0x90
	.type	convert_double_int16_t_8,@function
convert_double_int16_t_8:               # @convert_double_int16_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm3
	movapd	32(%rsi), %xmm2
	movapd	48(%rsi), %xmm4
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	pextrw	$4, %xmm4, %eax
	punpcklwd	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3]
	cvttsd2si	%xmm2, %rcx
	movd	%rcx, %xmm3
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rcx
	movd	%rcx, %xmm2
	punpcklqdq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0]
	cvttsd2si	%xmm0, %rcx
	movd	%rcx, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rcx
	movd	%rcx, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pextrw	$4, %xmm1, %ecx
	movd	%ecx, %xmm0
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1],xmm2[2],xmm3[2],xmm2[3],xmm3[3]
	punpcklwd	%xmm4, %xmm2    # xmm2 = xmm2[0],xmm4[0],xmm2[1],xmm4[1],xmm2[2],xmm4[2],xmm2[3],xmm4[3]
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm0
	movd	%ecx, %xmm3
	punpcklwd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpcklwd	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1],xmm2[2],xmm3[2],xmm2[3],xmm3[3]
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end286:
	.size	convert_double_int16_t_8, .Lfunc_end286-convert_double_int16_t_8
	.cfi_endproc

	.globl	convert_double_int16_t_16
	.align	16, 0x90
	.type	convert_double_int16_t_16,@function
convert_double_int16_t_16:              # @convert_double_int16_t_16
	.cfi_startproc
# BB#0:
	movapd	64(%rsi), %xmm8
	movapd	96(%rsi), %xmm1
	movapd	80(%rsi), %xmm2
	movapd	112(%rsi), %xmm4
	movapd	(%rsi), %xmm5
	movapd	16(%rsi), %xmm7
	movapd	32(%rsi), %xmm3
	movapd	48(%rsi), %xmm0
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0]
	pextrw	$4, %xmm0, %eax
	punpcklwd	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1],xmm0[2],xmm6[2],xmm0[3],xmm6[3]
	cvttsd2si	%xmm3, %rcx
	movd	%rcx, %xmm7
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rcx
	movd	%rcx, %xmm3
	punpcklqdq	%xmm3, %xmm7    # xmm7 = xmm7[0],xmm3[0]
	cvttsd2si	%xmm5, %rcx
	movd	%rcx, %xmm3
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	cvttsd2si	%xmm5, %rcx
	movd	%rcx, %xmm5
	punpcklqdq	%xmm5, %xmm3    # xmm3 = xmm3[0],xmm5[0]
	pextrw	$4, %xmm6, %ecx
	movd	%ecx, %xmm5
	pextrw	$4, %xmm3, %ecx
	punpcklwd	%xmm7, %xmm3    # xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1],xmm3[2],xmm7[2],xmm3[3],xmm7[3]
	punpcklwd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
	movd	%eax, %xmm0
	punpcklwd	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1],xmm0[2],xmm5[2],xmm0[3],xmm5[3]
	pextrw	$4, %xmm7, %eax
	movd	%eax, %xmm5
	movd	%ecx, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0],xmm6[1],xmm0[1],xmm6[2],xmm0[2],xmm6[3],xmm0[3]
	punpcklwd	%xmm6, %xmm3    # xmm3 = xmm3[0],xmm6[0],xmm3[1],xmm6[1],xmm3[2],xmm6[2],xmm3[3],xmm6[3]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm5
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	pextrw	$4, %xmm0, %eax
	punpcklwd	%xmm5, %xmm0    # xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1],xmm0[2],xmm5[2],xmm0[3],xmm5[3]
	cvttsd2si	%xmm1, %rcx
	movd	%rcx, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rcx
	movd	%rcx, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	cvttsd2si	%xmm8, %rcx
	movd	%rcx, %xmm1
	shufpd	$1, %xmm8, %xmm8        # xmm8 = xmm8[1,0]
	cvttsd2si	%xmm8, %rcx
	movd	%rcx, %xmm4
	punpcklqdq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0]
	pextrw	$4, %xmm5, %ecx
	movd	%ecx, %xmm4
	pextrw	$4, %xmm1, %ecx
	punpcklwd	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1],xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movd	%eax, %xmm0
	punpcklwd	%xmm4, %xmm0    # xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3]
	pextrw	$4, %xmm2, %eax
	movd	%eax, %xmm2
	movd	%ecx, %xmm4
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	punpcklwd	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3]
	punpcklwd	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end287:
	.size	convert_double_int16_t_16, .Lfunc_end287-convert_double_int16_t_16
	.cfi_endproc

	.globl	convert_uint8_t_int16_t_2
	.align	16, 0x90
	.type	convert_uint8_t_int16_t_2,@function
convert_uint8_t_int16_t_2:              # @convert_uint8_t_int16_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end288:
	.size	convert_uint8_t_int16_t_2, .Lfunc_end288-convert_uint8_t_int16_t_2
	.cfi_endproc

	.globl	convert_uint8_t_int16_t_4
	.align	16, 0x90
	.type	convert_uint8_t_int16_t_4,@function
convert_uint8_t_int16_t_4:              # @convert_uint8_t_int16_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end289:
	.size	convert_uint8_t_int16_t_4, .Lfunc_end289-convert_uint8_t_int16_t_4
	.cfi_endproc

	.globl	convert_uint8_t_int16_t_8
	.align	16, 0x90
	.type	convert_uint8_t_int16_t_8,@function
convert_uint8_t_int16_t_8:              # @convert_uint8_t_int16_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end290:
	.size	convert_uint8_t_int16_t_8, .Lfunc_end290-convert_uint8_t_int16_t_8
	.cfi_endproc

	.globl	convert_uint8_t_int16_t_16
	.align	16, 0x90
	.type	convert_uint8_t_int16_t_16,@function
convert_uint8_t_int16_t_16:             # @convert_uint8_t_int16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end291:
	.size	convert_uint8_t_int16_t_16, .Lfunc_end291-convert_uint8_t_int16_t_16
	.cfi_endproc

	.globl	convert_uint16_t_int16_t_2
	.align	16, 0x90
	.type	convert_uint16_t_int16_t_2,@function
convert_uint16_t_int16_t_2:             # @convert_uint16_t_int16_t_2
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end292:
	.size	convert_uint16_t_int16_t_2, .Lfunc_end292-convert_uint16_t_int16_t_2
	.cfi_endproc

	.globl	convert_uint16_t_int16_t_4
	.align	16, 0x90
	.type	convert_uint16_t_int16_t_4,@function
convert_uint16_t_int16_t_4:             # @convert_uint16_t_int16_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end293:
	.size	convert_uint16_t_int16_t_4, .Lfunc_end293-convert_uint16_t_int16_t_4
	.cfi_endproc

	.globl	convert_uint16_t_int16_t_8
	.align	16, 0x90
	.type	convert_uint16_t_int16_t_8,@function
convert_uint16_t_int16_t_8:             # @convert_uint16_t_int16_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end294:
	.size	convert_uint16_t_int16_t_8, .Lfunc_end294-convert_uint16_t_int16_t_8
	.cfi_endproc

	.globl	convert_uint16_t_int16_t_16
	.align	16, 0x90
	.type	convert_uint16_t_int16_t_16,@function
convert_uint16_t_int16_t_16:            # @convert_uint16_t_int16_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end295:
	.size	convert_uint16_t_int16_t_16, .Lfunc_end295-convert_uint16_t_int16_t_16
	.cfi_endproc

	.globl	convert_uint32_t_int16_t_2
	.align	16, 0x90
	.type	convert_uint32_t_int16_t_2,@function
convert_uint32_t_int16_t_2:             # @convert_uint32_t_int16_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end296:
	.size	convert_uint32_t_int16_t_2, .Lfunc_end296-convert_uint32_t_int16_t_2
	.cfi_endproc

	.globl	convert_uint32_t_int16_t_4
	.align	16, 0x90
	.type	convert_uint32_t_int16_t_4,@function
convert_uint32_t_int16_t_4:             # @convert_uint32_t_int16_t_4
	.cfi_startproc
# BB#0:
	pshuflw	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end297:
	.size	convert_uint32_t_int16_t_4, .Lfunc_end297-convert_uint32_t_int16_t_4
	.cfi_endproc

	.globl	convert_uint32_t_int16_t_8
	.align	16, 0x90
	.type	convert_uint32_t_int16_t_8,@function
convert_uint32_t_int16_t_8:             # @convert_uint32_t_int16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end298:
	.size	convert_uint32_t_int16_t_8, .Lfunc_end298-convert_uint32_t_int16_t_8
	.cfi_endproc

	.globl	convert_uint32_t_int16_t_16
	.align	16, 0x90
	.type	convert_uint32_t_int16_t_16,@function
convert_uint32_t_int16_t_16:            # @convert_uint32_t_int16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	pslld	$16, %xmm3
	psrad	$16, %xmm3
	pslld	$16, %xmm2
	psrad	$16, %xmm2
	packssdw	%xmm3, %xmm2
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end299:
	.size	convert_uint32_t_int16_t_16, .Lfunc_end299-convert_uint32_t_int16_t_16
	.cfi_endproc

	.globl	convert_uint64_t_int16_t_2
	.align	16, 0x90
	.type	convert_uint64_t_int16_t_2,@function
convert_uint64_t_int16_t_2:             # @convert_uint64_t_int16_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end300:
	.size	convert_uint64_t_int16_t_2, .Lfunc_end300-convert_uint64_t_int16_t_2
	.cfi_endproc

	.globl	convert_uint64_t_int16_t_4
	.align	16, 0x90
	.type	convert_uint64_t_int16_t_4,@function
convert_uint64_t_int16_t_4:             # @convert_uint64_t_int16_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end301:
	.size	convert_uint64_t_int16_t_4, .Lfunc_end301-convert_uint64_t_int16_t_4
	.cfi_endproc

	.globl	convert_uint64_t_int16_t_8
	.align	16, 0x90
	.type	convert_uint64_t_int16_t_8,@function
convert_uint64_t_int16_t_8:             # @convert_uint64_t_int16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm5
	punpcklwd	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1],xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	pextrw	$4, %xmm2, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1],xmm6[2],xmm4[2],xmm6[3],xmm4[3]
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1],xmm0[2],xmm6[2],xmm0[3],xmm6[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end302:
	.size	convert_uint64_t_int16_t_8, .Lfunc_end302-convert_uint64_t_int16_t_8
	.cfi_endproc

	.globl	convert_uint64_t_int16_t_16
	.align	16, 0x90
	.type	convert_uint64_t_int16_t_16,@function
convert_uint64_t_int16_t_16:            # @convert_uint64_t_int16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm4
	movdqa	96(%rsi), %xmm5
	movdqa	64(%rsi), %xmm2
	movdqa	112(%rsi), %xmm6
	movdqa	80(%rsi), %xmm7
	pextrw	$4, %xmm7, %eax
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1],xmm2[2],xmm5[2],xmm2[3],xmm5[3]
	punpcklwd	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1],xmm2[2],xmm7[2],xmm2[3],xmm7[3]
	pextrw	$4, %xmm6, %edx
	movd	%edx, %xmm6
	movd	%eax, %xmm7
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm5, %eax
	movd	%eax, %xmm5
	movd	%ecx, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
	punpcklwd	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
	pextrw	$4, %xmm4, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm7
	punpcklwd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0],xmm7[1],xmm5[1],xmm7[2],xmm5[2],xmm7[3],xmm5[3]
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	punpcklwd	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end303:
	.size	convert_uint64_t_int16_t_16, .Lfunc_end303-convert_uint64_t_int16_t_16
	.cfi_endproc

	.globl	convert_int8_t_int16_t_2
	.align	16, 0x90
	.type	convert_int8_t_int16_t_2,@function
convert_int8_t_int16_t_2:               # @convert_int8_t_int16_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end304:
	.size	convert_int8_t_int16_t_2, .Lfunc_end304-convert_int8_t_int16_t_2
	.cfi_endproc

	.globl	convert_int8_t_int16_t_4
	.align	16, 0x90
	.type	convert_int8_t_int16_t_4,@function
convert_int8_t_int16_t_4:               # @convert_int8_t_int16_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end305:
	.size	convert_int8_t_int16_t_4, .Lfunc_end305-convert_int8_t_int16_t_4
	.cfi_endproc

	.globl	convert_int8_t_int16_t_8
	.align	16, 0x90
	.type	convert_int8_t_int16_t_8,@function
convert_int8_t_int16_t_8:               # @convert_int8_t_int16_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end306:
	.size	convert_int8_t_int16_t_8, .Lfunc_end306-convert_int8_t_int16_t_8
	.cfi_endproc

	.globl	convert_int8_t_int16_t_16
	.align	16, 0x90
	.type	convert_int8_t_int16_t_16,@function
convert_int8_t_int16_t_16:              # @convert_int8_t_int16_t_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	psraw	$8, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end307:
	.size	convert_int8_t_int16_t_16, .Lfunc_end307-convert_int8_t_int16_t_16
	.cfi_endproc

	.globl	convert_int16_t_int16_t_2
	.align	16, 0x90
	.type	convert_int16_t_int16_t_2,@function
convert_int16_t_int16_t_2:              # @convert_int16_t_int16_t_2
	.cfi_startproc
# BB#0:
	movl	(%rsi), %eax
	movl	%eax, (%rdi)
	retq
.Lfunc_end308:
	.size	convert_int16_t_int16_t_2, .Lfunc_end308-convert_int16_t_int16_t_2
	.cfi_endproc

	.globl	convert_int16_t_int16_t_4
	.align	16, 0x90
	.type	convert_int16_t_int16_t_4,@function
convert_int16_t_int16_t_4:              # @convert_int16_t_int16_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end309:
	.size	convert_int16_t_int16_t_4, .Lfunc_end309-convert_int16_t_int16_t_4
	.cfi_endproc

	.globl	convert_int16_t_int16_t_8
	.align	16, 0x90
	.type	convert_int16_t_int16_t_8,@function
convert_int16_t_int16_t_8:              # @convert_int16_t_int16_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end310:
	.size	convert_int16_t_int16_t_8, .Lfunc_end310-convert_int16_t_int16_t_8
	.cfi_endproc

	.globl	convert_int16_t_int16_t_16
	.align	16, 0x90
	.type	convert_int16_t_int16_t_16,@function
convert_int16_t_int16_t_16:             # @convert_int16_t_int16_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end311:
	.size	convert_int16_t_int16_t_16, .Lfunc_end311-convert_int16_t_int16_t_16
	.cfi_endproc

	.globl	convert_int32_t_int16_t_2
	.align	16, 0x90
	.type	convert_int32_t_int16_t_2,@function
convert_int32_t_int16_t_2:              # @convert_int32_t_int16_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pshufd	$212, %xmm0, %xmm0      # xmm0 = xmm0[0,1,1,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end312:
	.size	convert_int32_t_int16_t_2, .Lfunc_end312-convert_int32_t_int16_t_2
	.cfi_endproc

	.globl	convert_int32_t_int16_t_4
	.align	16, 0x90
	.type	convert_int32_t_int16_t_4,@function
convert_int32_t_int16_t_4:              # @convert_int32_t_int16_t_4
	.cfi_startproc
# BB#0:
	pshuflw	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3,4,5,6,7]
	pshufhw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,4,6,6,7]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end313:
	.size	convert_int32_t_int16_t_4, .Lfunc_end313-convert_int32_t_int16_t_4
	.cfi_endproc

	.globl	convert_int32_t_int16_t_8
	.align	16, 0x90
	.type	convert_int32_t_int16_t_8,@function
convert_int32_t_int16_t_8:              # @convert_int32_t_int16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end314:
	.size	convert_int32_t_int16_t_8, .Lfunc_end314-convert_int32_t_int16_t_8
	.cfi_endproc

	.globl	convert_int32_t_int16_t_16
	.align	16, 0x90
	.type	convert_int32_t_int16_t_16,@function
convert_int32_t_int16_t_16:             # @convert_int32_t_int16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pslld	$16, %xmm1
	psrad	$16, %xmm1
	pslld	$16, %xmm0
	psrad	$16, %xmm0
	packssdw	%xmm1, %xmm0
	pslld	$16, %xmm3
	psrad	$16, %xmm3
	pslld	$16, %xmm2
	psrad	$16, %xmm2
	packssdw	%xmm3, %xmm2
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end315:
	.size	convert_int32_t_int16_t_16, .Lfunc_end315-convert_int32_t_int16_t_16
	.cfi_endproc

	.globl	convert_int64_t_int16_t_2
	.align	16, 0x90
	.type	convert_int64_t_int16_t_2,@function
convert_int64_t_int16_t_2:              # @convert_int64_t_int16_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	movd	%xmm0, (%rdi)
	retq
.Lfunc_end316:
	.size	convert_int64_t_int16_t_2, .Lfunc_end316-convert_int64_t_int16_t_2
	.cfi_endproc

	.globl	convert_int64_t_int16_t_4
	.align	16, 0x90
	.type	convert_int64_t_int16_t_4,@function
convert_int64_t_int16_t_4:              # @convert_int64_t_int16_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshuflw	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3,4,5,6,7]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	pshuflw	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3,4,5,6,7]
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movq	%xmm1, (%rdi)
	retq
.Lfunc_end317:
	.size	convert_int64_t_int16_t_4, .Lfunc_end317-convert_int64_t_int16_t_4
	.cfi_endproc

	.globl	convert_int64_t_int16_t_8
	.align	16, 0x90
	.type	convert_int64_t_int16_t_8,@function
convert_int64_t_int16_t_8:              # @convert_int64_t_int16_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm3
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm5
	punpcklwd	%xmm4, %xmm5    # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1],xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	pextrw	$4, %xmm2, %eax
	movd	%eax, %xmm4
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1],xmm6[2],xmm4[2],xmm6[3],xmm4[3]
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm3, %xmm1    # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1],xmm1[2],xmm3[2],xmm1[3],xmm3[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0],xmm0[1],xmm6[1],xmm0[2],xmm6[2],xmm0[3],xmm6[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end318:
	.size	convert_int64_t_int16_t_8, .Lfunc_end318-convert_int64_t_int16_t_8
	.cfi_endproc

	.globl	convert_int64_t_int16_t_16
	.align	16, 0x90
	.type	convert_int64_t_int16_t_16,@function
convert_int64_t_int16_t_16:             # @convert_int64_t_int16_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm4
	movdqa	96(%rsi), %xmm5
	movdqa	64(%rsi), %xmm2
	movdqa	112(%rsi), %xmm6
	movdqa	80(%rsi), %xmm7
	pextrw	$4, %xmm7, %eax
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm2, %ecx
	punpcklwd	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0],xmm2[1],xmm5[1],xmm2[2],xmm5[2],xmm2[3],xmm5[3]
	punpcklwd	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1],xmm2[2],xmm7[2],xmm2[3],xmm7[3]
	pextrw	$4, %xmm6, %edx
	movd	%edx, %xmm6
	movd	%eax, %xmm7
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	pextrw	$4, %xmm5, %eax
	movd	%eax, %xmm5
	movd	%ecx, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	punpcklwd	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1],xmm6[2],xmm7[2],xmm6[3],xmm7[3]
	punpcklwd	%xmm6, %xmm2    # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
	pextrw	$4, %xmm4, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm1, %eax
	movd	%eax, %xmm6
	punpcklwd	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0],xmm6[1],xmm5[1],xmm6[2],xmm5[2],xmm6[3],xmm5[3]
	pextrw	$4, %xmm3, %eax
	movd	%eax, %xmm5
	pextrw	$4, %xmm0, %eax
	movd	%eax, %xmm7
	punpcklwd	%xmm5, %xmm7    # xmm7 = xmm7[0],xmm5[0],xmm7[1],xmm5[1],xmm7[2],xmm5[2],xmm7[3],xmm5[3]
	punpcklwd	%xmm6, %xmm7    # xmm7 = xmm7[0],xmm6[0],xmm7[1],xmm6[1],xmm7[2],xmm6[2],xmm7[3],xmm6[3]
	punpcklwd	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1],xmm0[2],xmm7[2],xmm0[3],xmm7[3]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end319:
	.size	convert_int64_t_int16_t_16, .Lfunc_end319-convert_int64_t_int16_t_16
	.cfi_endproc

	.globl	convert_float_int32_t_2
	.align	16, 0x90
	.type	convert_float_int32_t_2,@function
convert_float_int32_t_2:                # @convert_float_int32_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, %xmm1, %xmm0      # xmm0 = xmm1[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end320:
	.size	convert_float_int32_t_2, .Lfunc_end320-convert_float_int32_t_2
	.cfi_endproc

	.globl	convert_float_int32_t_4
	.align	16, 0x90
	.type	convert_float_int32_t_4,@function
convert_float_int32_t_4:                # @convert_float_int32_t_4
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end321:
	.size	convert_float_int32_t_4, .Lfunc_end321-convert_float_int32_t_4
	.cfi_endproc

	.globl	convert_float_int32_t_8
	.align	16, 0x90
	.type	convert_float_int32_t_8,@function
convert_float_int32_t_8:                # @convert_float_int32_t_8
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	cvttps2dq	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end322:
	.size	convert_float_int32_t_8, .Lfunc_end322-convert_float_int32_t_8
	.cfi_endproc

	.globl	convert_float_int32_t_16
	.align	16, 0x90
	.type	convert_float_int32_t_16,@function
convert_float_int32_t_16:               # @convert_float_int32_t_16
	.cfi_startproc
# BB#0:
	cvttps2dq	(%rsi), %xmm0
	cvttps2dq	16(%rsi), %xmm1
	cvttps2dq	32(%rsi), %xmm2
	cvttps2dq	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end323:
	.size	convert_float_int32_t_16, .Lfunc_end323-convert_float_int32_t_16
	.cfi_endproc

	.globl	convert_double_int32_t_2
	.align	16, 0x90
	.type	convert_double_int32_t_2,@function
convert_double_int32_t_2:               # @convert_double_int32_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, %xmm1, %xmm0      # xmm0 = xmm1[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end324:
	.size	convert_double_int32_t_2, .Lfunc_end324-convert_double_int32_t_2
	.cfi_endproc

	.globl	convert_double_int32_t_4
	.align	16, 0x90
	.type	convert_double_int32_t_4,@function
convert_double_int32_t_4:               # @convert_double_int32_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0]
	pshufd	$232, %xmm2, %xmm1      # xmm1 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, %xmm2, %xmm0      # xmm0 = xmm2[0,2,2,3]
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end325:
	.size	convert_double_int32_t_4, .Lfunc_end325-convert_double_int32_t_4
	.cfi_endproc

	.globl	convert_double_int32_t_8
	.align	16, 0x90
	.type	convert_double_int32_t_8,@function
convert_double_int32_t_8:               # @convert_double_int32_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm1
	movapd	16(%rsi), %xmm2
	movapd	32(%rsi), %xmm0
	movapd	48(%rsi), %xmm3
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0]
	pshufd	$232, %xmm4, %xmm2      # xmm2 = xmm4[0,2,2,3]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0]
	pshufd	$232, %xmm4, %xmm1      # xmm1 = xmm4[0,2,2,3]
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	pshufd	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, %xmm3, %xmm0      # xmm0 = xmm3[0,2,2,3]
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end326:
	.size	convert_double_int32_t_8, .Lfunc_end326-convert_double_int32_t_8
	.cfi_endproc

	.globl	convert_double_int32_t_16
	.align	16, 0x90
	.type	convert_double_int32_t_16,@function
convert_double_int32_t_16:              # @convert_double_int32_t_16
	.cfi_startproc
# BB#0:
	movapd	96(%rsi), %xmm8
	movapd	112(%rsi), %xmm1
	movapd	64(%rsi), %xmm3
	movapd	80(%rsi), %xmm4
	movapd	(%rsi), %xmm2
	movapd	16(%rsi), %xmm6
	movapd	32(%rsi), %xmm5
	movapd	48(%rsi), %xmm7
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0]
	pshufd	$232, %xmm6, %xmm2      # xmm2 = xmm6[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm6, %xmm0    # xmm0 = xmm0[0],xmm6[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm5, %xmm6    # xmm6 = xmm6[0],xmm5[0]
	pshufd	$232, %xmm6, %xmm5      # xmm5 = xmm6[0,2,2,3]
	punpcklqdq	%xmm0, %xmm5    # xmm5 = xmm5[0],xmm0[0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm0    # xmm0 = xmm0[0],xmm4[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	pshufd	$232, %xmm4, %xmm3      # xmm3 = xmm4[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	cvttsd2si	%xmm8, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm8, %xmm8        # xmm8 = xmm8[1,0]
	cvttsd2si	%xmm8, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0]
	pshufd	$232, %xmm1, %xmm1      # xmm1 = xmm1[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm5, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end327:
	.size	convert_double_int32_t_16, .Lfunc_end327-convert_double_int32_t_16
	.cfi_endproc

	.globl	convert_uint8_t_int32_t_2
	.align	16, 0x90
	.type	convert_uint8_t_int32_t_2,@function
convert_uint8_t_int32_t_2:              # @convert_uint8_t_int32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end328:
	.size	convert_uint8_t_int32_t_2, .Lfunc_end328-convert_uint8_t_int32_t_2
	.cfi_endproc

	.globl	convert_uint8_t_int32_t_4
	.align	16, 0x90
	.type	convert_uint8_t_int32_t_4,@function
convert_uint8_t_int32_t_4:              # @convert_uint8_t_int32_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end329:
	.size	convert_uint8_t_int32_t_4, .Lfunc_end329-convert_uint8_t_int32_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI330_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_int32_t_8
	.align	16, 0x90
	.type	convert_uint8_t_int32_t_8,@function
convert_uint8_t_int32_t_8:              # @convert_uint8_t_int32_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movdqa	.LCPI330_0(%rip), %xmm2 # xmm2 = [255,0,0,0,255,0,0,0,255,0,0,0,255,0,0,0]
	pand	%xmm2, %xmm1
	punpckhwd	%xmm0, %xmm0    # xmm0 = xmm0[4,4,5,5,6,6,7,7]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end330:
	.size	convert_uint8_t_int32_t_8, .Lfunc_end330-convert_uint8_t_int32_t_8
	.cfi_endproc

	.globl	convert_uint8_t_int32_t_16
	.align	16, 0x90
	.type	convert_uint8_t_int32_t_16,@function
convert_uint8_t_int32_t_16:             # @convert_uint8_t_int32_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm4
	punpcklwd	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1],xmm4[2],xmm1[2],xmm4[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end331:
	.size	convert_uint8_t_int32_t_16, .Lfunc_end331-convert_uint8_t_int32_t_16
	.cfi_endproc

	.globl	convert_uint16_t_int32_t_2
	.align	16, 0x90
	.type	convert_uint16_t_int32_t_2,@function
convert_uint16_t_int32_t_2:             # @convert_uint16_t_int32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end332:
	.size	convert_uint16_t_int32_t_2, .Lfunc_end332-convert_uint16_t_int32_t_2
	.cfi_endproc

	.globl	convert_uint16_t_int32_t_4
	.align	16, 0x90
	.type	convert_uint16_t_int32_t_4,@function
convert_uint16_t_int32_t_4:             # @convert_uint16_t_int32_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end333:
	.size	convert_uint16_t_int32_t_4, .Lfunc_end333-convert_uint16_t_int32_t_4
	.cfi_endproc

	.globl	convert_uint16_t_int32_t_8
	.align	16, 0x90
	.type	convert_uint16_t_int32_t_8,@function
convert_uint16_t_int32_t_8:             # @convert_uint16_t_int32_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end334:
	.size	convert_uint16_t_int32_t_8, .Lfunc_end334-convert_uint16_t_int32_t_8
	.cfi_endproc

	.globl	convert_uint16_t_int32_t_16
	.align	16, 0x90
	.type	convert_uint16_t_int32_t_16,@function
convert_uint16_t_int32_t_16:            # @convert_uint16_t_int32_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movdqa	%xmm1, %xmm4
	punpcklwd	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3]
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end335:
	.size	convert_uint16_t_int32_t_16, .Lfunc_end335-convert_uint16_t_int32_t_16
	.cfi_endproc

	.globl	convert_uint32_t_int32_t_2
	.align	16, 0x90
	.type	convert_uint32_t_int32_t_2,@function
convert_uint32_t_int32_t_2:             # @convert_uint32_t_int32_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end336:
	.size	convert_uint32_t_int32_t_2, .Lfunc_end336-convert_uint32_t_int32_t_2
	.cfi_endproc

	.globl	convert_uint32_t_int32_t_4
	.align	16, 0x90
	.type	convert_uint32_t_int32_t_4,@function
convert_uint32_t_int32_t_4:             # @convert_uint32_t_int32_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end337:
	.size	convert_uint32_t_int32_t_4, .Lfunc_end337-convert_uint32_t_int32_t_4
	.cfi_endproc

	.globl	convert_uint32_t_int32_t_8
	.align	16, 0x90
	.type	convert_uint32_t_int32_t_8,@function
convert_uint32_t_int32_t_8:             # @convert_uint32_t_int32_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end338:
	.size	convert_uint32_t_int32_t_8, .Lfunc_end338-convert_uint32_t_int32_t_8
	.cfi_endproc

	.globl	convert_uint32_t_int32_t_16
	.align	16, 0x90
	.type	convert_uint32_t_int32_t_16,@function
convert_uint32_t_int32_t_16:            # @convert_uint32_t_int32_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end339:
	.size	convert_uint32_t_int32_t_16, .Lfunc_end339-convert_uint32_t_int32_t_16
	.cfi_endproc

	.globl	convert_uint64_t_int32_t_2
	.align	16, 0x90
	.type	convert_uint64_t_int32_t_2,@function
convert_uint64_t_int32_t_2:             # @convert_uint64_t_int32_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end340:
	.size	convert_uint64_t_int32_t_2, .Lfunc_end340-convert_uint64_t_int32_t_2
	.cfi_endproc

	.globl	convert_uint64_t_int32_t_4
	.align	16, 0x90
	.type	convert_uint64_t_int32_t_4,@function
convert_uint64_t_int32_t_4:             # @convert_uint64_t_int32_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end341:
	.size	convert_uint64_t_int32_t_4, .Lfunc_end341-convert_uint64_t_int32_t_4
	.cfi_endproc

	.globl	convert_uint64_t_int32_t_8
	.align	16, 0x90
	.type	convert_uint64_t_int32_t_8,@function
convert_uint64_t_int32_t_8:             # @convert_uint64_t_int32_t_8
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end342:
	.size	convert_uint64_t_int32_t_8, .Lfunc_end342-convert_uint64_t_int32_t_8
	.cfi_endproc

	.globl	convert_uint64_t_int32_t_16
	.align	16, 0x90
	.type	convert_uint64_t_int32_t_16,@function
convert_uint64_t_int32_t_16:            # @convert_uint64_t_int32_t_16
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, 80(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 64(%rsi), %xmm3   # xmm3 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, 112(%rsi), %xmm0  # xmm0 = mem[0,2,2,3]
	pshufd	$232, 96(%rsi), %xmm4   # xmm4 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end343:
	.size	convert_uint64_t_int32_t_16, .Lfunc_end343-convert_uint64_t_int32_t_16
	.cfi_endproc

	.globl	convert_int8_t_int32_t_2
	.align	16, 0x90
	.type	convert_int8_t_int32_t_2,@function
convert_int8_t_int32_t_2:               # @convert_int8_t_int32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end344:
	.size	convert_int8_t_int32_t_2, .Lfunc_end344-convert_int8_t_int32_t_2
	.cfi_endproc

	.globl	convert_int8_t_int32_t_4
	.align	16, 0x90
	.type	convert_int8_t_int32_t_4,@function
convert_int8_t_int32_t_4:               # @convert_int8_t_int32_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end345:
	.size	convert_int8_t_int32_t_4, .Lfunc_end345-convert_int8_t_int32_t_4
	.cfi_endproc

	.globl	convert_int8_t_int32_t_8
	.align	16, 0x90
	.type	convert_int8_t_int32_t_8,@function
convert_int8_t_int32_t_8:               # @convert_int8_t_int32_t_8
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end346:
	.size	convert_int8_t_int32_t_8, .Lfunc_end346-convert_int8_t_int32_t_8
	.cfi_endproc

	.globl	convert_int8_t_int32_t_16
	.align	16, 0x90
	.type	convert_int8_t_int32_t_16,@function
convert_int8_t_int32_t_16:              # @convert_int8_t_int32_t_16
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm0
	movd	4(%rsi), %xmm1          # xmm1 = mem[0],zero,zero,zero
	punpcklbw	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm1
	movd	8(%rsi), %xmm2          # xmm2 = mem[0],zero,zero,zero
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm2
	movd	12(%rsi), %xmm3         # xmm3 = mem[0],zero,zero,zero
	punpcklbw	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$24, %xmm3
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end347:
	.size	convert_int8_t_int32_t_16, .Lfunc_end347-convert_int8_t_int32_t_16
	.cfi_endproc

	.globl	convert_int16_t_int32_t_2
	.align	16, 0x90
	.type	convert_int16_t_int32_t_2,@function
convert_int16_t_int32_t_2:              # @convert_int16_t_int32_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end348:
	.size	convert_int16_t_int32_t_2, .Lfunc_end348-convert_int16_t_int32_t_2
	.cfi_endproc

	.globl	convert_int16_t_int32_t_4
	.align	16, 0x90
	.type	convert_int16_t_int32_t_4,@function
convert_int16_t_int32_t_4:              # @convert_int16_t_int32_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end349:
	.size	convert_int16_t_int32_t_4, .Lfunc_end349-convert_int16_t_int32_t_4
	.cfi_endproc

	.globl	convert_int16_t_int32_t_8
	.align	16, 0x90
	.type	convert_int16_t_int32_t_8,@function
convert_int16_t_int32_t_8:              # @convert_int16_t_int32_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end350:
	.size	convert_int16_t_int32_t_8, .Lfunc_end350-convert_int16_t_int32_t_8
	.cfi_endproc

	.globl	convert_int16_t_int32_t_16
	.align	16, 0x90
	.type	convert_int16_t_int32_t_16,@function
convert_int16_t_int32_t_16:             # @convert_int16_t_int32_t_16
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm0
	movq	8(%rsi), %xmm1          # xmm1 = mem[0],zero
	punpcklwd	%xmm1, %xmm1    # xmm1 = xmm1[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm1
	movq	16(%rsi), %xmm2         # xmm2 = mem[0],zero
	punpcklwd	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm2
	movq	24(%rsi), %xmm3         # xmm3 = mem[0],zero
	punpcklwd	%xmm3, %xmm3    # xmm3 = xmm3[0,0,1,1,2,2,3,3]
	psrad	$16, %xmm3
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end351:
	.size	convert_int16_t_int32_t_16, .Lfunc_end351-convert_int16_t_int32_t_16
	.cfi_endproc

	.globl	convert_int32_t_int32_t_2
	.align	16, 0x90
	.type	convert_int32_t_int32_t_2,@function
convert_int32_t_int32_t_2:              # @convert_int32_t_int32_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	retq
.Lfunc_end352:
	.size	convert_int32_t_int32_t_2, .Lfunc_end352-convert_int32_t_int32_t_2
	.cfi_endproc

	.globl	convert_int32_t_int32_t_4
	.align	16, 0x90
	.type	convert_int32_t_int32_t_4,@function
convert_int32_t_int32_t_4:              # @convert_int32_t_int32_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end353:
	.size	convert_int32_t_int32_t_4, .Lfunc_end353-convert_int32_t_int32_t_4
	.cfi_endproc

	.globl	convert_int32_t_int32_t_8
	.align	16, 0x90
	.type	convert_int32_t_int32_t_8,@function
convert_int32_t_int32_t_8:              # @convert_int32_t_int32_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end354:
	.size	convert_int32_t_int32_t_8, .Lfunc_end354-convert_int32_t_int32_t_8
	.cfi_endproc

	.globl	convert_int32_t_int32_t_16
	.align	16, 0x90
	.type	convert_int32_t_int32_t_16,@function
convert_int32_t_int32_t_16:             # @convert_int32_t_int32_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end355:
	.size	convert_int32_t_int32_t_16, .Lfunc_end355-convert_int32_t_int32_t_16
	.cfi_endproc

	.globl	convert_int64_t_int32_t_2
	.align	16, 0x90
	.type	convert_int64_t_int32_t_2,@function
convert_int64_t_int32_t_2:              # @convert_int64_t_int32_t_2
	.cfi_startproc
# BB#0:
	pshufd	$232, (%rsi), %xmm0     # xmm0 = mem[0,2,2,3]
	movq	%xmm0, (%rdi)
	retq
.Lfunc_end356:
	.size	convert_int64_t_int32_t_2, .Lfunc_end356-convert_int64_t_int32_t_2
	.cfi_endproc

	.globl	convert_int64_t_int32_t_4
	.align	16, 0x90
	.type	convert_int64_t_int32_t_4,@function
convert_int64_t_int32_t_4:              # @convert_int64_t_int32_t_4
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end357:
	.size	convert_int64_t_int32_t_4, .Lfunc_end357-convert_int64_t_int32_t_4
	.cfi_endproc

	.globl	convert_int64_t_int32_t_8
	.align	16, 0x90
	.type	convert_int64_t_int32_t_8,@function
convert_int64_t_int32_t_8:              # @convert_int64_t_int32_t_8
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end358:
	.size	convert_int64_t_int32_t_8, .Lfunc_end358-convert_int64_t_int32_t_8
	.cfi_endproc

	.globl	convert_int64_t_int32_t_16
	.align	16, 0x90
	.type	convert_int64_t_int32_t_16,@function
convert_int64_t_int32_t_16:             # @convert_int64_t_int32_t_16
	.cfi_startproc
# BB#0:
	pshufd	$232, 16(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, (%rsi), %xmm1     # xmm1 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	pshufd	$232, 48(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 32(%rsi), %xmm2   # xmm2 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	pshufd	$232, 80(%rsi), %xmm0   # xmm0 = mem[0,2,2,3]
	pshufd	$232, 64(%rsi), %xmm3   # xmm3 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	pshufd	$232, 112(%rsi), %xmm0  # xmm0 = mem[0,2,2,3]
	pshufd	$232, 96(%rsi), %xmm4   # xmm4 = mem[0,2,2,3]
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end359:
	.size	convert_int64_t_int32_t_16, .Lfunc_end359-convert_int64_t_int32_t_16
	.cfi_endproc

	.globl	convert_float_int64_t_2
	.align	16, 0x90
	.type	convert_float_int64_t_2,@function
convert_float_int64_t_2:                # @convert_float_int64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufps	$229, %xmm0, %xmm0      # xmm0 = xmm0[1,1,2,3]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end360:
	.size	convert_float_int64_t_2, .Lfunc_end360-convert_float_int64_t_2
	.cfi_endproc

	.globl	convert_float_int64_t_4
	.align	16, 0x90
	.type	convert_float_int64_t_4,@function
convert_float_int64_t_4:                # @convert_float_int64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm1
	movaps	%xmm0, %xmm2
	shufps	$229, %xmm2, %xmm2      # xmm2 = xmm2[1,1,2,3]
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movaps	%xmm0, %xmm2
	shufps	$231, %xmm2, %xmm2      # xmm2 = xmm2[3,1,2,3]
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end361:
	.size	convert_float_int64_t_4, .Lfunc_end361-convert_float_int64_t_4
	.cfi_endproc

	.globl	convert_float_int64_t_8
	.align	16, 0x90
	.type	convert_float_int64_t_8,@function
convert_float_int64_t_8:                # @convert_float_int64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm2
	movaps	16(%rsi), %xmm1
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm0
	movaps	%xmm2, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movaps	%xmm2, %xmm3
	shufps	$231, %xmm3, %xmm3      # xmm3 = xmm3[3,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	cvttss2si	%xmm1, %rax
	movd	%rax, %xmm3
	movaps	%xmm1, %xmm4
	shufps	$229, %xmm4, %xmm4      # xmm4 = xmm4[1,1,2,3]
	cvttss2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0]
	movaps	%xmm1, %xmm4
	shufps	$231, %xmm4, %xmm4      # xmm4 = xmm4[3,1,2,3]
	cvttss2si	%xmm4, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttss2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end362:
	.size	convert_float_int64_t_8, .Lfunc_end362-convert_float_int64_t_8
	.cfi_endproc

	.globl	convert_float_int64_t_16
	.align	16, 0x90
	.type	convert_float_int64_t_16,@function
convert_float_int64_t_16:               # @convert_float_int64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm2
	movaps	16(%rsi), %xmm5
	movaps	32(%rsi), %xmm4
	movaps	48(%rsi), %xmm0
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm8
	movaps	%xmm2, %xmm3
	shufps	$229, %xmm3, %xmm3      # xmm3 = xmm3[1,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm8    # xmm8 = xmm8[0],xmm3[0]
	movaps	%xmm2, %xmm3
	shufps	$231, %xmm3, %xmm3      # xmm3 = xmm3[3,1,2,3]
	cvttss2si	%xmm3, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttss2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	cvttss2si	%xmm5, %rax
	movd	%rax, %xmm3
	movaps	%xmm5, %xmm6
	shufps	$229, %xmm6, %xmm6      # xmm6 = xmm6[1,1,2,3]
	cvttss2si	%xmm6, %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm6, %xmm3    # xmm3 = xmm3[0],xmm6[0]
	movaps	%xmm5, %xmm6
	shufps	$231, %xmm6, %xmm6      # xmm6 = xmm6[3,1,2,3]
	cvttss2si	%xmm6, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	cvttss2si	%xmm5, %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm6, %xmm5    # xmm5 = xmm5[0],xmm6[0]
	cvttss2si	%xmm4, %rax
	movd	%rax, %xmm6
	movaps	%xmm4, %xmm7
	shufps	$229, %xmm7, %xmm7      # xmm7 = xmm7[1,1,2,3]
	cvttss2si	%xmm7, %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0]
	movaps	%xmm4, %xmm7
	shufps	$231, %xmm7, %xmm7      # xmm7 = xmm7[3,1,2,3]
	cvttss2si	%xmm7, %rax
	movd	%rax, %xmm7
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttss2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm7, %xmm4    # xmm4 = xmm4[0],xmm7[0]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm7
	movaps	%xmm0, %xmm1
	shufps	$229, %xmm1, %xmm1      # xmm1 = xmm1[1,1,2,3]
	cvttss2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0]
	movaps	%xmm0, %xmm1
	shufps	$231, %xmm1, %xmm1      # xmm1 = xmm1[3,1,2,3]
	cvttss2si	%xmm1, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttss2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm7, 96(%rdi)
	movdqa	%xmm4, 80(%rdi)
	movdqa	%xmm6, 64(%rdi)
	movdqa	%xmm5, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end363:
	.size	convert_float_int64_t_16, .Lfunc_end363-convert_float_int64_t_16
	.cfi_endproc

	.globl	convert_double_int64_t_2
	.align	16, 0x90
	.type	convert_double_int64_t_2,@function
convert_double_int64_t_2:               # @convert_double_int64_t_2
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end364:
	.size	convert_double_int64_t_2, .Lfunc_end364-convert_double_int64_t_2
	.cfi_endproc

	.globl	convert_double_int64_t_4
	.align	16, 0x90
	.type	convert_double_int64_t_4,@function
convert_double_int64_t_4:               # @convert_double_int64_t_4
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm1
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end365:
	.size	convert_double_int64_t_4, .Lfunc_end365-convert_double_int64_t_4
	.cfi_endproc

	.globl	convert_double_int64_t_8
	.align	16, 0x90
	.type	convert_double_int64_t_8,@function
convert_double_int64_t_8:               # @convert_double_int64_t_8
	.cfi_startproc
# BB#0:
	movapd	(%rsi), %xmm1
	movapd	16(%rsi), %xmm2
	movapd	32(%rsi), %xmm3
	movapd	48(%rsi), %xmm4
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm1
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0]
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end366:
	.size	convert_double_int64_t_8, .Lfunc_end366-convert_double_int64_t_8
	.cfi_endproc

	.globl	convert_double_int64_t_16
	.align	16, 0x90
	.type	convert_double_int64_t_16,@function
convert_double_int64_t_16:              # @convert_double_int64_t_16
	.cfi_startproc
# BB#0:
	movapd	112(%rsi), %xmm1
	movapd	96(%rsi), %xmm3
	movapd	80(%rsi), %xmm5
	movapd	64(%rsi), %xmm7
	movapd	(%rsi), %xmm0
	movapd	16(%rsi), %xmm4
	movapd	32(%rsi), %xmm6
	movapd	48(%rsi), %xmm2
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm8
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	cvttsd2si	%xmm0, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm8    # xmm8 = xmm8[0],xmm0[0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm9
	shufpd	$1, %xmm4, %xmm4        # xmm4 = xmm4[1,0]
	cvttsd2si	%xmm4, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm9    # xmm9 = xmm9[0],xmm0[0]
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm4
	shufpd	$1, %xmm6, %xmm6        # xmm6 = xmm6[1,0]
	cvttsd2si	%xmm6, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm6
	shufpd	$1, %xmm2, %xmm2        # xmm2 = xmm2[1,0]
	cvttsd2si	%xmm2, %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm0, %xmm6    # xmm6 = xmm6[0],xmm0[0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm0
	shufpd	$1, %xmm7, %xmm7        # xmm7 = xmm7[1,0]
	cvttsd2si	%xmm7, %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0]
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm2
	shufpd	$1, %xmm5, %xmm5        # xmm5 = xmm5[1,0]
	cvttsd2si	%xmm5, %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm5, %xmm2    # xmm2 = xmm2[0],xmm5[0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm5
	shufpd	$1, %xmm3, %xmm3        # xmm3 = xmm3[1,0]
	cvttsd2si	%xmm3, %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm3
	shufpd	$1, %xmm1, %xmm1        # xmm1 = xmm1[1,0]
	cvttsd2si	%xmm1, %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0]
	movdqa	%xmm3, 112(%rdi)
	movdqa	%xmm5, 96(%rdi)
	movdqa	%xmm2, 80(%rdi)
	movdqa	%xmm0, 64(%rdi)
	movdqa	%xmm6, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm9, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end367:
	.size	convert_double_int64_t_16, .Lfunc_end367-convert_double_int64_t_16
	.cfi_endproc

	.globl	convert_uint8_t_int64_t_2
	.align	16, 0x90
	.type	convert_uint8_t_int64_t_2,@function
convert_uint8_t_int64_t_2:              # @convert_uint8_t_int64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end368:
	.size	convert_uint8_t_int64_t_2, .Lfunc_end368-convert_uint8_t_int64_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI369_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_int64_t_4
	.align	16, 0x90
	.type	convert_uint8_t_int64_t_4,@function
convert_uint8_t_int64_t_4:              # @convert_uint8_t_int64_t_4
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pshufd	$212, %xmm0, %xmm1      # xmm1 = xmm0[0,1,1,3]
	movdqa	.LCPI369_0(%rip), %xmm2 # xmm2 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$246, %xmm0, %xmm0      # xmm0 = xmm0[2,1,3,3]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end369:
	.size	convert_uint8_t_int64_t_4, .Lfunc_end369-convert_uint8_t_int64_t_4
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI370_0:
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	255                     # 0xff
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.text
	.globl	convert_uint8_t_int64_t_8
	.align	16, 0x90
	.type	convert_uint8_t_int64_t_8,@function
convert_uint8_t_int64_t_8:              # @convert_uint8_t_int64_t_8
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshufd	$196, %xmm0, %xmm1      # xmm1 = xmm0[0,1,0,3]
	pshufhw	$229, %xmm1, %xmm1      # xmm1 = xmm1[0,1,2,3,5,5,6,7]
	movdqa	.LCPI370_0(%rip), %xmm2 # xmm2 = [255,0,0,0,0,0,0,0,255,0,0,0,0,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$213, %xmm0, %xmm3      # xmm3 = xmm0[1,1,1,3]
	pshufhw	$229, %xmm3, %xmm3      # xmm3 = xmm3[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm3
	pshufd	$230, %xmm0, %xmm4      # xmm4 = xmm0[2,1,2,3]
	pshufhw	$229, %xmm4, %xmm4      # xmm4 = xmm4[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm4
	pshufd	$247, %xmm0, %xmm0      # xmm0 = xmm0[3,1,3,3]
	pshufhw	$229, %xmm0, %xmm0      # xmm0 = xmm0[0,1,2,3,5,5,6,7]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end370:
	.size	convert_uint8_t_int64_t_8, .Lfunc_end370-convert_uint8_t_int64_t_8
	.cfi_endproc

	.globl	convert_uint8_t_int64_t_16
	.align	16, 0x90
	.type	convert_uint8_t_int64_t_16,@function
convert_uint8_t_int64_t_16:             # @convert_uint8_t_int64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklbw	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm3
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	movdqa	%xmm3, %xmm8
	punpckldq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0],xmm8[1],xmm1[1]
	punpckhdq	%xmm1, %xmm3    # xmm3 = xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpckhwd	%xmm1, %xmm2    # xmm2 = xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movdqa	%xmm2, %xmm5
	punpckldq	%xmm1, %xmm5    # xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
	punpckhdq	%xmm1, %xmm2    # xmm2 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
	movdqa	%xmm0, %xmm6
	punpcklwd	%xmm1, %xmm6    # xmm6 = xmm6[0],xmm1[0],xmm6[1],xmm1[1],xmm6[2],xmm1[2],xmm6[3],xmm1[3]
	movdqa	%xmm6, %xmm7
	punpckldq	%xmm1, %xmm7    # xmm7 = xmm7[0],xmm1[0],xmm7[1],xmm1[1]
	punpckhdq	%xmm1, %xmm6    # xmm6 = xmm6[2],xmm1[2],xmm6[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm4, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm2, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end371:
	.size	convert_uint8_t_int64_t_16, .Lfunc_end371-convert_uint8_t_int64_t_16
	.cfi_endproc

	.globl	convert_uint16_t_int64_t_2
	.align	16, 0x90
	.type	convert_uint16_t_int64_t_2,@function
convert_uint16_t_int64_t_2:             # @convert_uint16_t_int64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm1
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end372:
	.size	convert_uint16_t_int64_t_2, .Lfunc_end372-convert_uint16_t_int64_t_2
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI373_0:
	.short	65535                   # 0xffff
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	65535                   # 0xffff
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.text
	.globl	convert_uint16_t_int64_t_4
	.align	16, 0x90
	.type	convert_uint16_t_int64_t_4,@function
convert_uint16_t_int64_t_4:             # @convert_uint16_t_int64_t_4
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	pshufd	$212, %xmm0, %xmm1      # xmm1 = xmm0[0,1,1,3]
	movdqa	.LCPI373_0(%rip), %xmm2 # xmm2 = [65535,0,0,0,65535,0,0,0]
	pand	%xmm2, %xmm1
	pshufd	$246, %xmm0, %xmm0      # xmm0 = xmm0[2,1,3,3]
	pand	%xmm2, %xmm0
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end373:
	.size	convert_uint16_t_int64_t_4, .Lfunc_end373-convert_uint16_t_int64_t_4
	.cfi_endproc

	.globl	convert_uint16_t_int64_t_8
	.align	16, 0x90
	.type	convert_uint16_t_int64_t_8,@function
convert_uint16_t_int64_t_8:             # @convert_uint16_t_int64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movdqa	%xmm2, %xmm3
	punpckldq	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	punpckhdq	%xmm1, %xmm2    # xmm2 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movdqa	%xmm0, %xmm4
	punpckldq	%xmm1, %xmm4    # xmm4 = xmm4[0],xmm1[0],xmm4[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end374:
	.size	convert_uint16_t_int64_t_8, .Lfunc_end374-convert_uint16_t_int64_t_8
	.cfi_endproc

	.globl	convert_uint16_t_int64_t_16
	.align	16, 0x90
	.type	convert_uint16_t_int64_t_16,@function
convert_uint16_t_int64_t_16:            # @convert_uint16_t_int64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movdqa	%xmm3, %xmm8
	punpckldq	%xmm2, %xmm8    # xmm8 = xmm8[0],xmm2[0],xmm8[1],xmm2[1]
	punpckhdq	%xmm2, %xmm3    # xmm3 = xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpckhwd	%xmm2, %xmm0    # xmm0 = xmm0[4],xmm2[4],xmm0[5],xmm2[5],xmm0[6],xmm2[6],xmm0[7],xmm2[7]
	movdqa	%xmm0, %xmm5
	punpckldq	%xmm2, %xmm5    # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1]
	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movdqa	%xmm1, %xmm6
	punpcklwd	%xmm2, %xmm6    # xmm6 = xmm6[0],xmm2[0],xmm6[1],xmm2[1],xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	movdqa	%xmm6, %xmm7
	punpckldq	%xmm2, %xmm7    # xmm7 = xmm7[0],xmm2[0],xmm7[1],xmm2[1]
	punpckhdq	%xmm2, %xmm6    # xmm6 = xmm6[2],xmm2[2],xmm6[3],xmm2[3]
	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
	movdqa	%xmm1, %xmm4
	punpckldq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	punpckhdq	%xmm2, %xmm1    # xmm1 = xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	movdqa	%xmm1, 112(%rdi)
	movdqa	%xmm4, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm0, 48(%rdi)
	movdqa	%xmm5, 32(%rdi)
	movdqa	%xmm3, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end375:
	.size	convert_uint16_t_int64_t_16, .Lfunc_end375-convert_uint16_t_int64_t_16
	.cfi_endproc

	.globl	convert_uint32_t_int64_t_2
	.align	16, 0x90
	.type	convert_uint32_t_int64_t_2,@function
convert_uint32_t_int64_t_2:             # @convert_uint32_t_int64_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	pxor	%xmm1, %xmm1
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end376:
	.size	convert_uint32_t_int64_t_2, .Lfunc_end376-convert_uint32_t_int64_t_2
	.cfi_endproc

	.globl	convert_uint32_t_int64_t_4
	.align	16, 0x90
	.type	convert_uint32_t_int64_t_4,@function
convert_uint32_t_int64_t_4:             # @convert_uint32_t_int64_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pxor	%xmm1, %xmm1
	movdqa	%xmm0, %xmm2
	punpckldq	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	punpckhdq	%xmm1, %xmm0    # xmm0 = xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm2, (%rdi)
	retq
.Lfunc_end377:
	.size	convert_uint32_t_int64_t_4, .Lfunc_end377-convert_uint32_t_int64_t_4
	.cfi_endproc

	.globl	convert_uint32_t_int64_t_8
	.align	16, 0x90
	.type	convert_uint32_t_int64_t_8,@function
convert_uint32_t_int64_t_8:             # @convert_uint32_t_int64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pxor	%xmm2, %xmm2
	movdqa	%xmm0, %xmm3
	punpckldq	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
	punpckhdq	%xmm2, %xmm0    # xmm0 = xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movdqa	%xmm1, %xmm4
	punpckldq	%xmm2, %xmm4    # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1]
	punpckhdq	%xmm2, %xmm1    # xmm1 = xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm4, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm3, (%rdi)
	retq
.Lfunc_end378:
	.size	convert_uint32_t_int64_t_8, .Lfunc_end378-convert_uint32_t_int64_t_8
	.cfi_endproc

	.globl	convert_uint32_t_int64_t_16
	.align	16, 0x90
	.type	convert_uint32_t_int64_t_16,@function
convert_uint32_t_int64_t_16:            # @convert_uint32_t_int64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	movdqa	32(%rsi), %xmm2
	movdqa	48(%rsi), %xmm5
	pxor	%xmm4, %xmm4
	movdqa	%xmm0, %xmm8
	punpckldq	%xmm4, %xmm8    # xmm8 = xmm8[0],xmm4[0],xmm8[1],xmm4[1]
	punpckhdq	%xmm4, %xmm0    # xmm0 = xmm0[2],xmm4[2],xmm0[3],xmm4[3]
	movdqa	%xmm1, %xmm6
	punpckldq	%xmm4, %xmm6    # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1]
	punpckhdq	%xmm4, %xmm1    # xmm1 = xmm1[2],xmm4[2],xmm1[3],xmm4[3]
	movdqa	%xmm2, %xmm7
	punpckldq	%xmm4, %xmm7    # xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
	punpckhdq	%xmm4, %xmm2    # xmm2 = xmm2[2],xmm4[2],xmm2[3],xmm4[3]
	movdqa	%xmm5, %xmm3
	punpckldq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
	punpckhdq	%xmm4, %xmm5    # xmm5 = xmm5[2],xmm4[2],xmm5[3],xmm4[3]
	movdqa	%xmm5, 112(%rdi)
	movdqa	%xmm3, 96(%rdi)
	movdqa	%xmm2, 80(%rdi)
	movdqa	%xmm7, 64(%rdi)
	movdqa	%xmm1, 48(%rdi)
	movdqa	%xmm6, 32(%rdi)
	movdqa	%xmm0, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end379:
	.size	convert_uint32_t_int64_t_16, .Lfunc_end379-convert_uint32_t_int64_t_16
	.cfi_endproc

	.globl	convert_uint64_t_int64_t_2
	.align	16, 0x90
	.type	convert_uint64_t_int64_t_2,@function
convert_uint64_t_int64_t_2:             # @convert_uint64_t_int64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end380:
	.size	convert_uint64_t_int64_t_2, .Lfunc_end380-convert_uint64_t_int64_t_2
	.cfi_endproc

	.globl	convert_uint64_t_int64_t_4
	.align	16, 0x90
	.type	convert_uint64_t_int64_t_4,@function
convert_uint64_t_int64_t_4:             # @convert_uint64_t_int64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end381:
	.size	convert_uint64_t_int64_t_4, .Lfunc_end381-convert_uint64_t_int64_t_4
	.cfi_endproc

	.globl	convert_uint64_t_int64_t_8
	.align	16, 0x90
	.type	convert_uint64_t_int64_t_8,@function
convert_uint64_t_int64_t_8:             # @convert_uint64_t_int64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end382:
	.size	convert_uint64_t_int64_t_8, .Lfunc_end382-convert_uint64_t_int64_t_8
	.cfi_endproc

	.globl	convert_uint64_t_int64_t_16
	.align	16, 0x90
	.type	convert_uint64_t_int64_t_16,@function
convert_uint64_t_int64_t_16:            # @convert_uint64_t_int64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end383:
	.size	convert_uint64_t_int64_t_16, .Lfunc_end383-convert_uint64_t_int64_t_16
	.cfi_endproc

	.globl	convert_int8_t_int64_t_2
	.align	16, 0x90
	.type	convert_int8_t_int64_t_2,@function
convert_int8_t_int64_t_2:               # @convert_int8_t_int64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	psrad	$24, %xmm0
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end384:
	.size	convert_int8_t_int64_t_2, .Lfunc_end384-convert_int8_t_int64_t_2
	.cfi_endproc

	.globl	convert_int8_t_int64_t_4
	.align	16, 0x90
	.type	convert_int8_t_int64_t_4,@function
convert_int8_t_int64_t_4:               # @convert_int8_t_int64_t_4
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end385:
	.size	convert_int8_t_int64_t_4, .Lfunc_end385-convert_int8_t_int64_t_4
	.cfi_endproc

	.globl	convert_int8_t_int64_t_8
	.align	16, 0x90
	.type	convert_int8_t_int64_t_8,@function
convert_int8_t_int64_t_8:               # @convert_int8_t_int64_t_8
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movsbq	5(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	4(%rsi), %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movsbq	7(%rsi), %rax
	movd	%rax, %xmm0
	movsbq	6(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end386:
	.size	convert_int8_t_int64_t_8, .Lfunc_end386-convert_int8_t_int64_t_8
	.cfi_endproc

	.globl	convert_int8_t_int64_t_16
	.align	16, 0x90
	.type	convert_int8_t_int64_t_16,@function
convert_int8_t_int64_t_16:              # @convert_int8_t_int64_t_16
	.cfi_startproc
# BB#0:
	movsbq	1(%rsi), %rax
	movd	%rax, %xmm1
	movsbq	(%rsi), %rax
	movd	%rax, %xmm8
	punpcklqdq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0]
	movsbq	3(%rsi), %rax
	movd	%rax, %xmm2
	movsbq	2(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movsbq	5(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movsbq	7(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	6(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	movsbq	9(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	8(%rsi), %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movsbq	11(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	10(%rsi), %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm3, %xmm6    # xmm6 = xmm6[0],xmm3[0]
	movsbq	13(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	12(%rsi), %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm3, %xmm7    # xmm7 = xmm7[0],xmm3[0]
	movsbq	15(%rsi), %rax
	movd	%rax, %xmm3
	movsbq	14(%rsi), %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm7, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm5, 64(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end387:
	.size	convert_int8_t_int64_t_16, .Lfunc_end387-convert_int8_t_int64_t_16
	.cfi_endproc

	.globl	convert_int16_t_int64_t_2
	.align	16, 0x90
	.type	convert_int16_t_int64_t_2,@function
convert_int16_t_int64_t_2:              # @convert_int16_t_int64_t_2
	.cfi_startproc
# BB#0:
	movd	(%rsi), %xmm0           # xmm0 = mem[0],zero,zero,zero
	punpcklwd	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3]
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	psrad	$16, %xmm0
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end388:
	.size	convert_int16_t_int64_t_2, .Lfunc_end388-convert_int16_t_int64_t_2
	.cfi_endproc

	.globl	convert_int16_t_int64_t_4
	.align	16, 0x90
	.type	convert_int16_t_int64_t_4,@function
convert_int16_t_int64_t_4:              # @convert_int16_t_int64_t_4
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm0
	movswq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm0
	movswq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end389:
	.size	convert_int16_t_int64_t_4, .Lfunc_end389-convert_int16_t_int64_t_4
	.cfi_endproc

	.globl	convert_int16_t_int64_t_8
	.align	16, 0x90
	.type	convert_int16_t_int64_t_8,@function
convert_int16_t_int64_t_8:              # @convert_int16_t_int64_t_8
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm0
	movswq	(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm0
	movswq	4(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0]
	movswq	10(%rsi), %rax
	movd	%rax, %xmm0
	movswq	8(%rsi), %rax
	movd	%rax, %xmm3
	punpcklqdq	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0]
	movswq	14(%rsi), %rax
	movd	%rax, %xmm0
	movswq	12(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm0, %xmm4    # xmm4 = xmm4[0],xmm0[0]
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm3, 32(%rdi)
	movdqa	%xmm2, 16(%rdi)
	movdqa	%xmm1, (%rdi)
	retq
.Lfunc_end390:
	.size	convert_int16_t_int64_t_8, .Lfunc_end390-convert_int16_t_int64_t_8
	.cfi_endproc

	.globl	convert_int16_t_int64_t_16
	.align	16, 0x90
	.type	convert_int16_t_int64_t_16,@function
convert_int16_t_int64_t_16:             # @convert_int16_t_int64_t_16
	.cfi_startproc
# BB#0:
	movswq	2(%rsi), %rax
	movd	%rax, %xmm1
	movswq	(%rsi), %rax
	movd	%rax, %xmm8
	punpcklqdq	%xmm1, %xmm8    # xmm8 = xmm8[0],xmm1[0]
	movswq	6(%rsi), %rax
	movd	%rax, %xmm2
	movswq	4(%rsi), %rax
	movd	%rax, %xmm1
	punpcklqdq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0]
	movswq	10(%rsi), %rax
	movd	%rax, %xmm3
	movswq	8(%rsi), %rax
	movd	%rax, %xmm2
	punpcklqdq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0]
	movswq	14(%rsi), %rax
	movd	%rax, %xmm3
	movswq	12(%rsi), %rax
	movd	%rax, %xmm4
	punpcklqdq	%xmm3, %xmm4    # xmm4 = xmm4[0],xmm3[0]
	movswq	18(%rsi), %rax
	movd	%rax, %xmm3
	movswq	16(%rsi), %rax
	movd	%rax, %xmm5
	punpcklqdq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0]
	movswq	22(%rsi), %rax
	movd	%rax, %xmm3
	movswq	20(%rsi), %rax
	movd	%rax, %xmm6
	punpcklqdq	%xmm3, %xmm6    # xmm6 = xmm6[0],xmm3[0]
	movswq	26(%rsi), %rax
	movd	%rax, %xmm3
	movswq	24(%rsi), %rax
	movd	%rax, %xmm7
	punpcklqdq	%xmm3, %xmm7    # xmm7 = xmm7[0],xmm3[0]
	movswq	30(%rsi), %rax
	movd	%rax, %xmm3
	movswq	28(%rsi), %rax
	movd	%rax, %xmm0
	punpcklqdq	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0]
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm7, 96(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm5, 64(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, 16(%rdi)
	movdqa	%xmm8, (%rdi)
	retq
.Lfunc_end391:
	.size	convert_int16_t_int64_t_16, .Lfunc_end391-convert_int16_t_int64_t_16
	.cfi_endproc

	.globl	convert_int32_t_int64_t_2
	.align	16, 0x90
	.type	convert_int32_t_int64_t_2,@function
convert_int32_t_int64_t_2:              # @convert_int32_t_int64_t_2
	.cfi_startproc
# BB#0:
	movq	(%rsi), %xmm0           # xmm0 = mem[0],zero
	movdqa	%xmm0, %xmm1
	psrad	$31, %xmm1
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movdqa	%xmm0, (%rdi)
	retq
.Lfunc_end392:
	.size	convert_int32_t_int64_t_2, .Lfunc_end392-convert_int32_t_int64_t_2
	.cfi_endproc

	.globl	convert_int32_t_int64_t_4
	.align	16, 0x90
	.type	convert_int32_t_int64_t_4,@function
convert_int32_t_int64_t_4:              # @convert_int32_t_int64_t_4
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	pshufd	$78, %xmm0, %xmm1       # xmm1 = xmm0[2,3,0,1]
	movdqa	%xmm1, %xmm2
	psrad	$31, %xmm2
	punpckldq	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	movdqa	%xmm0, %xmm2
	psrad	$31, %xmm2
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm1, 16(%rdi)
	retq
.Lfunc_end393:
	.size	convert_int32_t_int64_t_4, .Lfunc_end393-convert_int32_t_int64_t_4
	.cfi_endproc

	.globl	convert_int32_t_int64_t_8
	.align	16, 0x90
	.type	convert_int32_t_int64_t_8,@function
convert_int32_t_int64_t_8:              # @convert_int32_t_int64_t_8
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm0
	movdqa	16(%rsi), %xmm1
	pshufd	$78, %xmm0, %xmm2       # xmm2 = xmm0[2,3,0,1]
	movdqa	%xmm2, %xmm3
	psrad	$31, %xmm3
	punpckldq	%xmm3, %xmm2    # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
	pshufd	$78, %xmm1, %xmm3       # xmm3 = xmm1[2,3,0,1]
	movdqa	%xmm3, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm3    # xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
	movdqa	%xmm0, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm0    # xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1]
	movdqa	%xmm1, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm1    # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
	movdqa	%xmm1, 32(%rdi)
	movdqa	%xmm0, (%rdi)
	movdqa	%xmm3, 48(%rdi)
	movdqa	%xmm2, 16(%rdi)
	retq
.Lfunc_end394:
	.size	convert_int32_t_int64_t_8, .Lfunc_end394-convert_int32_t_int64_t_8
	.cfi_endproc

	.globl	convert_int32_t_int64_t_16
	.align	16, 0x90
	.type	convert_int32_t_int64_t_16,@function
convert_int32_t_int64_t_16:             # @convert_int32_t_int64_t_16
	.cfi_startproc
# BB#0:
	movdqa	(%rsi), %xmm1
	movdqa	16(%rsi), %xmm2
	movdqa	32(%rsi), %xmm3
	movdqa	48(%rsi), %xmm5
	pshufd	$78, %xmm1, %xmm8       # xmm8 = xmm1[2,3,0,1]
	movdqa	%xmm8, %xmm4
	psrad	$31, %xmm4
	punpckldq	%xmm4, %xmm8    # xmm8 = xmm8[0],xmm4[0],xmm8[1],xmm4[1]
	pshufd	$78, %xmm2, %xmm4       # xmm4 = xmm2[2,3,0,1]
	movdqa	%xmm4, %xmm6
	psrad	$31, %xmm6
	punpckldq	%xmm6, %xmm4    # xmm4 = xmm4[0],xmm6[0],xmm4[1],xmm6[1]
	pshufd	$78, %xmm3, %xmm6       # xmm6 = xmm3[2,3,0,1]
	movdqa	%xmm6, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm6    # xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
	pshufd	$78, %xmm5, %xmm0       # xmm0 = xmm5[2,3,0,1]
	movdqa	%xmm0, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm0    # xmm0 = xmm0[0],xmm7[0],xmm0[1],xmm7[1]
	movdqa	%xmm1, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm1    # xmm1 = xmm1[0],xmm7[0],xmm1[1],xmm7[1]
	movdqa	%xmm2, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm2    # xmm2 = xmm2[0],xmm7[0],xmm2[1],xmm7[1]
	movdqa	%xmm3, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm3    # xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1]
	movdqa	%xmm5, %xmm7
	psrad	$31, %xmm7
	punpckldq	%xmm7, %xmm5    # xmm5 = xmm5[0],xmm7[0],xmm5[1],xmm7[1]
	movdqa	%xmm5, 96(%rdi)
	movdqa	%xmm3, 64(%rdi)
	movdqa	%xmm2, 32(%rdi)
	movdqa	%xmm1, (%rdi)
	movdqa	%xmm0, 112(%rdi)
	movdqa	%xmm6, 80(%rdi)
	movdqa	%xmm4, 48(%rdi)
	movdqa	%xmm8, 16(%rdi)
	retq
.Lfunc_end395:
	.size	convert_int32_t_int64_t_16, .Lfunc_end395-convert_int32_t_int64_t_16
	.cfi_endproc

	.globl	convert_int64_t_int64_t_2
	.align	16, 0x90
	.type	convert_int64_t_int64_t_2,@function
convert_int64_t_int64_t_2:              # @convert_int64_t_int64_t_2
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end396:
	.size	convert_int64_t_int64_t_2, .Lfunc_end396-convert_int64_t_int64_t_2
	.cfi_endproc

	.globl	convert_int64_t_int64_t_4
	.align	16, 0x90
	.type	convert_int64_t_int64_t_4,@function
convert_int64_t_int64_t_4:              # @convert_int64_t_int64_t_4
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end397:
	.size	convert_int64_t_int64_t_4, .Lfunc_end397-convert_int64_t_int64_t_4
	.cfi_endproc

	.globl	convert_int64_t_int64_t_8
	.align	16, 0x90
	.type	convert_int64_t_int64_t_8,@function
convert_int64_t_int64_t_8:              # @convert_int64_t_int64_t_8
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end398:
	.size	convert_int64_t_int64_t_8, .Lfunc_end398-convert_int64_t_int64_t_8
	.cfi_endproc

	.globl	convert_int64_t_int64_t_16
	.align	16, 0x90
	.type	convert_int64_t_int64_t_16,@function
convert_int64_t_int64_t_16:             # @convert_int64_t_int64_t_16
	.cfi_startproc
# BB#0:
	movaps	(%rsi), %xmm0
	movaps	16(%rsi), %xmm1
	movaps	32(%rsi), %xmm2
	movaps	48(%rsi), %xmm3
	movaps	64(%rsi), %xmm4
	movaps	80(%rsi), %xmm5
	movaps	96(%rsi), %xmm6
	movaps	112(%rsi), %xmm7
	movaps	%xmm7, 112(%rdi)
	movaps	%xmm6, 96(%rdi)
	movaps	%xmm5, 80(%rdi)
	movaps	%xmm4, 64(%rdi)
	movaps	%xmm3, 48(%rdi)
	movaps	%xmm2, 32(%rdi)
	movaps	%xmm1, 16(%rdi)
	movaps	%xmm0, (%rdi)
	retq
.Lfunc_end399:
	.size	convert_int64_t_int64_t_16, .Lfunc_end399-convert_int64_t_int64_t_16
	.cfi_endproc


	.ident	"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"
	.section	".note.GNU-stack","",@progbits
