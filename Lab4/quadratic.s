// Spencer Goles
// quadratic.s
// Febuary 5, 2020

	.syntax unified
	.cpu cortex-m4
	.text

	.global	Discriminant
	.thumb_func 
Discriminant:
	MUL R1,R1,R1      //R1 <= b^2
	LSL R0,R0,2       //R0 <= 4a
	MLS R0,R0,R2,R1   // R1^2 - 4*R0*R2 = b^2 - 4ac
	BX  LR

	.global	Root1
	.thumb_func
	
Root1:
	PUSH {R4,R5,LR}
	MOV R4,R0         // Put a in R4
	MOV R5,R1         // Put b in R5
	BL Discriminant   
	BL SquareRoot
	LSL R4,R4,1       // Multiply 2a
	SUB R0,R0,R5      // Subtracting equation output - b
	SDIV R0,R0,R4     // Dividing by 2a
	POP {R4,R5,PC}


	.global	Root2
	.thumb_func
	
Root2:
	PUSH {R4,R5,LR}
	MOV R4,R0          // Put a in R4
	MOV R5,R1          // Put b in R5
	BL Discriminant
	BL SquareRoot
	LSL R4,R4,1        // Multiply 2a
	NEG R5,R5          // Make b into -b
	SUB R0,R5,R0       // Subtracting -b to equation output
	SDIV R0,R0,R4      // Dividing by 2a
	POP {R4,R5,PC}


	.global	Quadratic
	.thumb_func
	
Quadratic:
	MLA R2,R2,R0,R3    // Multiply b*x + c
	MUL R0,R0,R0       // Square X
	MUL R0,R0,R1       // X^2 * a
	ADD R0,R0,R2       // Add full equation
	BX LR 
	
.end
	