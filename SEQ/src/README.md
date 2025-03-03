## We ran the given program for testing our processor -

- sd x2, 8(x0)
- ld x3, 8(x0)
- add x5, x1, x3
- beq x0, x0, 8
- nop
- nop
- nop
- add x8, x5, x7


Here `beq` is true, hence program counter will jump to 8th instruction