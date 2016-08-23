.pos 0x0
start:
			ld $sb, r5         # address of stack pointer
			inca r5            # stack pointer to the bottom
			gpc $6, r6         # set return pc
			j main             # call function copy
			halt
.pos 0x300
main:		deca r5            
			st (r6),r5         # store return address
			gpc $6, r6         # set return pc
			j copy             # jump to function copy
			ld r5, (r6)        
			inca r5            # deallocate ra
			j (r6)             # return

copy:       
			deca r5            # allocate ra
			st (r6), r5        # store return address
			deca r5
			deca r5            # allocate dst[2]
			ld $0, r0          # r0(i) = 0
			ld $src, r1        # r1 = &src
loop:       
			ld (r1,r0,4),r2    # r2 = src[i]
			beq r2, end_loop   # go to end_loop if src[i]==0
			st r2, (r5,r0,4)   # dst[i] = src[i]
			inc r0             # i++
			br loop            # goto start of the loop
end_loop:
			ld $0, r2          # r2 = 0
			st r2, (r5,r0,4)   # des[i] = 0
			inca r5
			inca r5            # deallocate
			ld (r5), r6        # set return address
			inca r5
			j (r6)             # return to function main

.pos 0x1000
src:        .long 0x1
			.long 0x0
			.long 0x703f       # redirect ra
			.long 0x0000ffff   # ld $0xffffffff,r0
			.long 0xffff6001   # ... move r0, r1
			.long 0x60026003   # move r0, r2; move r0, r3
			.long 0x60046005   # move r0, r4; move r0, r5
			.long 0x60066007   # move r0, r6; move r0, r7
            .long 0xf000       # halt
            .long 0
.pos 0x7000
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
