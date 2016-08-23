.pos 0x0
                 ld   $0x1028, r5              #r5 = 0x1028
                 ld   $0xfffffff4, r0          #r0 = -12
                 add  r0, r5                   #set up stack r5-=12
                 ld   $0x200, r0               #r0 = 0x200
                 ld   0x0(r0), r0              #r0 = x
                 st   r0, 0x0(r5)              #a0 = x
                 ld   $0x204, r0               #r0 = 0x204
                 ld   0x0(r0), r0              #r0 = y
                 st   r0, 0x4(r5)              #a1 = y
                 ld   $0x208, r0               #r0 = 0x208
                 ld   0x0(r0), r0              #r0 = z
                 st   r0, 0x8(r5)              #a2 = z
                 gpc  $6, r6                   #set return address
                 j    0x300                    #goto 0x300
                 ld   $0x20c, r1               #r1 = 0x20c
                 st   r0, 0x0(r1)              #t  = return of 0x300
                 halt                     
.pos 0x200
                 .long 0x00000000              #x     
                 .long 0x00000000              #y
                 .long 0x00000000              #z
                 .long 0x00000000              #t
.pos 0x300
                 ld   0x0(r5), r0              #r0 = a0 = x
                 ld   0x4(r5), r1              #r1 = a1 = y
                 ld   0x8(r5), r2              #r2 = a2 = z
                 ld   $0xfffffff6, r3          #r3 = -10
                 add  r3, r0                   #r0 = x-10
                 mov  r0, r3                   #r3 = r0 = x-10
                 not  r3                       #r3 = ~ (x-10)
                 inc  r3                       #r3 = - (x-10)
                 bgt  r3, L6                   #goto L6, if x<10
                 mov  r0, r3                   #r3 = x-10
                 ld   $0xfffffff8, r4          #r4 = -8
                 add  r4, r3                   #r3 = x-18
                 bgt  r3, L6                   #goto L6, if x>18
                 ld   $0x400, r3               #r3 = 0x400
                 j    *(r3, r0, 4)             #goto (0x400 + x-10)
.pos 0x330
case_10          add  r1, r2                   #r2 = y+z
                 br   L7                       #branch to L7 (done)
case_12          not  r2                       #r2 = ~z
                 inc  r2                       #r2 = -z
                 add  r1, r2                   #r2 = y-z
                 br   L7                       # done
case_14          not  r2                       #r2 = ~z
                 inc  r2                       #r2 = -z
                 add  r1, r2                   #r2 = y-z
                 bgt  r2, L0                   #gotoL0, if y>z
                 ld   $0x0, r2                 #r2 = 0
                 br   L1                       #branch L1
L0:              ld   $0x1, r2                 #r2 = 1
L1:              br   L7                       #done
case_16          not  r1                       #r1 = ~y
                 inc  r1                       #r1 = -y
                 add  r2, r1                   #r1 = z-y
                 bgt  r1, L2                   #gotoL2,if z>y
                 ld   $0x0, r2                 #r2 = 0
                 br   L3                       #branch L3
L2:              ld   $0x1, r2                 #r2 = 1
L3:              br   L7                       #done
case_18:         not  r2                       #r2 = ~z
                 inc  r2                       #r2 = -z
                 add  r1, r2                   #r2 = y-z
                 beq  r2, L4                   #gotoL4,if y==z
                 ld   $0x0, r2                 #r2 = 0
                 br   L5                       #branch L5
L4:              ld   $0x1, r2                 #r2 = 1
L5:              br   L7                       #doone
L6:              ld   $0x0, r2                 #r2 = 0
                 br   L7                       #done
L7:              mov  r2, r0                   #r0 = r2
                 j    0x0(r6)                  #return
.pos 0x400
                 .long 0x00000330              #case 10
                 .long 0x00000384              #case 11    -> L6
                 .long 0x00000334              #case 12
                 .long 0x00000384              #case 13    -> L6
                 .long 0x0000033c              #case 14
                 .long 0x00000384              #case 15    -> L6
                 .long 0x00000354              #case 16
                 .long 0x00000384              #case 17    -> l6
                 .long 0x0000036c              #case 18
.pos 0x1000
                 .long 0x00000000              #STACK
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000              #stack bot
