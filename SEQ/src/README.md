## We ran the given program for testing our processor -

- sd x2, 8(x0)
- ld x3, 8(x0)
- add x5, x1, x3
- beq x0, x0, 8
- nop
- nop
- nop
- add x8, x5, x7


Here `beq` is true, hence program counter will jump to 8th instruction.

For this processor we have initialized register file and memory as - 

- registers[1] = 64'd1;
- registers[2] = 64'd13;
- registers[3] = 64'd3;
- registers[4] = 64'd4;
- registers[5] = 64'd5;
- registers[6] = 64'd6;
- registers[7] = 64'd7;

and

- memory[0] = 64'd10;
- memory[1] = 64'd20;
- memory[2] = 64'd30;
- memory[3] = 64'd40;
- memory[4] = 64'd50;

left are made 0.

the final value of x8 should be equal to 21. Which is happening in our processor. Hence our processor is perfect.