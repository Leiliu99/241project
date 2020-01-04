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

#reset everything
force {clk} 0 0ns, 1 {5ns} -r 10ns
force {resetn} 0
force {clear} 0
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
force {ld_colour} 0
force {ld_clear} 0
force {enable} 0
run 10ns

#don't reset
#load x value
#x:1010
#colour: 111
force {resetn} 1
force {clear} 0
force {data_in[9]} 1
force {data_in[8]} 1
force {data_in[7]} 1
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 1
force {data_in[2]} 0
force {data_in[1]} 1
force {data_in[0]} 0
force {ld_x} 1
force {ld_y} 0
force {ld_colour} 1
force {ld_clear} 0
force {enable} 1
run 20ns


#don't reset
#load y value
#y: 1110
#colour : 111
force {resetn} 1
force {clear} 0
force {data_in[9]} 1
force {data_in[8]} 1
force {data_in[7]} 1
force {data_in[6]} 0
force {data_in[5]} 0
force {data_in[4]} 0
force {data_in[3]} 1
force {data_in[2]} 1
force {data_in[1]} 1
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 1
force {ld_colour} 1
force {ld_clear} 0
force {enable} 1
run 20ns

force {resetn} 0
run 10ns

#don't reset
#load x value
#x:1010
#colour: 111
force {resetn} 1
force {clear} 0
force {data_in[9]} 1
force {data_in[8]} 1
force {data_in[7]} 0
force {data_in[6]} 0
force {data_in[5]} 1
force {data_in[4]} 0
force {data_in[3]} 1
force {data_in[2]} 0
force {data_in[1]} 1
force {data_in[0]} 0
force {ld_x} 1
force {ld_y} 0
force {ld_colour} 1
force {ld_clear} 0
force {enable} 1
run 20ns

#don't reset
#load y value
#y: 111000
#colour : 11
force {resetn} 1
force {clear} 0
force {data_in[9]} 1
force {data_in[8]} 1
force {data_in[7]} 0
force {data_in[6]} 1
force {data_in[5]} 1
force {data_in[4]} 1
force {data_in[3]} 1
force {data_in[2]} 0
force {data_in[1]} 0
force {data_in[0]} 0
force {ld_x} 0
force {ld_y} 1
force {ld_colour} 1
force {ld_clear} 0
force {enable} 1
run 20ns

#clear
force {ld_clear} 1
run 20ns



