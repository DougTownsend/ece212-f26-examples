
module seq_moore(
    input clk,
    input in,
    output reg out,
    output reg [1:0] state
);
    reg [1:0] next_state;
    localparam idle = 2'b00;
    localparam s1 = 2'b01;
    localparam s10 = 2'b10;
    localparam s101 = 2'b11;

    //Initialze state to idle
    initial begin
        state = idle;
    end

    always @ (posedge clk) begin
        state <= next_state;
    end

    //next state logic
    always @ (*) begin
        case (state)
            idle: begin
                if(in == 0) next_state = idle;
                else next_state = s1;
            end
            s1: begin
                if(in == 0) next_state = s10;
                else next_state = s1;
            end
            s10: begin
                if(in == 0) next_state = idle;
                else next_state = s101;
            end
            s101: begin
                if(in == 0) next_state = s10;
                else next_state = s1;
            end
        endcase
    end

    //output logic
    always @(*) begin
        if (state == s101) out = 1;
        else out = 0;
    end

endmodule

module seq_mealy(
    input clk,
    input in,
    output reg out,
    output reg [1:0] state
);

    reg[1:0] next_state;
    
    initial begin
        state = 2'b0;
    end

    always @ (posedge clk) begin
        state <= next_state;
    end

    always @ (*) begin
        case(state)
            2'b00: begin
                if (in == 0) begin
                    next_state = 2'b00;
                    out = 0;
                end else begin
                    next_state = 2'b01;
                    out = 0;
                end
            end
            2'b01: begin
                if (in == 0) begin
                    next_state = 2'b10;
                    out = 0;
                end else begin
                    next_state = 2'b01;
                    out = 0;
                end
            end
            2'b10: begin
                if (in == 0) begin
                    next_state = 2'b00;
                    out = 0;
                end else begin
                    next_state = 2'b01;
                    out = 1;
                end
            end
            default: begin
                next_state = 2'b00;
                out = 0;
            end
        endcase
    end

endmodule