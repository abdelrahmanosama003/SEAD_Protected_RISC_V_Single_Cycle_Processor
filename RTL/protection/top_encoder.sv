module top_encoder(
    input  logic [31:0] data,
    output logic [14:0] parity
);

logic [31:0] data_interleaved;

SEAD_interleaver SEAD_interleaver_inst(
    .data_in(data),
    .data_out(data_interleaved)
);

encoder_comb encoder1 (
    .encoder_data_in(data_interleaved[10:0]), 
    .parity_bits(parity[4:0])
);

encoder_comb encoder2 (
    .encoder_data_in(data_interleaved[21:11]), 
    .parity_bits(parity[9:5])
);

encoder_comb encoder3 (
    .encoder_data_in({1'b0, data_interleaved[31:22]}), 
    .parity_bits(parity[14:10])
);

endmodule 