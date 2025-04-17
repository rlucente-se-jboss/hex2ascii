; hex2ascii
;
; This converts the hexadecimal byte in accumulator A into its ASCII
; representation, e.g. A=0xbd to the two ASCII characters 'B' and
; 'D'. See https://github.com/rlucente-se-jboss/hex2ascii for a
; full explanation of how the conversion works.
;
; Input:
; A = byte to convert to ASCII
; X = location to store ASCII characters
;
; Output:
; A,B smashed
; (X) is first ASCII character
; (X+1) is second ASCII character
; X = X+2

hex2ascii	tfr	a,b	; save to process lower nibble later
		anda	#$f0	; isolate upper nibble and shift it down
		lsra
		lsra
		lsra
		lsra
		bsr	hexconv	; convert upper nibble to ASCII and store it
		tfr	b,a	; recover original byte
		anda	#$0f	; isolate lower nibble
hexconv		adda	#$90	; very cleverly convert to ASCII
		daa
		adca	#$40
		daa
		sta	,x+	; save result
		rts
