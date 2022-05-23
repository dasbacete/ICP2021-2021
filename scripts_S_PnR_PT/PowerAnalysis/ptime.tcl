####----------------------------------------------------------####
# Title        : primeTime Sample Script
# Project      : IC Project 1
####----------------------------------------------------------####
# File         : ptime.tcl
# Module Name  : 
# Project Root : 
# Author       : Masoud Nouripayam (ma1570no@eit.lth.se)
# Company      : Digital ASIC Group, EIT, LTH, Lund University
# Created      : 2020-03-02
# Last Edit    : 
# version      : 1
####----------------------------------------------------------####
# Description  : 
####----------------------------------------------------------####

##################  remove any previous designs 
remove_design -all


################### set up power analysis mode #####################
# step 0: Define Top Module name 
set_design_top toptop_PnR
set TOP toptop_PnR
################### set up power analysis mode #####################
# step 1: enalbe analysis mode 
set power_enable_analysis  true
set power_analysis_mode time_based

####################### set up libaries ############################
# step 2: link to your design libary 

### Make sure you choose the same files and paths as you have used in
### synthesis and pnr stage

set  search_path "\
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs \
/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/LU_PADS_65nm "

#/usr/local-eit/cad2/cmpstm/stm065v536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs 
#/usr/local-eit/cad2/cmpstm/stm065v536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/libs"

set link_path "* \
CORE65LPHVT_wc_1.10V_m40C_10y.db \
CLOCK65LPHVT_wc_1.10V_m40C_10y.db \
SPHD110420_wc_1.10V_m40C_10y.db \
Pads_Oct2012.db "

#IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_1.05V_1.65V_m40C.db \ 
#IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_wc_1.05V_m40C.db \


####################### design input    ############################
# step 3: read your design (netlist) & link design
read_verilog "../PnR_outs/toptop_PnR_lp_v1.v"
current_design $TOP
link_design -force
#link_design $TOP -force
#link_design -force -verbose

#return ()
####################### timing constraint ##########################
# step 4: setup timing constraint (or read sdc file)
source ../PnR_outs/toptop_lp.sdc

####################### Back annotate     ##########################
# step 5: back annotate delay information (read sdf file)
read_parasitics ../PnR_outs/toptop_PnR_lp_v1.spef
#read_sdf -type sdf_max ../PnR/PnR_outs/toptop_PnR_lp_v1.spf
read_sdf ../PnR_outs/toptop_PnR_lp.sdf
################# read switching activity file #####################
# step 6: read vcd file obtained from post-layout (syn) simulation
#read_vcd -strip_path "/[string Top_inst latency_improvement_tb/UUT]" ./PT_outs/toptop_PnR.vcd
read_vcd -strip_path  latency_improvement_tb/UUT ./toptop_lp.vcd
####################### analysis and report #################
# step 7: Analysis the power
check_power
update_power

####################### report  #################
# step 8: output report
report_power -verbose > PT_outs/power.rpt
report_timing -delay_type min -max_paths 10 > PT_outs/timing_hold.rpt
report_timing -delay_type max -max_paths 10 > PT_outs/timing_setup.rpt
