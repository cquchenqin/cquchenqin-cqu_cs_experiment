`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 15:30:34
// Design Name: 
// Module Name: debkey
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


module debkey(clk,reset,key,debkey);
    input clk;
    input reset;
    input [1:0] key;
    output [1:0] debkey;
    parameter T100HZ=249999;
    integer cnt_100HZ;
    reg clk_100HZ;
    always @(posedge clk or negedge reset) begin
        if (!reset)
            cnt_100HZ<=32'b0;
        else begin
            cnt_100HZ<=cnt_100HZ+1'b1;
            if (cnt_100HZ==T100HZ) begin
                cnt_100HZ<=32'b0;
                clk_100HZ<=~clk_100HZ;
            end
        end
    end
    reg [1:0] key_rrr; reg [1:0] key_rr; reg [1:0] key_r;
    always @(posedge clk_100HZ or negedge reset) begin
        if (!reset) begin
            key_rrr<=1'b1;
            key_rr<=1'b1;
            key_r<=1'b1;
        end
        else begin
            key_rrr<=key_rr;
            key_rr<=key_r;
            key_r<=key;
        end
    end
    assign debkey = key_rrr & key_rr & key_r;
endmodule
