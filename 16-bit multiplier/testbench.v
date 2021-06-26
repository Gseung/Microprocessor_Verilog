`timescale 1ns/100ps

module testbench;

reg [9:0] in1;
reg [5:0] in2;

wire [15:0] out;

multiplier_16b multiplier_16b_m0 (in1, in2, out);

initial begin

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h3ff;
in2 = 6'h3f;

#100

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h3f;
in2 = 6'h1f;

#100


in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h3ff;
in2 = 6'h30;

#100

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h3de;
in2 = 6'h3f;

#100

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h33f;
in2 = 6'h3f;

#100

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h3ef;
in2 = 6'h3f;

#100

in1 = 10'h000;
in2 = 6'h00;

#100

in1 = 10'h000;
in2 = 6'h00;

end
endmodule


