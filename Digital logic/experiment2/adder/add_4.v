`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 16:29:29
// Design Name: 
// Module Name: add_4
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

//顶层模块
module add_4(CLK_in,rst,a,b,cin,flag_end,cout,overflow,segs,AN,symbol,add_min);
    parameter n=3;
    input CLK_in;   //时钟信号
    input rst;  //置位信号
    input[n:0] a;
    input[n:0] b;
    input cin;  
    output flag_end;  //加法结束信号
    output reg cout;   //进位信号
    output reg overflow;  //溢出信号
    output [3:0] AN;
    output [7:0] segs;
    input symbol; //是否为有符号数或无符号数
    input add_min;  //是做加法还是减法
    wire clk;         //降频信号
    wire [n:0]sum;    //加法运算结果
    wire [n:0]minus;  //减法运算结果
    wire [n:0]res_out;  //根据做加法还是减法信号应该输出的结果
    wire overflow_1; wire overflow_2;
    wire cout_1; wire cout_2;
    adder_4 t4(cin,sum,cout_1,a,b,overflow_1,flag_end,symbol);
    subber_4 t1(cin,minus,cout_2,a,b,overflow_2,flag_end,symbol);
    always @(*) begin
        if (add_min==1) begin   //等于1的时候做加法
            overflow=overflow_1;
            cout=cout_1;
        end
        else begin
            overflow=overflow_2;
            cout=cout_2;
        end
    end
    assign res_out= (add_min==1)? sum:minus;
    time_ruducer t2(CLK_in,rst,clk);
    seg_7 t3(clk,a,b,res_out,flag_end,segs,AN,symbol);
endmodule
