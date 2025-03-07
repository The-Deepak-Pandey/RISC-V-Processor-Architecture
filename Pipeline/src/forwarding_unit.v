module forwarding_unit(
    input [4:0] rs1_id_ex,
    input [4:0] rs2_id_ex,
    input reg_write_ex_mem,
    input reg_write_mem_wb,
    input [4:0] rd_ex_mem,
    input [4:0] rd_mem_wb,
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);

    always @(*) begin
        // Default forwarding control signals
        forward_a = 2'b00;
        forward_b = 2'b00;
        $display("Reset: forward_a=%b, forward_b=%b", forward_a, forward_b);

        // Forwarding for rs1
        if (reg_write_ex_mem && (rd_ex_mem != 0) && (rd_ex_mem == rs1_id_ex)) begin
            forward_a = 2'b10; // Forward from EX/MEM stage
            $display("rs1: Forwarding from EX/MEM stage, rd_ex_mem=%0d, rs1_id_ex=%0d", rd_ex_mem, rs1_id_ex);
        end else if (reg_write_mem_wb && (rd_mem_wb != 0) && (rd_mem_wb == rs1_id_ex)) begin
            forward_a = 2'b01; // Forward from MEM/WB stage
            $display("rs1: Forwarding from MEM/WB stage, rd_mem_wb=%0d, rs1_id_ex=%0d", rd_mem_wb, rs1_id_ex);
        end

        // Forwarding for rs2
        if (reg_write_ex_mem && (rd_ex_mem != 0) && (rd_ex_mem == rs2_id_ex)) begin
            forward_b = 2'b10; // Forward from EX/MEM stage
            $display("rs2: Forwarding from EX/MEM stage, rd_ex_mem=%0d, rs2_id_ex=%0d", rd_ex_mem, rs2_id_ex);
        end else if (reg_write_mem_wb && (rd_mem_wb != 0) && (rd_mem_wb == rs2_id_ex)) begin
            forward_b = 2'b01; // Forward from MEM/WB stage
            $display("rs2: Forwarding from MEM/WB stage, rd_mem_wb=%0d, rs2_id_ex=%0d", rd_mem_wb, rs2_id_ex);
        end

        $display("Final signals: forward_a=%b, forward_b=%b", forward_a, forward_b);
    end

endmodule