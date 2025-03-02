`timescale 1ns / 1ps

module alu_control_tb;
    // Inputs
    reg [1:0] alu_op;
    reg [2:0] funct3;
    reg funct7b5;

    // Output
    wire [3:0] alu_ctrl;

    // Instantiate the ALU Control module
    alu_control uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .alu_ctrl(alu_ctrl)
    );

    // Test procedure
    initial begin
        $monitor("ALUOp = %b, Funct3 = %b, Funct7b5 = %b --> ALU Ctrl = %b", alu_op, funct3, funct7b5, alu_ctrl);

        // Test cases based on the modified table
        alu_op = 2'b00; funct3 = 3'bXXX; funct7b5 = 1'bX; #10; // 0010
        alu_op = 2'b01; funct3 = 3'bXXX; funct7b5 = 1'bX; #10; // 0110
        alu_op = 2'b10; funct3 = 3'b000; funct7b5 = 1'b0; #10; // 0010
        alu_op = 2'b10; funct3 = 3'b000; funct7b5 = 1'b1; #10; // 0110
        alu_op = 2'b10; funct3 = 3'b000; funct7b5 = 1'b0; #10; // 0000
        alu_op = 2'b10; funct3 = 3'b110; funct7b5 = 1'b0; #10; // 0001
        
        $finish;
    end
endmodule
