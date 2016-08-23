ldi: ld $0x01234567, r0  #test load immediate
	 ld $0x00000001, r1   #0xfffffffe
	 
	 ld $0x00000002, r2   #0xffff00ff
	 ld $0x00000003, r3   #0x0123456d
	 
	 ld $0xffff00ff, r4   #0xffff0100
     ld $0x00001000, r5   
     
     ld $0x00002000, r6
     ld $0x00003000, r7

    # test ALU instruction
    rrmove: mov r0, r2      #move the value in r0 to r1, r2 will be 0x01234567
    		 mov r4, r2      # r2 will be 0xffff00ff
   	
   	add:     add r3, r3      # r3+r3 should be 6, r3 is 0x6 right now
   		     add r1, r3      # r1 +r3 should be 0x7, so r3 is 0x07
   	
	and:     and r4, r0      # r4&r0 should be 0x01230067, r0 is 0x01230067
		     and r0, r3      # r3 is 0x7

	inc:     inc r0         # r0 is 0x01230068
	         inc r4         # r4 is 0xffff0100

	incr:    inca r0        # r0 is 0x0123006c

	dec:     dec r0         # r0 is 0x0123006b

	decr:    deca r0        # r0 is 0x01200567

	not:     not r1         # r1 is 0xfffffffe
	         not r4         # r4 is 0x0000feff

	shift:   shl $0x00000004, r1  #r1 is 0xffffffe0
			 shr $0x00000004, r1  #r1 is 0xffffffff

	nop                     # do nothing

	# Test Memory-Access Instructions
	ldbase: ld 0(r5), r0    # r0 is 0x0
			ld 4(r5), r0    # r0 is 0x00ffffff

	ld $0x00000001, r1      # reset r1 to 1
	ldindexed: ld(r5,r1,4), r2

	stbase: st r1, 0(r6)

	stindexed: st r6, (r5, r1, 4)



	halt                    # Program stop

.pos 0x1000
	 .long 0x00000000
	 .long 0x00ffffff
	 .long 0x00000001
	 .long 0x0000a0be
	 .long 0x00000003
.pos 0x2000
	 .long 0x0
	 .long 0x0
	 .long 0x0