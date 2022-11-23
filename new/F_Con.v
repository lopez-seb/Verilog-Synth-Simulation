`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2021 11:46:31 PM
// Design Name: 
// Module Name: F_Con
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
//      FREQUENCY CONTROLLER

module F_Con    #(parameter WL=8)            // Max width of an address
                (input EN_MC, EN_E, CLK,        // EN1 coming from Contr. Main, EN2 coming from release envelope of ADSR
                input [WL-1:0] Acc_P, C_P,      //parameters -> top values for sub modules
                
                output [WL-1:0] count,          //output of count module for testing
                output rst_flg_A, rst_flg_C,    //reset flags for testing
                output [WL-1:0] Addr);       // max width = address width

wire rst_flg_C;
wire EN;
wire [WL-1:0] Pos;
assign EN = EN_MC | EN_E;


//Instantiating the modules of the Freq Controller
Acc     A01 (.CLK(CLK),
                .EN1(EN),               //main enable
                .EN2(rst_flg_C),        // increment enable from rst-flg from Counter
                .Acc_P(Acc_P),          //Accumulator top value
                .Pos(Addr),             //position of the accumulator -> address of rom
                .rst_flg(rst_flg_A));   // rst-flg 0f Accumulator for testing

Count   C01 (.CLK(CLK),
                .EN(EN),                //Main enable
                .C_P(C_P),              //Counter top value
                .rst_flg(rst_flg_C),    // rst_flg of counter -> EN2 of Accumulator
                .count(count));         //output count for testing

////////////////////////////////////////////////////
// WIRE
//wire EN;

//assign EN = EN_MC | EN_E;
//assign EN1_A = EN;
//assign EN_C = EN;
//assign EN2_A = rst_flg_C;

//      LOGIC
always @(posedge CLK) begin
    //Addr <= Pos;
    end
endmodule
