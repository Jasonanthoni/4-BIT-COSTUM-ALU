module nand_g(
    input [3:0] A, B,     // inputs A and B
    output [7:0] Y        // output Y
);
    assign Y = {4'b0000, ~(A & B)};   // perform bitwise NAND and extend to 8 bits
endmodule
