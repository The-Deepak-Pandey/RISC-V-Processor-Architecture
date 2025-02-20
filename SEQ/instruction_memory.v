module instruction_memory (
    input  wire [31:0]  addr,   // PC address
    output wire [31:0]  instr
);
    // Example: 256-word memory (each word is 32 bits)
    // Adjust size as needed
    reg [31:0] mem [0:255];
    
    initial begin
        // Optionally, load instructions from a file:
        // $readmemh("program.hex", mem);
        
        // Hardcode some instructions for testing:
        mem[0] = 32'h00000093; // NOP (addi x1, x0, 0)
        mem[1] = 32'h00100113; // addi x2, x0, 1
        mem[2] = 32'h002081b3; // add x3, x1, x2
        mem[3] = 32'h00310133; // add x2, x2, x3
        mem[4] = 32'h004181b3; // add x3, x3, x4
        // Add more instructions as needed
    end
    
    // Instruction memory is often treated as "combinational read"
    assign instr = mem[addr[9:2]]; 
    //  addr[9:2] because 256 words => 8 bits for index, ignoring byte offset bits

endmodule
