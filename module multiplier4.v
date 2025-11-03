module multiplier4 (
    input  [3:0] A, B,
    output [7:0] PRODUCT
);
    assign PRODUCT = A * B;
endmodule