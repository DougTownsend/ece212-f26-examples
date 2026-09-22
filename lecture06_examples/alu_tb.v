`timescale 1ps/1ps

module alu_tb();

    reg [3:0] opcode;
    reg [3:0] sr1, sr2;
    wire [3:0] out;

    alu uut(.opcode(opcode), .sr1(sr1), .sr2(sr2), .out(out));

    initial begin
        sr1 = 0;
        sr2 = 0;
        opcode = 0;
        #1;
        sr1 = 4'b0011;
        sr2 = 4'b0101;
        #1;
        $finish;
    end

    initial begin
        $dumpvars(0, alu_tb);
    end

endmodule;