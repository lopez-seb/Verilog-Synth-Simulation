`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2021 12:54:59 AM
// Design Name: 
// Module Name: Count
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


module Count#(parameter WL=8)           //WL: 8 bits for max 255
            (input CLK, EN,             
            input [WL-1:0] C_P,       //input parameters from the control module
            output reg rst_flg,
            output reg [WL-1:0] count);        //reset flag out
//reg [WL-1:0] tmp;
initial count = 0;            
always @(posedge CLK) begin
rst_flg <= 0;
    if (count==C_P) begin
        count <= 0;
        rst_flg <= 1;
        end
    else if (~EN) begin
        count <= 0;
        rst_flg <= 1;
        end
    else 
        count <= count +1;     
end
endmodule
