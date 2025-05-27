module reg_file (
    input logic clk,               // Clock signal
    input logic rstN,              // Reset signal
    input logic [4:0] read_addr1,  // Read address 1
    input logic [4:0] read_addr2,  // Read address 2
    input logic [4:0] write_addr,  // Write address
    input logic [31:0] write_data, // Data to write
    input logic write_enable,      // Write enable signal

    output logic [31:0] read_data1, // Output data for read address 1
    output logic [31:0] read_data2  // Output data for read address 2
);

logic [31:0] registers [31:0]; // Register array

// Combinational read logic
always_comb begin
    read_data1 = (read_addr1 == 5'b0) ? 32'd0 : registers[read_addr1];
    read_data2 = (read_addr2 == 5'b0) ? 32'd0 : registers[read_addr2];
end

// Synchronous reset and write logic
always_ff @(posedge clk or negedge rstN) begin
    if (!rstN) begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'b0;
        end
    end else if (write_enable && write_addr != 5'd0) begin
        registers[write_addr] <= write_data;
    end
end

endmodule 