.pos 0x0
                 ld   $sb, r5               # address to stack pointer
                 inca r5                    # stack pointer to the bottom
                 gpc  $6, r6                # set return address
                 j    0x300                 # call function fool
                 halt                       # end
.pos 0x100
z:               .long 0x00001000           # int* z = data
.pos 0x200
add:             ld   0x0(r5), r0           # r0 = x
                 ld   0x4(r5), r1           # r1 = y
                 ld   $0x100, r2            # load the address of z into r2
                 ld   0x0(r2), r2           # r2 = z[0]
                 ld   (r2, r1, 4), r3       # r3 = z[y]
                 add  r3, r0                # r0 = x + z[y]
                 st   r0, (r2, r1, 4)   #??  # v[y] = x + z[y]
                 j    0x0(r6)               # return to function fool, and continue
.pos 0x300
fool:            ld   $0xfffffff4, r0       # r0 = -12
                 add  r0, r5                # allocate frame in the stack
                 st   r6, 0x8(r5)           # store return address on stack
                 ld   $0x1, r0              # r0 = 1
                 st   r0, 0x0(r5)           # store value of a0 in the stack
                 ld   $0x2, r0              # r0 = 2
                 st   r0, 0x4(r5)           # store value of a1 in the stack
                 ld   $0xfffffff8, r0       # r0 = -8
                 add  r0, r5                # parameter for function add
                 ld   $0x3, r0              # r0 = 3
                 st   r0, 0x0(r5)           # store value of x in the stack
                 ld   $0x4, r0              # r0 = 4
                 st   r0, 0x4(r5)           # store value of y in the stack
                 gpc  $6, r6                # set return address
                 j    0x200                 # call function add(3,4)
                 ld   $0x8, r0              # r0 = 8
                 add  r0, r5                # deallocate parameter
                 ld   0x0(r5), r1           # r1 = a0
                 ld   0x4(r5), r2           # r2 = a1
                 ld   $0xfffffff8, r0       # r0 = 8
                 add  r0, r5                # decrease stack pointer by 8
                 st   r1, 0x0(r5)           # store parameter a0
                 st   r2, 0x4(r5)           # store parameter a1
                 gpc  $6, r6                # set return address
                 j    0x200                 # call funtion add(a0,a1)
                 ld   $0x8, r0              # r0 = 8
                 add  r0, r5                # deallocate
                 ld   0x8(r5), r6           # set return address
                 ld   $0xc, r0              # r0 = 12
                 add  r0, r5                # deallocate frame on stack
                 j    0x0(r6)               # return
.pos 0x1000
data:            .long 0x00000000           # data[0]
                 .long 0x00000000           # data[1]
                 .long 0x00000000           # data[2]
                 .long 0x00000000           # data[3]
                 .long 0x00000000           # data[4]
                 .long 0x00000000           # data[5]
                 .long 0x00000000           # data[6]
                 .long 0x00000000           # data[7]
                 .long 0x00000000           # data[8]
                 .long 0x00000000           # data[9]
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
