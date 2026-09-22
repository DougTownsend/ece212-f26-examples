module nzp(
    input signed [3:0] in,
    output reg n, z, p
);

    always @ (*) begin
        n = 0;
        z = 0;
        p = 0;
        if (in == 0) z = 1;
        if (in < 0) n = 1;
        if (in > 0) p = 1;
    end

endmodule