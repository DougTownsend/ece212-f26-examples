module main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output [6:0] led
);
    wire [3:0] btn_db;
    debounce db_btn0(clk, btn[0], btn_db[0]);
    debounce db_btn1(clk, btn[1], btn_db[1]);
    debounce db_btn2(clk, btn[2], btn_db[2]);
    debounce db_btn3(clk, btn[3], btn_db[3]);

    train t1(clk, btn_db[0], btn_db[1], led[4]);
    assign led[0] = btn_db[1];
    assign led[3] = btn_db[0];
endmodule