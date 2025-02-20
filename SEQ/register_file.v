module register_file (
    input  wire         clk,
    input  wire         reg_write,   // control signal: enable write
    input  wire [4:0]   rs1,         // read register 1 address
    input  wire [4:0]   rs2,         // read register 2 address
    input  wire [4:0]   rd,          // write register address
    input  wire [31:0]  write_data,  // data to write
    output wire [31:0]  read_data1,
    output wire [31:0]  read_data2
);
    
endmodule
