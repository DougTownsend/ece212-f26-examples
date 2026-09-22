module alu(
    input [1:0] opcode,
    input [3:0] sr1,
    input [3:0] sr2,
    output reg [3:0] out
);
    always @(*) begin
        /*
        case (opcode)
            0: out = sr1 & sr2;
            1: out = sr1 + sr2;
            2: out = ~sr1;
            3: out = sr1 >> sr2;
        endcase
        */
        //This is a comment

        out = 0;
        out = sr1 & sr2;
        if (opcode == 1) out = sr1 + sr2;
        if (opcode == 2) out = ~sr1;
        if (opcode == 3) out = sr1 >> sr2;

    end
endmodule