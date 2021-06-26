`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Seung-il Ko
// 
// Create Date: 2021/05/23 13:19:04
// Design Name: 
// Module Name: adder_16b
// Project Name: 16bit adder
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

assign #(0.1, 0.1) w0 = i0;
assign #(0.2, 0.1) w1 = i1;

assign o = ~(w0 | w1);

endmodule

module NOR_3I1O (i0, i1, i2, o);
input i0;
input i1;
input i2;
output o;

wire w0, w1, w2;

assign #(0.1, 0.1) w0 = i0;
assign #(0.2, 0.1) w1 = i1;
assign #(0.3, 0.1) w2 = i2;


assign o = ~(w0 | w1 | w2);

endmodule

module NOR_4I1O (i0, i1, i2, i3, o);
input i0;
input i1;
input i2;
input i3;
output o;

wire w0, w1, w2, w3;

assign #(0.1, 0.1) w0 = i0;
assign #(0.2, 0.1) w1 = i1;
assign #(0.3, 0.1) w2 = i2;
assign #(0.4, 0.1) w3 = i3;


assign o = ~(w0 | w1 | w2 | w3);

endmodule


module INV (i, o);
input i;
output o;

assign #0.1 o = ~i;

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

