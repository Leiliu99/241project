vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog audiotuner.v

#load simulation using mux as the top level simulation module
vsim compareWithNote
log {/*}
#log all signals a
add wave {/*}
add wave {allData}
add wave {fA4/*}

force {clock} 0 0ns, 1 {5ns} -r 10ns
force {compare/fn/finalResult} 0 0 -cancel 0
force {compare/allData} 0 0 -cancel 0
force {compare/fCs5/max} 0 0 -cancel 0
#-2: {1111111111111111111111111111111111111111111110}
force {compare/fCs5/min} 0 0 -cancel 0
force {compare/fCs5/sampleOf20} 0 0 -cancel 0

force {compare/Cs5arr} 0 0 -cancel 0
force {compare/deltaA4} 0 0 -cancel 0
force {compare/deltaAs4} 0 0 -cancel 0
force {compare/deltaB4} 0 0 -cancel 0
force {compare/deltaC5} 0 0 -cancel 0
force {compare/deltaCs5} 0 0 -cancel 0
force {compare/deltaD5} 0 0 -cancel 0
force {compare/deltaDs5} 0 0 -cancel 0
force {compare/deltaE5} 0 0 -cancel 0
force {compare/deltaF5} 0 0 -cancel 0
force {compare/deltaFs5} 0 0 -cancel 0
force {compare/deltaG5} 0 0 -cancel 0
force {compare/deltaGs5} 0 0 -cancel 0
force {compare/deltaA5} 0 0 -cancel 0

force {compare/enable} 0 0 -cancel 0
force {compare/isUpdateArr} 0 0 -cancel 0
force {compare/fCs5/count} 0 0 -cancel 0
force {compare/fCs5/isCalculating} 0 0 -cancel 0
#force {fA4/isComparing} 1 0 -cancel 0
#force {compare/temp} 1 0 -cancel 0

force {compare/weightedData} {1111111111111111111111111111111111111111111111}
#-1
run 250ns

force {compare/weightedData} {10#256}
run 250ns

force {compare/weightedData} {1111111111111111111111111111111111111110000101}
#-123
run 250ns
force {compare/weightedData} {1111111111111111111111111111111111111111111011}
#-5
run 250ns

force {compare/weightedData} {10#128}
run 250ns

force {compare/weightedData} {1111111111111111111111111111111111111111111101}
#-3
run 250ns
force {compare/weightedData} {1111111111111111111111111111111111111010011100}
#-356
run 250ns
#force {weightedData} {1111111111111111111111111111111111111110101000}
#-88
#run 250ns



