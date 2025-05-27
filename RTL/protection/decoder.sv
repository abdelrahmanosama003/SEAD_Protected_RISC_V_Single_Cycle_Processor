module decoder (
    input  logic [10:0] data_in,
    input  logic [4:0]  parity, // parity[4]: overall parity

    output logic [10:0] data_corrected,
    output logic        double_error_flag
);

// Error index directly assigned
logic [3:0] error_index;
always_comb begin
    error_index[0] = parity[0] ^ data_in[1] ^ data_in[4] ^ data_in[8] ^ data_in[0] ^ data_in[3] ^ data_in[6] ^ data_in[10];
    error_index[1] = parity[1] ^ data_in[2] ^ data_in[5] ^ data_in[9] ^ data_in[0] ^ data_in[3] ^ data_in[6] ^ data_in[10];
    error_index[2] = parity[2] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10];
    error_index[3] = parity[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10];
end

// Overall parity calculation
logic overall_parity;
assign overall_parity = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^
                        data_in[8] ^ data_in[9] ^ data_in[10] ^ parity[0] ^ parity[1] ^ parity[2] ^ parity[3];

// Double-error detection flags
assign double_error_flag = (|error_index) & (~(parity[4] ^ overall_parity));

// Error inversion vector
logic [10:0] inversions;
always_comb begin
    case (error_index)
        4'b0011: inversions = 11'b00000000001;
        4'b0101: inversions = 11'b00000000010;
        4'b0110: inversions = 11'b00000000100;
        4'b0111: inversions = 11'b00000001000;
        4'b1001: inversions = 11'b00000010000;  
        4'b1010: inversions = 11'b00000100000;
        4'b1011: inversions = 11'b00001000000;
        4'b1100: inversions = 11'b00010000000;
        4'b1101: inversions = 11'b00100000000;
        4'b1110: inversions = 11'b01000000000;
        4'b1111: inversions = 11'b10000000000;
        default: inversions = 11'b00000000000; // No error
    endcase
end

// Corrected data calculation
assign data_corrected = data_in ^ inversions;

endmodule
