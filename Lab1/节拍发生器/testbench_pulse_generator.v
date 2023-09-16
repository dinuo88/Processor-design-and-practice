`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 15:05:13
// Design Name: 
// Module Name: testbench_pulse_generator
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

module testbench_pulse_generator;
    
    reg clk;        // ����ʱ���ź�
    reg rst;        // ���븴λ�ź�
    wire [3:0] T;   // �������������������ź�

    // ʵ��������������ģ��
    pulse_generator pg (
        .clk(clk),
        .rst(rst),
        .T(T)
    );
    
    
    initial begin
        clk = 0;                // ��ʼ��ʱ���ź�Ϊ�͵�ƽ
        forever #5 clk = ~clk;  // ��5nsΪ�����תʱ���ź�
    end

    
    initial begin
        $dumpfile("pulse_generator.vcd");          //���ɷ��沨���ļ�
        $dumpvars(0, testbench_pulse_generator);     // ���浱ǰģ�����ֵ

        rst = 1;        //���λ�ź�
        #10;            // �ȴ�10ns
        rst = 0;        // ȡ����λ�ź�

        
        #100;           // ��������100ns

        $finish;        //��������
    end

endmodule

