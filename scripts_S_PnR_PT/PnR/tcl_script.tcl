# POWER NETS
globalNetConnect VDD -type pgpin -pin VDDC -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect GND -type pgpin -pin GNDC -inst *
globalNetConnect GND -type tielo -inst *

#RESIZING FOORPLAN
floorPlan -site CORE -s 304.8 154.8 78.0 153.2 78.2 153.0

#MEMORY MOVE
setObjFPlanBox Instance TOP_inst/RAM_inst/MEM_inst_DUT_ST_SPHDL_160x32_mem2011 153.499 342.5 458.299 383.5
#ADD HALO
addHaloToBlock {10 10 10 10} -allBlock

#CUT CORE ROWS
selectInst TOP_inst/RAM_inst/MEM_inst_DUT_ST_SPHDL_160x32_mem2011
cutRow -selected
#RINGS
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 2.5 -threshold 2.5 -nets {VDD GND} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 10
deselectAll
selectInst TOP_inst/RAM_inst/MEM_inst_DUT_ST_SPHDL_160x32_mem2011
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -around selected -jog_distance 2.5 -threshold 2.5 -type block_rings -nets {VDD GND} -follow core -stacked_via_bottom_layer M1 -layer {bottom M3 top M3 right M4 left M4} -width 2 -spacing 2 -offset 10
#ADD STRIPES
#VERTICAL
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M5 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M3 -number_of_sets 1 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M5 -spacing 2 -xleft_offset 150 -xright_offset 146 -merge_stripes_value 2.5 -layer M4 -block_ring_bottom_layer_limit M3 -width 2 -nets {VDD GND} -stacked_via_bottom_layer M1
#HORIZONTAL
addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M4 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M2 -number_of_sets 1 -ybottom_offset 47 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M4 -spacing 2 -merge_stripes_value 2.5 -direction horizontal -layer M3 -block_ring_bottom_layer_limit M2 -width 2 -nets {VDD GND} -stacked_via_bottom_layer M1

#WELLTAP
addWellTap -cell HS65_LS_FILLERNPWPFP4 -cellInterval 25 -prefix WELLTAP

#PLACE STANDARD CELLS
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign


#OPTIMIZATION PRE CTS

redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_preCTS -outDir timingReports/preCTS
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_preCTS -outDir timingReports/preCTS


#CLOCKTREE
createClockTreeSpec -bufferList {HS65_LH_CNBFX10 HS65_LH_CNBFX103 HS65_LH_CNBFX124 HS65_LH_CNBFX14 HS65_LH_CNBFX17 HS65_LH_CNBFX21 HS65_LH_CNBFX24 HS65_LH_CNBFX27 HS65_LH_CNBFX31 HS65_LH_CNBFX34 HS65_LH_CNBFX38 HS65_LH_CNBFX38_0 HS65_LH_CNBFX38_1 HS65_LH_CNBFX38_10 HS65_LH_CNBFX38_11 HS65_LH_CNBFX38_12 HS65_LH_CNBFX38_13 HS65_LH_CNBFX38_14 HS65_LH_CNBFX38_15 HS65_LH_CNBFX38_16 HS65_LH_CNBFX38_17 HS65_LH_CNBFX38_18 HS65_LH_CNBFX38_19 HS65_LH_CNBFX38_2 HS65_LH_CNBFX38_20 HS65_LH_CNBFX38_21 HS65_LH_CNBFX38_22 HS65_LH_CNBFX38_23 HS65_LH_CNBFX38_3 HS65_LH_CNBFX38_4 HS65_LH_CNBFX38_5 HS65_LH_CNBFX38_6 HS65_LH_CNBFX38_7 HS65_LH_CNBFX38_8 HS65_LH_CNBFX38_9 HS65_LH_CNBFX41 HS65_LH_CNBFX45 HS65_LH_CNBFX48 HS65_LH_CNBFX52 HS65_LH_CNBFX55 HS65_LH_CNBFX58 HS65_LH_CNBFX62 HS65_LH_CNBFX82 HS65_LH_CNIVX10 HS65_LH_CNIVX103 HS65_LH_CNIVX124 HS65_LH_CNIVX14 HS65_LH_CNIVX17 HS65_LH_CNIVX21 HS65_LH_CNIVX24 HS65_LH_CNIVX27 HS65_LH_CNIVX3 HS65_LH_CNIVX31 HS65_LH_CNIVX34 HS65_LH_CNIVX38 HS65_LH_CNIVX41 HS65_LH_CNIVX45 HS65_LH_CNIVX48 HS65_LH_CNIVX52 HS65_LH_CNIVX55 HS65_LH_CNIVX58 HS65_LH_CNIVX62 HS65_LH_CNIVX7 HS65_LH_CNIVX82} -file Clock.ctstch
clockDesign -specFile Clock.ctstch -outDir clock_report
deleteTrialRoute
ccopt_design
#IOFILLER
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side n
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side s
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side w
addIoFiller -cell PADSPACE_74x1u -prefix FILLER -side e
#POST CTS OPTIMIZATION
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_postCTS -outDir timingReports/postCTS/setup
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 50 -prefix toptop_PnR_postCTS -outDir timingReports/postCTS/hold

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -hold
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postCTS -hold -incr
setOptMode -effort high -leakagePowerEffort none -dynamicPowerEffort none -reclaimArea true -simplifyNetlist true -allEndPoints false -setupTargetSlack 0 -holdTargetSlack 0 -maxDensity 0.99 -drcMargin 0 -usefulSkew false
setEndCapMode -reset
setEndCapMode -boundary_tap false
setOptMode -fixCap false -fixTran false -fixFanoutLoad false
optDesign -postCTS -hold -incr

redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_postCTS -outDir timingReports/postCTS/setup
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -hold -pathReports -slackReports -numPaths 50 -prefix toptop_PnR_postCTS -outDir timingReports/postCTS/hold


#ROUTING
#POWER
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M1 AP } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 AP } -nets { VDD GND } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 AP }
#NETS
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
#POST ROUTE OPTIMIZATION
setAnalysisMode -analysisType onChipVariation -cppr both

redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_postRoute -outDir timingReports/postRoute/setup
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix toptop_PnR_postRoute -outDir timingReports/postRoute/hold

setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute 
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute -hold


redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix toptop_PnR_postRoute -outDir timingReports/postRoute/setup
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix toptop_PnR_postRoute -outDir timingReports/postRoute/hold

#ADDFILLER
addFiller -cell HS65_LH_FILLERPFP4 -prefix FILLERPFOP64 -markFixed
addFiller -cell HS65_LH_FILLERPFP3 -prefix FILLERPFOP64 -markFixed
addFiller -cell HS65_LH_FILLERPFP2 -prefix FILLERPFOP64 -markFixed
addFiller -cell HS65_LH_FILLERPFP1 -prefix FILLERPFOP64 -markFixed


#SAVE DESIGN AND OUTS

saveNetlist PnR_outs/toptop_PnR_lp_v1.v
saveDesign PnR_outs/toptop_PnR.enc
all_hold_analysis_views 
all_setup_analysis_views 
rcOut -setload PnR_outs/toptop_PnR_lp_v1.setload -rc_corner SS
rcOut -setres PnR_outs/toptop_PnR_lp_v1.setres -rc_corner SS
rcOut -spf PnR_outs/toptop_PnR_lp_v1.spf -rc_corner SS
rcOut -spef PnR_outs/toptop_PnR_lp_v1.spef -rc_corner SS
write_sdf -version 2.1 -interconn nooutport PnR_outs/toptop_PnR_lp.sdf
write_sdc > PnR_outs/toptop_lp.sdc
