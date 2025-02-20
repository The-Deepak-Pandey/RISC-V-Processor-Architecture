module alu_control (
    input  wire [1:0]  alu_op,
    input  wire [2:0]  funct3,  // bits [14:12]
    input  wire        funct7b5, // bit [30] in R-type
    output reg  [3:0]  alu_ctrl  // 4-bit control to ALU
);
    // We'll define these localparams for clarity
    localparam AND_CTRL = 4'b0000;
    localparam OR_CTRL  = 4'b0001;
    localparam ADD_CTRL = 4'b0010;
    localparam SUB_CTRL = 4'b0110;

    always @(*) begin
        case (alu_op)
            2'b00: begin
                // Typically for loads/stores => add
                alu_ctrl = ADD_CTRL;
            end
            2'b01: begin
                // Typically for branch => subtract
                alu_ctrl = SUB_CTRL;
            end
            2'b10: begin
                // R-type => decode funct3/funct7
                case (funct3)
                    3'b000: begin
                        // ADD or SUB depends on funct7 bit [30]
                        if (funct7b5 == 1'b1) 
                            alu_ctrl = SUB_CTRL; // SUB
                        else
                            alu_ctrl = ADD_CTRL; // ADD
                    end
                    3'b111: alu_ctrl = AND_CTRL; // AND
                    3'b110: alu_ctrl = OR_CTRL;  // OR
                    // Add more R-type instructions as needed (e.g. SLT, XOR, etc.)
                    default: alu_ctrl = ADD_CTRL; 
                endcase
            end
            default: begin
                // For other cases, default to add
                alu_ctrl = ADD_CTRL;
            end
        endcase
    end
endmodule
