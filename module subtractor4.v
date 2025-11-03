module subtractor4 (
    input  [3:0] A, B,
    output [3:0] DIFF,
    output BORROW
);
    assign {BORROW, DIFF} = {1'b0, A} - {1'b0, B};
endmodule