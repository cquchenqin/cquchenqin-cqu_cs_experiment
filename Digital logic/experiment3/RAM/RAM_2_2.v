`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 16:22:05
// Design Name: 
// Module Name: RAM_2_2
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


module RAM_2_2(choice_a,choice_b,addr_a,addr_b,we,clk,din_a,din_b,dout_a,dout_b);
    parameter data_width=3;
    parameter addr_width=3;
    parameter RAM_depth=1<<addr_width;
    input clk;
    input we;
    input choice_a,choice_b;   //ѡ��˿�a����b
    input [addr_width-1:0] addr_a;
    input [addr_width-1:0] addr_b;
    input [data_width-1:0] din_a;
    input [data_width-1:0] din_b;
    output reg[data_width-1:0]dout_a;
    output reg[data_width-1:0]dout_b;
    reg [data_width-1:0] mem [RAM_depth-1:0]; 
    always @(posedge clk) begin
        if (we) begin
            if (choice_a&&choice_b)  begin   
                mem[addr_a]<=din_a;
                dout_a<=0;
                dout_b<=0;
            end
            else begin
                if (choice_a) begin
                    mem[addr_a]<=din_a;
                    dout_a<=0;
                end
                else if (choice_b) begin
                    mem[addr_b]<=din_b;
                    dout_b<=0;
                end
            end
        end
    end
    always @(*) begin
        if (!we) begin
            if (choice_a) begin
                dout_a=mem[addr_a];
            end
            else if (choice_b) begin
                dout_b=mem[addr_b];
            end
        end
    end
endmodule
