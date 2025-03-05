`include "PC_adder.v"
`include "instruction_memory.v"

module instruction_fetch_stage(
    input wire clk, 
    input wire rst,
    input wire PCSrc,
    input wire PC_write,
    input wire [63:0] pc_branch,
    output wire [63:0] pc,
    output wire [31:0] instruction
);

    // program counter adding
    PC_adder pcadding(
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .pc_branch(pc_branch),
        .PC_write(PC_write),
        .pc_out(pc)
    );

    // instruction mem
    instruction_memory imem(
        .pc(pc),    
        .instruction(instruction)
    );

endmodule