`include "ALU.v"

module ALU_tb;
    reg signed [63:0] rs1,rs2;   
    reg [6:0] func7;
    reg [2:0] func3;
    wire signed [63:0] out;
    wire signed [9:0] Cout;


    ALU uut(
        .rs1(rs1),
        .rs2(rs2),
        .func3(func3),
        .func7(func7),
        .out(out),
        .Cout(Cout)
    );

    initial begin

        // ADDITION FUNCTIONALITY
        $display("ADD FUNCTIONALITY");

        rs1=7; rs2=9; func3=3'h0; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=-9; func3=3'h0; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=-7; rs2=9; func3=3'h0; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SUBTRACTION FUNCTIONALITY
        $display("SUBTRACTION FUNCTIONALITY");

        rs1=9; rs2=7; func3=3'h0; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=9; func3=3'h0; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=-9; func3=3'h0; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SLL FUNCTIONALITY
        $display("SHIFT LEFT LOGICAL FUNCTIONALITY");

        rs1=10; rs2=2; func3=3'h1; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=-10; rs2=2; func3=3'h1; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SLT FUNCTIONALITY
        $display("SET LESS THAN FUNCTIONALITY");

        rs1=-7; rs2=9; func3=3'h2; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=9; func3=3'h2; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=9; rs2=7; func3=3'h2; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=9; rs2=-7; func3=3'h2; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SLTU FUNCTIONALITY
        $display("SET LESS THAN UNSIGNED FUNCTIONALITY");

        rs1=-7; rs2=9; func3=3'h3; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=9; func3=3'h3; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=9; rs2=7; func3=3'h3; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=9; rs2=-7; func3=3'h3; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // XOR FUNCTIONALITY
        $display("XOR FUNCTIONALITY");

        rs1=7; rs2=9; func3=3'h4; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=7; rs2=7; func3=3'h4; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=0; rs2=7; func3=3'h4; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SRL FUNCTIONALITY
        $display("SHIFT RIGHT LOGICAL FUNCTIONALITY");

        rs1=16; rs2=2; func3=3'h5; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=-16; rs2=2; func3=3'h5; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=16; rs2=20; func3=3'h5; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // SRA FUNCTIONALITY
        $display("SHIFT RIGHT ARITHMETIC FUNCTIONALITY");

        rs1=16; rs2=2; func3=3'h5; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=-16; rs2=2; func3=3'h5; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=16; rs2=20; func3=3'h5; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);

        rs1=-16; rs2=20; func3=3'h5; func7=7'h20;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d ",rs1, rs2, func3, func7, out);


        // OR FUNCTIONALITY
        $display("OR FUNCTIONALITY");

        rs1=7; rs2=9; func3=3'h6; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);

        rs1=7; rs2=7; func3=3'h6; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);

        rs1=7; rs2=0; func3=3'h6; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);


        // AND FUNCTIONALITY
        $display("AND FUNCTIONALITY");

        rs1=7; rs2=9; func3=3'h7; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);

        rs1=7; rs2=7; func3=3'h7; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);

        rs1=7; rs2=0; func3=3'h7; func7=7'h00;
        #10;
        $display("rs1=%5d rs2=%5d func3=0x%h func7=0x%h out=%5d",rs1, rs2, func3, func7, out);
    end
endmodule