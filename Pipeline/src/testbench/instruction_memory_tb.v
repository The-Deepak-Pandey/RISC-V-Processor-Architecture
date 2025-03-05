`timescale 1ns / 1ps
`include "instruction_memory.v"

module instruction_memory_tb;
    // Inputs
    reg [31:0] pc;

    // Outputs
    wire [31:0] instruction;

    // Instantiate the Instruction Memory module
    instruction_memory uut (
        .pc(pc),
        .instruction(instruction)
    );

    // Test procedure
    initial begin
        // Initialize PC
        pc = 32'h00000000;

        // Monitor changes
        $monitor("Time: %0t | PC: %b | Instruction: %b", $time, pc, instruction);

        // Test 1: Fetch instruction at PC = 0
        #10 pc = 32'h00000000;

        // Test 2: Fetch instruction at PC = 4
        #10 pc = 32'h00000004;

        // Test 3: Fetch instruction at PC = 8
        #10 pc = 32'h00000008;

        // Test 4: Fetch instruction at PC = 12
        #10 pc = 32'h0000000C;

        // Test 5: Fetch instruction at PC = 16
        #10 pc = 32'h00000010;

        // Test 6: Fetch instruction at PC = 20
        #10 pc = 32'h00000014;

        // Test 7: Fetch instruction at PC = 24
        #10 pc = 32'h00000018;

        // Test 8: Fetch instruction at PC = 28
        #10 pc = 32'h0000001C;

        // Test 9: Fetch instruction at PC = 32
        #10 pc = 32'h00000020;

        // Additional cycles to observe behavior
        #10 pc = 32'h00000024;
        #10 pc = 32'h00000028;
        #10 pc = 32'h0000002C;

        #20 $finish;
    end
endmodule