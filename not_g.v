module not_g(
input [3:0] A,
output [7:0] Y
);
    assign Y = {4'b000, ~A};
endmodule


