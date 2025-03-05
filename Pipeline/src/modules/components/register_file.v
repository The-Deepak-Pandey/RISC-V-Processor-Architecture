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
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 64'h0000000000000000;
        end

        // test values initialization
        registers[1] = 64'd1;
        registers[2] = 64'd13;
        registers[3] = 64'd3;
        registers[4] = 64'd4;
        registers[5] = 64'd5;
        registers[6] = 64'd6;
        registers[7] = 64'd7;

        // Debug output for register initialization
        $display("Register Initialization testing:");
        for (i = 0; i < 32; i = i + 1) begin
            $display("Register %0d: %d", i, registers[i]);
        end
    end

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
                for (i = 0; i < 32; i = i + 1) begin : reset_loop
                    registers[i] <= 64'h0000000000000000;
                end

                // test values initialization
                registers[1] <= 64'd1;
                registers[2] <= 64'd13;
                registers[3] <= 64'd3;
                registers[4] <= 64'd4;
                registers[5] <= 64'd5;
                registers[6] <= 64'd6;
                registers[7] <= 64'd7;
            
        end 
        else if (reg_write && rd_addr != 5'b00000) begin
            registers[rd_addr] <= rd_data;
            // Debug output for register writes
            $display("Register Write happening: x%0d (rd addr) = %d (rd data)", rd_addr, rd_data);
        end
    end
endmodule