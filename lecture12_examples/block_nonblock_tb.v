`timescale  1ps/1ps

module block_tb();

    reg [3:0] a, b, c, d;
    reg clk;

    always @ (posedge clk) begin
        //blocking assignment
        a = b;
        b = a;
    end

    always @ (posedge clk) begin
        //nonblocking
        c <= d;
        d <= c;
    end

    initial begin
        $dumpvars(1,block_tb);
        clk = 0;
        a = 5;
        b = 3;
        c = 5;
        d = 3;
        #5;
        clk = 1;
        #5;
        $finish;
    end

endmodule