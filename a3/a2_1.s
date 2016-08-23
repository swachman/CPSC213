.pos 0x100
# c = 5
	ld $c, r0           #r0 = address of c
	ld 0(r0), r0        #r0 = value of c
	ld $5, r1           #r1 = 5
	st r1, r0           #c  = 5

# b = c + 10
	ld $10, r1          #r1 = 10
	add r0, r1          #r1 = r1 + r0 = c +10
	ld $b, r2           #r2 = address of b
	st r1, 0(r2)         #b  = c + 10

# a[8] = 8
	ld $a, r1           #r1 = address of a
	ld $8, r3           #r3 = 8
	st r3, (r1, r3, 4)  # a[8] = 8

# a[4] = a[4] + 4
	ld $4, r3           #r3 = 4
	ld (r1,r3,4),r3     #r3 = a[4]
	mov r3, r4          #r4 = a[4]
	inca r4             #r4 = a[4] + 4
	st r4, r3           #a[4] = a[4] + 4

# a[c] = a[8] + b + a[b & 0x7]
	#a[8]
	ld $8, r3           #r3 = 8
	ld (r1,r3,4),r3     #r3 = a[8]

	#a[b& 0x7]
	ld $0x7, r4         #r4 = 0x7
	ld 0(r2), r2        #r2 = value of b
	mov r2, r5          #r5 = value of b
	and r4, r5          #r5 = b & 0x7
	ld (r1,r5,4), r5    #r5 = a[b&0x7]

	#a[8] + b + a[a & 0x7]
	add r3, r2          #r2 = a[8] + b
	add r5, r2          #r2 = a[8] + b + a[b&0x7]
	ld (r1,r0,4), r0    #r0 = a[c]
	st r2, r0           #a[c] = a[8] + b + a[b&0x7]

	halt

.pos 0x200
# DARA AREA
b:	.long 0             #b
c:  .long 0             #c
a:  .long 0             #a[0]
	.long 0				#a[1]
	.long 0				#a[2]
	.long 0				#a[3]
	.long 0				#a[4]
	.long 0				#a[5]
	.long 0				#a[6]
	.long 0				#a[7]
	.long 0				#a[8]
	.long 0				#a[9]
