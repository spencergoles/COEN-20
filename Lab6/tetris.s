// Spencer Goles
// tetris.s
// Febuary 19, 2020

	.syntax	unified
	.cpu	cortex-m4
	.text
	
	.global	GetBit
	.thumb_func
	//.set	BITBANDING, 1  //Comment out to disable bitbanding
	.ifdef	BITBANDING
	
// R0 = uing16_t *bits, R1 = uint32_t row, R2 = uint32_t col

GetBit:
	LDR R12,=4
	SUB R3,R0,0x20000000		// Subtract base address
	LSL R3,R3,5					// Multiply by 32
	MUL R1,R1,R12				// Multiply rows
	ADD R1,R1,R2				// Add rows to col
	ADD R3,R3,R1,LSL 2			// Compute new address
	ADD R3,R3,0x22000000		// Create full new address
	LDRH R0,[R3]				// Load address for return
	BX LR
	.else
	
GetBit:
	LDRH R0,[R0]				// Load address
	LDR R3,=4
	MUL R1,R1,R3				// Multiply rows by 4	
	ADD R1,R1,R2				// Add new rows to cols
	LDR R12,=1
	LSL R12,R12,R1				// Shift (1 << R1)
	AND R0,R0,R12				// And address with R12
	LSR R0,R0,R1				// Shift R0 by R1 right
	BX LR
	
	.endif
	
	
	.global	PutBit
	.thumb_func
	.ifdef	BITBANDING
	
// R0 = BOOL value, R1 = uint16_t *bits, R2 = uint32_t row, R3 = uint32_t col
	
PutBit:	
	PUSH {R4}			
	SUB R12,R1,0x20000000		// R12 = base address
	LSL R12,R12,5				// Multiply by 32
	LDR R4,=4
	MUL R2,R2,R4				// Multiply row by R4
	ADD R2,R2,R3				// Add row by itself plus col
	ADD R12,R12,R2,LSL 2		// Add newaddress by itselft plus 4*R2
	ADD R12,R12,0x22000000		// Add R12 with 0x22000000 to form new full address
	CMP R0,0					// Check if zero
	ITE EQ						
	LDREQ R4,=0					// If posative
	LDRNE R4,=1					// If negative
	STRH R4,[R12]				// Stores bit
	POP {R4}
	BX LR


	.else
	
PutBit:
	PUSH {R4,R5}				
	LDR R12,=4
	LDR R4,=1
	LDRH R5,[R1]				//Load bit address
	MUL R2,R2,R12				// Multiply row by 4
	ADD R2,R2,R3				// Add rows by col
	LSL R4,R4,R2				// Shift (1<<R2)
	CMP R0,0					// Check if zero
	ITE EQ
	BICEQ R5,R5,R4				// Clear bits if zero
	ORRNE R5,R5,R4				// OR bits if nonzero
	STRH R5,[R1]				// Store bit 
	POP {R4,R5}
	BX LR


	.endif
	.end
	