module sub (
    input  [3:0] A, B,      // inputs A and B
    output [3:0] DIFF,      // output difference
    output COUT             // output borrow flag
);

    wire [4:0] temp;        // 5-bit wire to hold result with borrow

    assign temp = {1'b0, A} - {1'b0, B};  // perform subtraction

    assign DIFF = temp[3:0];      // assign lower 4 bits as difference          

    assign COUT = ~temp[4];          // invert MSB to get borrow out         
    
endmodule
