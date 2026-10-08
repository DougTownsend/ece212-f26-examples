module debounce(
    input clk,
    input btn,
    output reg btn_db
);
    //Signal must be stable for 10ms.
    reg [31:0] count = 0;
    
    initial begin
        btn_db = 0;
    end

    always @ (posedge clk) begin
        if (btn != btn_db)begin
            if (count < 10) count <= count + 1;
            else begin
                count <= 0;
                btn_db <= btn;
            end
        end
        else count <= 0;
    end

endmodule