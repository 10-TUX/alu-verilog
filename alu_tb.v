
//===================================== Testbench for 32-bit ALU =====================================\\
//================================== Tests every supported operation ==================================\\
//======================================================================================================\\
`timescale 1ns /1ps
`include "alu_defines.vh"

module alu_tb;

    parameter WIDTH = 32;
    reg [WIDTH-1:0] A;
    reg [WIDTH-1:0] B;
    reg [3:0] alu_control;

    wire [WIDTH-1:0] result;
    wire zero;
    wire overflow;
    wire carry;
    wire negative;

    integer tests;
    integer passed;

    alu #(WIDTH) dut (
        .A(A),
        .B(B),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .overflow(overflow),
        .carry(carry),
        .negative(negative)
    );

    task check_result;
        input[WIDTH-1:0]expected;
        input[8*20:1]operation;
        
        begin
            tests = tests +1;
            if (result == expected)begin
                $display("%s : PASS", operation);
                passed = passed +1;
            end
            else begin
                $display("%s : FAIL (Expected = %d, got = %d)", operation, expected, result);
            end
        end
    endtask

    task test_operation;
        input[3:0] op;
        input[WIDTH-1:0]expected;
        input[8*20:1]operation;

        begin
            alu_control = op;#10;
            check_result(expected,operation);
        end
    endtask

    task check_flags;
        input expected_zero;
        input expected_carry;
        input expected_overflow;
        input expected_negative;
        begin
            if (zero != expected_zero)
                $display("ZERO FLAG FAIL");
            if (carry != expected_carry)
                $display("CARRY FLAG FAIL");
            if(overflow != expected_overflow)
                $display("OVERFLOW FLAG FAIL");
            if(negative != expected_negative)
                $display("NEGATIVE FLAG FAIL");
        end
    endtask


    initial begin
        $display("----------------------------------------");
        $display("32-bit Parameterized ALU Testbench");
        $display("----------------------------------------");

        $dumpfile("alu.vcd");
        $dumpvars(0,alu_tb);

        tests =0;
        passed =0;

//-----------------------------------------  Arithmetic Operations  --------------------------------------------\\
        A = 15;
        B = 20;
        test_operation(`ALU_ADD,35, "ADD");
        test_operation(`ALU_SUB, -5, "SUB");

//-----------------------------------------  Logical Operations  --------------------------------------------\\
        test_operation(`ALU_AND, 4, "AND");
        test_operation(`ALU_OR,31,"OR");
        test_operation(`ALU_XOR, 27, "XOR");
        test_operation(`ALU_NOR,32'hFFFFFFE0 , "NOR");

        // Test case 4 : NOT A/XNOR/PASS A/PASS B
        A = 3;
        B = 8;
        test_operation(`ALU_NOT,32'hFFFFFFFC,"NOT");
        test_operation(`ALU_XNOR,32'hFFFFFFF4,"XNOR");

        test_operation(`ALU_SLT, 1, "SLT");

        // Test Case 2: Verify Zero Flag
        A = 3;
        B = 8;

        test_operation(`ALU_AND, 0, "AND");
        test_operation(`ALU_PASSA,3,"PASS A");
        test_operation(`ALU_PASSB,8,"PASS B");
        test_operation(`ALU_SUB,-5,"NEGATIVE TEST");
        check_flags(0,0,0,1);

//-----------------------------------------  Shift Operations  --------------------------------------------\\

        // Test case 3 : SLL/SRL/SRA
        A = 3;
        B = 2;
        
        test_operation(`ALU_SLL,12,"SLL");
        test_operation(`ALU_SRL,0,"SRL");
        test_operation(`ALU_SRA,0,"SRA");

        // Test Case to Verify Overflow Flag
        A = 32'h7FFFFFFF;
        B = 32'h00000001;

        test_operation(`ALU_ADD,32'h80000000,"ADD OVERFLOW");
        check_flags(0,0,1,1);

        $display("----------------------------------------");
        $display("Simulation Complete");
        $display("Passed %0d / %0d tests",passed,tests);
        $display("----------------------------------------");

        $finish;
    end

endmodule