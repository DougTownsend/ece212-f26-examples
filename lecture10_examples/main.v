module main(
    input clk,
    input [3:0] btn,
    input [7:0] sw,
    output reg [6:0] led
);
    initial begin
        led = 0;
    end

    always @ (*) begin
        //combinational logic
    end
    wire btn_db;
    debounce db_btn0(clk, btn[0], btn_db);

    always @ (posedge btn_db) begin
        //Sequential logic
        //Anything assigned to in here will be a DFF
        led[3:0] = led[3:0] + 1;
    end

endmodule