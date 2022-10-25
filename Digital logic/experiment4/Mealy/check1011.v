`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/05 15:28:53
// Design Name: 
// Module Name: check1011
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


module check1011(
    input clk,
    input set,
    input [7:0] data,
    input [1:0] key,  //key[0]表示按键时钟,key[1]表示启动按钮
    output reg out,
    output reg work  //表示工作状态
    );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
     reg [1:0] currentstate;
     reg [1:0] nextstate;
     reg [7:0] out_8;
     parameter s0 = 2'b00;
     parameter s1 = 2'b01;
     parameter s2 = 2'b10;
     parameter s3 = 2'b11;
     wire [1:0] dekey;
     integer cnt;
     debkey b(clk,set,key,dekey);
     always@(posedge dekey[1] or posedge dekey[0] or negedge set) begin
            if (!set) begin
                out_8<=8'b0;
                work<=0;
            end
            else if (dekey[1]) begin
                out_8<=data;
                cnt<=1;
                work<=1;
            end
            else if (cnt) out_8<=(out_8>>1);
            else out_8<=out_8;
     end
     always@(posedge dekey[0] or negedge set) //状态跳转
     begin
        if(!set)
            currentstate<=s0;
        else
            currentstate<=nextstate;
     end
     
     always@(currentstate or out_8 or set) //下一状态的计算
     begin
     if(!set)
         nextstate<=s0;
     else
         case(currentstate)
            s0:nextstate <= (out_8[0]== 1) ? s1:s0;
            s1:nextstate <= (out_8[0]== 1) ? s1:s2;
            s2:nextstate <= (out_8[0]== 1) ? s3:s0;
            s3:nextstate <= (out_8[0]== 1) ? s1:s2;
            default: nextstate <= s0;
         endcase
     end
     always@(posedge dekey[0] or negedge set) //输出逻辑的处理
     begin
        if(!set)
            out<=0;
        else if(currentstate==s3&&out_8[0]==1) //检查当前状态和输入
            out<=1;
        else
            out<=0;
     end
endmodule