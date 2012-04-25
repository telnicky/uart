////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1.03
//  \   \         Application : sch2verilog
//  /   /         Filename : uart.vf
// /___/   /\     Timestamp : 04/23/2012 12:59:24
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family spartan2 -w E:/cs3700/cs3700final/uart.sch uart.vf
//Design Name: uart
//Device: spartan2
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module uart(clear, 
            clock, 
            receive, 
            data, 
            transmit);

    input clear;
    input clock;
    input receive;
   output [7:0] data;
   output transmit;
   
   wire XLXN_1;
   wire XLXN_2;
   wire [7:0] data_DUMMY;
   
   assign data[7:0] = data_DUMMY[7:0];
   receiver XLXI_1 (.ack(XLXN_2), 
                    .clk(clock), 
                    .clr(clear), 
                    .rcv(receive), 
                    .data(data_DUMMY[7:0]), 
                    .req(XLXN_1));
   sender XLXI_2 (.clk(clock), 
                  .clr(clear), 
                  .data(data_DUMMY[7:0]), 
                  .req(XLXN_1), 
                  .ack(XLXN_2), 
                  .xmt(transmit));
endmodule
