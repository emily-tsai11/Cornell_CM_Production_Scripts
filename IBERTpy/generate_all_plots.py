# -*- coding: utf-8 -*-
"""
Created on Fri Jul 21 16:40:12 2017

@author: msilvaol
"""

from eyescan_plot import eyescan_plot
from glob import glob
import argparse
import datetime
import os.path
import numpy as np

minlog10ber = -8
overwrite = True

fmt='%m-%d-%Y'
timestamp = datetime.datetime.now().strftime(fmt) 
print(timestamp)

parser = argparse.ArgumentParser()
parser.add_argument('CMXX', type=int, help="specified CM##")            
parser.add_argument('fpgaX', type=int, help="specified fpga# (1 or 2)")
args = parser.parse_args()

CM = args.CMXX
fpga = args.fpgaX  

filename_i_list = glob('../scans/CM'+str(CM).zfill(2)+'/fpga'+str(fpga)+'/'+str(timestamp)+'/*.csv') # ---------------> need to be modified as a variable input
print(filename_i_list)
filename_o_list = [p.replace('csv','pdf') for p in filename_i_list]

yticks = list(np.arange(-127,0,16))+[0]+list(np.arange(127,0,-16))[-1::-1]
xticks = list(np.arange(-0.5,0.625,0.125))
k=1
#if os.path.exists('..\scans\eyedata.csv'):
#    pass
#else
#    eyedict

for i,o in zip(filename_i_list, filename_o_list):
    print('Saving file {0:03d} out of {1:d}.'.format(k,len(filename_i_list)))
    if (not os.path.exists(o)) or overwrite:
        eyescan_plot(i, o, minlog10ber, colorbar=True, xaxis=True, yaxis=True, xticks_f=xticks, yticks_f=yticks, mask_x1x2x3y1y2=(0.25, 0.4, 0.45, 0.25, 0.28))
    k += 1
    #break
