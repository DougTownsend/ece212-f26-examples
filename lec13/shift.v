module shift_reg(
    input [7:0] led,
    input [7:0] seven_seg,
    input clk,
    output reg strobe,
    output reg data,
    output reg shift_clk
);
    initial begin
        strobe = 0;
        data = 0;
        shift_clk = 0;
    end

    wire [7:0] led_byte;
    assign led_byte = {led[3:0], led[7:4]};
    reg [1:0] state = 0;
    reg [1:0] next_state = 0;
    reg [2:0] current_bit = 7;
    reg [2:0] next_bit = 0;
    reg next_strobe = 0;
    reg next_data = 0;
    reg next_clk = 0;

    always @(posedge clk) begin
        shift_clk <= next_clk;
        data <= next_data;
        strobe <= next_strobe;
        state <= next_state;
        current_bit <= next_bit;
    end

    always @ (*) begin
        next_bit = current_bit;
        next_state = state;
        next_strobe = 0;
        next_data = data;
        next_clk = shift_clk;
        case(state)
            0: begin
                next_clk = ~shift_clk;
                if(shift_clk) begin
                    next_data = seven_seg[current_bit];
                    next_bit = current_bit - 1;
                    if (current_bit == 0) next_state = 1;
                end
            end

            1: begin
                next_clk = ~shift_clk;
                if(shift_clk) begin
                    next_data = led_byte[current_bit];
                    next_bit = current_bit - 1;
                    if (current_bit == 0) next_state = 2;
                end
            end

            2: begin
                next_clk = 1;
                next_state = 3;
            end

            3: begin
                next_strobe = 1;
                next_state = 0;
            end
        endcase   
    end

endmodule