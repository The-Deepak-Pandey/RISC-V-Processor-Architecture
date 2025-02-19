// ADD module A+B

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

// AND module A AND B

module AND(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] AND_op
);

    genvar i;
    generate
        for(i=0; i<64; i=i+1) begin: and_block
            and a1(AND_op[i], A[i], B[i]);
        end
    endgenerate

endmodule

// OR module A OR B

module OR(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] OR_op
);

    genvar i;
    generate
        for(i=0; i<64; i=i+1) begin: or_block
            or gate(OR_op[i], A[i], B[i]);
        end
    endgenerate

endmodule

// Shift logical left module

module SLL(
    input  signed [63:0] A,
    input  [4:0]         shift_amount,
    output signed [63:0] SLL_op
);

    wire [63:0] ww[5:0];
    wire [63:0] mux_op[5:0];

    assign ww[0] = A;

    genvar i, j;

    generate
        for (i = 0; i<5; i=i+1) begin : shift_loop
            for (j = 0; j<64; j=j+1) begin : bit_loop
                MUX_2x1 mux(
                    .d0(ww[i][j]),
                    .d1((i == 0 && j >= 1) ? ww[i][j-1] :
                        (i == 1 && j >= 2) ? ww[i][j-2] :
                        (i == 2 && j >= 4) ? ww[i][j-4] :
                        (i == 3 && j >= 8) ? ww[i][j-8] :
                        (i == 4 && j >= 16) ? ww[i][j-16] : 1'b0),
                    .sel(shift_amount[i]),
                    .y(mux_op[i+1][j])
                );
            end
        end
    endgenerate

    assign ww[1] = mux_op[1];
    assign ww[2] = mux_op[2];
    assign ww[3] = mux_op[3];
    assign ww[4] = mux_op[4];
    assign ww[5] = mux_op[5];


    assign SLL_op = ww[5];

endmodule

// Set less than A<B

module SLT(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] S
);

    wire [63:0] S_temp;
    wire Cout;
    SUB sub1(
        .A(A),
        .B(B),
        .S(S_temp),
        .Cout(Cout)
    );

    // assign value of S[0] = Cout , and rest S[i] = 0;

    assign S = {63'b0, S_temp[63]};

endmodule

// Set less than unsigned module A<B

module SLTU(A, B, SLTU_op);
    input signed [63:0] A, B;
    output signed [63:0] SLTU_op;

    wire [63:0] xnorred, andedd;
    wire [63:0] final_exp;

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : xnor_and
            xnor xn(xnorred[i], A[i], B[i]);  
            and a1(andedd[i], ~A[i], B[i]);    
        end
    endgenerate

    or o1(final_exp[63],1'b1,1'b1);
    generate
        for (i = 62; i >= 0; i = i - 1) begin : final_exp_gen
            and a2(final_exp[i], xnorred[i+1], final_exp[i+1]); 
        end
    endgenerate

    wire [63:0] or_terms;
    generate
        for (i = 0; i < 64; i = i + 1) begin : or_chain
            and a3(or_terms[i], final_exp[i], andedd[i]);
        end
    endgenerate

    assign SLTU_op = {63'b0, |or_terms};
endmodule

// Shift Arithmetical Right module

module SRA(
    input  signed [63:0] A,
    input  [4:0]         shift_amount,
    output signed [63:0] SRA_op
);

    wire [63:0] ww[5:0];
    wire [63:0] mux_op[5:0];

    assign ww[0] = A;

    genvar i, j;

    generate
        for (i = 0; i<5; i=i+1) begin : shift_loop
            for (j = 0; j<64; j=j+1) begin : bit_loop
                MUX_2x1 mux(
                    .d0(ww[i][j]),
                    .d1((i == 0) ? (j + 1 < 64 ? ww[i][j + 1] : ww[i][63]) :
                        (i == 1) ? (j + 2 < 64 ? ww[i][j + 2] : ww[i][63]) :
                        (i == 2) ? (j + 4 < 64 ? ww[i][j + 4] : ww[i][63]) :
                        (i == 3) ? (j + 8 < 64 ? ww[i][j + 8] : ww[i][63]) :
                        (i == 4) ? (j + 16 < 64 ? ww[i][j + 16] : ww[i][63]) :
                        ww[i][63]),
                    .sel(shift_amount[i]),
                    .y(mux_op[i+1][j])
                );
            end
        end
    endgenerate

    assign ww[1] = mux_op[1];
    assign ww[2] = mux_op[2];
    assign ww[3] = mux_op[3];
    assign ww[4] = mux_op[4];
    assign ww[5] = mux_op[5];


    assign SRA_op = ww[5];

endmodule

// Shift logical right module 

module SRL(
    input  signed [63:0] A,
    input  [4:0]         shift_amount,
    output signed [63:0] SRL_op
);

    wire [63:0] ww[5:0];
    wire [63:0] mux_op[5:0];

    assign ww[0] = A;

    genvar i, j;

    generate
        for (i = 0; i<5; i=i+1) begin : shift_loop
            for (j = 0; j<64; j=j+1) begin : bit_loop
                MUX_2x1 mux(
                    .d0(ww[i][j]),
                    .d1((i == 0) ? (j + 1 < 64 ? ww[i][j+1] : 1'b0) :
                        (i == 1) ? (j + 2 < 64 ? ww[i][j+2] : 1'b0) :
                        (i == 2) ? (j + 4 < 64 ? ww[i][j+4] : 1'b0) :
                        (i == 3) ? (j + 8 < 64 ? ww[i][j+8] : 1'b0) :
                        (i == 4) ? (j + 16 < 64 ? ww[i][j+16] : 1'b0) : 1'b0),
                    .sel(shift_amount[i]),
                    .y(mux_op[i+1][j])
                );
            end
        end
    endgenerate

    assign ww[1] = mux_op[1];
    assign ww[2] = mux_op[2];
    assign ww[3] = mux_op[3];
    assign ww[4] = mux_op[4];
    assign ww[5] = mux_op[5];


    assign SRL_op = ww[5];

endmodule


// Subtraction module B-A

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

// XOR module A XOR B

module XOR(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] XOR_op
);

    genvar i;
    generate
        for(i=0; i<64; i=i+1) begin: xor_block
            xor gate(XOR_op[i], A[i], B[i]);
        end
    endgenerate

endmodule


// Helpful modules

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

module MUX_2x1(
    input d0,
    input d1,
    input sel,
    output y
);
    wire w1, w2;

    and a1(w1,d0,~sel);
    and a2(w2,d1,sel);
    or o1(y,w1,w2);
endmodule


module MUX_8x1(
    input [7:0] data_in,
    input [2:0] sel,
    output out
);
    wire [7:0] w;
    and a1(w[0],data_in[0],~sel[2],~sel[1],~sel[0]);
    and a2(w[1],data_in[1],~sel[2],~sel[1],sel[0]);
    and a3(w[2],data_in[2],~sel[2],sel[1],~sel[0]);
    and a4(w[3],data_in[3],~sel[2],sel[1],sel[0]);
    and a5(w[4],data_in[4],sel[2],~sel[1],~sel[0]);
    and a6(w[5],data_in[5],sel[2],~sel[1],sel[0]);
    and a7(w[6],data_in[6],sel[2],sel[1],~sel[0]);
    and a8(w[7],data_in[7],sel[2],sel[1],sel[0]);
    or o1(out,w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7]);
endmodule