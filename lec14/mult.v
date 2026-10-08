module mult_ctl(
    input clk, start, last,
    output reg done, load, step
);
    localparam IDLE = 2'd0;
    localparam LOAD = 2'd1;
    localparam STEP = 2'd2;
    reg [1:0] state = 0;
    reg [1:0] next_state;

    always @ (posedge clk) begin
        state <= next_state;
    end

    always @ (*) begin
        done = 0;
        load = 0;
        step = 0;
        case(state)
            IDLE: begin
                done = 1;
                if(start) next_state = LOAD;
                else next_state = IDLE;
            end
            LOAD: begin
                load = 1;
                next_state = STEP;
            end
            STEP: begin
                step = 1;
                if (last) next_state = IDLE;
                else next_state = STEP;
            end
        endcase
    end
endmodule

module mult_data(
    input clk, load, step,
    input [3:0] a, b,
    output reg last,
    output reg [7:0] prod
);
    reg [7:0] areg = 0;
    reg [7:0] prod = 0;
    reg [3:0] breg = 0;
    reg [1:0] count = 0;
    reg [7:0] next_areg;
    reg [7:0] next_prod;
    reg [3:0] next_breg;
    reg [1:0] next_count;

    always @ (posedge clk) begin
        areg <= next_areg;
        prod <= next_prod;
        breg <= next_breg;
        count <= next_count;
    end

    always @ (*) begin
        if (load) begin
            next_areg = {4'b0, a};
            next_breg = b;
            next_count = 0;
            next_prod = 0;
        end else begin
            next_areg = areg << 1;
            next_breg = b >> 1;
            next_count = count + 1;
            //To be continued in lecture 15
            //TODO: handle prod
        end
    end 
endmodule