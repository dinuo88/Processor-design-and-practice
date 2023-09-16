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
    reg [31 : 0] A;         // 输入数据A
    reg [31 : 0] B;         // 输入数据B
    reg Cin;                // 上一级的进位
    
    wire [31 : 0] Sum;      // 结果
    wire Cout;              // 下一级的进位
    
    // 实例化
    adder uut(
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
        
    initial begin
        $dumpfile("adder_tb.vcd");          // 生成波形仿真文件
        $dumpvars(0,adder_tb);                // 保存变量值
        
        A = 32'hf2345678;                   // 初始化A为f2345678
        B = 32'h87654321;                   // 初始化B为87654321
        Cin = 1;                            // 上一级的进位为1
        
        $display("Input A; %h",A);       // 打印A
        $display("Input B; %h",B);       // 打印B
        $display("Cin; %b",Cin);         // 打印Cin
        
        #10             // 等待10ns
        
        $display("Sum: %h",Sum);            // 打印Sum
        $display("Cout: %b",Cout);          // 打印Cout
        
        $finish;                // 结束仿真
    end
    
endmodule  
