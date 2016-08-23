.pos 0x100
# a[i] = a [i+1] + b [i+2]
	# i , i+1, i+2
	ld $i r0              #r0 = &i
	ld (r0),r0                           							#r0 = i
	mov r0, r1            #r1 = i
	inc r1                #r1 = i+1
	mov r1, r2            #r2 = i+1
	inc r2                #r2 = i+2

	# a[i+1] + b[i+2]
	ld $a, r3                             							#r3 =&a
	ld (r3,r1,4),r1       #r1 = a[i+1]
	ld $b, r4                             							#r4 = &b
	ld (r4,r2,4),r2       #r2 = b[i+2]
	add r1,r2             #r2 = a[i+1] + b[i+2]

	# a[i] = a[i+1] + b[i+2]
	ld (r3,r0,4),r5       #r5 = a[i]
	st r2, r5             #a[i] = a[i+1] + b[i+2]

# d[i] = a[i] + b[i]
	# a[i] + b[i]
	ld (r3,r0,4),r1      #r1 = a[i]
	ld (r4,r0,4),r2      #r2 = b[i]
	add r2,r1            #r1 = a[i] +b[i]

	#d[i]
	ld $d,r2             #r2 = &d
	ld (r2),r2                            							#r2 = d
	ld (r2,r0,4),r5      #r5 = d[i]
	st r1,r5             # d[i] = a[i] + b[i]

# d[i] = a[b[i]] + b[a[i]]
	ld (r4,r0,4),r1      #r1 = b[i]
	ld (r3,r1,4),r6      #r6 = a[b[i]]
	ld (r3,r0,4),r7      #r7 = a[i]
	ld (r4,r7,4),r8      #r8 = b[a[i]]
	add r8,r6            #r6 = a[b[i]] + b[a[i]]
	st r6,r5             #d[i] = a[b[i]] + b[a[i]]

 # d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]
 	#b[a[i & 3] & 3]
 	ld $3,r1             #r1=3
 	mov r1,r6            #r6=3
 	and r0,r6            #r6 = i&3
 	ld (r3,r6,4),r6      #r6 = a[i & 3]
 	and r1,r6            #r6 = a[i & 3] &3
 	ld(r4,r6,4),r6       #r6 = b[a[i &3] &3]

 	#a[b[i & 3] & 3]
 	mov r1,r7
 	and r0,r7             #r7 = i &3
 	ld (r4,r7,4),r7       #r7 = b[i&3]
 	and r7,r1             #r1 = b[i & 3] &3
 	ld (r3,r1,4),r1       #r1 = a[b[i & 3] & 3]

 	# - a[b[i & 3] & 3]
 	not r1                #r1 = ~a[b[i & 3] & 3]
 	inc r1                #r1 = ~a[b[i & 3] & 3] +1 = - a[b[i & 3] & 3]

 	add r6,r1             #r1 = b[a[i & 3] & 3] - a[b[i & 3] & 3]
 	add r5,r1             #r1 = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]

 	#d[b[i]]
 	ld (r4,r0,4),r5       #r5 = b[i]
 	ld (r2,r5,4),r5       #r5 = d[b[i]]
 	st r1,r5              #d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]


.pos 0x200
#DATA AREA
a: 	.long 0    #a[0]
	.long 11   #a[1]
	.long 2    #a[2]
	.long 0    #a[3]
	.long 1    #a[4]
	.long 2    #a[5]
	.long 0    #a[6]
	.long 1    #a[7]

b:  .long 2    #b[0]
	.long 12   #b[1]
	.long 0    #b[2]
	.long 2    #b[3]
	.long 1    #b[4]
	.long 0    #b[5]
	.long 2    #b[6]
	.long 1    #b[7]

c: 	.long 99   #c[0]
	.long 6    #c[1]
	.long 2    #c[2]
	.long 1    #c[3]
	.long 0    #c[4]
	.long 2    #c[5]
	.long 1    #c[6]
	.long 0    #c[7]

i:  .long 5    #i 

.pos 0x300
d:  .long c    #d