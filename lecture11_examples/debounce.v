module debounce(
    input clk,
    input btn,
    output reg btn_db
);

    reg [31:0] count = 0;

    always @ (posedge clk) begin
        if (btn != btn_db)begin
            if (count < 120000) count <= count + 1;
            else begin
                count <= 0;
                btn_db <= btn;
            end
        end
        else count <= 0;
    end

endmodule