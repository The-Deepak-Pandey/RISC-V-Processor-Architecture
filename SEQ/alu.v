module alu (
    input  wire [63:0]  in1,
    input  wire [63:0]  in2,
    input  wire [3:0]   alu_ctrl,
    output reg  [63:0]  alu_result,
    output wire         zero
);
    localparam AND_CTRL = 4'b0000;
    localparam OR_CTRL  = 4'b0001;
    localparam ADD_CTRL = 4'b0010;
    localparam SUB_CTRL = 4'b0110;
    // You can add more as needed: XOR, SLT, etc.
    
    always @(*) begin
        case (alu_ctrl)
            AND_CTRL: and(alu_result, in1, in2);

            OR_CTRL:  or(alu_result, in1, in2);

            ADD_CTRL: begin
                wire signed [63:0] add_result;
                wire add_cout;
                ADD add_inst (
                    .A({in1}),
                    .B({in2}),
                    .Cin(1'b0),
                    .S(add_result),
                    .Cout(add_cout)
                );
                alu_result = add_result[63:0];
            end

            SUB_CTRL: begin
                wire signed [63:0] sub_result;
                wire sub_cout;
                SUB sub_inst (
                    .A({in1}),
                    .B({in2}),
                    .S(sub_result),
                    .Cout(sub_cout)+
                );
                alu_result = sub_result[63:0];
            end
            default:  alu_result = 63'b0;
        endcase
    end

    assign zero = (alu_result == 63'b0) ? 1'b1 : 1'b0;
endmodule
    


module ADD(
    input signed [63:0] A,
    input signed [63:0] B,
    input Cin,
    output signed [63:0] S,
    output Cout
);

    wire [64:0] c;
    assign c[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin
            fulladder fa(
                .A(A[i]),
                .B(B[i]),
                .Cin(c[i]),
                .S(S[i]),
                .Cout(c[i+1])
            );
        end
    endgenerate

    xor gate1(Cout, c[64], c[63]);

endmodule

module fulladder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);

    wire w1, w2, w3;
    xor gate1(w1, A, B);
    xor gate2(S, w1, Cin);
    and gate3(w2, A, B);
    and gate4(w3, w1, Cin);
    or gate5(Cout, w2, w3);

endmodule

module SUB (
    input  signed [63:0] A,
    input  signed [63:0] B,
    output signed [63:0] S,
    output               Cout
);

    // Step 1: Compute 2's complement of B (i.e. ~B)
    wire signed [63:0] B_2s;
    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : NOT_LOOP
            not u_not (B_2s[i], B[i]);
        end
    endgenerate

    // Step 2: Add 1 to get 2's complement of B
    wire signed [63:0] B_2s_plus1;
    wire               cout1;
    ADD add1 (
        .A(B_2s),
        .B({64{1'b0}}),
        .Cin(1'b1),
        .S(B_2s_plus1),
        .Cout(cout1)
    );

    // Step 3: Compute A + (2's complement of B) = A - B
    wire               cout2;
    ADD add2 (
        .A(A),
        .B(B_2s_plus1),
        .Cin(1'b0),
        .S(S),
        .Cout(cout2)
    );

    // Optionally, output the carry of the final addition.
    assign Cout = cout2;

endmodule

