module main(
    input clk,
    input [3:0] btn,
    output strobe,
    output data,
    output shift_clk
);

    wire [7:0] seven_seg;
    reg [7:0] led;
    assign seven_seg = 0;

    shift_reg sreg(led, seven_seg, clk, strobe, data, shift_clk);

    reg [1:0] state, next_state;
    reg done, clear;
    reg out;

    //Control Path
    localparam cnt_hi = 0;
    localparam done_hi = 1;
    localparam cnt_lo = 2;
    localparam done_lo = 3;

    always @ (posedge clk) begin
        state <= next_state;
    end

    always @ (*) begin
        case (state)
            cnt_hi: begin
                out = 1;
                clear = 0;
                case (done)
                    0: next_state = cnt_hi;
                    1: next_state = done_hi;
                endcase
            end
            done_hi: begin
                out = 1;
                clear = 1;
                next_state = cnt_lo;
            end
            cnt_lo: begin
                out = 0;
                clear = 0;
                case (done)
                    0: next_state = cnt_lo;
                    1: next_state = done_lo;
                endcase
            end
            done_lo: begin
                out = 0;
                clear = 1;
                next_state = cnt_hi;
            end
        endcase
    end

    //Datapath
    localparam count_to = 500;
    reg [31:0] count, next_count;

    always @ (posedge clk) begin
        count <= next_count;
    end

    always @ (*) begin
        if (clear) next_count = 0;
        else next_count = count + 1;

        if (count == (count_to - 2)) done = 1;
        else done = 0;
    end

    //Connect to leds
    always @ (*) begin
        led = 0;
        led[0] = out;
        led[1] = 1;
    end

endmodule