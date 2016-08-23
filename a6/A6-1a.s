.pos 0x1000
# load variables
	 ld $0,  r0              #r0 = i ＝ 0
	 ld $a,  r1              #r1 = &a
	 ld $s,  r2              #r2 = &s
	 ld (r2),r2              #r2 = s
#for loop
	 ld $-5, r4              #r4 ＝ 5
loop:mov r0,r5               #r5 = temp_i =0
	 add r4,r5               #r5 = temp_i-5 
	 beq r5, end_loop        # goto end_loop if temp_i=5

	 # if loop
	 ld (r1,r0,4),r3         #r3 ＝ a[temp_i]
	 bgt r3, then            # if a[i] > 0, goto then
     br else                # do nothing, go back to strat of the loop
then:add r3, r2              # temp_s += a[temp_i]
else:inc r0                  # temp_i++
	 br loop                 # go back to strat of the loop
end_loop: ld $s, r1          # r1 = &s
		  st r2, 0x0(r1)     # s = temp_s
		  ld $i, r1          # r1 = &i
		  st r0, 0x0(r1)     # i = temp_i
		  halt
.pos 0x2000
i: 	.long 10
a: 	.long 10
	.long -38
	.long -12
	.long 4
	.long 8
s:  .long 0