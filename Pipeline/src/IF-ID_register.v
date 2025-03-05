`include "instruction_fetch_stage.v"

module ifid_reg(
    input wire clk,
    input wire rst,
    input wire [31:0] instruction,
    input wire ifid_write,
    output reg [31:0] instruction_d
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction_d <= 32'b0;
        end else if (ifid_write) begin
            instruction_d <= instruction;
        end
    end

endmodule