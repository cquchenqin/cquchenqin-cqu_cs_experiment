`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/18 07:54:11
// Design Name: 
// Module Name: addsub_display
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


module addsub_display (
    input clk,
    input en,
    input[7:0] a,
    input[1:0] counter,
    input fstorsnd,
    input addorsub,
    input switch,//���Ʋ鿴���������ǽ��,0Ϊ�鿴��������1Ϊ�鿴���
    output carry,
    output[3:0] sm_wei,
    output[6:0] sm_duan,
    output over,
    output showSign
    );
    
    parameter FREQ = 10**5/2;  //FREQ���������Ƶ�ʣ�Ϊ1/FREQ Hz
    parameter INTERVAL = 10**8; //INTERVAL���Ƹߵ�16λ֮��仯�ļ����Ĭ��Ϊ1s
    wire [31:0]ord1;
    wire [31:0] ord2;
    wire [31:0]total;
    reg [31:0]show;
    addsub addsub_ing(a,counter,fstorsnd,addorsub,carry,total,ord1,ord2,over,showSign);
    always@(fstorsnd or switch)
    begin 
       if(switch)
            show=total;
       else begin
            if(fstorsnd)
                show=ord2;
            else
                show=ord1;
       end
    end
    display_32_7se u(clk,en,show,sm_wei,sm_duan);
endmodule

