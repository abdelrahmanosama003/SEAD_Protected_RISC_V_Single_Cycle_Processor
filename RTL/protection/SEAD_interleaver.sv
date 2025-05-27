module SEAD_interleaver(
    input  logic [31:0] data_in,
    output logic [31:0] data_out

);

logic [5:0] k;
logic [5:0] j;

always_comb begin
    for (k = 0; k < 32; k++) begin
        j = (5'd11 * (k % 5'd3)) + (k / 5'd3);
        data_out[j] = data_in[k];
    end
end
endmodule