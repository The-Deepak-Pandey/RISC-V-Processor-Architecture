`include "data_memory.v"

module memory_access_stage(
    input wire clk,
    input wire mem_read,
    input wire mem_write,
    input wire alu_zero,
    input wire branch,
    input wire [63:0] alu_result,
    input wire [63:0] write_data,
    output wire [63:0] mem_data,
    output wire PCSrc
);

    wire [63:0] data_out;

    data_memory dmem(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(write_data),
        .read_data(mem_data)
    );

    always @(posedge clk) begin
        if(mem_write)
            $display("memory access:store %d to address %h", write_data, alu_result);
        if(mem_read)
            $display("memory access:load %d from address %h", mem_data, alu_result);
    end

    assign PCSrc = branch & alu_zero;


endmodule