// `include "instruction_fetch_stage.v"

module ifid_reg(
    input wire [63:0] pc,
    input wire clk,
    input wire rst,
    input wire [31:0] instruction,
    input wire ifid_write,
    output reg [31:0] instruction_d,
    output reg [63:0] pc_d
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instruction_d <= 32'b0;
        end
        else if (ifid_write) begin
            instruction_d <= instruction;
            pc_d <= pc;
        end 
        else begin
                $display("stalling IF-ID register");
            end
        end

endmodule