`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 15:09:51
// Design Name: 
// Module Name: time_ruducer
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

//Ê±ÖÓ·ÖÆµÆ÷Ä£¿é
module time_ruducer(CLK_in,rst,clk);
    input CLK_in;
    input rst;
    output reg clk;
    reg [20:0] count;
    always@(posedge CLK_in or posedge rst) begin
        if (rst==1) begin
        clk<=0;
        count<=0;
        end
        else begin
            if (count<99999)
                count<=count+1;
            else begin
                count<=0;
                clk<=~clk;
            end
        end
    end
endmodule
