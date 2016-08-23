.pos 0x100
# test br
    ld $0x0,r0       # r0 = 0
    br continue      # go continue
    halt             # if failed, stop
continue: ld $0x2,r0 # if correct, r0 = 2

# test beq
    ld $0x0,r1       # r1 = 0
    beq r1, then     # goto then if r1==0
    halt
then: ld $0x1,r1     # r1 = 1

# test bgt
    bgt r1           # if r1>0, then go to jump
    halt
jump: ld $0x8,r2     # r2 = 8

# test j
    j 0x300          # jump to address 0x300
    halt


.pos 0x300
# test gpc
    gpc $6,r6        # pc=pc+6

# test j o(rt)
    j 4(r6)          # pc = pc + 4

    halt

