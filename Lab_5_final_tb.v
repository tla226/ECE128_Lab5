`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/20/2024 02:32:06 PM
// Design Name:
// Module Name: top_2bit_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////



/*

to get waveform, add anode, bcd_seg, and g_count from uut and uut1, then show enable to show it only works on back half when enable is high
*/
`timescale 1ns/1ps
module multi_seg_driver_tb;
reg clk;
reg [15:0] BCD_in_tb; // input
wire [3:0] sseg_a_o_tb; // output
wire [6:0] sseg_c_o_tb;


// Instantiate original module (named DUT {device under test})
multi_seg_driver uut1(clk, BCD_in_tb, sseg_a_o_tb, sseg_c_o_tb);


parameter T = 2;

always begin
    clk = 1'b0;
    #(T/2);
    clk = 1'b1;
    #(T/2);
end
// if not go back to #80
initial begin 
BCD_in_tb = 16'b0000000000000000;
#256 BCD_in_tb = 16'b0001001000110100;
#256 BCD_in_tb = 16'b0101011001111000;
#256 BCD_in_tb = 16'b1001000000010010;
#256 $stop;
end

   

endmodule

