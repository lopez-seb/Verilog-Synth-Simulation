`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2021 11:51:33 PM
// Design Name: 
// Module Name: Acc
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


module Acc  #(parameter WL=8,    //INPUT IS 8 for a 8 bit input : max value 255
                                    //meant specifically for control parameter input
                        Out=8)      //Meant for the output word length
                                    //8 bits max of 255 
            (input CLK, EN1, EN2,
            input [WL-1:0] Acc_P,       //Accumulator Parameter
            output reg [Out-1:0] Pos,   //position
            output reg rst_flg);        //reset flag
reg [Out-1:0] tmp;

initial Pos <= 0;    //initializing Pos

always @(posedge CLK) begin
    rst_flg <= 0;                   //reset flag goes down
    if (Pos==Acc_P) begin           //check for end of count
        Pos <= 0;                   // if so reset
        //Pos <= tmp;
        rst_flg <= 1;               //reset flag goes up
        end
    else
        if (EN1 & EN2) begin        // if both enables are active
        Pos <= Pos +1;              //increment count
        //Pos <= tmp;                 //new position is tx'd
        end
   // else
     //   if (EN1)                    //if only EN1 active
       // Pos <= tmp;                 //current position tx'd
    else
        if (~EN1) begin             //if EN1 is inactive
        Pos <= 0;                   //reset count
        rst_flg <= 1;               //reset flag goes up
        
        end
end   
endmodule
