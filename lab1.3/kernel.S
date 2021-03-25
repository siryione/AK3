.syntax unified
.cpu cortex-m4
.thumb
#define a #5
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
	final: .asciz "Value in register #3: "
.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line
	// calculate 
	mov r0, a
	mov r1, b
	mov r2, c
	mul r3, r0, r1
	cmp r3, #10
	ITE GE
	orrGE r3, r0, r1
	andLT r3, r0, r1
	mul r3, r2

	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num

	end:
	b end

