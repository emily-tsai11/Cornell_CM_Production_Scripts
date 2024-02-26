set mgt_tx_list [eval get_hw_sio_txs]
set mgt_rx_list [eval get_hw_sio_rxs]
set mgt_len [llength $mgt_tx_list]
set mgt_link_list [eval get_hw_sio_links]

set date 02-26-24
# Modify this variable to correspond to current date before running, Example date: 01-19-22

set nfspath /afs/cern.ch/user/e/etsai/workspace/Cornell_CM_Production_Scripts/autotuning/results/02-26-24
# Also, be sure to first create corresponding directories to save the scans to (e.g. /mnt/scratch/ad683/Cornell_CM_Production_Scripts/scans/CM203/01-19-22)

# Links between FPGA (Tx are the ones from FPGA1, Rxs are from FPGA2)
set Txs {}
set Rxs {}

# FFs FPGA1 - FPGA2
for {set t 20} {$t<32} {incr t} {
    set tstring "X0Y$t/"
    lappend Txs $tstring
}

for {set r 20} {$r<32} {incr r} {
    set rstring "X0Y$r/"
    lappend Rxs $rstring
}

puts $Txs
puts $Rxs

set i 0
foreach Tx $Txs Rx $Rxs {
    puts "MGT $i"
    puts $Tx
    puts $Rx
    puts [lsearch -all -inline $mgt_link_list *2542/0_1*$Tx*->*2542/1_1*$Rx*]
    set xil_newScan [create_hw_sio_scan -description {Scan $i} 2d_full_eye  [lindex [get_hw_sio_links [lsearch -all -inline $mgt_link_list "*2542/0_1*$Tx*->*2542/0_1*$Rx*"]] 0 ]]
    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    set_property VERTICAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    incr i 1
    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
    set trimTx [string trim $Tx "/"]
    set trimRx [string trim $Rx "/"]
    write_hw_sio_scan -force "${nfspath}/eyescan_${trimTx}(xcvu13p_0)_to_${trimRx}(xcvu13p_1)" [get_hw_sio_scans $xil_newScan]
    ;
}
