onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Single_Cycle_TB/clk
add wave -noupdate /Single_Cycle_TB/reset
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/WriteData
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/DataAddr
add wave -noupdate -divider {PC Signals}
add wave -noupdate -color Yellow -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/PC_inst/corrected_count
add wave -noupdate -color Yellow -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/PC_inst/count
add wave -noupdate -divider {Reg File Signals}
add wave -noupdate /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/data_reg_file/registers
add wave -noupdate -color {Medium Orchid} {/Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/data_reg_file/registers[3]}
add wave -noupdate -color {Medium Orchid} -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/RD1_corrected
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/RD2_corrected
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/read_addr1
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/read_addr2
add wave -noupdate -radix hexadecimal /Single_Cycle_TB/DUT/core_top/Datapath/Register_inst/write_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93236 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {27780 ps} {124906 ps}
