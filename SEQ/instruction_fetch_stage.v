`include "instruction_memory.v"

module instruction_fetch_stage(
    input wire clk, 
    input wire rst,
    input wire branch,
    input wire [63:0] branch_offset,
    output wire [31:0] pc,
    output wire [31:0] instruction
);


    // instruction mem
    instruction_memory imem(
        .pc(pc),
        .instruction(instruction)
    )

endmodule