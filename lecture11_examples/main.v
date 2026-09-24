module main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output [6:0] led
);
    wire btn_db;
    debounce db_btn0(clk, btn[0], btn_db);
    //seq_moore fsm1(btn_db, btn[1], led[6], led[3:2]);
    seq_mealy fsm1(btn_db, btn[1], led[6], led[3:2]);
    assign led[0] = btn_db;
    assign led[1] = btn[1];

endmodule