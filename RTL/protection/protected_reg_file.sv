module protected_reg_file(
    input  logic clk,             
    input  logic rstN,            
    input  logic [4:0] read_addr1,
    input  logic [4:0] read_addr2,
    input  logic [4:0] write_addr,
    input  logic [31:0] write_data,
    input  logic write_enable,    

    output logic [31:0] RD1_corrected,
    output logic [31:0] RD2_corrected,
    output logic double_error_flag
);

logic [14:0] parity_bits;
logic [31:0] read_data1, read_data2;
logic [14:0] RD1_parity, RD2_parity;
logic double_error_flag1, double_error_flag2;

/////////////////////////////////  INSTANTIATION /////////////////////////////////////

top_encoder encoder(
    .data(write_data),

    .parity(parity_bits)
);

top_decoder decoder1(
    .data_in(read_data1),
    .parity(RD1_parity),

    .data_corrected(RD1_corrected),
    .double_error_flag(double_error_flag1)
);

top_decoder decoder2(
    .data_in(read_data2),
    .parity(RD2_parity),

    .data_corrected(RD2_corrected),
    .double_error_flag(double_error_flag2)
);

reg_file data_reg_file(
    .clk(clk),        
    .rstN(rstN),       
    .read_addr1(read_addr1), 
    .read_addr2(read_addr2), 
    .write_addr(write_addr), 
    .write_data(write_data), 
    .write_enable(write_enable),

    .read_data1(read_data1), 
    .read_data2(read_data2)  
);

ECC_reg_file hamming_reg_file(
    .clk(clk),        
    .rstN(rstN),       
    .read_addr1(read_addr1), 
    .read_addr2(read_addr2), 
    .write_addr(write_addr), 
    .write_data(parity_bits), 
    .write_enable(write_enable),

    .read_data1(RD1_parity), 
    .read_data2(RD2_parity)  
);

always_ff @(posedge clk or negedge rstN ) begin
    if (!rstN) begin
        double_error_flag <= 1'b0;
    end else begin
        double_error_flag <= (double_error_flag1 | double_error_flag2);
    end
end

endmodule 