module top_decoder(
    input  logic [31:0] data_in,
    input  logic [14:0] parity,

    output logic [31:0] data_corrected,
    output logic        double_error_flag
);

logic double_error_flag1, double_error_flag2, double_error_flag3;
logic [10:0] corrected_data_1, corrected_data_2, corrected_data_3;
logic [31:0] data_interleaved;


SEAD_interleaver SEAD_interleaver_inst(
    .data_in(data_in),
    .data_out(data_interleaved)
);

decoder decoder1 (
    .data_in(data_interleaved[10:0]),
    .parity(parity[4:0]),

    .data_corrected(corrected_data_1),
    .double_error_flag(double_error_flag1)
);

decoder decoder2 (
    .data_in(data_interleaved[21:11]),
    .parity(parity[9:5]),

    .data_corrected(corrected_data_2),
    .double_error_flag(double_error_flag2)
);

decoder decoder3 (
    .data_in({1'b0, data_interleaved[31:22]}),
    .parity(parity[14:10]),

    .data_corrected(corrected_data_3),
    .double_error_flag(double_error_flag3)
);

SEAD_deinterleaver SEAD_deinterleaver_inst(
    .data_in({corrected_data_3[9:0], corrected_data_2, corrected_data_1}),
    .data_out(data_corrected)
);

assign double_error_flag = double_error_flag1 | double_error_flag2 | double_error_flag3;

endmodule 