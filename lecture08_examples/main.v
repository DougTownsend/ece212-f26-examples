module main(
    input [3:0] btn,
    input [7:0] sw,
    output [6:0] led
);
    reg [1:0] opcode;

    always @ (*) begin
        opcode = 0;
        if (btn[0] == 1) opcode = 0;
        if (btn[1] == 1) opcode = 1;
        if (btn[2]) opcode = 2;
        if (btn[3]) opcode = 3;
    end

    wire [3:0] alu_out;
    assign led[3:0] = alu_out;

    alu alu1(.opcode(opcode), .sr1(sw[7:4]), 
            .sr2(sw[3:0]), .out(alu_out));

    nzp nzp1(.in(alu_out), .n(led[6]), 
            .z(led[5]), .p(led[4]));

endmodule