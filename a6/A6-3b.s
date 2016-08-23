.pos 0x100
start:
    ld $sb, r5             # address to stack pointer
    inca    r5             # stack pointer to the bottom
    gpc $6, r6             # set return address
    j main                 # call function main
    halt

f:
    deca r5               # decrease stack pointer／allocate stack frame
    ld $0, r0             # r0 = temp_j = 0
    ld 4(r5), r1          # r1 = temp_i
    ld $0x80000000, r2    # r2 = 0x80000000
f_loop:
    beq r1, f_end         # if temp_i == 0 , then goto f_end(end the loop)
    mov r1, r3            # r3 = temp_i
    and r2, r3            # r3 = temp_i & 0x80000000
    beq r3, f_if1         # if !(temp_i & 0x80000000), goto f_if1 (into if statement)
    inc r0                # r0 = temp_j++;
f_if1:
    shl $1, r1            # temp_i = temp_i*2
    br f_loop             # branch to f_loop
f_end:
    inca r5               # deallocate stack pointer for f
    j(r6)                 # return to main_loop, and continue

main:
    deca r5               # allocate frame in the stack/ increase stack pointer 4 byte
    deca r5               # increase stack pointer 4 byte
    st r6, 4(r5)          # store return address into stack
    ld $8, r4             # r4 = 8
main_loop:
    beq r4, main_end      # if r4 == 0, goto main_end
    dec r4                # r4 --;
    ld $x, r0             # r0 = &x;
    ld (r0,r4,4), r0      # r0 = x[temp_i]
    deca r5               # decrease stack pointer for parameter
    st r0, (r5)           # store parameter x[i] into stack
    gpc $6, r6            # set return address
    j f                   # jump to function f
    inca r5               # deallocate parameter
    ld $y, r1             # r1 = &y
    st r0, (r1,r4,4)      # y[temp_i]=f(x[temp_i])
    br main_loop          # brance to main_loop
main_end:
    ld 4(r5), r6          # set return address
    inca r5               # increase stack pointer
    inca r5               # deallocate stack frame
    j (r6)                # return

.pos 0x2000
x:
    .long 1               # x[0]
    .long 2               # x[1]
    .long 3               # x[2]
    .long 0xffffffff      # x[3]
    .long 0xfffffffe      # x[4]
    .long 0               # x[5]
    .long 184             # x[6]
    .long 340057058       # x[7]

y:
    .long 0               # y[0]
    .long 0               # y[1]
    .long 0               # y[2]
    .long 0               # y[3]
    .long 0               # y[4]
    .long 0               # y[5]
    .long 0               # y[6]
    .long 0               # y[7]

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
sb: .long 00000000

