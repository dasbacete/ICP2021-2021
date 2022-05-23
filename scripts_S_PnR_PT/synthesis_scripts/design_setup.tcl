# Set the top_entity_name you want to do synthesis on
set DESIGN toptop_PnR 

set RTL "../src/VHDL/src"
set SYNTH_SCRIPTS "./"
set DATE [clock format [clock seconds] -format "%b%d-%T"]

set_attribute script_search_path $SYNTH_SCRIPTS 

set_attribute init_hdl_search_path $RTL

set_attribute init_lib_search_path { \
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPHVT_5.1/libs/ \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPHVT_3.1/libs/ \
/usr/local-eit/cad2/cmpstm/mem2011/SPHD110420-48158@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/LU_PADS_65nm/ \
} /

set_attribute library { \
CLOCK65LPHVT_wc_1.10V_m40C_10y.lib \
CORE65LPHVT_wc_1.10V_m40C_10y.lib \
SPHD110420_wc_1.10V_m40C_10y.lib \
Pads_Oct2012.lib } /

# put all your design files here
set Design_Files "toptop_PnR.vhd RW_RAM_mod.vhd Datapath.vhd HC_ROM.vhd input_register.vhd PE.vhd processing_block.vhd sg.vhd SRAM_SP_WRAPPER.vhd SPHD110420_FUNCT.vhd StateMachine.vhd Top.vhd"

set SYN_EFF high
set MAP_EFF high
set OPT_EFF high

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 9
