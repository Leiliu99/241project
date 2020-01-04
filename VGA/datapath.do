# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog VGA_display.v

#load simulation using mux as the top level simulation module
vsim datapath

#log all signals and add some signals to waveform window
log -r {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clk} 0 0ns, 1 {5ns} -r 10ns

force {resetn} 0
force {data_in[9]} 0
force {data_in[8]} 0
force {data_in[7]} 0
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 0
force {data_in[2]} 0
force {data_in[1]} 0
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 0
run 10ns

force {resetn} 1
force {data_in[9]} 0
force {data_in[8]} 0
force {data_in[7]} 0
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 0
force {data_in[2]} 0
force {data_in[1]} 1
force {data_in[0]} 0
force {ld_x} 1
force {ld_y} 0
run 10ns

force {resetn} 1
force {data_in[9]} 1
force {data_in[8]} 0
force {data_in[7]} 0
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 0
force {data_in[2]} 1
force {data_in[1]} 0
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 1
run 10ns

force {resetn} 1
force {data_in[9]} 1
force {data_in[8]} 0
force {data_in[7]} 1
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 0
force {data_in[2]} 0
force {data_in[1]} 0
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 1
run 10ns

force {resetn} 0
force {data_in[9]} 0
force {data_in[8]} 0
force {data_in[7]} 0
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 0
force {data_in[2]} 0
force {data_in[1]} 0
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 0
run 10ns



