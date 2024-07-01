# Script compares chip to sim

import os
import readline

# --------------------------------------------------------------------------- #
# File Format:                                                                #
# TXDIFFSWING,TXPRE,TXPOST,RXTERM,Error_Count,Open Area,N Bits                #
# name: defaultTxEq_RxX0Y16_TxX0Y16_ErrReq5000_BER1e-6_Bathtub.csv            #
# 530 mV (00101),0.01 dB (00000),0.00 dB (00000),800 mV,0,68.75,434712880     #
# 530 mV (00101),0.01 dB (00000),2.28 dB (01001),800 mV,0,70.3125,396994560   #
# 530 mV (00101),0.01 dB (00000),3.99 dB (01111),800 mV,0,70.3125,409309200   #
# 530 mV (00101),0.01 dB (00000),5.81 dB (10100),800 mV,16960,0               #
# --------------------------------------------------------------------------- #


results_dir = "../results/05-23-24/"
# TxEqs_12 = ["defaultTxEq", "TxEqBin1_", "TxEqBin2_", "TxEqBin3_", "TxEqBin4_"]
TxEqs_12 = ["eyes"]
TxEqs_4 = ["TxEqBin1_", "defaultTxEq", "TxEqBin2_", "TxEqBin3_", "TxEqBin4_"]
# TXEQs_12 = ["0", "1", "2", "4", "7"]
TXEQs_12 = ["0"]
TXEQs_4 = ["1.3", "2.7", "3.7", "6.5", "8.8"] 
# TXDIFFSWINGs = ["530 mV (00101)", "950 mV (11000)", "1040 mV (11111)"]
TXDIFFSWINGs = ["390 mV (00000)", "530 mV (00101)", "870 mV (10100)"]
# TXDIFFSWINGs = ["530 mV (00101)", "390 mV (00000)", "870 mV (10100)"]
# TXDIFFSWINGs = ["530 mV (00101)"]
TXPOSTs = ["0.00 dB (00000)", "2.21 dB (01001)", "4.08 dB (01111)", "6.02 dB (10100)"]
# TXPOSTs = ["0.00 dB (00000)", "6.02 dB (10100)"]
TXPREs = ["0.00 dB (00000)", "2.21 dB (01001)", "4.08 dB (01111)"]
# TXPREs = ["0.00 dB (00000)", "4.08 dB (01111)"]
ff_4 = ["X0Y16", "X0Y17", "X0Y18", "X0Y19", "X0Y32", "X0Y33", "X0Y34", "X0Y35"]
# ff_12 = ["X0Y48", "X0Y49", "X0Y50", "X0Y51", "X0Y52", "X0Y53", "X0Y54", "X0Y55", "X0Y56", "X0Y57", "X0Y58", "X0Y59"]
ff_12_rx = ["X0Y48", "X0Y49"]
# ff_12_rx = ["X0Y48", "X0Y49", "X0Y50", "X0Y51", "X0Y52", "X0Y53", "X0Y54", "X0Y55", "X0Y56", "X0Y57", "X0Y58", "X0Y59"]
# ff_12_rx = ["X0Y20", "X0Y21", "X0Y22", "X0Y23", "X0Y24", "X0Y25", "X0Y26", "X0Y27", "X0Y28", "X0Y29", "X0Y30", "X0Y31"]
ff_12_tx = ["X0Y59", "X0Y58"]
# ff_12_tx = ["X0Y59", "X0Y58", "X0Y57", "X0Y56", "X0Y55", "X0Y54", "X0Y53", "X0Y52", "X0Y51", "X0Y50", "X0Y49", "X0Y48"]
# ff_12_tx = ["X0Y20", "X0Y21", "X0Y22", "X0Y23", "X0Y24", "X0Y25", "X0Y26", "X0Y27", "X0Y28", "X0Y29", "X0Y30", "X0Y31"]

# Nlinks_noerrors = [[[[],[],[]],[[],[],[]],[[],[],[]]],[[[],[],[]],[[],[],[]],[[],[],[]]],[[[],[],[]],[[],[],[]],[[],[],[]]],[[[],[],[]],[[],[],[]],[[],[],[]]],[[[],[],[]],[[],[],[]],[[],[],[]]]]
Nlinks_noerrors = [[ [ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ] ], [ [ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ] ], [ [ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ],[ [],[],[],[],[] ] ]]
Nlinks_noerrors_np = [[], [], [], [], [], [], [], [], [], [], [], []]
# Nlinks_noerrors_np = [[], [], [], []]
# Nlinks_noerrors_np = [[], []]


a = 0
for TxPre in TXPREs:
    b = 0
    for TxPost in TXPOSTs:
        c = 0
        for TxEq in TxEqs_12:
            d = 0
            for TxDiff in TXDIFFSWINGs:
                line_string = TxDiff+","+TxPre+","+TxPost
                nlinks = 0
                for iff, ff_rx in enumerate(ff_12_rx):
                    # print("../results/"+TxEq+"_Rx"+ff_rx+"_Tx"+ff_12_tx[iff]+"_ErrReq5000_BER1e-5_Bathtub.csv")
                    file_ff = open(results_dir+TxEq+"_Rx"+ff_rx+"_Tx"+ff_12_tx[iff]+"_ErrReq5000_BER1e-5_Bathtub.csv", 'r')
                    while file_ff:
                        line  = file_ff.readline()
                        if line_string in line:
                            if int(line.split(",")[4]) == 0:
                                nlinks += 1
                            break
                    file_ff.close()
                print(TXEQs_12[c]+","+line_string, ": ", nlinks)
                Nlinks_noerrors[a][b][c].append(nlinks)
                Nlinks_noerrors_np[4*a+b].append(nlinks)
                d += 1
            c += 1
        b += 1
    a += 1

print(Nlinks_noerrors)
print(Nlinks_noerrors_np)
