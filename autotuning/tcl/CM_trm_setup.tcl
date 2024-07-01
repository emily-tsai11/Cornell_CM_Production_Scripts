################################################################################
# set_property PROBES.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
# set_property FULL_PROBES.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
# set_property PROGRAM.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.bit} [get_hw_devices xcvu7p_2]
# program_hw_devices [get_hw_devices xcvu7p_2]
refresh_hw_device [lindex [get_hw_devices xcvu7p_2] 0]
# refresh_hw_device [lindex [get_hw_devices xcku15p_1] 0]

################################################################################
# Links
set mgt_tx_list [eval get_hw_sio_txs]
set mgt_rx_list [eval get_hw_sio_rxs]
set mgt_len [llength $mgt_tx_list]
remove_hw_sio_link [get_hw_sio_links]
for {set i 0} {$i<$mgt_len} {incr i} {
    set xil_newLink [create_hw_sio_link -description "MGT $i" [lindex $mgt_tx_list $i] [lindex $mgt_rx_list $i] ]
    lappend xil_newLinks $xil_newLink
}
set xil_newLinkGroup [create_hw_sio_linkgroup -description [get_hw_sio_links $xil_newLinks]]
unset xil_newLinks
eval get_hw_sio_links

################################################################################
# Transceivers
set_property TXDIFFSWING {780 mV (10000)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property TXPOST {0.00 dB (00000)}  [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property TXPRE {0.00 dB (00000)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property RXDFEENABLED 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# Reset channels
set_property PORT.GTRXRESET 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property PORT.GTRXRESET 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property PORT.GTRXRESET 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property PORT.GTRXRESET 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# PRBS Pattern
set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
# set_property TX_PATTERN {Slow Clk} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
# set_property RX_PATTERN {Slow Clk} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# TX Inhibit
# set_property PORT.TXINHIBIT 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
# commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
