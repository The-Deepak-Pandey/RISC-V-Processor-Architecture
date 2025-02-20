// module data_memory (
//     input logic clk,            // Clock signal
//     input logic mem_read,       // Memory read control signal
//     input logic mem_write,      // Memory write control signal
//     input logic [63:0] address, // Memory address (64-bit for RV64)
//     input logic [63:0] write_data, // Data to be written
//     output logic [63:0] read_data  // Data read from memory
// );

//     // Define memory (simple register array)

//     always_ff @(posedge clk) begin
//         if (mem_write) begin
//             mem_array[address[7:0]] <= write_data; // Write data to memory
//         end
//     end

//     always_comb begin
//         if (mem_read) begin
//             read_data = mem_array[address[7:0]]; // Read data from memory
//         end else begin
//             read_data = 64'b0; // Default output when not reading
//         end
//     end

// endmodule
