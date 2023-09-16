`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/29 13:59:45
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] A,         // 加数A
    input [31:0] B,         // 加数B
    input Cin,              // 下一级的进位
    output [31:0] Sum,      // A+B的结果
    output Cout             // 进位
);

wire [32:0] carry_out;              // 33位的数组，保存每一位的进位
assign carry_out[0] = Cin;          // 初始化

genvar i;           // 变量i
generate
    for (i = 0; i < 32; i = i + 1) begin : adder_loop
        assign Sum[i] = A[i] ^ B[i] ^ carry_out[i];         // 计算第i位的结果
        assign carry_out[i+1] = (A[i] & B[i]) | (A[i] & carry_out[i]) | (B[i] & carry_out[i]);
    end                                                    // 计算第i位的进位
endgenerate

assign Cout = carry_out[32];     // 最高位进位为这两个加数的进位

endmodule
