module NAND(input [3:0] A, B, output [7:0] Y);
    assign Y = 4'b0000, ~(A & B);

endmodule
