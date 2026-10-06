module train(
    input clk,
    input l, r,
    output reg cross
);
    localparam idle = 2'b00;
    localparam entering = 2'b01;
    localparam between = 2'b10;
    localparam exiting = 2'b11;

    reg [1:0] state = 0;
    reg [1:0] next_state;

    always @ (posedge clk) begin
        state <= next_state;
    end

    always @ (*) begin
        case (state)
            idle: begin
                cross = 0;
                case ({l, r})
                    2'b00: next_state = idle;
                    2'b01: next_state = idle; //dont care
                    2'b10: next_state = entering;
                    2'b11: next_state = idle; // dont care
                endcase
            end
            entering: begin
                cross = 1;
                case ({l, r})
                    2'b00: next_state = between;
                    2'b01: next_state = idle; //dont care
                    2'b10: next_state = entering;
                    2'b11: next_state = between;
                endcase
            end
            between: begin
                cross = 1;
                case ({l, r})
                    2'b00: next_state = between;
                    2'b01: next_state = exiting;
                    2'b10: next_state = entering; //dont care
                    2'b11: next_state = between;
                endcase
            end
            exiting: begin
                cross = 1;
                case ({l, r})
                    2'b00: next_state = idle;
                    2'b01: next_state = exiting;
                    2'b10: next_state = entering;//dont care
                    2'b11: next_state = idle;//dont care
                endcase
            end
        endcase
    end 

endmodule