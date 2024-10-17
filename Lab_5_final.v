`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/11/2024 12:25:31 PM
// Design Name:
// Module Name: Lab_5_final
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


module multi_seg_driver(
input clk,
 input [15:0] bcd_in,
 output [3:0] sseg_a_o,
 output [6:0] sseg_c_o);

wire [6:0] sseg_o;
wire [3:0] anode;
wire en;
wire [3:0] bcd_seg;

//Seven_seg_decoder uut1(clk, bcd_seg,sseg_o);
anode_generator uut1(clk, en, anode);
mux uut2(anode, bcd_seg, en, bcd_in, sseg_a_o);
BCD_7seg ss_dec(clk, bcd_seg, sseg_c_o);

endmodule

module anode_generator(clk,en,anode);
input clk;
output reg en;
output [3:0] anode = 4'b0001;
reg [3:0] bcd_seg = 4'b0000;
reg [3:0] anode = 4'b0001;

parameter g_s = 5;
parameter gt = 4;
reg [g_s-1:0] g_count = 0;



always @(posedge clk)
    begin
    g_count = g_count+1;
        if(g_count == 0)
            begin
            if(anode == 4'b0001)
                begin
                anode = 4'b1000;
                end  
            else
                begin
                anode = anode >>1;
                end
             end
             end
        always @(posedge clk)
        begin
        if (&g_count[g_s-1:gt])
        begin
        en = 1'b1;
        end
        else
        en = 1'b0;
      end
  endmodule
 
module mux(anode, bcd_seg,en,bcd_in,sseg_a_o);
input [15:0] bcd_in;
 output [3:0] sseg_a_o;
 input [3:0] anode;
 output reg [3:0] bcd_seg;
 input en;
 
    always @(*)
    begin
        if (en)
            begin
            case(anode)
                4'b1000: bcd_seg = bcd_in[15:12];
                4'b0100: bcd_seg = bcd_in[11:8];
                4'b0010: bcd_seg = bcd_in[7:4];
                4'b0001: bcd_seg = bcd_in[3:0];
                default : bcd_seg = 4'b1111;
            endcase
            end
          end
assign sseg_a_o = ~anode;
       
endmodule          


module BCD_7seg(
    input clk,
    input [3:0] num,
    output reg [6:0] out
    );
   
    always @(posedge clk)
    begin
        case (num)
            4'b0000: out = 7'b1000000; // 0
            4'b0001: out = 7'b1111001; // 1
            4'b0010: out = 7'b0100100; // 2
            4'b0011: out = 7'b0110000; // 3
            4'b0100: out = 7'b0011001; // 4
            4'b0101: out = 7'b0010010; // 5
            4'b0110: out = 7'b0000010; // 6
            4'b0111: out = 7'b1111000; // 7
            4'b1000: out = 7'b0000000; // 8
            4'b1001: out = 7'b0010000; // 9
            default: out = 1'bx; // turn it off
            endcase
         end
                     
endmodule



 
