module main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output strobe,
    output data,
    output shift_clk
);
    wire [7:0] seven_seg;
    reg [7:0] led;
    shift_reg sreg(led, seven_seg, clk, strobe, data, shift_clk);
    wire [1:0] btn_db;
    debounce db0(clk, btn[0], btn_db[0]);

endmodule