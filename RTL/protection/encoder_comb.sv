module encoder_comb (
    input  logic  [10:0] encoder_data_in,
    
    output logic  [4:0]  parity_bits
);

always_comb begin
    parity_bits[0] = encoder_data_in[0] ^ encoder_data_in[1] ^ encoder_data_in[3] ^ encoder_data_in[4] ^ encoder_data_in[6] ^ encoder_data_in[8] ^ encoder_data_in[10];
    parity_bits[1] = encoder_data_in[0] ^ encoder_data_in[2] ^ encoder_data_in[3] ^ encoder_data_in[5] ^ encoder_data_in[6] ^ encoder_data_in[9] ^ encoder_data_in[10];
    parity_bits[2] = encoder_data_in[3] ^ encoder_data_in[2] ^ encoder_data_in[1] ^ encoder_data_in[7] ^ encoder_data_in[8] ^ encoder_data_in[9] ^ encoder_data_in[10];
    parity_bits[3] = encoder_data_in[4] ^ encoder_data_in[5] ^ encoder_data_in[6] ^ encoder_data_in[7] ^ encoder_data_in[8] ^ encoder_data_in[9] ^ encoder_data_in[10];
    parity_bits[4] = encoder_data_in[0] ^ encoder_data_in[1] ^ encoder_data_in[2] ^ encoder_data_in[3] ^ encoder_data_in[4] ^ encoder_data_in[5] ^ encoder_data_in[6] ^ 
                        encoder_data_in[7] ^ encoder_data_in[8] ^ encoder_data_in[9] ^ encoder_data_in[10] ^ parity_bits[0] ^ parity_bits[1] ^ parity_bits[2] ^ parity_bits[3];
end

endmodule 