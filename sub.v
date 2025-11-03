module sub (
    input  [3:0] A, B,
    output [3:0] DIFF,
    output BORROW
);
    assign {BORROW, DIFF} = A-B;

endmodule
