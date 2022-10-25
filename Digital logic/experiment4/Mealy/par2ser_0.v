`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 15:29:38
// Design Name: 
// Module Name: par2ser_0
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


module par2ser_0 (input [7:0]register,input clk,input set,output reg [7:0]out_8);
    reg ou; //ou为0时是检测序列第一位并输出，register直接对输出out_8赋值操作，ou为1时检测序列后几位并输出，是对out_8右移操作
    always @ (posedge clk)
    begin
        if((ou != 1)&&set == 1)//输出序列第一位
        begin
            out_8 <= register;
            ou <= 1;
        end
        else if(set == 0)//set关闭时ou回到0
        begin
            ou <= 0;
        end
        else if(ou == 1) //输出序列后几位
        begin
            out_8 <= (out_8>>1);
            out_8[7] <= 1'b0;
        end
    end
endmodule
