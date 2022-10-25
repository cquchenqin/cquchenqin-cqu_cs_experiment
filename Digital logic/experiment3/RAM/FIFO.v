`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/27 22:52:56
// Design Name: 
// Module Name: FIFO
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

module FIFO(data_out,empty,full,data_in,wr_en,rd_en,clk,rst);
    parameter data_w = 4;// 
    parameter addr_w = 3;//
    parameter ram_w = 1<<addr_w;
    input [data_w-1:0] data_in;
    input wr_en;
    input rd_en;
    input clk;
    input rst;
    output  empty;
    output  full;
    output reg [data_w-1:0] data_out;
    reg [data_w-1:0]ram[0:ram_w-1];// ram_w个data_w位的存储器。
    reg [addr_w:0]count;//
    reg [addr_w:0]addr_wr;//
    reg [addr_w:0]addr_rd;//
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            data_out <= 0;
            count <= 0;
            addr_wr <= 0;
            addr_rd <= 0;
        end
        else
        begin
            if(wr_en)//写入
            begin
                if(count!=8)//没满
                begin
                    ram[addr_wr] <= data_in;
                    count <= count+1;
                    if(addr_wr==7)
                        addr_wr <= 0;
                    else
                        addr_wr <= addr_wr+1;
                end
                else
                begin
                    data_out <= 0;
                    count <= 0;
                    addr_wr <= 0;
                    addr_rd <= 0;
                end
            end
            if (rd_en) //读取
            begin
                if(count!=0)//不空
                begin
                    data_out <= ram[addr_rd];
                    count <= count-1;
                    if(addr_rd==7)
                        addr_rd<=0;
                    else
                        addr_rd<=addr_rd+1;
                end
                else
                begin
                    data_out <= 0; 
                end
            end
        end
    end
    assign empty = (count==0) ? 1:0;
    assign full = (count==8) ? 1:0;
endmodule


