vlib work

vlog -sv "../RTL/protection/*.sv"
vlog "../RTL/*.v"
vlog Single_Cycle_TB.v
vsim -voptargs=+acc work.Single_Cycle_TB

do wave.do

run -all