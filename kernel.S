.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define a #8
#define b #3
#define c #2

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
.word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started!\n"
	result: .asciz "Result value in R0: "

.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line
	
	// Calculation

	mov r0, a
    	mov r1, b
    	mov r2, c
	mov r4, #3
    	sub r0, r1
    	mul r0, r4
    	mov r3, #2
    	pow:
		cmp r2, #1
		beq sum
		lsl r3, r3, #1
		sub r2, #1
		bne pow
   	sum:
		add r0, r3
	mov r3, r0

	ldr r0, =result
	bl dbgput
	mov r0, r3
	bl dbgput_num

	end:
	b end
