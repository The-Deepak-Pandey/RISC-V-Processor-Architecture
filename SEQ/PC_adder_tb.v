`timescale 1ns / 1ps
`include "PC_adder.v"

module PC_adder_tb;
    // Inputs
    reg clk, rst;
    reg ALU_zero;
    reg branch;
    reg [63:0] branch_offset;

    // Output
    wire [31:0] pc_out;

    // Instantiate the PC Adder module
    PC_adder uut (
        .clk(clk),
        .rst(rst),
        .ALU_zero(ALU_zero),
        .branch_offset(branch_offset),
        .branch(branch),
        .pc_out(pc_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        ALU_zero = 0;
        branch = 0;
        branch_offset = 0;

        // Release reset
        #10 rst = 0;

        // Test 1: Normal PC increment
        #10 branch = 0; ALU_zero = 0;
        
        // Test 2: Branch taken (ALU_zero = 1, branch = 1, branch_offset = 8)
        #10 branch = 1; ALU_zero = 1; branch_offset = 64'h8;

        // Test 3: Branch not taken (ALU_zero = 0)
        #10 branch = 1; ALU_zero = 0; branch_offset = 64'h10;

        // Test 4: Another PC increment (without branching)
        #10 branch = 0; ALU_zero = 0;

        // Additional Test 5: Branch taken with different immediate value
        #10 branch = 1; ALU_zero = 1; branch_offset = 64'h20;

        // Additional Test 6: Branch not taken with different immediate value
        #10 branch = 1; ALU_zero = 0; branch_offset = 64'h40;

        // Additional Test 7: Normal PC increment with different initial PC
        #10 rst = 1;
        #10 rst = 0;

        // Additional cycles to observe behavior
        #10 branch = 0; ALU_zero = 0;
        #10 branch = 0; ALU_zero = 0;

        #20 $finish;
    end

    // Monitor changes at each clock cycle
    always @(posedge clk) begin
        if (!rst) begin
            $display("Time: %0t | pc_out: %d | branch: %d | ALU_zero: %d | branch_offset: %d", 
                     $time, pc_out, branch, ALU_zero, branch_offset);
        end
    end
endmodule