module sub (
    input  [3:0] A, B,
    output [3:0] DIFF,
    output COUT // Borrow out
);
    wire [4:0] temp;
    assign temp = {1'b0, A} - {1'b0, B};  
    assign DIFF = temp[3:0];              
    assign COUT = ~temp[4];               
endmodule
