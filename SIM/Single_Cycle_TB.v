`timescale 1ns / 1ps
// Single Cycle RISC-V Processor by Sai Govardhan
// mail: saigov14@gmail.com or saigovardhanmc@pesu.pes.edu

module Single_Cycle_TB();

reg clk = 0, reset;
wire [31:0] WriteData, DataAddr;
wire MemWrite;

always #10 clk = ~clk;

Single_Cycle_Top DUT(
	.clk(clk),
	.reset(reset),
	.WriteData(WriteData),
	.DataAddr(DataAddr),
	.MemWrite(MemWrite)
);
  
initial begin
    reset = 1; 
	#20; 
    reset = 0;
    #40;
    force DUT.core_top.Datapath.PC_inst.count[31] = ~DUT.core_top.Datapath.PC_inst.count[31];
    force DUT.core_top.Datapath.PC_inst.count[30] = ~DUT.core_top.Datapath.PC_inst.count[30];
    force DUT.core_top.Datapath.PC_inst.count[29] = ~DUT.core_top.Datapath.PC_inst.count[29];
    repeat (1) @ (posedge clk);
    release DUT.core_top.Datapath.PC_inst.count[31];
    release DUT.core_top.Datapath.PC_inst.count[30];
    release DUT.core_top.Datapath.PC_inst.count[29];
    #20;
    force DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][31] = ~DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][31];
    force DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][30] = ~DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][30];
    force DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][29] = ~DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][29];
    repeat (1) @ (posedge clk);
    release DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][31];
    release DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][30];
    release DUT.core_top.Datapath.Register_inst.data_reg_file.registers[3][29];
end


always@(posedge clk)  begin
    if(MemWrite) begin
      if(DataAddr == 100 & WriteData == 25) begin
        $display("PASSED: Data 25 written when Data Address is 100");
        $stop;
      end else if (DataAddr != 96) begin
        $display("FAILED");
        $stop;
      end
    end
end

endmodule