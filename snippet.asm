    adda  #$90  ; add $90 to the current accumulator value
    daa         ; adjust result to be correct BCD
    adca  #$40  ; add $40 plus previous carry from DAA
    daa         ; adjust result to be correct BCD
