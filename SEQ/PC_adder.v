module PC_adder (
    input clk, reset,           // Clock and reset signals
    input ALU_zero,             // Zero flag from ALU
    input [63:0] branch_offset,   // Immediate generator output
    input branch,               // Branch control signal
    input [31:0] pc_in,         // Current PC value
    output reg [31:0] pc_out        // Updated PC value
);

    // max pc limit  = 128 inst * 4 bytes
    localparam pc_limit = 64'h0000000000000200;

    initial begin
      pc_out = 64'h0;
      $display("pc initialize to 0x%h", pc)
    end

    always@(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 32'b0;  // Reset PC to 0
            $display("pc reset to 0x%h", pc_out);
        end else if (branch & ALU_zero) begin
            pc_out <= pc_in + branch_offset << 1;
            $display("pc branched to 0x%h", pc_out);
        end else if (pc < pc_limit-4) begin
            pc_out <= pc_in + 4;
            $display("pc incremented to 0x%h", pc_out);
        end else begin
            $display("PROGRAM COMPLETED!!! : PC reached maximum value");
            $finish;
        end
    end

endmodule
