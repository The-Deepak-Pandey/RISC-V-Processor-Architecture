module register_file (
    input wire clk,
    input wire rst,
    input wire reg_write,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [63:0] rd_data,
    output reg [63:0] rs1_data,
    output reg [63:0] rs2_data
);
    reg [63:0] registers [0:31];  // 32 64-bit registers

    // genvar i;
    // generate
    //     for (i = 0; i < 32; i = i + 1) begin : init_loop
    //         initial begin
    //             registers[i] = 64'h0000000000000000;
    //         end
    //     end
    // endgenerate
    

    // Read operation
    always @(*) begin
        // x0 is hardwired to 0
        rs1_data = (rs1_addr == 5'b00000) ? 64'h0 : registers[rs1_addr];
        rs2_data = (rs2_addr == 5'b00000) ? 64'h0 : registers[rs2_addr];
    end
    
    
    // Write operation
    always @(posedge clk) begin
        if (rst) begin
            genvar i;
            generate
                for (i = 0; i < 32; i = i + 1) begin : reset_loop
                    registers[i] <= 64'h0000000000000000;
                end
            endgenerate
        end 
        else if (reg_write && rd_addr != 5'b00000) begin
            registers[rd_addr] <= rd_data;
            // Debug output for register writes
            $display("Register Write: x%0d = %h", rd_addr, rd_data);
        end
    end
endmodule