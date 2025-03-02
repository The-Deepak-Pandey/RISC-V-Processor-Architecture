`include "alu_control.v"
`include "alu.v"

module execute_stage (
    input wire clk,
    input wire rst,
    input [1:0] alu_op,
    input [3:0] alu_ctrl,
    input wire alu_src,
    input [63:0] rd1,
    input [63:0] rd2,
    input [63:0] imm,
    input wire [2:0] funct3,
    input wire funct7b5, // bit [30] in R-type
    output wire [63:0] alu_result,
    output wire alu_zero
);

    wire [63:0] alu_in1;
    wire [63:0] alu_in2;

    assign alu_in1 = rd1;
    assign alu_in2 = (alu_src) ? imm : rd2;

    alu_control alu_ctrl_inst (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7b5(funct7b5),
        .alu_ctrl(alu_ctrl)
    );

    alu alu_inst (
        .in1(alu_in1),
        .in2(alu_in2),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_result),
        .alu_zero(alu_zero)
    );

endmodule