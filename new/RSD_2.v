`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2021 02:54:50 AM
// Design Name: 
// Module Name: RSD_2
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


module RSD_2 #(parameter WL=16)
                (input EN1, EN2, CLK,                   //EN1: Master Controll Enable, EN2: Increment 
                input   signed  [WL-1:0]    data_in,        //data from ROM 16 bit length
                input   [4:0]   D_S_param,
                
                output  reg signed [WL-1:0] data_out,   //data after shifting
                
                output  reg [4:0]   total,                //  total output for testing the position of the RSD
                
                
                output  reg hold,                       //  made to hold the main enable open once the 
                                                        //      envelope has been enabled 
                
                output  reg z_flg);                     //      zero flg: the shifter has reached its limit 
                                                        //      and has stopped shifting
                                                        //      output should now be at 100%
//reg [4:0] total;   
initial total = 0;                                     // max value of 16: Word length of data is 16 bits
initial data_out = 0;
initial hold = 0;
initial z_flg =0;


//      LOGIC       //                                                     
always @(posedge CLK) begin
    
    if (EN1 & EN2 & ~z_flg) begin       //  If EN1 & EN2 with zero flag down
        hold <= 1;                      //  engage hold
        if (total==16)                  //  if max shift value reached
            z_flg <= 1;                 //  raise zero flag
        else 
            total = total +1;           //  if not increase total    
        end         
    
    if (EN1 & EN2 & z_flg)              // if the zero flag has been raised
        if (total==D_S_param)           //  has the decay paramter been reached?
            total = total;              // if so keep the total where it is
        else    
            total = total -1;           // if not, decrease the total so more shifting can be made
               
    else if (~EN1) begin                // if main enable is off
        if (total==0) begin             //  and the toal is zero
            hold <=0;                   //      release the hold flag, freq controller turns off
            z_flg <= 0;                 //       turn off zero flag- envelope is reset
            end
        else 
            total = total -1;           //  otherwise decrease total amount one unit at a time until zero is reached
        end
    data_out <= (data_in >>> (16 - total));     //perform shift operation based on steps above
end    
endmodule
