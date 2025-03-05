`include "immediate_gen.v"

module test_immediate_gen;
    reg  [31:0] inst;
    wire [63:0] imm;
    
    immediate_gen uut (
        .instruction(inst),
        .immediate(imm)
    );
    
    initial begin
        // I-type test: Use opcode 0000011 and set i_imm = 12'b101010101010
        inst = {12'b101010101010, 13'b0, 7'b0000011};
        #10;
        $display("I-type test:");
        $display("  Instruction = %b", inst);
        $display("  Immediate   = %b", imm);
        
        // S-type test: Use opcode 0100011 and set s_imm = {instruction[31:25], instruction[11:7]}
        // Let s_imm = {7'b0101010, 5'b10101}. 
        inst = {7'b0101010, 13'b0, 5'b10101, 7'b0100011};
        #10;
        $display("S-type test:");
        $display("  Instruction = %b", inst);
        $display("  Immediate   = %b", imm);
        
        // B-type test: Use opcode 1100011 and set b_imm = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}
        // Choose: instruction[31] = 1, instruction[30:25] = 6'b101010, instruction[11:8] = 4'b1100, instruction[7] = 1'b0.
        inst = {1'b1, 6'b101010, 13'b0, 4'b1100, 1'b0, 7'b1100011};
        #10;
        $display("B-type test:");
        $display("  Instruction = %b", inst);
        $display("  Immediate   = %b", imm);
        
        // Default test: Use an opcode that doesn't match any case (e.g., 7'b1111111)
        inst = {25'b0, 7'b1111111};
        #10;
        $display("Default test:");
        $display("  Instruction = %b", inst);
        $display("  Immediate   = %b", imm);
        
        #10;
        $finish;
    end
endmodule