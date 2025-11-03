module sub (
    input  [3:0] A, B,
    output [3:0] DIFF,
    output BORROW_OUT 
);
    
    wire [3:0] B_inv = ~B;
    wire C_out; 
    assign {C_out, DIFF} = A + B_inv + 1'b1;
    assign BORROW_OUT = ~C_out; 
    
endmodule
