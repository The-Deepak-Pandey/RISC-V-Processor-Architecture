## We ran the given program for testing our processor -

1. `sd x2, 8(x0)`
2. `ld x3, 8(x0)`
3. `add x5, x1, x3`
4. `beq x0, x1, 8`
5. `beq x0, x0, 8`
6. `nop`
7. `nop`
8. `nop`
9. `add x8, x5, x7`

(rest instructions are no operation instruction)

Here `beq` is true, hence program counter will jump to 8th instruction.

For this processor we have initialized register file and memory as - 

- registers[1] = 1;
- registers[2] = 13;
- registers[3] = 3;
- registers[4] = 4;
- registers[5] = 5;
- registers[6] = 6;
- registers[7] = 7;

and

- memory[0] = 10;
- memory[1] = 20;
- memory[2] = 30;
- memory[3] = 40;
- memory[4] = 50;

left are made 0.

the final value of x8 should be equal to 21. Which is happening in our processor. Hence our processor is perfect.