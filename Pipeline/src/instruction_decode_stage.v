`include "control.v"
`include "register_file.v"
`include "immediate_gen.v"

module instruction_decode_stage(
    input wire clk,
    input wire rst,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [63:0] rd_data,
    input wire [31:0] instruction,
    input wire ctrl_hazard,
    input wire reg_write_d4,
    output wire [63:0] rs1_data,
    output wire [63:0] rs2_data,
    output wire  [63:0] immediate,
    output wire        branch,
    output wire        mem_read,
    output wire        mem_to_reg,
    output wire [1:0]  alu_op,
    output wire        mem_write,
    output wire        alu_src,
    output wire        reg_write
);

    control cnt(
        .ctrl_hazard(ctrl_hazard),
        .opcode(instruction[6:0]),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write)
    );

    register_file rf(
        .clk(clk),
        .rst(rst),
        .reg_write(reg_write_d4),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)     
    );

    immediate_gen imm_gen(
        .instruction(instruction),
        .immediate(immediate)
    );

endmodule