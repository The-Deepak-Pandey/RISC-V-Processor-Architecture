module mem_wb_reg (
    input wire clk,
    input wire rst,
    input wire mem_to_reg,
    input wire reg_write,
    input wire [63:0] read_data,
    input wire [63:0] alu_result_d3,
    input wire [4:0] rd_d3,

    output reg mem_to_reg_d4,
    output reg reg_write_d4,
    output reg [63:0] read_data_d4,
    output reg [63:0] alu_result_d4,
    output reg [4:0] rd_d4
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mem_to_reg_d4 <= 1'b0;
            reg_write_d4 <= 1'b0;
            read_data_d4 <= 64'b0;
            alu_result_d4 <= 64'b0;
            rd_d4 <= 5'b0;
        end else begin
            mem_to_reg_d4 <= mem_to_reg;
            reg_write_d4 <= reg_write;
            read_data_d4 <= read_data;
            alu_result_d4 <= alu_result_d3;
            rd_d4 <= rd_d3;
        end
    end

endmodule