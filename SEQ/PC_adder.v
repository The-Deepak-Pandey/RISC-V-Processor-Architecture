module PC_adder (
    input clk, reset,           // Clock and reset signals
    input ALU_zero,             // Zero flag from ALU
    input [63:0] imm_gen_out,   // Immediate generator output
    input branch,               // Branch control signal
    input [31:0] pc_in,         // Current PC value
    output reg [31:0] pc_out        // Updated PC value
);

    always@(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 32'b0;  // Reset PC to 0
        else begin
            if (branch && ALU_zero)
                pc_out <= pc_in + (imm_gen_out << 1);  // Branch target calculation
            else
                pc_out <= pc_in + 4;  // Default PC increment
        end
    end

endmodule
