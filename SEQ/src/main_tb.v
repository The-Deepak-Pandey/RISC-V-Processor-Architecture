`include "main.v"

module main_tb;
    reg clk, rst;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Release reset
        #10 rst = 0;

        $dumpfile("main_tb.vcd");
        $dumpvars(0, main_tb);
    end

    // Instantiate the processor module
    processor uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    

    // Test procedure



endmodule