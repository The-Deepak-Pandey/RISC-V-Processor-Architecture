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
    always @(*) begin
        // Default values
        branch     = 0;
        mem_read   = 0;
        mem_to_reg = 0;
        alu_op     = 2'b00;
        mem_write  = 0;
        alu_src    = 0;
        reg_write  = 0;
        
        case (opcode)
            7'b0110011: begin
                // R-type
                alu_op     = 2'b10; // R-type ALU operation
                alu_src    = 0;
                reg_write  = 1;
                // mem_to_reg = 0 (already default)
            end
            7'b0000011: begin
                // load (e.g. ld/lw)
                alu_op     = 2'b00; // add
                alu_src    = 1;
                mem_read   = 1;
                mem_to_reg = 1;
                reg_write  = 1;
            end
            7'b0100011: begin
                // store (e.g. sd/sw)
                alu_op     = 2'b00; // add
                alu_src    = 1;
                mem_write  = 1;
            end
            7'b1100011: begin
                // branch (e.g. beq)
                alu_op     = 2'b01; // subtract for comparison
                branch     = 1;
            end
            default: begin
                // For other opcodes (e.g. immediate instructions, etc.)
                // You can add more logic here or leave them as no-ops.
            end
        endcase
    end
endmodule
