
module exmem_reg(
    input wire clk,
    input wire rst,
    input wire mem_to_reg,
    input wire reg_write,
    input wire branch,
    input wire mem_read,
    input wire mem_write,
    input wire [63:0] pc_branch,
    input wire [63:0] alu_result,
    input wire alu_zero,
    input wire [63:0] rs2_data,
    input wire [4:0] rd,

    output reg mem_to_reg_d3,
    output reg reg_write_d3,
    output reg branch_d3,
    output reg mem_read_d3,
    output reg mem_write_d3,
    output reg [63:0] pc_branch_d3,
    output reg [63:0] alu_result_d3,
    output reg alu_zero_d3,
    output reg [63:0] rs2_data_d3,
    output reg [4:0] rd_d3

);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        mem_to_reg_d3 <= 1'b0;
        reg_write_d3 <= 1'b0;
        branch_d3 <= 1'b0;
        mem_read_d3 <= 1'b0;
        mem_write_d3 <= 1'b0;
        pc_branch_d3 <= 64'b0;
        alu_result_d3 <= 64'b0;
        alu_zero_d3 <= 1'b0;
        rs2_data_d3 <= 64'b0;
        rd_d3 <= 5'b0;
    end
    else begin
        mem_to_reg_d3 <= mem_to_reg;
        reg_write_d3 <= reg_write;
        branch_d3 <= branch;
        mem_read_d3 <= mem_read;
        mem_write_d3 <= mem_write;
        pc_branch_d3 <= pc_branch;
        alu_result_d3 <= alu_result;
        alu_zero_d3 <= alu_zero;
        rs2_data_d3 <= rs2_data;
        rd_d3 <= rd;
    end
    
end



endmodule