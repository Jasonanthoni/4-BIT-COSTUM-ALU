module add (
    input  [3:0] A, B,
    output [3:0] SUM,
    output COUT
);
    assign {COUT, SUM} = A + B;

endmodule
