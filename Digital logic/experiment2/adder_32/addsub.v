`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 07:52:17
// Design Name: 
// Module Name: addsub
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

module addsub(
    input[7:0] a,
    input[1:0] counter,
    input fstorsnd,
    input addorsub,
    output carry,
    output [31:0] sum,
    output [31:0] operand1,
    output [31:0] operand2,
    output over,
    output reg showSign    //表示结果正负
    );
    //addorsub为控制加减法的信号0为加法，1为减法,counter为控制第几个8位，frtorsnd为控制第几个操作数
    reg [7:0] a_0 = 0;
    reg [7:0] a_1 = 0;
    reg [7:0] a_2 = 0;
    reg [7:0] a_3 = 0;
    reg [7:0] b_0 = 0;
    reg [7:0] b_1 = 0;
    reg [7:0] b_2 = 0;
    reg [7:0] b_3 = 0;
    
    always@(*)
    begin
            if(fstorsnd == 1'b0)
            begin
                if(counter == 2'b00)
                    a_0 = a;
                else if(counter == 2'b01)
                    a_1 = a;
                else if(counter == 2'b10) 
                    a_2 = a;
                else if(counter == 2'b11)
                    a_3 = a;
            end
            else if(fstorsnd == 1'b1)
            begin
                if(counter == 2'b00)
                b_0 = a;
                else if(counter == 2'b01)
                b_1 = a;
                else if(counter == 2'b10)
                b_2 = a;
                else if(counter == 2'b11)
                b_3 = a;
            end
    end
    assign operand1 = {a_3,a_2,a_1,a_0};
    assign operand2 = {b_3,b_2,b_1,b_0};    
    reg [31:0] temp1;//会等于那个较大的数
    reg [31:0] temp2;//会等于那个较小的数

    always @ (operand1 or operand2)
        begin 
        if(addorsub==1'b1)//减法
            begin
            if(operand1 >= operand2)//不会出现负数的减法
                begin
                temp1 <= operand1;
                temp2 <= ~operand2 + 1;//取b_t的补码
                showSign <= 1'b0;
                end 
            else//会出现负数的减法，即b_t>a_t
                begin
                temp1 <= operand2;
                temp2 <= ~operand1 + 1;//算式变成b_t - a_t，所以取a_t的补码
                showSign <= 1'b1;
                end
            end
        else if(addorsub == 1'b0)
            begin//加法   
            temp1 <= operand1;
            temp2 <= operand2;
            showSign <= 1'b0;//加法不能出现负数
            end
        end
    adder_32 adding2 (temp1,temp2,1'b0,addorsub,sum,carry,over);
endmodule



