`include "processor.v"

module processor_tb;
    reg clk, rst;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Release reset
        #10 rst = 0;
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