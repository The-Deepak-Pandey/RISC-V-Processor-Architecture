module hazard_det_unit (
    input wire idex_memRead,
    input wire [4:0] rs1_d1,
    input wire [4:0] rs2_d1,
    input wire [4:0] rd_d2,
    output wire ifid_write,
    output wire PC_write,
    output wire ctrl_hazard
);


    // Check for data hazards
    assign ifid_write = ((idex_memRead) & ((rs1_d1 == rd_d2) || (rs2_d1 == rd_d2))) ? 1'b0 : 1'b1;
    assign ctrl_hazard= ((idex_memRead) & ((rs1_d1 == rd_d2) || (rs2_d1 == rd_d2))) ? 1'b1 : 1'b0;


    // Check for control hazards
    assign PC_write = ((idex_memRead) & ((rs1_d1 == rd_d2) || (rs2_d1 == rd_d2))) ? 1'b0 : 1'b1;

endmodule