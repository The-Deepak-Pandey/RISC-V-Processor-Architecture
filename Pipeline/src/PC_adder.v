    module PC_adder (
        input wire clk,             // Clock signal
        input wire rst,           // Reset signal
        input wire PCSrc,               // Branch control signal
        input wire [63:0] pc_branch,    // Branch PC value
        input wire PC_write,             // PC write control signal
        output reg [63:0] pc_out        // Updated PC value
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
                else if (PCSrc) begin
                    pc_out <= pc_branch;
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
