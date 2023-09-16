// 功能描述：
// 这个模块包含了 CPU 测试的顶层逻辑。它读取 CPU 运行轨迹数据，与 CPU 的输出进行比较，以验证 CPU 的正确性。
// 设计方法：
// 1. 从文件读取 CPU 运行轨迹数据。
// 2. 在时钟上升沿检查 CPU 输出是否匹配预期结果。
// 3. 如果匹配，测试通过；否则，报错。


`timescale 1ns / 1ps

// 定义 trace 文件路径和测试次数
`define TRACE_FILE_PATH "E:/RTL/Single_CPU/data/cpu_trace"
`define TEST_COUNT 11

module cpu_top(
    input clk,
    input reset
);

    // 定义存储 CPU 运行轨迹数据的寄存器
    reg [71:0] cpu_trace_data [`TEST_COUNT - 1 : 0];

    initial begin
        // 从 trace 文件读取 CPU 运行轨迹数据
        $readmemh(`TRACE_FILE_PATH, cpu_trace_data);
    end

    // 定义调试信号
    wire [31:0] debug_wb_pc;
    wire debug_wb_rf_wen;
    wire [4:0] debug_wb_rf_addr;
    wire [31:0] debug_wb_rf_wdata;

    // 实例化 CPU 模块
    cpu U_cpu(
        .clk(clk),
        .reset(reset),
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_rf_wen(debug_wb_rf_wen),
        .debug_wb_rf_addr(debug_wb_rf_addr),
        .debug_wb_rf_wdata(debug_wb_rf_wdata)
    );

    // 定义测试相关的寄存器和信号
    reg test_err;
    reg test_pass;
    reg [31:0] test_counter;
    reg [15:0] leds_reg;

    // 从 trace 数据中提取参考值
    wire [31:0] test_wb_pc = cpu_trace_data[test_counter][71:40];
    wire [4:0] test_wb_rf_addr = cpu_trace_data[test_counter][36:32];
    wire [31:0] test_wb_rf_wdata = cpu_trace_data[test_counter][31:0];

    always @(posedge clk) begin
        if (!reset) begin
            // 初始化测试相关的寄存器和信号
            leds_reg <= 16'hffff;
            test_err <= 1'b0;
            test_pass <= 1'b0;
            test_counter <= 0;
        end
        else if (debug_wb_pc == 32'h00000040 && !test_err) begin
            // 当 PC 达到特定值时，测试通过
            $display("    ----PASS!!!");
            $display("Test end!");
            $display("==============================================================");
            test_pass <= 1'b1;
            leds_reg <= 16'h0000;
            #5;
            $finish;
        end
        else if (debug_wb_rf_wen && |debug_wb_rf_addr && !test_pass) begin
            if (debug_wb_pc != test_wb_pc || debug_wb_rf_addr != test_wb_rf_addr || debug_wb_rf_wdata != test_wb_rf_wdata) begin
                // 如果写回数据不匹配参考值，报错
                $display("--------------------------------------------------------------");
                $display("Error!!!");
                $display("    Reference : PC = 0x%8h, write back reg number = %2d, write back data = 0x%8h", test_wb_pc, test_wb_rf_addr, test_wb_rf_wdata);
                $display("    Error     : PC = 0x%8h, write back reg number = %2d, write back data = 0x%8h", debug_wb_pc, debug_wb_rf_addr, debug_wb_rf_wdata);
                $display("--------------------------------------------------------------");
                $display("==============================================================");
                test_err <= 1'b1;
                #5;
                $finish;
            end
            else begin
                // 测试通过，增加测试计数器
                test_counter <= test_counter + 1;
            end
        end
    end

endmodule
