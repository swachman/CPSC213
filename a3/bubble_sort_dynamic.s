.pos 0x100
ld $i,r0         #r0 = &i
ld 0(r0),r0      #r0 = i
ld $j,r1         #r1 = &j
ld 0(r1),r1      #r1 = j
ld $val, r2      #r2 = &val
ld 0(r2),r2      #r2 = val

ld (r2,r0,4),r3  #r3 = val[i]
ld (r2,r1,4),r4  #r4 = val[j]

st (r2,r1,4),r3  #val[i] = val[j]
st (r2,r0,4),r4  #val[j] = val[i]

halt
.pos 0x200
i:   .long 0
j:   .long 3
val: .long data

.pos 0x300
data: .long 1
	  .long 2
	  .long 3
	  .long 4