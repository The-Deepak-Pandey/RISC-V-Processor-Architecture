module instruction_fetch(
    input wire clk,               // Clock Signal
    input wire rst,               // Reset Signal
    input wire [31:0] pc,         // Program Counter (PC)
    output reg [31:0] instruction // Output: Fetched Instruction
);

    reg [31:0] instr_mem [0:255]; // Instruction Memory (256 words)

    initial begin
        $readmemb("instructions.txt", instr_mem); // Read instructions from file
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            instruction <= 32'b0; // Reset instruction
        else
            instruction <= instr_mem[pc >> 2]; // Fetch instruction
    end

endmodule
