transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/blk_mem_gen_v8_4_12
vlib activehdl/xil_defaultlib

vmap blk_mem_gen_v8_4_12 activehdl/blk_mem_gen_v8_4_12
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work blk_mem_gen_v8_4_12  -v2k5 "+incdir+../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" -l blk_mem_gen_v8_4_12 -l xil_defaultlib \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" -l blk_mem_gen_v8_4_12 -l xil_defaultlib \
"../../../../rv32i_v2.gen/sources_1/ip/blk_mem_gen_1/sim/blk_mem_gen_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

