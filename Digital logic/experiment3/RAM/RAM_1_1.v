`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 09:39:38
// Design Name: 
// Module Name: RAM_1_1
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

//同步读写单端口寄存器模块
module RAM_1_1(data_in,addr,we,clk,data_out);
    parameter data_width=8;   //数据位宽
    parameter addr_width=3;   //地址位宽
    parameter RAM_depth=1<<addr_width;   //寄存器深度
    input[data_width-1:0] data_in;
    input[addr_width-1:0] addr;
    input we;
    input clk;
    output reg [data_width-1:0] data_out;
    reg [data_width-1:0] mem [RAM_depth-1:0];
    always@ (posedge clk) begin
        if (we)   begin        //写使能端有效
            mem[addr]<=data_in;   //执行写操作
            data_out<=0;
        end
        else begin
            data_out<=mem[addr];  //执行读操作
        end
    end
endmodule
