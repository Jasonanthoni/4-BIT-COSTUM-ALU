`timescale 1ns/1ps

module alu_tb;

    // ----------------------------------------------------
    // 1. Signals for connecting to the Device Under Test (DUT)
    // ----------------------------------------------------
    reg  [3:0] A;
    reg  [3:0] B;
    reg  [2:0] opcode;
    wire [7:0] result;
    wire       carry_out;

    // ----------------------------------------------------
    // 2. Local Parameters for Opcodes (Improves Readability)
    // ----------------------------------------------------
    localparam OP_ADD  = 3'b000;
    localparam OP_SUB  = 3'b001;
    localparam OP_MUL  = 3'b010;
    localparam OP_DIV  = 3'b011;
    localparam OP_NAND = 3'b100;
    localparam OP_NOT  = 3'b101;
    localparam OP_CMP  = 3'b110;
    localparam OP_AVG  = 3'b111;

    // ----------------------------------------------------
    // 3. Instantiate the ALU Top Module (DUT)
    // ----------------------------------------------------
    alu_top DUT (
        .A          (A),
        .B          (B),
        .opcode     (opcode),
        .result     (result),
        .carry_out  (carry_out)
    );

    // ----------------------------------------------------
    // 4. Initial Block for Test Vectors
    // ----------------------------------------------------
    initial begin
        // Initialize inputs
        A = 4'd0; B = 4'd0; opcode = OP_ADD; 

        // Setup VCD for waveform viewing
        $dumpfile("alu_top.vcd");
        $dumpvars(0, alu_tb);
        
        $display("----------------------------------------------------------------------------------");
        $display("| Time | OpCode | A | B | Result (Hex) | Result (Dec) | Carry | Expected Check |");
        $display("----------------------------------------------------------------------------------");

        // ==========================================================
        // Test Case 1: Arithmetic Operations (Max Values & Carry/Borrow)
        // ==========================================================
        #10 A = 4'hC; B = 4'h3; opcode = OP_ADD;  // 12 + 3 = 15. Expected: 15, Carry: 0
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd15) ? "PASS" : "FAIL");

        #10 A = 4'hF; B = 4'h1; opcode = OP_ADD;  // 15 + 1 = 16. Expected: 16 (1'h0, carry=1)
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd0) && (carry_out == 1'b1) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'h1; opcode = OP_SUB;  // 15 - 1 = 14. Expected: 14, Carry: 1 (no borrow)
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd14) && (carry_out == 1'b1) ? "PASS" : "FAIL");

        #10 A = 4'h1; B = 4'hF; opcode = OP_SUB;  // 1 - 15 = -14. Expected: Carry: 0 (borrow required)
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (carry_out == 1'b0) ? "PASS" : "FAIL"); 

        // ==========================================================
        // Test Case 2: Multiplication and Division
        // ==========================================================
        #10 A = 4'hA; B = 4'h3; opcode = OP_MUL;  // 10 * 3 = 30. Expected: 8'd30
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd30) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'hF; opcode = OP_MUL;  // 15 * 15 = 225. Expected: 8'd225 (E1 in hex)
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'hE1) ? "PASS" : "FAIL");

        #10 A = 4'hD; B = 4'h3; opcode = OP_DIV;  // 13 / 3 = 4, Remainder: 1. Expected: {Rem, Quo} = {1, 4} = 8'h14
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h14) ? "PASS" : "FAIL");
        
        #10 A = 4'hF; B = 4'h0; opcode = OP_DIV;  // Division by Zero. Expected: 8'h00
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h00) ? "PASS" : "FAIL");

        // ==========================================================
        // Test Case 3: Logical and Custom Operations
        // ==========================================================
        #10 A = 4'hA; B = 4'h5; opcode = OP_NAND; // (10 NAND 5) = NOT(10 AND 5) = NOT(0) = 15. Expected: 8'hF
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h0F) ? "PASS" : "FAIL");

        #10 A = 4'hA; B = 4'h0; opcode = OP_NOT;  // NOT(10) = 5. Expected: 8'h5
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h05) ? "PASS" : "FAIL");

        #10 A = 4'h9; B = 4'h9; opcode = OP_CMP;  // 9 == 9. Expected: A=B flag (8'h01)
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'h01) ? "PASS" : "FAIL");

        #10 A = 4'hA; B = 4'h5; opcode = OP_AVG;  // (10 + 5) / 2 = 7. Expected: 8'd7
        #10 $display("| %4d | %7b| %h| %h| %12h | %12d | %5b | %s |", $time, opcode, A, B, result, result, carry_out, (result == 8'd7) ? "PASS" : "FAIL");

        #10 $finish; // End simulation
    end

    // ----------------------------------------------------
    // 5. Clock Generator (Optional but good practice)
    // ----------------------------------------------------
    reg clk = 0;
    always #5 clk = ~clk;

endmodule
