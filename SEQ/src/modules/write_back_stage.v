module write_back(
    input wire mem_read,
    input wire [63:0] read_data,
    input wire [63:0] alu_result,
    output wire [63:0] write_back_data
);

    // Write back data mux
    assign write_back_data = (mem_read) ? read_data : alu_result;

    // For debuging
    always @(*) begin
        if (mem_read) begin
            $display("Write Back (ld operations): Read Data from memory = %0d", read_data);
        end else begin
            $display("Write Back (alu operations): ALU Result = %0d", alu_result);
        end
    end

endmodule