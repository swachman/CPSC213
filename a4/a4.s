.pos 0x1000
code:
ld $v, r0          #r0 = &v
ld $s, r1          #r1 = &s
ld $i, r2          #r2 = &i
ld (r2),r2         #r2 = i
ld (r1,r2,4),r3    #r3 = s.x[i]
st r3, (r0)        # v = s.x[i]   

ld 8(r1), r4       #r4 = s.y, which is a pointer
ld (r4,r2,4),r5    #r5 = s.y[i]
st r5,(r0)         # v = s.y[i]

ld 12(r1),r4       #r4 = s.z
ld (r5, r2, 4),r5  #r5 = s.z->x[i]
st r5,(r0)         # v = s.z->x[i]

halt


.pos 0x2000
static:
i: .long 0
v: .long 0
s: .long 0       # x[0]
   .long 0       # x[1]
   .long heap0   # y
   .long heap1   # z

.pos 0x3000
heap0:
	.long 0      # s.y[0]
	.long 0      # s.y[1]
heap1:
	.long 0      # s.z->x[0]
	.long 0      # s.z->x[1]
	.long 0      # s.z->y
	.long 0      # s.z->z