module instruction_fetch(
    input wire [31:0] pc,         // Program Counter (PC)
    output reg [31:0] instruction // Output: Fetched Instruction
);

    reg [31:0] instr_mem [0:127]; // Instruction Memory (128 words)

    integer i; // Loop variable
    initial begin

        for(i = 0; i<128; i = i+1) begin
          instr_mem[i] = 32'h00000013; // no operation
        end

        $readmemb("instructions.txt", instr_mem); // Read instructions from file

        // // Debug output for instruction memory
        // $display("Instruction Memory contents:");
        // for(i = 0; i<128; i = i+1) begin
        //     $display("instr_mem[%0d] = %h", i, instr_mem[i]);
        // end
    end

    always @(*) begin
        instruction = instr_mem[pc[8:2]]; // Read instruction from memory
        $display("Instruction Fetch: PC = %d, Instruction = %h", pc, instruction);
    end

endmodule
