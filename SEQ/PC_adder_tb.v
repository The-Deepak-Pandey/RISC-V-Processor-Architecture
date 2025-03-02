`timescale 1ns / 1ps
`include "PC_adder.v"

module PC_adder_tb;
    // Inputs
    reg clk, reset;
    reg ALU_zero;
    reg branch;
    reg [63:0] imm_gen_out;
    reg [31:0] pc_in;

    // Output
    wire [31:0] pc_out;

    // Instantiate the PC Adder module
    PC_adder uut (
        .clk(clk),
        .reset(reset),
        .ALU_zero(ALU_zero),
        .imm_gen_out(imm_gen_out),
        .branch(branch),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        ALU_zero = 0;
        branch = 0;
        imm_gen_out = 0;
        pc_in = 32'h00000000;

        // Monitor changes
        $monitor("Time: %0t | pc_in: %h | pc_out: %h | branch: %b | ALU_zero: %b | imm_gen_out: %h", 
                 $time, pc_in, pc_out, branch, ALU_zero, imm_gen_out);

        #10 reset = 0;  // Release reset

        // Test 1: Normal PC increment
        #10 pc_in = 32'h00000004; branch = 0; ALU_zero = 0;
        
        // Test 2: Branch taken (ALU_zero = 1, branch = 1, imm_gen_out = 8)
        #10 branch = 1; ALU_zero = 1; imm_gen_out = 64'h8;

        // Test 3: Branch not taken (ALU_zero = 0)
        #10 branch = 1; ALU_zero = 0; imm_gen_out = 64'h10;

        // Test 4: Another PC increment (without branching)
        #10 branch = 0; ALU_zero = 0; pc_in = 32'h00000010;

        // Test 5: Reset
        #10 reset = 1;
        #10 reset = 0;

        #20 $finish;
    end
endmodule