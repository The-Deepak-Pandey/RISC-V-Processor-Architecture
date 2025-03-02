// module data_memory (
//     input logic clk,          // Clock signal
//     input logic mem_write,    // Control signal: 1 = Write, 0 = Read
//     input logic mem_read,     // Control signal: 1 = Read
//     input logic [63:0] addr,  // Memory address
//     input logic [63:0] write_data, // Data to write
//     output logic [63:0] read_data  // Data read from memory
// );

//     // 64-bit wide, 1024 locations (adjust size as needed)
//     logic [63:0] memory [0:1023];  

//     always_ff @(posedge clk) begin
//         if (mem_write) begin
//             memory[addr >> 3] <= write_data; // Store word-aligned
//         end
//     end

//     always_comb begin
//         if (mem_read)
//             read_data = memory[addr >> 3]; // Load word-aligned
//         else
//             read_data = 64'b0;
//     end

// endmodule
