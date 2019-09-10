# script to connect to the FPGA board

open_hw
connect_hw_server
open_hw_target {localhost:3121/xilinx_tcf/Xilinx/00001631afcb01}

# configure the FPGA
set_property PROBES.FILE {/scratch/disk2/bartz/Apollo/vu7/Chip2Chip/Example/Example.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
set_property FULL_PROBES.FILE {/scratch/disk2/bartz/Apollo/vu7/Chip2Chip/Example/Example.runs/impl_1/example_ibert_ultrascale_gty_0.ltx} [get_hw_devices xcvu7p_2]
set_property PROGRAM.FILE {/scratch/disk2/bartz/Apollo/vu7/Chip2Chip/Example/Example.runs/impl_1/example_ibert_ultrascale_gty_0.bit} [get_hw_devices xcvu7p_2]

program_hw_devices [get_hw_devices xcvu7p_2]
refresh_hw_device [lindex [get_hw_devices xcvu7p_2] 0]
