module regfile_test;

    // Parameters
    reg clk;
    reg [5:1] raddr1, raddr2, waddr;
    reg we;
    reg rwe;
    reg [32:1] wdata;
    wire [32:1] rdata1, rdata2;
    reg [15:0] raddr;
    wire [31:0] rrdata;
    reg [31:0] temp_data;
    // Instantiate the regfile module
    regfile regfile_inst (
        .clk(clk),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .raddr2(raddr2),
        .rdata2(rdata2),
        .we(we),
        .waddr(waddr),
        .wdata(wdata)
    );

    ram_top ram1(
        .clk(clk),
        .ram_addr(raddr), //地址
        .ram_wdata(temp_data), //写数据
        .ram_wen(rwe), //读写使能
        .ram_rdata(rrdata) // 读数据
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        clk =0;
        rwe =0;
        wdata =32'd2;

        waddr =32'd1;

        we=0;

        #10;

        we =1;

        #10;

        wdata =32'd1;

        waddr =32'd5;

        #10;

        we =0;

        #10;

        raddr1 =32'd1;

        raddr2 =32'd5;
        #10;

        temp_data =rdata2;

        rwe =1;

        raddr =32'd1;


        #10;

        rwe =0;
        

        #10;
		
		wdata = rrdata;
		waddr = 32'd3;
		we = 1;
		
		#10;
		
		raddr1 = 32'd3;
		we = 0;
		
		#10;

        $finish;
    end

endmodule

