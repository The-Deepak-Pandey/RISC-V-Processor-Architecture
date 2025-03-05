module hazard_det_unit (
    input wire idex_memRead,
    input wire rs1_d1,
    input wire rs2_d1,
    input wire rd_d2,
    output wire ifid_write,
    output wire PC_write
);

    assign ifid_write = 1'b1;
    assign PC_write = 1'b1;

    // Check for data hazards
    assign ifid_write = ((idex_memRead) & ((rs1_d1 == rd_d2) || (rs2_d1 == rd_d2))) ? 1'b0 : 1'b1;

    // Check for control hazards
    assign PC_write = ((idex_memRead) & ((rs1_d1 == rd_d2) || (rs2_d1 == rd_d2))) ? 1'b0 : 1'b1;

endmodule