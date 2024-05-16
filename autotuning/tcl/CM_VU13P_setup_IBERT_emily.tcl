################################################################################
#set_property PROBES.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
#set_property FULL_PROBES.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
#set_property PROGRAM.FILE {/scratch/disk2/rglein/vivado/CM_VU7P_125/CM_VU7P_125.runs/impl_1/example_ibert_ultrascale_gty_0.bit} [get_hw_devices xcvu7p_2]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcvu13p_0] 0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcvu13p_1] 0]

puts get_hw_sio_links

# Links
set mgt_tx_list [eval get_hw_sio_txs]
set mgt_rx_list [eval get_hw_sio_rxs]
set mgt_len [llength $mgt_tx_list]
remove_hw_sio_link [get_hw_sio_links]

# Links between FPGA
# set Txs {20,59}
# set Rxs {43,4}

#########
# FPGA1 #
#########

set TxFF1s {}
set RxFF1s {}
# reverse loopback
for {set t 4} {$t<10} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
}
for {set r 15} {$r>9} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF1s $rstring
}
# loopback
for {set t 20} {$t<32} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
    lappend RxFF1s $tstring
}
# reverse loopback
for {set t 48} {$t<54} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
}
for {set r 59} {$r>53} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF1s $rstring
}
# 4ch reverse loopback
# for {set t 36} {$t<38} {incr t} {
#     set tstring "X0Y$t/"
#     lappend TxFF1s $tstring
# }
# for {set r 37} {$r>35} {incr r -1} {
#     set rstring "X0Y$r/"
#     lappend RxFF1s $rstring
# }

puts $TxFF1s
puts $RxFF1s

set i 0
foreach Tx $TxFF1s Rx $RxFF1s {
    puts "MGT $i"
    puts [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Tx*] "*2542/0_1*"]
    puts [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Rx*] "*2542/0_1*"]
    set xil_newLink [create_hw_sio_link -description "MGT $i" [lindex [get_hw_sio_txs [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Tx*] "*2542/0_1*"]] 0] [lindex [get_hw_sio_rxs [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Rx*] "*2542/0_1*"]] 0]]
    lappend xil_newLinks $xil_newLink
    if {$Tx != $Rx} {
        incr i 1
        set xil_newLink1 [create_hw_sio_link -description "MGT $i" [lindex [get_hw_sio_txs [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Rx*] "*2542/0_1*"]] 0] [lindex [get_hw_sio_rxs [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Tx*] "*2542/0_1*"]] 0]]
        lappend xil_newLinks $xil_newLink1
    }
    incr i 1
    ;
}

#########
# FPGA2 #
#########

set TxFF2s {}
set RxFF2s {}
# loopback
for {set t 4} {$t<16} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
    lappend RxFF2s $tstring
}
# reverse loopback
for {set t 20} {$t<26} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
}
for {set r 31} {$r>25} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF2s $rstring
}
# reverse loopback
for {set t 48} {$t<54} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
}
for {set r 59} {$r>53} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF2s $rstring
}

set i 0
foreach Tx $TxFF2s Rx $RxFF2s {
    puts "MGT $i"
    puts [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Tx*] "*2542/1_1*"]
    puts [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Rx*] "*2542/1_1*"]
    set xil_newLink [create_hw_sio_link -description "MGT $i" [lindex [get_hw_sio_txs [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Tx*] "*2542/1_1*"]] 0] [lindex [get_hw_sio_rxs [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Rx*] "*2542/1_1*"]] 0]]
    lappend xil_newLinks $xil_newLink
    if {$Tx != $Rx} {
        incr i 1
        set xil_newLink1 [create_hw_sio_link -description "MGT $i" [lindex [get_hw_sio_txs [lsearch -all -inline [lsearch -all -inline $mgt_tx_list *$Rx*] "*2542/1_1*"]] 0] [lindex [get_hw_sio_rxs [lsearch -all -inline [lsearch -all -inline $mgt_rx_list *$Tx*] "*2542/1_1*"]] 0]]
        lappend xil_newLinks $xil_newLink1
    }
    incr i 1
    ;
}

# puts $mgt_tx_list

set xil_newLinkGroup [create_hw_sio_linkgroup -description {Link_Group_0} [get_hw_sio_links $xil_newLinks]]
unset xil_newLinks
eval get_hw_sio_links

################################################################################
# Transceivers
set_property TXDIFFSWING {530 mV (00101)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property TXPOST {0.00 dB (00000)}  [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property TXPRE {0.00 dB (00000)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property RXDFEENABLED 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# Reset channels
set_property LOGIC.TX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property LOGIC.TX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property LOGIC.RX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property LOGIC.RX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# PRBS Pattern
set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]

################################################################################
# TX Inhibit
#set_property PORT.TXINHIBIT 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
#commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups]]
