VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_2
        SIGNAL data(7:0)
        SIGNAL clock
        SIGNAL XLXN_5
        SIGNAL clear
        SIGNAL receive
        SIGNAL transmit
        SIGNAL XLXN_9
        SIGNAL XLXN_10
        PORT Output data(7:0)
        PORT Input clock
        PORT Input clear
        PORT Input receive
        PORT Output transmit
        BEGIN BLOCKDEF receiver
            TIMESTAMP 2012 4 23 18 11 26
            RECTANGLE N 64 -320 320 -64 
            LINE N 320 -288 384 -288 
            LINE N 192 -320 192 -384 
            LINE N 64 -112 0 -112 
            LINE N 192 0 192 -64 
            RECTANGLE N 320 -140 384 -116 
            LINE N 320 -128 384 -128 
            LINE N 384 -240 320 -240 
        END BLOCKDEF
        BEGIN BLOCKDEF sender
            TIMESTAMP 2012 4 23 18 11 26
            RECTANGLE N 64 -320 320 -64 
            LINE N 320 -288 384 -288 
            LINE N 192 -384 192 -320 
            LINE N 192 0 192 -64 
            LINE N 64 -288 0 -288 
            LINE N 0 -240 64 -240 
            RECTANGLE N 0 -140 64 -116 
            LINE N 64 -128 0 -128 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 receiver
            PIN req XLXN_1
            PIN rcv receive
            PIN clr clear
            PIN data(7:0) data(7:0)
            PIN ack XLXN_2
            PIN clk clock
        END BLOCK
        BEGIN BLOCK XLXI_2 sender
            PIN xmt transmit
            PIN clk clock
            PIN clr clear
            PIN req XLXN_1
            PIN ack XLXN_2
            PIN data(7:0) data(7:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 976 1136 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 1552 1136 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 1360 848 1552 848
        END BRANCH
        BEGIN BRANCH XLXN_2
            WIRE 1360 896 1552 896
        END BRANCH
        BEGIN BRANCH data(7:0)
            WIRE 1360 1008 1440 1008
            WIRE 1440 1008 1552 1008
            WIRE 1440 1008 1440 1152
            WIRE 1440 1152 2000 1152
        END BRANCH
        BEGIN BRANCH clock
            WIRE 896 688 1168 688
            WIRE 1168 688 1744 688
            WIRE 1744 688 1744 752
            WIRE 1168 688 1168 752
        END BRANCH
        BEGIN BRANCH clear
            WIRE 896 1200 1168 1200
            WIRE 1168 1200 1744 1200
            WIRE 1168 1136 1168 1200
            WIRE 1744 1136 1744 1200
        END BRANCH
        BEGIN BRANCH receive
            WIRE 896 1024 960 1024
            WIRE 960 1024 976 1024
        END BRANCH
        BEGIN BRANCH transmit
            WIRE 1936 848 2000 848
        END BRANCH
        IOMARKER 2000 848 transmit R0 28
        IOMARKER 896 1200 clear R180 28
        IOMARKER 896 688 clock R180 28
        IOMARKER 2000 1152 data(7:0) R0 28
        IOMARKER 896 1024 receive R180 28
    END SHEET
END SCHEMATIC
