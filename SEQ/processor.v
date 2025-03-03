`include "instruction_fetch_stage.v"
`include "instruction_decode_stage.v"
`include "execute_stage.v"
`include "memory_access_stage.v"
`include "write_back_stage.v"

module processor (
    input wire clk,              // Clock signal
    input wire rst               // Reset signal
);

    wire [31:0] pc;              // Program Counter
    wire [31:0] instruction;     // Fetched Instruction
    wire [63:0] rs1_data;        // Data from source register 1
    wire [63:0] rs2_data;        // Data from source register 2
    wire [63:0] immediate;       // Immediate value
    wire branch;                 // Branch control signal
    wire mem_read;               // Memory read control signal
    wire mem_to_reg;             // Memory to register control signal
    wire [1:0] alu_op;           // ALU operation control signal
    wire mem_write;              // Memory write control signal
    wire alu_src;                // ALU source control signal
    wire reg_write;              // Register write control signal
    wire [63:0] alu_result;      // ALU result
    wire zero;                   // Zero flag from ALU
    wire [63:0] mem_data;        // Data read from memory
    wire [63:0] write_data;      // Data to write back to register file
    wire [3:0] alu_ctrl;         // ALU control signal
    


    // PC update logic

    // Instruction Fetch Stage
    instruction_fetch_stage if_stage (
        .clk(clk),
        .rst(rst),
        .ALU_zero(zero),
        .branch(branch),
        .branch_offset(immediate),
        .pc(pc),
        .instruction(instruction)
    );

    // Instruction Decode Stage
    instruction_decode_stage id_stage (
        .clk(clk),
        .rst(rst),
        .rs1_addr(instruction[19:15]),
        .rs2_addr(instruction[24:20]),
        .rd_addr(instruction[11:7]),
        .rd_data(write_data),
        .instruction(instruction),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .immediate(immediate),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write)
    );

    // Execute Stage
    execute_stage ex_stage (
        .alu_op(alu_op),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src),
        .rd1(rs1_data),
        .rd2(rs2_data),
        .imm(immediate),
        .funct3(instruction[14:12]),
        .funct7b5(instruction[30]),
        .alu_result(alu_result),
        .alu_zero(zero)
    );

    // Memory Access Stage
    memory_access_stage mem_stage (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_result(alu_result),
        .write_data(rs2_data),
        .mem_data(mem_data)
    );

    // Write Back Stage
    write_back wb_stage (
        .mem_read(mem_read),
        .read_data(mem_data),
        .alu_result(alu_result),
        .write_back_data(write_data)
    );

endmodule