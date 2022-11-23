`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2021 03:00:59 AM
// Design Name: 
// Module Name: Attack_Env
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


module Attack_Env#(parameter DL=16,             //DL: data length-16 bits out from RAM
                    WL=8)                       //WL: word length-8 bits for parameters
                    (input  signed [DL-1:0] data_in,       //data from the RAM
                    input   [WL-1:0] A_E_param,   //parameters for the counter
                    input   [4:0] D_S_param,
                    
                    input   EN_MC, CLK,              // EN for shifter and counter
                    
                    output  hold,
                    output  signed [DL-1:0] data_out,
                    output  [4:0] total,
                    output  z_flg);          // flg that the attack envelope has finished 
                                                // shift amount = 0
//          Intermediate Wire           //

wire flg;                                               
//          Initializing modules        //

//      counter
Count   AEC1    (.C_P(A_E_param),       //inputs//
                .CLK(CLK),
                .EN(EN_MC),
                .rst_flg(flg));         //output//
                
//      right shift decreasing            
RSD_2     AER1    (.data_in(data_in),     //inputs
                .data_out(data_out),    //output
                .EN1(EN_MC),
                .EN2(flg),
                .CLK(CLK),
                .D_S_param(D_S_param),
                .total(total),
                .z_flg(z_flg),
                .hold(hold)
                );         //output
                      
//  LOGIC
always @(posedge CLK)begin
end
endmodule
