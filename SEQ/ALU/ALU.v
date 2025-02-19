`include "ALL_COMPONENTS.v"

module ALU(
    input signed [63:0] rs1, 
    input signed [63:0] rs2,
    input [2:0] func3,
    input [6:0] func7,
    output reg signed [63:0] out,
    output [9:0] Cout
);

    wire [9:0][63:0] outputs;


    ADD adder(
        .A(rs1),
        .B(rs2),
        .Cin(1'b0),
        .S(outputs[0]),
        .Cout(Cout[0])
    );

    SUB subber(
        .A(rs1),
        .B(rs2),
        .S(outputs[1]),
        .Cout(Cout[1])
    );

    XOR xor_gate(
        .A(rs1),
        .B(rs2),
        .XOR_op(outputs[2])
    );

    OR or_gate(
        .A(rs1),
        .B(rs2),
        .OR_op(outputs[3])
    );

    AND and_gate(
        .A(rs1),
        .B(rs2),
        .AND_op(outputs[4])
    );

    SLL sll_gate(
        .A(rs1),
        .shift_amount(rs2[4:0]),
        .SLL_op(outputs[5])
    );

    SRL srl_gate(
        .A(rs1),
        .shift_amount(rs2[4:0]),
        .SRL_op(outputs[6])
    );

    SRA sra_gate(
        .A(rs1),
        .shift_amount(rs2[4:0]),
        .SRA_op(outputs[7])
    );

    SLT slt_gate(
        .A(rs1),
        .B(rs2),
        .S(outputs[8])
    );

    SLTU sltu_gate(
        .A(rs1),
        .B(rs2),
        .SLTU_op(outputs[9])
    );

    always @(*) begin
        if(func3 == 3'h0) begin
            if (func7 == 7'h00) begin
                out = outputs[0];
            end
            else begin
                out = outputs[1];
            end
        end
        else if (func3 == 3'h5) begin
            if (func7 == 7'h00) begin
                out = outputs[6];
            end else begin
                out = outputs[7];
            end
        end
        else if (func3 == 3'h4) begin
            out = outputs[2];
        end
        else if (func3 == 3'h6) begin
            out = outputs[3];
        end
        else if (func3 == 3'h7) begin
            out = outputs[4];
        end
        else if (func3 == 3'h1) begin
            out = outputs[5];
        end
        else if (func3 == 3'h2) begin
            out = outputs[8];
        end
        else if (func3 == 3'h3) begin
            out = outputs[9];
        end
    end

endmodule