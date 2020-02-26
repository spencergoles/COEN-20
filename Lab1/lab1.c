// Spencer Goles
// January 15, 2020
// COEN 20 Lab 1 Code 

#include <stdint.h>
#include <math.h>

// Convert array of bits to unsigned int 
// Using formula and binary power of 2 relationship in conversion
uint32_t Bits2Unsigned(int8_t bits[8]){
	int32_t num = 0;
	for(int i = 0; i < 8;i++){
		num = num + ((bits[i]) * pow(2,i));
	}
	return num;
}


// Convert array of bits to signed int. 
// Unchanged if under 128 or else subtract 256 constant to convert sign
int32_t Bits2Signed(int8_t bits[8]){
	int32_t num  = 0;
	if(bits[7]==0){
		num = (int32_t)Bits2Unsigned(bits);
	}
	else{
		num = (int32_t)Bits2Unsigned(bits) - 256;
	}
	return num;
} 


// Add 1 to value represented by bit pattern 
// Increment binary number until a zero
void Increment(int8_t bits[8]){
	for(int i = 0; i < 8; i++){
		if(bits[i]==0){
			bits[i] = 1;
			break;
		}
		else{
			bits[i] = 0;
		}	
	}
}

// Opposite of Bits2Unsigned. 
// Using repeated division and remainder to convert to binary number
void Unsigned2Bits(uint32_t n, int8_t bits[8]){
	int num = n;
	for(int i = 0; i < 8; i++){
		bits[i] = num%2;
		num/=2;
	}
}
