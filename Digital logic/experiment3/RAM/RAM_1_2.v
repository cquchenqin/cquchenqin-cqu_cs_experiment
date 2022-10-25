`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 10:19:58
// Design Name: 
// Module Name: RAM_1_2
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


module RAM_1_2(data_in,addr,we,clk,data_out);
    parameter data_width=8;   //数据位宽
    parameter addr_width=3;   //地址位宽
    parameter RAM_depth=1<<addr_width;   //寄存器深度
    input[data_width-1:0] data_in;
    input[addr_width-1:0] addr;
    input we;
    input clk;
    output reg [data_width-1:0] data_out;
    reg [data_width-1:0] mem [RAM_depth-1:0];
    always@(posedge clk) begin
        if (we) begin
            mem[addr]<=data_in;
            data_out<=0;
        end
    end
    //异步读取
    always@(*) begin
        if (!we) begin
            data_out<=mem[addr];
        end
    end
endmodule
