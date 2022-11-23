`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2021 11:34:02 PM
// Design Name: 
// Module Name: RSD
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
//          RIGHT SHIFT DECREASING 

module RSD  #(parameter WL=16)
                (input EN1, EN2, CLK,                   //EN1: Master Controll Enable, EN2: Increment 
                input signed [WL-1:0] data_in,          //data from ROM 16 bit length
                output reg signed [WL-1:0] data_out,    //data after shifting
                output reg [4:0] total,                 //total output for testing the position of the RSD
                output reg z_flg);                          // zero flg: the shifter has reached its limit and has stopped shifting
                                                        //output should now be at 100%
//reg [4:0] total;   
initial total = 0;                                     // max value of 16: Word length of data is 16 bits
initial data_out = 0; 
  
//      LOGIC       //                                                     
always @(posedge CLK) begin
//z_flg <= 0;                               //rst-flg down     
    if (EN1 & EN2) begin                    //if both enables
        if (total==16)                      // and total is 16
            total =16;                      // leave total at 16
        else 
            total = total +1;               // else increment total by 1
    end
    else if (~EN1) begin                    // if main enable off
            total = 0;                      // reset total -> main stimulation signal has ended 
            z_flg = 1;                    // raise rst_flg
    end
    else                        //!!!!!!!!
        data_out <= (data_in >>> (16 - total));     //perform shift operation
end                                         //shift data right by (16 - total)     
endmodule











