module control (
    input  wire [6:0] opcode,
    output reg        branch,
    output reg        mem_read,
    output reg        mem_to_reg,
    output reg [1:0]  alu_op,
    output reg        mem_write,
    output reg        alu_src,
    output reg        reg_write
);
    // RISC-V opcodes used in the example:
    localparam R_TYPE = 7'b0110011; // R-format
    localparam LD     = 7'b0000011; // load (e.g., lw/ld)
    localparam SD     = 7'b0100011; // store (e.g., sw/sd)
    localparam BEQ    = 7'b1100011; // branch equal

    always @(*) begin
        // Set default (safe) values for all outputs:
        branch     = 0;
        mem_read   = 0;
        mem_to_reg = 0;
        mem_write  = 0;
        alu_src    = 0;
        reg_write  = 0;
        alu_op     = 2'b00;

        case (opcode)
            R_TYPE: begin
                // R-format: ALUSrc=0, MemtoReg=0, RegWrite=1, MemRead=0,
                //           MemWrite=0, Branch=0, ALUOp=10
                alu_src    = 0;
                mem_to_reg = 0;
                reg_write  = 1;
                mem_read   = 0;
                mem_write  = 0;
                branch     = 0;
                alu_op     = 2'b10;
            end

            LD: begin
                // ld: ALUSrc=1, MemtoReg=1, RegWrite=1, MemRead=1,
                //     MemWrite=0, Branch=0, ALUOp=00
                alu_src    = 1;
                mem_to_reg = 1;
                reg_write  = 1;
                mem_read   = 1;
                mem_write  = 0;
                branch     = 0;
                alu_op     = 2'b00;  // add
            end

            SD: begin
                // sd: ALUSrc=1, MemtoReg=X (don't care), RegWrite=0, MemRead=0,
                //     MemWrite=1, Branch=0, ALUOp=00
                alu_src    = 1;
                // mem_to_reg = don't care, often just set to 0
                mem_to_reg = 0;
                reg_write  = 0;
                mem_read   = 0;
                mem_write  = 1;
                branch     = 0;
                alu_op     = 2'b00;  // add
            end

            BEQ: begin
                // beq: ALUSrc=0, MemtoReg=X, RegWrite=0, MemRead=0,
                //      MemWrite=0, Branch=1, ALUOp=01
                alu_src    = 0;
                mem_to_reg = 0; // don't care
                reg_write  = 0;
                mem_read   = 0;
                mem_write  = 0;
                branch     = 1;
                alu_op     = 2'b01;  // subtract
            end

            default: begin
                // For unrecognized opcodes, you can leave the default
                // outputs (which are all zero here) or define new behavior.
            end
        endcase
    end
endmodule
