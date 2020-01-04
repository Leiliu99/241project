
vlib work

vlog multiplier.v
vlog calculation/out440.v
vlog calculation/calculation.v
vlog audiotuner.v

vsim -L altera_mf_ver -L lpm_ver -L lpm calculation

log -r {/*}
add wave {/*}
force {pre_magnitude} 0 0 -cancel 0
force {register_magnitude} 0 0 -cancel 0
force {currentAdd} {10#5567} 0 -cancel 0
force {address} 0 0 -cancel 0
force {sum} 0 0 -cancel 0

force {clk} 0 0ns, 1 {5ns} -r 10ns



force {resetn} 1
run 10ns

force {resetn} 0
force {magnitude} {11111111111111111111111110000101}
run 1770ns

force {magnitude} {10#256}
run 3540ns

force {magnitude} {10#1}
run 1770ns
force {magnitude} {10#2}
run 1770ns
force {magnitude} {10#3}
run 1770ns
force {magnitude} {10#4}
run 2000ns
