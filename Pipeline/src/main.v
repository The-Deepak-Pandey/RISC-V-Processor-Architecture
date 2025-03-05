`include "instruction_fetch_stage.v"
`include "instruction_decode_stage.v"
`include "execute_stage.v"
`include "memory_access_stage.v"
`include "write_back_stage.v"
`include "IF-ID_register.v"
`include "ID_EX_register.v"
`include "forwarding_unit.v"
`include "EX_MEM_register.v"
`include "MEM_WB_register.v"

module processor (
    input wire clk,              // Clock signal
    input wire rst               // Reset signal
);

    wire [63:0] pc;              // Program Counter
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
    wire [31:0] instructiond1;    // Fetched Instruction
    // wire [31:0] instructiond2;    // Fetched Instruction
    wire PC_write;
    wire ifid_write;
    wire ctrl_hazard;
    wire [63:0] pc_d1;
    wire [63:0] pc_d2;
    wire PCSrc;
    wire [63:0] pc_branch;
    wire [63:0] rs1_data_d2;
    wire [63:0] rs2_data_d2;
    wire  [4:0] rs1_d2;
    wire  [4:0] rs2_d2;
    wire  [4:0] rd_d2;
    wire  [63:0] immediate_d2;
    wire        branch_d2;
    wire        mem_read_d2;
    wire        mem_to_reg_d2;
    wire [1:0]  alu_op_d2;
    wire        mem_write_d2;
    wire        alu_src_d2;
    wire        reg_write_d2;
    wire [2:0] func3_d2;
    wire func7b5_d2;

    wire mem_to_reg_d3;
    wire reg_write_d3;
    wire branch_d3;
    wire mem_read_d3;
    wire mem_write_d3;
    wire [63:0] pc_branch_d3;
    wire [63:0] alu_result_d3;
    wire alu_zero_d3;
    wire [63:0] rs2_data_d3;
    wire [4:0] rd_d3;


    wire [1:0] forward_a;
    wire [1:0] forward_b;

    wire mem_to_reg_d4;
    wire reg_write_d4;
    wire [63:0] read_data_d4;
    wire [63:0] alu_result_d4;
    wire [4:0] rd_d4;
    wire [63:0] write_data_d4;

    // Instruction Fetch Stage
    instruction_fetch_stage if_stage (
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .pc_branch(pc_branch),
        .PC_write(PC_write),
        .pc(pc),
        .instruction(instruction)
    );

    // IF-ID Register
    ifid_reg ifid_reg (
        .pc(pc),
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .ifid_write(ifid_write),
        .instruction_d(instructiond1),
        .pc_d(pc_d1)
    );

    // Instruction Decode Stage
    instruction_decode_stage id_stage (
        .clk(clk),
        .rst(rst),
        .rs1_addr(instructiond1[19:15]),
        .rs2_addr(instructiond1[24:20]),
        .rd_addr(rd_d4),
        .rd_data(write_data_d4),
        .instruction(instructiond1),
        .ctrl_hazard(ctrl_hazard),
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


    // ID-EX Register
    idex_reg idex_reg (
        .pc(pc_d1),
        .clk(clk),
        .rst(rst),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .rs1(instructiond1[19:15]),
        .rs2(instructiond1[24:20]),
        .rd(instructiond1[11:7]),
        .immediate(immediate),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .func3(instructiond1[14:12]),
        .func7b5(instructiond1[30]),
        .rs1_data_d2(rs1_data_d2),
        .rs2_data_d2(rs2_data_d2),
        .rs1_d2(rs1_d2),
        .rs2_d2(rs2_d2),
        .rd_d2(rd_d2),
        .immediate_d2(immediate_d2),
        .branch_d2(branch_d2),
        .mem_read_d2(mem_read_d2),
        .mem_to_reg_d2(mem_to_reg_d2),
        .alu_op_d2(alu_op_d2),
        .mem_write_d2(mem_write_d2),
        .alu_src_d2(alu_src_d2),
        .reg_write_d2(reg_write_d2),
        .func3_d2(func3_d2),
        .func7b5_d2(func7b5_d2),
        .pc_d2(pc_d2)
    );

    // Forwarding Unit
    forwarding_unit fwd_unit (
        .rs1_id_ex(idex_reg.rs1_d2),
        .rs2_id_ex(idex_reg.rs2_d2),
        .reg_write_ex_mem(exmem_reg.reg_write_d3),
        .reg_write_mem_wb(memwb_reg.reg_write_d4),
        .rd_ex_mem(exmem_reg.rd_d3),
        .rd_mem_wb(memwb_reg.rd_d4),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );

    // Execute Stage
    execute_stage ex_stage (
        .pc(pc_d2),
        .alu_op(alu_op_d2),
        .alu_ctrl(alu_ctrl),
        .alu_src(alu_src_d2),
        .rs1_data(rs1_data_d2),
        .rs2_data(rs2_data_d2),
        .imm(immediate_d2),
        .funct3(func3_d2),
        .funct7b5(func7b5_d2),
        .alu_result(alu_result),
        .alu_zero(zero),
        .pc_branch(pc_branch)
    );

    exmem_reg exmem_reg (
        .clk(clk),
        .rst(rst),
        .mem_to_reg(mem_to_reg_d2),
        .reg_write(reg_write_d2),
        .branch(branch_d2),
        .mem_read(mem_read_d2),
        .mem_write(mem_write_d2),
        .pc_branch(pc_branch),
        .alu_result(alu_result),
        .alu_zero(zero),
        .rs2_data(rs2_data_d2),
        .rd(rd_d2),

        .mem_to_reg_d3(mem_to_reg_d3),
        .reg_write_d3(reg_write_d3),
        .branch_d3(branch_d3),
        .mem_read_d3(mem_read_d3),
        .mem_write_d3(mem_write_d3),
        .pc_branch_d3(pc_branch_d3),
        .alu_result_d3(alu_result_d3),
        .alu_zero_d3(alu_zero_d3),
        .rs2_data_d3(rs2_data_d3),
        .rd_d3(rd_d3)
    );

    // Memory Access Stage
    memory_access_stage mem_stage (
        .clk(clk),
        .mem_read(mem_read_d3),
        .mem_write(mem_write_d3),
        .alu_zero(alu_zero_d3),
        .branch(branch_d3),
        .alu_result(alu_result_d3),
        .write_data(rs2_data_d3),

        .mem_data(mem_data),
        .PCSrc(PCSrc)
    );

    // MEM-WB Register
    mem_wb_reg memwb_reg (
        .clk(clk),
        .rst(rst),
        .mem_to_reg(mem_to_reg_d3),
        .reg_write(reg_write_d3),
        .read_data(mem_data),
        .alu_result_d3(alu_result_d3),
        .rd_d3(rd_d3),

        .mem_to_reg_d4(mem_to_reg_d4),
        .reg_write_d4(reg_write_d4),
        .read_data_d4(write_data_d4),
        .alu_result_d4(alu_result_d4),
        .rd_d4(rd_d4)
    );

    // Write Back Stage
    write_back wb_stage (
        .mem_read(mem_to_reg_d4),
        .read_data(read_data_d4),
        .alu_result(alu_result_d4),
        .write_back_data(write_data_d4)
    );

    // Display register file array
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin

        end else begin
            // Display register file contents
            $display("Register File Contents: for instruction number = %0d", pc/4 + 1);
            for (i = 0; i < 10; i = i + 1) begin
                $display("x%0d: %d", i, id_stage.rf.registers[i]);
            end
        end
    end

    // Display memory file array
    integer j;
    always @(posedge clk or posedge rst) begin
        if (rst) begin

        end else begin
            // Display memory file contents
            $display("Memory File Contents: for instruction number = %0d", pc/4 + 1);
            for (j = 0; j < 5; j = j + 1) begin
                $display("memory[%0d]: %d", j, mem_stage.dmem.memory[j]);
            end
        end
    end

endmodule