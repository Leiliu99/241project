# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog VGA_display.v

#load simulation using mux as the top level simulation module
vsim control

#log all signals and add some signals to waveform window
log -r {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clk} 0 0ns, 1 {5ns} -r 10ns
force {resetn} 0
force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#load x
force {resetn} 1
force {keys[3]} 1
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#load y
force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 1
force {keys[0]} 0
run 10ns

force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#load x
force {keys[3]} 0
force {keys[2]} 1
force {keys[1]} 0
force {keys[0]} 0
run 10ns
force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#reset
force {resetn} 0
run 10ns

#not reset
#load x
force {resetn} 1
force {keys[3]} 1
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#load y
force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 1
force {keys[0]} 0
run 10ns

force {keys[3]} 0
force {keys[2]} 0
force {keys[1]} 0
force {keys[0]} 0
run 10ns

#clear screen
force {keys[3]} 0
force {keys[2]} 1
force {keys[1]} 0
force {keys[0]} 0
run 10ns