// Spencer Goles
// change.s
// Febuary 26, 2020

	.syntax	unified
	.cpu	cortex-m4
	.text
	
	.global	Bills
	.thumb_func

Bills:
	// $20
	LDR R2,=214748365   	// R2 <-- 2^32/20
	SMMUL R3,R0,R2			
	STR R3,[R1]				// BILLS[twenties] <-- R2
	LSL R2,R3,4				// R2 <-- count * 16
	ADD R2,R2,R3,LSL 2      // R2 <-- 20 * count
	SUB R0,R0,R2			// R0 <-- Remainder

TenFiveOne:
	// $10 or Dime
	LDR R2,=429496730		// R2 <-- 2^32/10
	SMMUL R3,R0,R2
	STR R3,[R1,4]			// BILLS[tens] <-- R2
	LSL R2,R3,3				// R2 <-- count * 8
	ADD R2,R2,R3,LSL 1		// R2 <-- 10 * count
	SUB R0,R0,R2			// R0 <-- Remainder
	
	// $5 or Nickel			// R2 <-- 2^32/5
	LDR R2,=858993459
	SMMUL R3,R0,R2
	STR R3,[R1,8]			// BILLS[fives] <-- R2
	LSL R2,R3,2				// R2 <-- count * 4
	ADD R2,R2,R3,LSL 0		// R2 <-- 5 * count
	SUB R0,R0,R2			// R0 <-- Remainder
	
	// $1 or Penny
	STR R0,[R1,12]			// BILLS[ones] <-- R2
	
	BX LR
	
	
	.global	Coins
	.thumb_func
Coins:
	// Quarter
	LDR R2,=171798692		// R2 <-- 2^32/25
	SMMUL R3,R0,R2
	STR R3,[R1]				// BILLS[quarters] <-- R2
	LSL R2,R3,4				// R2 <-- count * 16
	ADD R2,R2,R3,LSL 3		// R2 <-- 24 * count
	ADD R2,R2,R3,LSL 0		// R2 <-- 25 * count
	SUB R0,R0,R2			// R0 <-- Remainder
	
	B TenFiveOne
	
	.end
	
	