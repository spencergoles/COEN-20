// Spencer Goles
// January 22, 2020
// functions.s
// Assembley code for Lab 2a

	.syntax unified
	.cpu cortex-m4
	.text
	
	.global Add
	.thumb_func
Add:
	ADD R0, R0, R1     // Add a + b
	BX LR              // Return  

	.global Less1
	.thumb_func
Less1:
	SUB R0, 1          // Subtract a - 1
	BX LR              // Return

	.global Square2x
	.thumb_func
Square2x:
	ADD R0, R0, R0     // Add x + x
	B Square           // Square Func (x+x)

	.global Last
	.thumb_func
Last:
	PUSH {R4,LR}        // Push R4 onto Stack
	MOV R4,R0           // Moving x to temp register
	BL SquareRoot       // SquareRoot R0
	ADD R0,R0,R4        // Add X + sq(X)
	POP {R4,PC}         // Pop R4 from Stack 

	.end