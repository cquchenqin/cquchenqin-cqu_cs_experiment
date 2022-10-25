`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 20:29:38
// Design Name: 
// Module Name: adder_1
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


module adder_4(cin,sum,cout,a,b,overflow,flag_end,symbol);  //四位加法器
    parameter n=3;
    output cout;           //进位信号
    output reg [n:0] sum;     //加法结果
    output overflow;     //溢出信号
    input [n:0] a;
    input [n:0] b;
    input cin;
    input symbol;
    reg [n+1:0] c;
    output reg flag_end=1'b0; //计算完成信号，默认为0
    assign cout=c[n+1];
    assign overflow= (symbol==1)?(a[n]&b[n]&~sum[n])|(~a[n]&~b[n]&sum[n]):0;
    integer i;
    always @(*) begin
        c[0]=cin;
        flag_end=1'b0;
        for (i=0;i<=n;i=i+1) begin
            sum[i]=(a[i]^b[i])^c[i];
            c[i+1]=(a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
        end
        flag_end=1'b1;  //加法计算完成
    end
    //4位加法运算结束，将a显示在第一个数码管，将b显示在第二个数码管，将结果显示在最右边数码管
    //将cout和overflow信号输出在led信号上
    
endmodule
    