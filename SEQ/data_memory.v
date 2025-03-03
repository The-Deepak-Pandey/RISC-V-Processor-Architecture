module data_memory (
    input wire clk,            // Clock signal
    input wire mem_read,       // Memory read control signal
    input wire mem_write,      // Memory write control signal
    input wire [63:0] address, // Memory address (64-bit for RV64)
    input wire [63:0] write_data, // Data to be written
    output reg [63:0] read_data  // Data read from memory
);
    reg [63:0] memory [0:1023];  // 32 64-bit memory locations

    integer i;
    initial begin
        for(i = 0; i < 1024; i = i + 1) begin
            memory[i] = 64'h0000000000000000;
        end

        // initialize with some random test data

        memory[0] = 64'd10;
        memory[1] = 64'd20;
        memory[2] = 64'd30;
        memory[3] = 64'd40;
        memory[4] = 64'd50;

        // Debug output for memory initialization
        $display("Data Memory contents having test values:");
        for(i = 0; i < 5; i = i + 1) begin
            $display("memory[%0d] = %d", i, memory[i]);
        end
    end

    // For Read operation

    always @(*) begin
        if(mem_read) begin
            read_data <= memory[address[10:3]]; // Read 64-bit data from memory (10:3 since memory is word accessible)
            $display("Data Memory Read: Address = 0x%h, Data = %0d", address, read_data);
        end else begin
            read_data = 64'b0;
        end
    end

    // For Write operation
    always @(posedge clk) begin
        if(mem_write) begin
            memory[address[10:3]] <= write_data; // Write 64-bit data to memory (10:3 since memory is word accessible)
            $display("Data Memory Write: Address = 0x%h, Data = %0d", address, write_data);
        end
    end

endmodule
