// Spencer Goles
// COEN 20 - Lab3.s
// January 29, 2020

	.syntax unified
	.cpu    cortex-m4
	.text

	.global UseLDRB
	.thumb_func
// Copy and store single unsigned byte
UseLDRB:	
	.rept 512   //512 / 1 byte = 512		
	LDRB R2,[R1],1  // Loading 1 byte from source
	STRB R2,[R0],1  // Storing 1 byte from loaded register
	.endr
	BX LR

	.global UseLDRH
	.thumb_func
// Copy and store two unsigned bytes
UseLDRH:
	.rept 256  //512 / 2 bytes = 256
	LDRH R2,[R1],2  // Loading 2 byte from source
	STRH R2,[R0],2  // Storing 2 byte from loaded register
	.endr
	BX LR

	.global UseLDR
	.thumb_func
// Copy and store four bytes
UseLDR:
	.rept 128  //512 / 4 bytes = 128
	LDR R2,[R1],4  // Loading 4 byte from source
	STR R2,[R0],4  // Storing 4 byte from loaded register
	.endr
	BX LR
				
	.global UseLDRD
	.thumb_func
// Copy and store eight bytes
UseLDRD:
	.rept 64  //512 / 8 bytes = 64
	LDRD R3,R2,[R1],8  // Loading 8 byte from source
	STRD R3,R2,[R0],8  // Storing 8 byte from loaded register
	.endr
	BX LR
				
	.global UseLDM
	.thumb_func
// Copy and store 32 bytes at a time
UseLDM:
	PUSH {R4-R9}  //Use these registers plus R2 and R3
  	.rept 16   //512 / 32 bytes = 16
	LDMIA R1!,{R2-R9}  // Loading 32 byte from source to 8 registers
	STMIA R0!,{R2-R9}  // Storing 32 byte from 8 loaded registers
	.endr
	POP {R4-R9}
	BX LR
	.end

        
		