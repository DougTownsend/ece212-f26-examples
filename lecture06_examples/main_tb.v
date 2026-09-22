`timescale 1ns/1ns

module and_tb();

    reg i1, i2;
    wire y;
    and_gate uut(.a(i1), .b(i2), .y(y));

    initial begin
        $dumpvars(0, and_tb);
        $monitor("%b, %b, out: %b", i1, i2, y);
        i1 = 0;
        i2 = 0;
        #1;
        i1 = 0;
        i2 = 1;
        #1;
        i1 = 1;
        i2 = 0;
        #1;
        i1 = 1;
        i2 = 1;
        #1;
        $finish;
    end

endmodule