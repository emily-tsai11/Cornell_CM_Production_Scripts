set mgt_tx_list [eval get_hw_sio_txs]
set mgt_rx_list [eval get_hw_sio_rxs]
set mgt_len [llength $mgt_tx_list]
set mgt_link_list [eval get_hw_sio_links]

set date 05-16-24
# Modify this variable to correspond to current date before running, Example date: 01-19-22

set nfspath /afs/cern.ch/user/e/etsai/workspace/Cornell_CM_Production_Scripts/scans/apollo214/05-16-24
# Also, be sure to first create corresponding directories to save the scans to (e.g. /mnt/scratch/ad683/Cornell_CM_Production_Scripts/scans/CM203/01-19-22)

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
puts $TxFF1s
puts $RxFF1s
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

    puts "MGT $i"
    puts [lsearch -all -inline $mgt_link_list *2542/0_1*$Rx*->*2542/0_1*$Tx*]
    set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/0_1*$Rx*->*2542/0_1*$Tx*"]] 0 ]]
    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    incr i 1
    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    write_hw_sio_scan -force "${nfspath}/eyescan_${trimRx}(xcvu13p_0rx)_to_${trimTx}(xcvu13p_0tx)" [get_hw_sio_scans $xil_newScan]
    ;
}

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
puts $TxFF2s
puts $RxFF2s
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

    puts "MGT $i"
    puts [lsearch -all -inline $mgt_link_list *2542/1_1*$Rx*->*2542/1_1*$Tx*]
    set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/1_1*$Rx*->*2542/1_1*$Tx*"]] 0 ]]
    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    incr i 1
    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    write_hw_sio_scan -force "${nfspath}/eyescan_${trimRx}(xcvu13p_1tx)_to_${trimTx}(xcvu13p_1rx)" [get_hw_sio_scans $xil_newScan]
    ;
}
