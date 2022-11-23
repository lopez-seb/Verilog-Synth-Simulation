`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 04:26:43 PM
// Design Name: 
// Module Name: MAIN
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


module MAIN #(parameter WL=8,           //word length for paramters
                DL = 16)                // data width
                (input  [WL-1:0] Acc_P,      //accumulator top value fixed at 99-> max address
                input   [WL-1:0] C_P,         //F_Con counter param, higher value=lower frequency
                input   [WL-1:0] A_E_param,   //Attack envelope -> slope of envelope higher=lower slope
                input   [4:0] D_S_param,
                input   EN_MC, CLK,           // Main Enable
                
                output  reg signed [DL-1:0] data_sam,    // output for testing the output of the LUT
                output  signed [DL-1:0] data_out,
                output  z_flg,
                output  hold,
                output  [4:0] total);          
//      WIRES       //
wire [DL-1:0] data;
wire [WL-1:0] addr;
//      CONNECTIONS / INSTANTIATIONS        //
F_Con   F01     (.EN_MC(EN_MC),
                .EN_E(hold),
                .CLK(CLK),
                .Acc_P(Acc_P),
                .C_P(C_P),
                .Addr(addr));
                
blk_mem_gen_3mk4    M01     (.addra(addr),
                            .douta(data),
                            .clka(CLK));
                            
Attack_Env      A01 (   .CLK(CLK),
                        .data_in(data),
                        .A_E_param(A_E_param),
                        .D_S_param(D_S_param),
                        .EN_MC(EN_MC),
                        .data_out(data_out),
                        .total(total),
                        .z_flg(z_flg),
                        .hold(hold)
                        );

                       
always @(posedge CLK) begin
data_sam <= data;
end
endmodule
