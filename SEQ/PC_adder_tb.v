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

        // Release reset
        #10 reset = 0;

        // Test 1: Normal PC increment
        #10 branch = 0; ALU_zero = 0;
        
        // Test 2: Branch taken (ALU_zero = 1, branch = 1, imm_gen_out = 8)
        #10 branch = 1; ALU_zero = 1; imm_gen_out = 64'h8;

        // Test 3: Branch not taken (ALU_zero = 0)
        #10 branch = 1; ALU_zero = 0; imm_gen_out = 64'h10;

        // Test 4: Another PC increment (without branching)
        #10 branch = 0; ALU_zero = 0;

        // Additional Test 5: Branch taken with different immediate value
        #10 branch = 1; ALU_zero = 1; imm_gen_out = 64'h20;

        // Additional Test 6: Branch not taken with different immediate value
        #10 branch = 1; ALU_zero = 0; imm_gen_out = 64'h40;

        // Additional Test 7: Normal PC increment with different initial PC
        #10 pc_in = 32'h00000010; branch = 0; ALU_zero = 0;

        // Test 8: Reset
        #10 reset = 1;
        #10 reset = 0; pc_in = 32'h00000000;

        // Additional cycles to observe behavior
        #10 branch = 0; ALU_zero = 0;
        #10 branch = 0; ALU_zero = 0;

        #20 $finish;
    end

    // Monitor changes at each clock cycle
    always @(posedge clk) begin
        if (!reset) begin
            $display("Time: %0t | pc_in: %d | pc_out: %d | branch: %d | ALU_zero: %d | imm_gen_out: %d", 
                     $time, pc_in, pc_out, branch, ALU_zero, imm_gen_out);
        end
    end
    always @(pc_out) begin
            pc_in <= pc_out;
    end
endmodule
