transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog  -work work +incdir+D:/Model_sim/14\ days\ development\ series/Adder-implementation {D:/Model_sim/14 days development series/Adder-implementation/ripple_carry_adder.v}
vlog  -work work +incdir+D:/Model_sim/14\ days\ development\ series/Adder-implementation {D:/Model_sim/14 days development series/Adder-implementation/full_adder.v}

