module alu_control (
    input  wire [1:0]  alu_op,
    input  wire [2:0]  funct3,
    input  wire        funct7b5, // bit [30] in R-type
    output wire [3:0]  alu_ctrl  // 4-bit control to ALU
);
    wire op0, op1, f3_0, f3_1, f3_2, f7_5;
    assign op0 = alu_op[0];
    assign op1 = alu_op[1];
    assign f3_0 = funct3[0];
    assign f3_1 = funct3[1];
    assign f3_2 = funct3[2];
    assign f7_5 = funct7b5;

    assign alu_ctrl[3] = 0;
    assign alu_ctrl[2] = (op0 & ~op1) | (op1 & (~op0) & f7_5); 
    assign alu_ctrl[1] = (~op1) | op0 | f7_5 | (~f3_2) | (~f3_1) ;
    assign alu_ctrl[0] = op1 & (~f7_5) & f3_2 & f3_1 & (~f3_0);

endmodule