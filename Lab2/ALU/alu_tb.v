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
    reg [31:0] A, B;      // 输入操作数 A 和 B，每个为 32 位宽
    reg Cin;              // 输入进位标志位
    reg [4:0] Card;       // 输入操作码，用于选择ALU执行的操作
    wire [31:0] F;        // 输出结果 F，32 位宽
    wire Cout;            // 输出进位标志位
    wire Zero;            // 输出零标志位
    alu alu_inst(.A(A), .B(B), .Cin(Cin), .Card(Card), .F(F), .Cout(Cout), .Zero(Zero)); // 实例化ALU模块

    initial begin
        A = 32'h00000010;   // 初始化操作数 A
        B = 32'h00000008;   // 初始化操作数 B
        Cin = 1'b1;         // 初始化进位标志位
        Card = 5'b00001;    // 初始化操作码，选择加法操作
        #10;                // 等待 10 个时间单位

        // 依次改变操作码以测试不同的ALU操作
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
        Card = 5'b00000;    // 测试 ALU 是否正确处理未知操作码
        #10;
        $finish;             // 结束仿真
    end

    always @(F) begin
        $display("A = %h, B = %h, Cin = %b, Card = %d, F = %h, Cout = %b, Zero = %b", A, B, Cin, Card, F, Cout, Zero);
    end

endmodule



