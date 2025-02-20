module alu (
    input  wire [31:0]  in1,
    input  wire [31:0]  in2,
    input  wire [3:0]   alu_ctrl,
    output reg  [31:0]  alu_result,
    output wire         zero
);
    localparam AND_CTRL = 4'b0000;
    localparam OR_CTRL  = 4'b0001;
    localparam ADD_CTRL = 4'b0010;
    localparam SUB_CTRL = 4'b0110;
    // You can add more as needed: XOR, SLT, etc.

    always @(*) begin
        case (alu_ctrl)
            AND_CTRL: alu_result = in1 & in2;
            OR_CTRL:  alu_result = in1 | in2;
            ADD_CTRL: alu_result = in1 + in2;
            SUB_CTRL: alu_result = in1 - in2;
            default:  alu_result = 32'b0;
        endcase
    end

    assign zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;
endmodule
