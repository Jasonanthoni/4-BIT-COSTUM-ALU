`timescale 1ns/1ps

module alu_tb;

   
    reg  [3:0] A;
    reg  [3:0] B;
    reg  [2:0] opcode;
    wire [7:0] result;
    wire       carry_out;

    
    localparam OP_ADD  = 3'b000;
    localparam OP_SUB  = 3'b001;
    localparam OP_MUL  = 3'b010;
    localparam OP_DIV  = 3'b011;
    localparam OP_NAND = 3'b100;
    localparam OP_NOT  = 3'b101;
    localparam OP_CMP  = 3'b110;
    localparam OP_AVG  = 3'b111;

   
    alu_top DUT (
        .A          (A),
        .B          (B),
        .opcode     (opcode),
        .result     (result),
        .carry_out  (carry_out)
    );

  
    initial begin
       
        A = 4'd0; B = 4'd0; opcode = OP_ADD; 

       
        $dumpfile("alu_top.vcd");
        $dumpvars(0, alu_tb);
        
        $display("----------------------------------------------------------------------------------");
        $display("| Time | OpCode | A | B | Result (Hex) | Result (Dec) | Carry | Expected Check |");
        $display("----------------------------------------------------------------------------------");

        
        #10 A = 4'hC; B = 4'h3; opcode = OP_ADD;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd15) ? "PASS" : "FAIL");

        #10 A = 4'hF; B = 4'h1; opcode = OP_ADD;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd0) && (carry_out == 1'b1) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'h1; opcode = OP_SUB;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd14) && (carry_out == 1'b1) ? "PASS" : "FAIL");

        #10 A = 4'h1; B = 4'hF; opcode = OP_SUB;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (carry_out == 1'b0) ? "PASS" : "FAIL"); 

        #10 A = 4'hA; B = 4'h3; opcode = OP_MUL;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd30) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'hF; opcode = OP_MUL;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'hE1) ? "PASS" : "FAIL");

        #10 A = 4'hD; B = 4'h3; opcode = OP_DIV;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h14) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'h0; opcode = OP_DIV;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h00) ? "PASS" : "FAIL");

     
        #10 A = 4'hA; B = 4'h5; opcode = OP_NAND; 
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h0F) ? "PASS" : "FAIL");

        #10 A = 4'hA; B = 4'h0; opcode = OP_NOT;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h05) ? "PASS" : "FAIL");

        #10 A = 4'h9; B = 4'h9; opcode = OP_CMP; 
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h01) ? "PASS" : "FAIL");

        #10 A = 4'hA; B = 4'h5; opcode = OP_AVG;  
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd7) ? "PASS" : "FAIL");

        #10 $finish; 
    end

   
    reg clk = 0;
    always #5 clk = ~clk;

endmodule
