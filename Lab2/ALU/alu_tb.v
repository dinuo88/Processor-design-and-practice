`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 23:56:30
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    reg [31:0] A, B;      // ��������� A �� B��ÿ��Ϊ 32 λ��
    reg Cin;              // �����λ��־λ
    reg [4:0] Card;       // ��������룬����ѡ��ALUִ�еĲ���
    wire [31:0] F;        // ������ F��32 λ��
    wire Cout;            // �����λ��־λ
    wire Zero;            // ������־λ
    alu alu_inst(.A(A), .B(B), .Cin(Cin), .Card(Card), .F(F), .Cout(Cout), .Zero(Zero)); // ʵ����ALUģ��

    initial begin
        A = 32'h00000010;   // ��ʼ�������� A
        B = 32'h00000008;   // ��ʼ�������� B
        Cin = 1'b1;         // ��ʼ����λ��־λ
        Card = 5'b00001;    // ��ʼ�������룬ѡ��ӷ�����
        #10;                // �ȴ� 10 ��ʱ�䵥λ

        // ���θı�������Բ��Բ�ͬ��ALU����
        Card = 5'b00010;
        #10;
        Card = 5'b00011;
        #10;
        Card = 5'b00100;
        #10;
        Card = 5'b00101;
        #10;
        Card = 5'b00110;
        #10;
        Card = 5'b00111;
        #10;
        Card = 5'b01000;
        #10;
        Card = 5'b01001;
        #10;
        Card = 5'b01010;
        #10;
        Card = 5'b01011;
        #10;
        Card = 5'b01100;
        #10;
        Card = 5'b01101;
        #10;
        Card = 5'b01110;
        #10;
        Card = 5'b01111;
        #10;
        Card = 5'b00000;    // ���� ALU �Ƿ���ȷ����δ֪������
        #10;
        $finish;             // ��������
    end

    always @(F) begin
        $display("A = %h, B = %h, Cin = %b, Card = %d, F = %h, Cout = %b, Zero = %b", A, B, Cin, Card, F, Cout, Zero);
    end

endmodule



