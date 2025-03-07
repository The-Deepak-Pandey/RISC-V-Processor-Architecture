`include "alu_control.v"
`include "alu.v"

module execute_stage (
    input wire [63:0] pc,
    input wire [1:0] alu_op,
    input wire alu_src,
    input wire [63:0] rs1_data,
    input wire [63:0] rs2_data,
    input wire [63:0] imm,
    input wire [2:0] funct3,
    input wire funct7b5, // bit [30] in R-type
    output wire [63:0] alu_result,
    output wire [3:0] alu_ctrl,
    output wire alu_zero,
    output reg [63:0] pc_branch
);

    wire [63:0] alu_in1;
    wire [63:0] alu_in2;

    assign alu_in1 = rs1_data;
    assign alu_in2 = (alu_src) ? imm : rs2_data;

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

    always @(*) begin
        pc_branch = pc + (imm << 1);
        $display("pc_branch is now %d", pc_branch);
    end

endmodule