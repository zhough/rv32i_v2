vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/blk_mem_gen_v8_4_12
vlib questa_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_12 questa_lib/msim/blk_mem_gen_v8_4_12
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_12  -incr -mfcu  "+incdir+../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" \
"../../../../rv32i_v2.gen/sources_1/ip/blk_mem_gen_1/sim/blk_mem_gen_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

