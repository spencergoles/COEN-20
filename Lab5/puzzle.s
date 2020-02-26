// Spencer Goles
// puzzle.s
// Febuary 12, 2020

	.syntax	unified
	.cpu	cortex-m4
	.text
	
	.global	CopyCell
	.thumb_func
// R0 = uint32_t *dst  R1 = uint32_t *src)
CopyCell:	
			PUSH {R4}
			LDR R2,=0				// R2 = row		
outLoop:	LDR R4,=0				// R4 = col
			CMP R2,60	 			// Compare row count to 60
			BHS DONE     			// If rows higher or same as 60 goto DONE
inLoop:		CMP R4,60    			// Compare col count to 60
			BHS inDone   			// If col higher or same as 60 goto DONE
			LDR R3,[R1,R4,LSL 2]  	// Move down to 
			STR R3,[R0,R4,LSL 2]    // next row by +=240 to dst and src
			ADD R4,R4,1    			// Add col count +1
			B inLoop				// Repeat until col greater than 60
inDone:		ADD R2,R2,1				// Add +1 to row count
			ADD R0,R0,960			// Add 240 to dst with x4
			ADD R1,R1,960			// Add 240 to src with x4
			B outLoop				// Goto outLoop
DONE:		POP {R4}
			BX	LR
			
	.global	FillCell
	.thumb_func
	
FillCell:	 
			LDR R2,=0				// R2 = row
oLoop:		LDR R3,=0 				// R3 = col		
			CMP R2,60				// Compare row count to 60
			BHS fDONE
iLoop:		CMP R3,60				// Compare row count to 60
			BHS iDone
			STR R1,[R0,R3,LSL 2]
			ADD R3,R3,1				// Add +1 to col
			B iLoop
iDone:		ADD R2,R2,1             // Add +1 to row
			ADD R0,R0,960			// Add 240 to dst with x4
			B oLoop
fDONE: 		BX	LR
.end 