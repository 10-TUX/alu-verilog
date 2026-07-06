//===================================== Testbench for 32-bit ALU =====================================\\
//================================== Tests every supported operation ==================================\\
//======================================================================================================\\

module alu_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] alu_control;

    wire [31:0] result;
    wire zero;

    alu dut (.A(A), .B(B), .alu_control(alu_control), .result(result), .zero(zero));

    initial begin
        //Test Case 1//
        A = 15;
        B = 20;

        alu_control = 4'b0000;#10;
        $display("ADD : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0001;#10;
        $display("SUB : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0010;#10;
        $display("AND : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0011;#10;
        $display("OR : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0100;#10;
        $display("XOR : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0101;#10;
        $display("NOR : Result = %d, Zero = %b",result,zero);

        alu_control = 4'b0110;#10;
        $display("SLT : Result = %d, Zero = %b",result,zero);

        // Test Case 2: Verify Zero Flag
        A = 3;
        B = 8;

        alu_control = 4'b0010;#10; //AND
        $display("AND (3,8): Result = %d, Zero = %b", result, zero);

        $finish;
    end

endmodule