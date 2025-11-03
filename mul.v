module mul (
    input  [3:0] A, B,      // inputs A and B
    output [7:0] product    // output product
);
    assign product = A * B;   // multiply A and B

endmodule
