    module PC_adder (
        input wire clk, rst,           // Clock and rst signals
        input wire ALU_zero,             // Zero flag from ALU
        input wire [63:0] branch_offset,   // Immediate generator output
        input wire branch,               // Branch control signal
        input wire PC_write,             // PC write control signal
        output reg [31:0] pc_out        // Updated PC value
    );

        // max pc limit  = 128 inst * 4 bytes
        localparam pc_limit = 64'h0000000000000200;

        initial begin
            pc_out = 64'h0;
            $display("PC initialize to 0x%h", pc_out);
        end

        always@(posedge clk or posedge rst) begin
            if (PC_write) begin
                if (rst) begin
                    pc_out <= 32'b0;  // rst PC to 0
                    $display("PC rst to 0x%h", pc_out);
                end 
                // in case of branching
                else if (branch & ALU_zero) begin
                    pc_out <= pc_out + (branch_offset << 1);
                    $display("PC branched to 0x%h", pc_out);
                end 
                // normal case
                else if (pc_out < pc_limit-4) begin
                    pc_out <= pc_out + 4;
                    $display("PC incremented to 0x%h", pc_out);
                end 
                // limit reached case
                else begin
                    $display("PROGRAM COMPLETED!!! : PC reached maximum value");
                    $finish;
                end
            end

            else begin
                $display("PC not updated, stalling");
            end
        end

    endmodule
