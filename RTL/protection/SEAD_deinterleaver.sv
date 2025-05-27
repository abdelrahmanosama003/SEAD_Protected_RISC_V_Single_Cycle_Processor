module SEAD_deinterleaver(
    input  logic [31:0] data_in,
    output logic [31:0] data_out

);

logic [5:0] k;
logic [5:0] j;

always_comb begin
    for (k = 0; k < 32; k++) begin
        j = (5'd11 * (k % 5'd3)) + (k / 5'd3);
        data_out[k] = data_in[j]; 
    end
end
endmodule