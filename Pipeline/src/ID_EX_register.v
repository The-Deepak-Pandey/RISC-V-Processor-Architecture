// `include "instruction_fetch_stage.v"

module idex_reg(
    input wire [63:0] pc,
    input wire clk,
    input wire rst,
    input wire [63:0] rs1_data,
    input wire [63:0] rs2_data,
    input wire  [4:0] rs1,
    input wire  [4:0] rs2,
    input wire  [4:0] rd,
    input wire  [63:0] immediate,
    input wire        branch,
    input wire        mem_read,
    input wire        mem_to_reg,
    input wire [1:0]  alu_op,
    input wire        mem_write,
    input wire        alu_src,
    input wire        reg_write,
    input wire [2:0] func3,
    input wire func7b5,
    
    output reg [63:0] rs1_data_d2,
    output reg [63:0] rs2_data_d2,
    output reg  [4:0] rs1_d2,
    output reg  [4:0] rs2_d2,
    output reg  [4:0] rd_d2,
    output reg  [63:0] immediate_d2,
    output reg        branch_d2,
    output reg        mem_read_d2,
    output reg        mem_to_reg_d2,
    output reg [1:0]  alu_op_d2,
    output reg        mem_write_d2,
    output reg        alu_src_d2,
    output reg        reg_write_d2,
    output reg [2:0] func3_d2,
    output reg func7b5_d2,
    output reg [63:0] pc_d2

);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rs1_data_d2 <= 64'b0;
            rs2_data_d2 <= 64'b0;
            rs1_d2 <= 5'b0;
            rs2_d2 <= 5'b0;
            rd_d2 <= 5'b0;
            immediate_d2 <= 64'b0;
            branch_d2 <= 1'b0;
            mem_read_d2 <= 1'b0;
            mem_to_reg_d2 <= 1'b0;
            alu_op_d2 <= 2'b00;
            mem_write_d2 <= 1'b0;
            alu_src_d2 <= 1'b0;
            reg_write_d2 <= 1'b0;
            func3_d2 <= 3'b0;
            func7b5_d2 <= 1'b0;
        end
        else begin
            rs1_data_d2 <= rs1_data;
            rs2_data_d2 <= rs2_data;
            rs1_d2 <= rs1;
            rs2_d2 <= rs2;
            rd_d2 <= rd;
            immediate_d2 <= immediate;
            branch_d2 <= branch;
            mem_read_d2 <= mem_read;
            mem_to_reg_d2 <= mem_to_reg;
            alu_op_d2 <= alu_op;
            mem_write_d2 <= mem_write;
            alu_src_d2 <= alu_src;
            reg_write_d2 <= reg_write;
            func3_d2 <= func3;
            func7b5_d2 <= func7b5;
        end
    end

endmodule