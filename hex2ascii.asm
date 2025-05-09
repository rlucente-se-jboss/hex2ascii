; hex2ascii
;
; This converts the hexadecimal byte in accumulator A into its ASCII
; representation, e.g. A=$bd to the two ASCII characters 'B' and
; 'D'. See https://github.com/rlucente-se-jboss/hex2ascii for a full
; explanation of how the conversion works.
;
; Input:
; A = byte to convert to ASCII
; X = location to store ASCII characters
;
; Output:
; A smashed
; (X) is first ASCII character
; (X+1) is second ASCII character
; X = X+2

hex2ascii       pshs    a       ; save to process lower nibble later
                lsra            ; shift upper nibble down
                lsra
                lsra
                lsra
                bsr     hexconv ; convert upper nibble to ASCII and store it
                puls    a       ; recover original byte
                anda    #$0f    ; isolate lower nibble
hexconv         adda    #$90    ; very cleverly convert to ASCII
                daa
                adca    #$40
                daa
                ora     #$40    ; CoCo VDG adjustment for characters 0 - 9
                sta     ,x+     ; save result
                rts
