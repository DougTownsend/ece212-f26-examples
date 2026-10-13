`timescale 1ps/1ps

module mult_tb();

    reg [7:0] sw;
    reg [7:0] led;
    reg done;
    reg clk;
    reg start;
    wire last, load, step;
    mult_ctl mc(.clk(clk), .start(start), .last(last),
                .load(load), .step(step), .done(done));
    
    mult_data md(.clk(clk), .load(load), .step(step),
                .a(sw[7:4]), .b(sw[3:0]), .last(last), .prod(led));

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpvars(1, mult_tb);
        clk = 0;
        sw[7:4] = 4'd3;
        sw[3:0] = 4'd3;
        start = 1;
        #10;
        start = 0;
        #50;
        $finish;

    end
endmodule