module immediate_gen (
    input  wire [31:0] instruction,
    output reg  [63:0] immediate
);
    wire [11:0] i_imm = instruction[31:20];
    wire [11:0] s_imm = {instruction[31:25], instruction[11:7]};
    wire [12:0] b_imm = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; 
    
    // Sign extension
    always @(*) begin
        case (instruction[6:0])
            7'b0000011, 7'b0010011, 7'b1100111: // I-type opcodes
                immediate = {{52{i_imm[11]}}, i_imm};
            7'b0100011: // S-type opcode
                immediate = {{52{s_imm[11]}}, s_imm};
            7'b1100011: // B-type opcode
                immediate = {{51{b_imm[12]}}, b_imm};
            default: 
                immediate = 64'b0;
        endcase
    end
endmodule
