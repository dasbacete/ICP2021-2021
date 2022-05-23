

set SYNT_OUT       "Synth_outs"
set SYNT_REPORT    "Synth_reports"



puts "\n\n\n DESIGN FILES \n\n\n"
source design_setup.tcl

puts "\n\n\n ANALYZE HDL DESIGN \n\n\n"
read_hdl -vhdl ${Design_Files}
puts "\n\n\n ELABORATE \n\n\n"
elaborate ${DESIGN}

check_design
report timing -lint

puts "\n\n\n TIMING CONSTRAINTS \n\n\n"
source create_clock.tcl

puts "\n\n\n SYN_GENERIC \n\n\n"
syn_generic

puts "\n\n\n SYN_MAP \n\n\n"
syn_map

puts "\n\n\n SYN_OPT \n\n\n"
syn_opt

puts "\n\n\n EXPORT DESIGN \n\n\n"
write_hdl    > Synth_outs/top_lp.v
write_sdc    > Synth_outs/Top_lp.sdc
write_sdf   -version 2.1  > Synth_outs/Top_lp.sdf

puts "\n\n\n REPORTING \n\n\n"
report qor      > $SYNT_REPORT/qor_${DESIGN}.rpt
report area     > $SYNT_REPORT/area_${DESIGN}.rpt
report datapath > $SYNT_REPORT/datapath_${DESIGN}.rpt
report messages > $SYNT_REPORT/messages_${DESIGN}.rpt
report gates    > $SYNT_REPORT/gates_${DESIGN}.rpt
report timing   > $SYNT_REPORT/timing_${DESIGN}.rpt

report_summary -outdir $SYNT_REPORT