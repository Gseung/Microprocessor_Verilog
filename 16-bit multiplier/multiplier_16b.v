`timescale 1ns/100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seung-il Ko
// 
// Create Date: 2021/06/14 20:39:07
// Design Name: 
// Module Name: multiplier_16b
// Project Name: 16-bit multiplier
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module booth_encoding (x2i_p1, x2i, x2i_n1, single, double, neg);
input x2i_p1, x2i, x2i_n1;
output single, double, neg;

wire bar_x2i_p1, bar_x2i, bar_x2i_n1;
wire bar_sig, bar_dou, bar_neg;
wire w_i0, w_i1;
wire w_o0, w_o1, w_o2;

INV INV_00 (x2i_p1, bar_x2i_p1);
INV INV_01 (x2i, bar_x2i);
INV INV_02 (x2i_n1, bar_x2i_n1);

// SINGLE
XOR_2I1O XOR2_00 (x2i_n1, x2i, single);

// DOUBLE
NAND_3I1O NAND3_00 (x2i_n1, x2i, bar_x2i_p1, w_i0);
NAND_3I1O NAND3_01 (bar_x2i_n1, bar_x2i, x2i_p1, w_i1);
INV INV_03 (w_i0, w_o0);
INV INV_04 (w_i1, w_o1);
// or gate
NOR_2I1O NOR2_00 (w_o0, w_o1, w_o2);
INV INV_05 (w_o2, double);

// NEG
assign neg = x2i_p1;

endmodule

module BUF (i, o);
input i;
output o;

wire w;

INV INV_00 (i, w);
INV INV_01 (w, o);

endmodule


module booth_selector (single, double, neg, Y, pp);
input single, double, neg;
input [9:0] Y;
output [9:0] pp;

wire [10:0] o_w;
wire [10:0] op0, op1;
wire [10:0] w_single;
wire [10:0] w_double;
wire [10:0] Y_shift;

AND_2I1O AND2_single00 (Y[0], single, w_single[0]);
AND_2I1O AND2_single01 (Y[1], single, w_single[1]);
AND_2I1O AND2_single02 (Y[2], single, w_single[2]);
AND_2I1O AND2_single03 (Y[3], single, w_single[3]);
AND_2I1O AND2_single04 (Y[4], single, w_single[4]);
AND_2I1O AND2_single05 (Y[5], single, w_single[5]);
AND_2I1O AND2_single06 (Y[6], single, w_single[6]);
AND_2I1O AND2_single07 (Y[7], single, w_single[7]);
AND_2I1O AND2_single08 (Y[8], single, w_single[8]);
AND_2I1O AND2_single09 (Y[9], single, w_single[9]);

left_1shift shift_00 (Y, Y_shift);

AND_2I1O AND2_double00 (Y_shift[0], double, w_double[0]);
AND_2I1O AND2_double01 (Y_shift[1], double, w_double[1]);
AND_2I1O AND2_double02 (Y_shift[2], double, w_double[2]);
AND_2I1O AND2_double03 (Y_shift[3], double, w_double[3]);
AND_2I1O AND2_double04 (Y_shift[4], double, w_double[4]);
AND_2I1O AND2_double05 (Y_shift[5], double, w_double[5]);
AND_2I1O AND2_double06 (Y_shift[6], double, w_double[6]);
AND_2I1O AND2_double07 (Y_shift[7], double, w_double[7]);
AND_2I1O AND2_double08 (Y_shift[8], double, w_double[8]);
AND_2I1O AND2_double09 (Y_shift[9], double, w_double[9]);

NOR_2I1O NOR2_00 (w_single[0], w_double[0], op0[0]);
NOR_2I1O NOR2_01 (w_single[1], w_double[1], op0[1]);
NOR_2I1O NOR2_02 (w_single[2], w_double[2], op0[2]);
NOR_2I1O NOR2_03 (w_single[3], w_double[3], op0[3]);
NOR_2I1O NOR2_04 (w_single[4], w_double[4], op0[4]);
NOR_2I1O NOR2_05 (w_single[5], w_double[5], op0[5]);
NOR_2I1O NOR2_06 (w_single[6], w_double[6], op0[6]);
NOR_2I1O NOR2_07 (w_single[7], w_double[7], op0[7]);
NOR_2I1O NOR2_08 (w_single[8], w_double[8], op0[8]);
NOR_2I1O NOR2_09 (w_single[9], w_double[9], op0[9]);

INV INV_00 (op0[0], op1[0]);
INV INV_01 (op0[1], op1[1]);
INV INV_02 (op0[2], op1[2]);
INV INV_03 (op0[3], op1[3]);
INV INV_04 (op0[4], op1[4]);
INV INV_05 (op0[5], op1[5]);
INV INV_06 (op0[6], op1[6]);
INV INV_07 (op0[7], op1[7]);
INV INV_08 (op0[8], op1[8]);
INV INV_09 (op0[9], op1[9]);

XOR_2I1O XOR2_00 (op1[0], neg, pp[0]);
XOR_2I1O XOR2_01 (op1[1], neg, pp[1]);
XOR_2I1O XOR2_02 (op1[2], neg, pp[2]);
XOR_2I1O XOR2_03 (op1[3], neg, pp[3]);
XOR_2I1O XOR2_04 (op1[4], neg, pp[4]);
XOR_2I1O XOR2_05 (op1[5], neg, pp[5]);
XOR_2I1O XOR2_06 (op1[6], neg, pp[6]);
XOR_2I1O XOR2_07 (op1[7], neg, pp[7]);
XOR_2I1O XOR2_08 (op1[8], neg, pp[8]);
XOR_2I1O XOR2_09 (op1[9], neg, pp[9]);

endmodule

module sign_ext00 (in1, neg, o);
input [9:0] in1;
input neg;
output [15:0] o;

wire bar_neg;

INV INV_00 (neg, bar_neg); 

BUF buf_00 (in1[0], o[0]);
BUF buf_01 (in1[1], o[1]);
BUF buf_02 (in1[2], o[2]);
BUF buf_03 (in1[3], o[3]);
BUF buf_04 (in1[4], o[4]);
BUF buf_05 (in1[5], o[5]);
BUF buf_06 (in1[6], o[6]);
BUF buf_07 (in1[7], o[7]);
BUF buf_08 (in1[8], o[8]);
BUF buf_09 (in1[9], o[9]);
BUF buf_10 (neg, o[10]);
BUF buf_11 (neg, o[11]);
BUF buf_12 (bar_neg, o[12]);
BUF buf_13 (0, o[13]);
BUF buf_14 (0, o[14]);
BUF buf_15 (0, o[15]);
endmodule

module sign_ext01 (in1, neg_1, neg_2, o);
input [9:0] in1; 
input neg_1, neg_2;
output [15:0] o;

wire bar_neg_2;

INV INV_00 (neg_2, bar_neg_2); 

BUF buf_00 (neg_2, o[0]);
BUF buf_01 (0, o[1]);
BUF buf_02 (in1[0], o[2]);
BUF buf_03 (in1[1], o[3]);
BUF buf_04 (in1[2], o[4]);
BUF buf_05 (in1[3], o[5]);
BUF buf_06 (in1[4], o[6]);
BUF buf_07 (in1[5], o[7]);
BUF buf_08 (in1[6], o[8]);
BUF buf_09 (in1[7], o[9]);
BUF buf_10 (in1[8], o[10]);
BUF buf_11 (in1[9], o[11]);
BUF buf_12 (bar_neg_2, o[12]);
BUF buf_13 (1, o[13]);
BUF buf_14 (0, o[14]);
BUF buf_15 (0, o[15]);

endmodule

module sign_ext02 (in1, neg_1, neg_2, o);
input [9:0] in1;
input neg_1, neg_2;
output [15:0] o;

wire bar_neg_2;

INV INV_00 (neg_2, bar_neg_2);

BUF buf_00 (0, o[0]);
BUF buf_01 (0, o[1]);
BUF buf_02 (neg_1, o[2]);
BUF buf_03 (0, o[3]);
BUF buf_04 (in1[0], o[4]);
BUF buf_05 (in1[1], o[5]);
BUF buf_06 (in1[2], o[6]);
BUF buf_07 (in1[3], o[7]);
BUF buf_08 (in1[4], o[8]);
BUF buf_09 (in1[5], o[9]);
BUF buf_10 (in1[6], o[10]);
BUF buf_11 (in1[7], o[11]);
BUF buf_12 (in1[8], o[12]);
BUF buf_13 (in1[9], o[13]);
BUF buf_14 (bar_neg_2, o[14]);
BUF buf_15 (1, o[15]);

endmodule

module sign_ext03 (in1, neg_1, neg_2, o);
input [9:0] in1; 
input neg_1, neg_2;
output [15:0] o;

wire bar_neg_2;

INV INV_00 (neg_2, bar_neg_2);

BUF buf_00 (0, o[0]);
BUF buf_01 (0, o[1]);
BUF buf_02 (0, o[2]);
BUF buf_03 (0, o[3]);
BUF buf_04 (neg_1, o[4]);
BUF buf_05 (0, o[5]);
BUF buf_06 (in1[0], o[6]);
BUF buf_07 (in1[1], o[7]);
BUF buf_08 (in1[2], o[8]);
BUF buf_09 (in1[3], o[9]);
BUF buf_10 (in1[4], o[10]);
BUF buf_11 (in1[5], o[11]);
BUF buf_12 (in1[6], o[12]);
BUF buf_13 (in1[7], o[13]);
BUF buf_14 (in1[8], o[14]);
BUF buf_15 (in1[9], o[15]);

endmodule


module full_adder_16b(i_a, i_b, cin, sum, cout);

input [15:0] i_a, i_b;
input cin;
output [15:0] sum;
output cout;

wire [15:0] w0;

full_adder FA_00(i_a[0], i_b[0], cin, sum[0], w0[0]);
full_adder FA_01(i_a[1], i_b[1], w0[0], sum[1], w0[1]);
full_adder FA_02(i_a[2], i_b[2], w0[1], sum[2], w0[2]);
full_adder FA_03(i_a[3], i_b[3], w0[2], sum[3], w0[3]);

full_adder FA_04(i_a[4], i_b[4], w0[3], sum[4], w0[4]);
full_adder FA_05(i_a[5], i_b[5], w0[4], sum[5], w0[5]);
full_adder FA_06(i_a[6], i_b[6], w0[5], sum[6], w0[6]);
full_adder FA_07(i_a[7], i_b[7], w0[6], sum[7], w0[7]);

full_adder FA_08(i_a[8], i_b[8], w0[7], sum[8], w0[8]);
full_adder FA_09(i_a[9], i_b[9], w0[8], sum[9], w0[9]);
full_adder FA_10(i_a[10], i_b[10], w0[9], sum[10], w0[10]);
full_adder FA_11(i_a[11], i_b[11], w0[10], sum[11], w0[11]);

full_adder FA_12(i_a[12], i_b[12], w0[11], sum[12], w0[12]);
full_adder FA_13(i_a[13], i_b[13], w0[12], sum[13], w0[13]);
full_adder FA_14(i_a[14], i_b[14], w0[13], sum[14], w0[14]);
full_adder FA_15(i_a[15], i_b[15], w0[14], sum[15], cout);

endmodule

module full_adder (i_a, i_b, cin, sum, cout);
input i_a, i_b, cin;
output sum, cout;

wire w0, w1, w2;

XOR_2I1O XOR2_00 (i_a, i_b, w0);
XOR_2I1O XOR2_01 (w0, cin, sum);

AND_2I1O AND2_00 (cin, w0, w1);
AND_2I1O AND2_01 (i_a, i_b, w2);
OR_2I1O OR_00 (w1, w2, cout);

endmodule

module multiplier_16b (in1, in2, out);
input [9:0] in1;
input [5:0] in2;
output [15:0] out;

wire ws0, ws1, ws2, ws3;
wire wd0, wd1, wd2, wd3;
wire wn0, wn1, wn2, wn3;

wire [9:0] pp_t0, pp_t1, pp_t2, pp_t3;
wire [15:0] pp_0, pp_1, pp_2, pp_3;

wire [15:0] w_sum0, w_sum1, w_sum2;
wire c_o0, c_o1, c_o2;

// Write netlists for your multiplier from this line.

booth_encoding be_00 (in2[1], in2[0], 0, ws0, wd0, wn0);
booth_selector bs_00 (ws0, wd0, wn0, in1, pp_t0);
sign_ext00 ex_00 (pp_t0, wn0, pp_0);

booth_encoding be_02 (in2[3], in2[2], in2[1], ws1, wd1, wn1);
booth_selector bs_01 (ws1, wd1, wn1, in1, pp_t1);
sign_ext01 ex_01 (pp_t1, wn0, wn1, pp_1);

booth_encoding be_03 (in2[5], in2[4], in2[3], ws2, wd2, wn2);
booth_selector bs_02 (ws2, wd2, wn2, in1, pp_t2);
sign_ext02 ex_02 (pp_t2, wn1, wn2, pp_2);

// CPA
booth_encoding be_04 (0, 0, in2[5], ws3, wd3, wn3);
booth_selector bs_03 (ws3, wd3, wn3, in1, pp_t3);
sign_ext03 ex_03 (pp_t3, wn2, wn3, pp_3);

//full_adder_16b FA_00(pp_0, pp_1, 0, w_sum0, c_o0);
//full_adder_16b FA_01(pp_2, pp_3, 0, w_sum1, c_o1);
//full_adder_16b FA_02(w_sum0, w_sum1, 0, out, c_o2);

// Kogge-Stone
adder_16b FA_00(pp_0, pp_1, w_sum0, 0, c_o0);
adder_16b FA_01(pp_2, pp_3, w_sum1, 0, c_o1);
adder_16b FA_02(w_sum0, w_sum1, out, 0, c_o2);

endmodule

module left_1shift (ip, op);
input [9:0] ip;
output [10:0] op;

BUF buf_00 (0, op[0]);
BUF buf_01 (ip[0], op[1]);
BUF buf_02 (ip[1], op[2]);
BUF buf_03 (ip[2], op[3]);
BUF buf_04 (ip[3], op[4]);
BUF buf_05 (ip[4], op[5]);
BUF buf_06 (ip[5], op[6]);
BUF buf_07 (ip[6], op[7]);
BUF buf_08 (ip[7], op[8]);
BUF buf_09 (ip[8], op[9]);
BUF buf_10 (ip[9], op[10]);

endmodule


module XOR_2I1O (i0, i1, o);
input i0;
input i1;
output o;

wire w0, w1, w2;

NAND_2I1O NAND2_00 (i0, i1, w0);
NAND_2I1O NAND2_01 (i0, w0, w1);
NAND_2I1O NAND2_02 (i1, w0, w2);
NAND_2I1O NAND2_03 (w1, w2, o);

endmodule

module AND_2I1O (i0, i1, o);
input i0;
input i1;
output o;

wire w0;

NAND_2I1O NAND2_00 (i0, i1, w0);
INV INV_00 (w0, o);

endmodule

module OR_2I1O (i0, i1, o);
input i0;
input i1;
output o;

wire w0;

NOR_2I1O NOR2_00 (i0, i1, w0);
INV INV_00 (w0, o);

endmodule

module NAND_2I1O (i0, i1, o);
input i0;
input i1;
output o;

wire w0, w1;

assign #(0.1, 0.1) w0 = i0;
assign #(0.1, 0.2) w1 = i1;


assign o = ~(w0 & w1);

endmodule

module NAND_3I1O (i0, i1, i2, o);
input i0;
input i1;
input i2;
output o;

wire w0, w1, w2;

assign #(0.1, 0.1) w0 = i0;
assign #(0.1, 0.2) w1 = i1;
assign #(0.1, 0.3) w2 = i2;

assign o = ~(w0 & w1 & w2);

endmodule

module NAND_4I1O (i0, i1, i2, i3, o);
input i0;
input i1;
input i2;
input i3;
output o;

wire w0, w1, w2, w3;

assign #(0.1, 0.1) w0 = i0;
assign #(0.1, 0.2) w1 = i1;
assign #(0.1, 0.3) w2 = i2;
assign #(0.1, 0.4) w3 = i3;

assign o = ~(w0 & w1 & w2 & w3);

endmodule


module NOR_2I1O (i0, i1, o);
input i0;
input i1;
output o;

wire w0, w1;

assign #(0.2, 0.1) w0 = i0;
assign #(0.1, 0.1) w1 = i1;

assign o = ~(w0 | w1);

endmodule

module NOR_3I1O (i0, i1, i2, o);
input i0;
input i1;
input i2;
output o;

wire w0, w1, w2;

assign #(0.3, 0.1) w0 = i0;
assign #(0.2, 0.1) w1 = i1;
assign #(0.1, 0.1) w2 = i2;

assign o = ~(w0 | w1 | w2);

endmodule

module NOR_4I1O (i0, i1, i2, i3, o);
input i0;
input i1;
input i2;
input i3;
output o;

wire w0, w1, w2, w3;

assign #(0.4, 0.1) w0 = i0;
assign #(0.3, 0.1) w1 = i1;
assign #(0.2, 0.1) w2 = i2;
assign #(0.1, 0.1) w3 = i3;

assign o = ~(w0 | w1 | w2 | w3);

endmodule


module INV (i, o);
input i;
output o;

assign #0.1 o = ~i;

endmodule

///////  16-bit adder
module black (i_g1, i_p1, i_g0, i_p0, o_g, o_p);
input i_g0, i_p0;
input i_g1, i_p1;
output o_g, o_p;

wire w_cp;

// P
NAND_2I1O NAND2_00 (i_p0, i_p1, w_cp);
INV INV_00 (w_cp, o_p);

// G
gray GR(i_g1, i_p1, i_g0, o_g);

endmodule

module gray (i_g1, i_p, i_g0, o_g);
input i_g0, i_g1, i_p;
output o_g;

wire w_cp, w_cp2, w_g;

// and gate
NAND_2I1O NAND2_00 (i_g0, i_p, w_cp);
INV INV_00 (w_cp, w_cp2);

// or gate
NOR_2I1O NOR2_00 (w_cp2, i_g1, w_g);
INV INV_01 (w_g, o_g);

endmodule

module pg(i_a, i_b, o_p, o_g);
input i_a, i_b;
output o_p, o_g;

wire w_a, w_b, w_n, w_g;

// P
NAND_2I1O NAND2_00 (i_a, i_b, w_n);
NAND_2I1O NAND2_01 (i_a, w_n, w_a);
NAND_2I1O NAND2_02 (i_b, w_n, w_b);
NAND_2I1O NAND2_03 (w_a, w_b, o_p);

// G
NAND_2I1O NAND2_04 (i_a, i_b, w_g);
INV INV_00 (w_g, o_g);

endmodule

module level1_logic (i_c1, i_a, i_b, o_p1, o_g1, o_c1);
input i_c1;
input [15:0] i_a, i_b;
output [15:0] o_p1, o_g1;
output o_c1;

assign o_c1 = i_c1;

pg PG_00(i_a[0], i_b[0], o_p1[0], o_g1[0]);
pg PG_01(i_a[1], i_b[1], o_p1[1], o_g1[1]);
pg PG_02(i_a[2], i_b[2], o_p1[2], o_g1[2]);
pg PG_03(i_a[3], i_b[3], o_p1[3], o_g1[3]);
pg PG_04(i_a[4], i_b[4], o_p1[4], o_g1[4]);
pg PG_05(i_a[5], i_b[5], o_p1[5], o_g1[5]);
pg PG_06(i_a[6], i_b[6], o_p1[6], o_g1[6]);
pg PG_07(i_a[7], i_b[7], o_p1[7], o_g1[7]);
pg PG_08(i_a[8], i_b[8], o_p1[8], o_g1[8]);
pg PG_09(i_a[9], i_b[9], o_p1[9], o_g1[9]);
pg PG_10(i_a[10], i_b[10], o_p1[10], o_g1[10]);
pg PG_11(i_a[11], i_b[11], o_p1[11], o_g1[11]);
pg PG_12(i_a[12], i_b[12], o_p1[12], o_g1[12]);
pg PG_13(i_a[13], i_b[13], o_p1[13], o_g1[13]);
pg PG_14(i_a[14], i_b[14], o_p1[14], o_g1[14]);
pg PG_15(i_a[15], i_b[15], o_p1[15], o_g1[15]);

endmodule

module level2_logic (i_c2, i_p, i_g, o_p2, o_g2, o_c2);
input i_c2;
input [15:0] i_p, i_g;
output [15:0] o_p2, o_g2;
output o_c2;

assign o_c2 = i_c2;
assign o_p2[0] = i_p[0];

gray G_00(i_g[0], i_p[0], i_c2, o_g2[0]); 
black B_01(i_g[1], i_p[1], i_g[0], i_p[0], o_g2[1], o_p2[1]);
black B_02(i_g[2], i_p[2], i_g[1], i_p[1], o_g2[2], o_p2[2]);
black B_03(i_g[3], i_p[3], i_g[2], i_p[2], o_g2[3], o_p2[3]);
black B_04(i_g[4], i_p[4], i_g[3], i_p[3], o_g2[4], o_p2[4]);
black B_05(i_g[5], i_p[5], i_g[4], i_p[4], o_g2[5], o_p2[5]);
black B_06(i_g[6], i_p[6], i_g[5], i_p[5], o_g2[6], o_p2[6]);
black B_07(i_g[7], i_p[7], i_g[6], i_p[6], o_g2[7], o_p2[7]);
black B_08(i_g[8], i_p[8], i_g[7], i_p[7], o_g2[8], o_p2[8]);
black B_09(i_g[9], i_p[9], i_g[8], i_p[8], o_g2[9], o_p2[9]);
black B_10(i_g[10], i_p[10], i_g[9], i_p[9], o_g2[10], o_p2[10]);
black B_11(i_g[11], i_p[11], i_g[10], i_p[10], o_g2[11], o_p2[11]);
black B_12(i_g[12], i_p[12], i_g[11], i_p[11], o_g2[12], o_p2[12]);
black B_13(i_g[13], i_p[13], i_g[12], i_p[12], o_g2[13], o_p2[13]);
black B_14(i_g[14], i_p[14], i_g[13], i_p[13], o_g2[14], o_p2[14]);
black B_15(i_g[15], i_p[15], i_g[14], i_p[14], o_g2[15], o_p2[15]);

endmodule

module level3_logic (i_c3, i_p, i_g, o_p3, o_g3, o_c3);
input i_c3;
input [15:0] i_p, i_g;
output [15:0] o_p3, o_g3;
output o_c3;

assign o_p3[2:0] = i_p[2:0];
assign o_g3[0] = i_g[0];
assign o_c3 = i_c3;

gray G_00(i_g[1], i_p[1], i_c3, o_g3[1]);
gray G_01(i_g[2], i_p[2], i_g[0], o_g3[2]);
black B_03(i_g[3], i_p[3], i_g[1], i_p[1], o_g3[3], o_p3[3]);
black B_04(i_g[4], i_p[4], i_g[2], i_p[2], o_g3[4], o_p3[4]);
black B_05(i_g[5], i_p[5], i_g[3], i_p[3], o_g3[5], o_p3[5]);
black B_06(i_g[6], i_p[6], i_g[4], i_p[4], o_g3[6], o_p3[6]);
black B_07(i_g[7], i_p[7], i_g[5], i_p[5], o_g3[7], o_p3[7]);
black B_08(i_g[8], i_p[8], i_g[6], i_p[6], o_g3[8], o_p3[8]);
black B_09(i_g[9], i_p[9], i_g[7], i_p[7], o_g3[9], o_p3[9]);
black B_10(i_g[10], i_p[10], i_g[8], i_p[8], o_g3[10], o_p3[10]);
black B_11(i_g[11], i_p[11], i_g[9], i_p[9], o_g3[11], o_p3[11]);
black B_12(i_g[12], i_p[12], i_g[10], i_p[10], o_g3[12], o_p3[12]);
black B_13(i_g[13], i_p[13], i_g[11], i_p[11], o_g3[13], o_p3[13]);
black B_14(i_g[14], i_p[14], i_g[12], i_p[12], o_g3[14], o_p3[14]);
black B_15(i_g[15], i_p[15], i_g[13], i_p[13], o_g3[15], o_p3[15]);


endmodule

module level4_logic (i_c4, i_p, i_g, o_p4, o_g4, o_c4);
input i_c4;
input [15:0] i_p, i_g;
output [15:0] o_p4, o_g4;
output o_c4;

assign o_p4[6:0] = i_p[6:0];
assign o_g4[2:0] = i_g[2:0];
assign o_c4 = i_c4;

gray G_00(i_g[3], i_p[3], i_c4, o_g4[3]);
gray G_01(i_g[4], i_p[4], i_g[0], o_g4[4]);
gray G_02(i_g[5], i_p[5], i_g[1], o_g4[5]);
gray G_03(i_g[6], i_p[6], i_g[2], o_g4[6]);
black B_07(i_g[7], i_p[7], i_g[3], i_p[3], o_g4[7], o_p4[7]);
black B_08(i_g[8], i_p[8], i_g[4], i_p[4], o_g4[8], o_p4[8]);
black B_09(i_g[9], i_p[9], i_g[5], i_p[5], o_g4[9], o_p4[9]);
black B_10(i_g[10], i_p[10], i_g[6], i_p[6], o_g4[10], o_p4[10]);
black B_11(i_g[11], i_p[11], i_g[7], i_p[7], o_g4[11], o_p4[11]);
black B_12(i_g[12], i_p[12], i_g[8], i_p[8], o_g4[12], o_p4[12]);
black B_13(i_g[13], i_p[13], i_g[9], i_p[9], o_g4[13], o_p4[13]);
black B_14(i_g[14], i_p[14], i_g[10], i_p[10], o_g4[14], o_p4[14]);
black B_15(i_g[15], i_p[15], i_g[11], i_p[11], o_g4[15], o_p4[15]);

endmodule

module level5_logic (i_c5, i_p, i_g, o_p5, o_g5, o_c5);
input i_c5;
input [15:0] i_p, i_g;
output [15:0] o_p5, o_g5;
output o_c5;

assign o_g5[6:0] = i_g[6:0];
assign o_c5 = i_c5;

gray G_00(i_g[7], i_p[7], i_c5, o_g5[7]);
gray G_01(i_g[8], i_p[8], i_g[0], o_g5[8]);
gray G_02(i_g[9], i_p[9], i_g[1], o_g5[9]);
gray G_03(i_g[10], i_p[10], i_g[2], o_g5[10]);
gray G_04(i_g[11], i_p[11], i_g[3], o_g5[11]);
gray G_05(i_g[12], i_p[12], i_g[4], o_g5[12]);
gray G_06(i_g[13], i_p[13], i_g[5], o_g5[13]);
gray G_07(i_g[14], i_p[14], i_g[6], o_g5[14]);
gray G_08(i_g[15], i_p[15], i_g[7], o_g5[15]);

endmodule

module level6_logic (i_c, i_p, i_g, o_s, o_c);
input i_c;
input [15:0] i_p, i_g;
output [15:0] o_s, o_c;

assign o_c = i_g[15];

XOR_2I1O XOR2_00 (i_c, i_p[0], o_s[0]);
XOR_2I1O XOR2_01 (i_g[0], i_p[1], o_s[1]);
XOR_2I1O XOR2_02 (i_g[1], i_p[2], o_s[2]);
XOR_2I1O XOR2_03 (i_g[2], i_p[3], o_s[3]);
XOR_2I1O XOR2_04 (i_g[3], i_p[4], o_s[4]);
XOR_2I1O XOR2_05 (i_g[4], i_p[5], o_s[5]);
XOR_2I1O XOR2_06 (i_g[5], i_p[6], o_s[6]);
XOR_2I1O XOR2_07 (i_g[6], i_p[7], o_s[7]);
XOR_2I1O XOR2_08 (i_g[7], i_p[8], o_s[8]);
XOR_2I1O XOR2_09 (i_g[8], i_p[9], o_s[9]);
XOR_2I1O XOR2_10 (i_g[9], i_p[10], o_s[10]);
XOR_2I1O XOR2_11 (i_g[10], i_p[11], o_s[11]);
XOR_2I1O XOR2_12 (i_g[11], i_p[12], o_s[12]);
XOR_2I1O XOR2_13 (i_g[12], i_p[13], o_s[13]);
XOR_2I1O XOR2_14 (i_g[13], i_p[14], o_s[14]);
XOR_2I1O XOR2_15 (i_g[14], i_p[15], o_s[15]);

endmodule

module adder_16b (a, b, s, c_i, c_o);
input [15:0] a, b;
input c_i;
output c_o;
output [15:0] s;

wire [15:0] wg0, wg1, wg2, wg3, wg4, wp0, wp1, wp2, wp3;
wire c1, c2, c3, c4, c5;

level1_logic ks_01 (c_i, a, b, wp0, wg0, c1);
level2_logic ks_02 (c1, wp0, wg0, wp1, wg1, c2);
level3_logic ks_03 (c2, wp1, wg1, wp2, wg2, c3);
level4_logic ks_04 (c3, wp2, wg2, wp3, wg3, c4);
level5_logic ks_05 (c4, wp3, wg3, wp4, wg4, c5);
level6_logic ks_06 (c5, wp0, wg4, s, c_o);

endmodule
