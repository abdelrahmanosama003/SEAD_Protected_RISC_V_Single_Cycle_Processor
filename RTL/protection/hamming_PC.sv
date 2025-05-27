module hamming_PC (
    input  logic        clk,
    input  logic        rstN,
    input  logic [31:0] nextcount,

    output logic [31:0] corrected_count,
    output logic        double_error_flag
);
////////////////////////////////  INTERNAL WIRES  //////////////////////////////////

logic [31:0] count;
// logic [31:0] nextcount;
logic double_error_1, double_error_2, double_error_3;   
logic [4:0] parity_bits1, parity_bits2, parity_bits3;
logic [10:0] corrected_data_1, corrected_data_2, corrected_data_3;
logic [31:0] nextcount_interleaved, count_interleaved;
// assign nextcount = corrected_count + 32'd4;

////////////////////////////////  INTERLEAVING BITS  ///////////////////////////////

SEAD_interleaver SEAD_interleaver_inst(
    .data_in(nextcount),
    .data_out(nextcount_interleaved)
);

SEAD_interleaver SEAD_interleaver_inst_2(
    .data_in(count),
    .data_out(count_interleaved)
);

SEAD_deinterleaver SEAD_deinterleaver_inst(
    .data_in({corrected_data_3[9:0], corrected_data_2, corrected_data_1}),
    .data_out(corrected_count)
);
/////////////////////////////////  ENCODING & DECODING /////////////////////////////////////

encoder encoder1 (
    .clk(clk),
    .rstN(rstN),
    .encoder_data_in(nextcount_interleaved[10:0]), 
    .parity_bits(parity_bits1)
);

encoder encoder2 (
    .clk(clk),
    .rstN(rstN),
    .encoder_data_in(nextcount_interleaved[21:11]), 
    .parity_bits(parity_bits2)
);

encoder encoder3 (
    .clk(clk),
    .rstN(rstN),
    .encoder_data_in({1'b0, nextcount_interleaved[31:22]}), 
    .parity_bits(parity_bits3)
);

decoder decoder1 (
    .data_in(count_interleaved[10:0]),
    .parity(parity_bits1),

    .data_corrected(corrected_data_1),
    .double_error_flag(double_error_1)
);

decoder decoder2 (
    .data_in(count_interleaved[21:11]),
    .parity(parity_bits2),

    .data_corrected(corrected_data_2),
    .double_error_flag(double_error_2)
);

decoder decoder3 (
    .data_in({1'b0, count_interleaved[31:22]}),
    .parity(parity_bits3),

    .data_corrected(corrected_data_3),
    .double_error_flag(double_error_3)
);

///////////////////////////////  REGISTER LOGIC ///////////////////////////////////////

always_ff @(posedge clk or negedge rstN) begin
    if (!rstN) begin
        count <= 32'd0;
        double_error_flag <= 1'b0;
    end else begin
        count <= nextcount;
        double_error_flag <= (double_error_1 | double_error_2 | double_error_3);
    end
end

endmodule 