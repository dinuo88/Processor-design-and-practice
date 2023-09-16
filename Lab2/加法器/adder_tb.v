`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/29 14:04:26
// Design Name: 
// Module Name: adder_tb
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


module adder_tb;
    reg [31 : 0] A;         // ��������A
    reg [31 : 0] B;         // ��������B
    reg Cin;                // ��һ���Ľ�λ
    
    wire [31 : 0] Sum;      // ���
    wire Cout;              // ��һ���Ľ�λ
    
    // ʵ����
    adder uut(
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
        
    initial begin
        $dumpfile("adder_tb.vcd");          // ���ɲ��η����ļ�
        $dumpvars(0,adder_tb);                // �������ֵ
        
        A = 32'hf2345678;                   // ��ʼ��AΪf2345678
        B = 32'h87654321;                   // ��ʼ��BΪ87654321
        Cin = 1;                            // ��һ���Ľ�λΪ1
        
        $display("Input A; %h",A);       // ��ӡA
        $display("Input B; %h",B);       // ��ӡB
        $display("Cin; %b",Cin);         // ��ӡCin
        
        #10             // �ȴ�10ns
        
        $display("Sum: %h",Sum);            // ��ӡSum
        $display("Cout: %b",Cout);          // ��ӡCout
        
        $finish;                // ��������
    end
    
endmodule  
