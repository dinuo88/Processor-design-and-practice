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
    input [31:0] A,         // ����A
    input [31:0] B,         // ����B
    input Cin,              // ��һ���Ľ�λ
    output [31:0] Sum,      // A+B�Ľ��
    output Cout             // ��λ
);

wire [32:0] carry_out;              // 33λ�����飬����ÿһλ�Ľ�λ
assign carry_out[0] = Cin;          // ��ʼ��

genvar i;           // ����i
generate
    for (i = 0; i < 32; i = i + 1) begin : adder_loop
        assign Sum[i] = A[i] ^ B[i] ^ carry_out[i];         // �����iλ�Ľ��
        assign carry_out[i+1] = (A[i] & B[i]) | (A[i] & carry_out[i]) | (B[i] & carry_out[i]);
    end                                                    // �����iλ�Ľ�λ
endgenerate

assign Cout = carry_out[32];     // ���λ��λΪ�����������Ľ�λ

endmodule
