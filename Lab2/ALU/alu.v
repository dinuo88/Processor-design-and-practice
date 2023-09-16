`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 23:38:45
// Design Name: 
// Module Name: alu
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


module alu(
    input [31 : 0] A,     // ��������� A��32 λ��
    input [31 : 0] B,     // ��������� B��32 λ��
    input          Cin,   // �����λ��־λ
    input [4 : 0]  Card,  // ��������룬ָʾҪִ�еĲ���
    
    output reg [31 : 0] F, // ������ F��32 λ��
    output          Cout, // �����λ��־λ
    output          Zero  // ������־λ
);

    // �ڲ���·���������ڴ洢��ͬ�������м���
    wire [31:0] add_result, addc_result, sub_result, sub1_result, inv_A, inv_B, or_result, and_result, xnor_result, xor_result, nor_result;
    
    // ʹ�� assign ��������ֲ������м���
    assign add_result = A + B;
    assign addc_result = add_result + Cin;
    assign sub_result = A - B;
    assign sub1_result = B - A;
    assign inv_A = ~A;
    assign inv_B = ~B;
    assign or_result = A | B;
    assign and_result = A & B;
    assign xnor_result = ~(A ^ B);
    assign xor_result = A ^ B;
    assign nor_result = ~(A & B);
    
    // ����߼��飬���ݲ�����ѡ�������� F
    always @(*) begin
        case (Card)
            5'b00001 : F <= add_result; // ִ�мӷ�����
            5'b00010 : F <= add_result + Cin; // ִ�мӷ���λ����
            5'b00011 : F <= sub_result; // ִ�м�������
            5'b00100 : F <= sub_result - Cin; // ִ�м�����λ����
            5'b00101 : F <= sub1_result; // ִ�з����������
            5'b00110 : F <= sub1_result - Cin; // ִ�з��������λ����
            5'b00111 : F <= A; // �������� A
            5'b01000 : F <= B; // �������� B
            5'b01001 : F <= inv_A; // ִ�� A �İ�λȡ��
            5'b01010 : F <= inv_B; // ִ�� B �İ�λȡ��
            5'b01011 : F <= or_result; // ִ�а�λ�����
            5'b01100 : F <= and_result; // ִ�а�λ�����
            5'b01101 : F <= xnor_result; // ִ�а�λ���ǲ���
            5'b01110 : F <= xor_result; // ִ�а�λ������
            5'b01111 : F <= nor_result; // ִ�а�λ��ǲ���
            default   : F <= 32'b0; // ����δ֪�Ĳ�����ֵ
        endcase
    end
    
    // ʹ�� assign �������λ��־λ Cout
    assign Cout =  (Card == 5'b00001 && (add_result[31] ^ A[31] ^ B[31])) | (Card == 5'b00010 && (addc_result[31] ^ A[31] ^ B[31] ^ Cin));
    
    // ʹ�� assign ���������־λ Zero
    assign Zero = (F == 32'b0);
    
endmodule
