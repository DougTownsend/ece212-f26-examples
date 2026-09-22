module and_gate(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule

module alu(
    input [1:0] opcode,
    input [3:0] sr1,
    input [3:0] sr2,
    output reg [3:0] out
);
    always @(*) begin
        case (opcode)
            0: out = sr1 & sr2;
            1: out = sr1 + sr2;
            2: out = ~sr1;
            3: out = 0;
        endcase
    end

endmodule


module main(
    input btn,
    input btn2, 
    output reg led
);
    and_gate and1(btn, btn2, led);
    //assign led = 1;
endmodule