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
    input [31 : 0] A,     // 输入操作数 A，32 位宽
    input [31 : 0] B,     // 输入操作数 B，32 位宽
    input          Cin,   // 输入进位标志位
    input [4 : 0]  Card,  // 输入操作码，指示要执行的操作
    
    output reg [31 : 0] F, // 输出结果 F，32 位宽
    output          Cout, // 输出进位标志位
    output          Zero  // 输出零标志位
);

    // 内部线路声明，用于存储不同操作的中间结果
    wire [31:0] add_result, addc_result, sub_result, sub1_result, inv_A, inv_B, or_result, and_result, xnor_result, xor_result, nor_result;
    
    // 使用 assign 语句计算各种操作的中间结果
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
    
    // 组合逻辑块，根据操作码选择输出结果 F
    always @(*) begin
        case (Card)
            5'b00001 : F <= add_result; // 执行加法操作
            5'b00010 : F <= add_result + Cin; // 执行加法进位操作
            5'b00011 : F <= sub_result; // 执行减法操作
            5'b00100 : F <= sub_result - Cin; // 执行减法借位操作
            5'b00101 : F <= sub1_result; // 执行反向减法操作
            5'b00110 : F <= sub1_result - Cin; // 执行反向减法借位操作
            5'b00111 : F <= A; // 传递输入 A
            5'b01000 : F <= B; // 传递输入 B
            5'b01001 : F <= inv_A; // 执行 A 的按位取反
            5'b01010 : F <= inv_B; // 执行 B 的按位取反
            5'b01011 : F <= or_result; // 执行按位或操作
            5'b01100 : F <= and_result; // 执行按位与操作
            5'b01101 : F <= xnor_result; // 执行按位异或非操作
            5'b01110 : F <= xor_result; // 执行按位异或操作
            5'b01111 : F <= nor_result; // 执行按位或非操作
            default   : F <= 32'b0; // 处理未知的操作码值
        endcase
    end
    
    // 使用 assign 语句计算进位标志位 Cout
    assign Cout =  (Card == 5'b00001 && (add_result[31] ^ A[31] ^ B[31])) | (Card == 5'b00010 && (addc_result[31] ^ A[31] ^ B[31] ^ Cin));
    
    // 使用 assign 语句计算零标志位 Zero
    assign Zero = (F == 32'b0);
    
endmodule
