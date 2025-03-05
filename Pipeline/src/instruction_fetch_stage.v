`include "PC_adder.v"
`include "instruction_memory.v"

module instruction_fetch_stage(
    input wire clk, 
    input wire rst,
    input wire ALU_zero,
    input wire branch,
    input wire PC_write,
    input wire [63:0] branch_offset,
    output wire [31:0] pc,
    output wire [31:0] instruction
);

    // program counter adding
    PC_adder pcadding(
        .clk(clk),
        .rst(rst),
        .ALU_zero(ALU_zero),
        .branch_offset(branch_offset),
        .branch(branch),
        .PC_write(PC_write),
        .pc_out(pc)
    );

    // instruction mem
    instruction_memory imem(
        .pc(pc),    
        .instruction(instruction)
    );

endmodule