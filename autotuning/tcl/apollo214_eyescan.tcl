set mgt_tx_list [eval get_hw_sio_txs]
set mgt_rx_list [eval get_hw_sio_rxs]
set mgt_len [llength $mgt_tx_list]
set mgt_link_list [eval get_hw_sio_links]

set nfspath /afs/cern.ch/user/e/etsai/workspace/Cornell_CM_Production_Scripts/scans/apollo214/24-08-06
# Also, be sure to first create corresponding directories to save the scans to (e.g. scans/apollo214/24-07-19)

#########
# FPGA1 #
#########

set TxFF1s {}
set RxFF1s {}
# Reverse loopback on F1_1
for {set t 4} {$t<10} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
}
for {set r 15} {$r>9} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF1s $rstring
}
# Loopback on F1_2
for {set t 20} {$t<32} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
    lappend RxFF1s $tstring
}
# Reverse loopback on F1_3
for {set t 48} {$t<54} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
}
for {set r 59} {$r>53} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF1s $rstring
}
# 4ch loopback on F1_6
for {set t 36} {$t<40} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF1s $tstring
    lappend RxFF1s $tstring
}

# puts $TxFF1s
# puts $RxFF1s

set i 0
foreach Tx $TxFF1s Rx $RxFF1s {
    puts "MGT $i"
    puts [lsearch -all -inline $mgt_link_list *2542/0_1*$Tx*->*2542/0_1*$Rx*]
    set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/0_1*$Tx*->*2542/0_1*$Rx*"]] 0 ]]
    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    incr i 1
    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    set trimTx [string trim $Tx "/"]
    set trimRx [string trim $Rx "/"]
    write_hw_sio_scan -force "${nfspath}/eyescan_${trimTx}(xcvu13p_0tx)_to_${trimRx}(xcvu13p_0rx)" [get_hw_sio_scans $xil_newScan]

    if {$Tx != $Rx} {
        puts "MGT $i"
        puts [lsearch -all -inline $mgt_link_list *2542/0_1*$Rx*->*2542/0_1*$Tx*]
        set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/0_1*$Rx*->*2542/0_1*$Tx*"]] 0 ]]
        set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
        set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
        run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        incr i 1
        wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        write_hw_sio_scan -force "${nfspath}/eyescan_${trimRx}(xcvu13p_0tx)_to_${trimTx}(xcvu13p_0rx)" [get_hw_sio_scans $xil_newScan]
    }
    ;
}

#########
# FPGA2 #
#########

set TxFF2s {}
set RxFF2s {}
# Loopback on F2_1
for {set t 4} {$t<16} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
    lappend RxFF2s $tstring
}
# Reverse loopback on F2_2
for {set t 20} {$t<26} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
}
for {set r 31} {$r>25} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF2s $rstring
}
# Reverse loopback on F2_3
for {set t 48} {$t<54} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
}
for {set r 59} {$r>53} {incr r -1} {
    set rstring "X0Y$r/"
    lappend RxFF2s $rstring
}
# 4ch loopback on F2_6
for {set t 36} {$t<40} {incr t} {
    set tstring "X0Y$t/"
    lappend TxFF2s $tstring
    lappend RxFF2s $tstring
}

# puts $TxFF2s
# puts $RxFF2s

set i 0
foreach Tx $TxFF2s Rx $RxFF2s {
    puts "MGT $i"
    puts [lsearch -all -inline $mgt_link_list *2542/1_1*$Tx*->*2542/1_1*$Rx*]
    set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/1_1*$Tx*->*2542/1_1*$Rx*"]] 0 ]]
    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    incr i 1
    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    set trimTx [string trim $Tx "/"]
    set trimRx [string trim $Rx "/"]
    write_hw_sio_scan -force "${nfspath}/eyescan_${trimTx}(xcvu13p_1tx)_to_${trimRx}(xcvu13p_1rx)" [get_hw_sio_scans $xil_newScan]

    if {$Tx != $Rx} {
        puts "MGT $i"
        puts [lsearch -all -inline $mgt_link_list *2542/1_1*$Rx*->*2542/1_1*$Tx*]
        set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/1_1*$Rx*->*2542/1_1*$Tx*"]] 0 ]]
        set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
        set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
        run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        incr i 1
        wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        write_hw_sio_scan -force "${nfspath}/eyescan_${trimRx}(xcvu13p_1tx)_to_${trimTx}(xcvu13p_1rx)" [get_hw_sio_scans $xil_newScan]
    }
    ;
}

##################
# FPGA1 & FPGA2 #
##################

# set TxFF12s {}
# set RxFF12s {}
# set TxFF21s {}
# set RxFF21s {}
# F1_1 Tx to F2_2 Rx (reverse loopback)
# for {set t 4} {$t<16} {incr t} {
#     set tstring "X0Y$t/"
#     lappend TxFF12s $tstring
# }
# for {set r 31} {$r>19} {incr r -1} {
#     set rstring "X0Y$r/"
#     lappend RxFF12s $rstring
# }
# F2_2 Tx to F1_1 Rx (reverse loopback)
# for {set t 20} {$t<32} {incr t} {
#     set tstring "X0Y$t/"
#     lappend TxFF21s $tstring
# }
# for {set r 15} {$r>3} {incr r -1} {
#     set rstring "X0Y$r/"
#     lappend RxFF21s $rstring
# }

# puts $TxFF12s
# puts $RxFF12s
# puts $TxFF21s
# puts $RxFF21s

# set i 0
# foreach Tx $TxFF12s Rx $RxFF12s {
#     puts "MGT $i"
#     puts [lsearch -all -inline $mgt_link_list *2542/0_1*$Tx*->*2542/1_1*$Rx*]
#     set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/0_1*$Tx*->*2542/1_1*$Rx*"]] 0 ]]
#     set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
#     set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
#     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
#     incr i 1
#     wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
#     set trimTx [string trim $Tx "/"]
#     set trimRx [string trim $Rx "/"]
#     write_hw_sio_scan -force "${nfspath}/eyescan_${trimTx}(xcvu13p_0tx)_to_${trimRx}(xcvu13p_1rx)" [get_hw_sio_scans $xil_newScan]
# }
# set i 0
# foreach Tx $TxFF21s Rx $RxFF21s {
#     puts "MGT $i"
#     puts [lsearch -all -inline $mgt_link_list *2542/1_1*$Tx*->*2542/0_1*$Rx*]
#     set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/1_1*$Tx*->*2542/0_1*$Rx*"]] 0 ]]
#     set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
#     set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
#     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
#     incr i 1
#     wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
#     set trimTx [string trim $Tx "/"]
#     set trimRx [string trim $Rx "/"]
#     write_hw_sio_scan -force "${nfspath}/eyescan_${trimTx}(xcvu13p_1tx)_to_${trimRx}(xcvu13p_0rx)" [get_hw_sio_scans $xil_newScan]
# }
