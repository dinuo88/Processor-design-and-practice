`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 15:16:59
// Design Name: 
// Module Name: testbench_mux_2to1
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


`timescale 1ns / 1ps 

module testbench_mux_2to1;
    reg [1:0] d0;     // ����
    reg [1:0] d1;     // ����
    reg select;       // ѡ���ź�
    wire [1:0] out;   // ����ź�

   // ����
    mux_2to1 my_mux (
        .d0(d0),
        .d1(d1),
        .select(select),
        .out(out)
    );

   
    initial begin
        d0 = 2'b00;            // ����d0Ϊ2λ��������00
        d1 = 2'b11;            // ����d1Ϊ2λ��������11
        select = 1'b0;         // ����selectΪ1λ��������0

        #10;            // �ȴ�10ns

        $finish;        // ��������
    end

   
    always begin
        #5 select = ~select; // ÿ 5 ��ʱ�䵥λ�л�һ��ѡ���ź�
    end

endmodule   
