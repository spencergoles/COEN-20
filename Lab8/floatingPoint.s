// Spencer Goles
// floatingPoint.s
// March 4, 2020

	.syntax	unified
	.cpu	cortex-m4
	.text
	
	.global Discriminant
	.thumb_func
Discriminant:
	VMUL.F32 S1,S1,S1        	// b*b = b^2
	VMOV S3,4.0					// S3 = 4.0
	VMUL.F32 S0,S0,S3			// 4.0 * a
	VMLS.F32 S1,S0,S2			// b^2 - 4ac
	VMOV S0,S1   				// Move to S0 
	BX	LR
	

	.global	Quadratic
	.thumb_func
Quadratic:
	VMOV S4,S0					// Preserve X
	VMUL.F32 S0,S4,S4			// X^2
	VMUL.F32 S1,S0,S1			// AX^2
	VMLA.F32 S1,S2,S4			// ax^2 + bx
	VADD.F32 S1,S1,S3			// ax^2 + bx + c
	VMOV S0,S1					// Move to S0
	BX	LR


	.global	Root1
	.thumb_func
Root1:
	PUSH {R4,R5,LR}
	VMOV R4,S0					// Preserve A
	VMOV R5,S1					// Preserve B 
	BL	Discriminant			// Discriminant(a,b,c)
	VSQRT.F32 S0,S0				// SQRT(Discriminant(a,b,c))
	VMOV S1,R5
	VMOV S2,R4
	VSUB.F32 S0,S0,S1			// SQRT(Discriminant(a,b,c)) - b
	VMOV S3,2.0					// S5 = 2.0
	VMUL.F32 S2,S2,S3			// 2.0 * a 
	VDIV.F32 S0,S0,S2			// (SQRT(Discriminant(a,b,c)) - b) / 2a
	POP {R4,R5,PC}				
	BX	LR
	
	
	.global	Root2
	.thumb_func
Root2:
	PUSH {R4,R5,LR}
	VMOV R4,S0					// Preserve A
	VMOV R5,S1					// Preserve B 
	BL	Discriminant			// Discriminant(a,b,c)
	VSQRT.F32 S0,S0				// SQRT(Discriminant(a,b,c))
	VMOV S1,R5
	VMOV S2,R4
	VNEG.F32 S1,S1
	VSUB.F32 S0,S1,S0			// SQRT(Discriminant(a,b,c)) - b
	VMOV S3,2.0					// S5 = 2.0
	VMUL.F32 S2,S2,S3			// 2.0 * a 
	VDIV.F32 S0,S0,S2			// (SQRT(Discriminant(a,b,c)) - b) / 2a
	POP {R4,R5,PC}				
	BX	LR

	.end
	
