
//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule


//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/ccs_out_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------

module ccs_out_v1 (dat, idat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output   [width-1:0] dat;
  input    [width-1:0] idat;

  wire     [width-1:0] dat;

  assign dat = idat;

endmodule




//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule


//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.v 
module mgc_shift_l_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
   if (signd_a)
   begin: SGNED
      assign z = fshl_u(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
      assign z = fshl_u(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

endmodule

//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_shift_r_beh_v5.v 
module mgc_shift_r_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
     if (signd_a)
     begin: SGNED
       assign z = fshr_u(a,s,a[width_a-1]);
     end
     else
     begin: UNSGNED
       assign z = fshr_u(a,s,1'b0);
     end
   endgenerate

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

endmodule

//------> ../td_ccore_solutions/leading_sign_13_1_1_0_fbd6b6484e0226fdfa7c7e6838ce99f45fe9_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   ajh9498@hansolo.poly.edu
//  Generated date: Tue Apr 22 14:20:36 2025
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    leading_sign_13_1_1_0
// ------------------------------------------------------------------


module leading_sign_13_1_1_0 (
  mantissa, all_same, rtn
);
  input [12:0] mantissa;
  output all_same;
  output [3:0] rtn;


  // Interconnect Declarations
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_2;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_18_3_sdt_3;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_32_4_sdt_4;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_1;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_14_2_sdt_1;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_26_2_sdt_1;
  wire [11:0] r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0;
  wire c_h_1_2;
  wire c_h_1_4;

  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_or_1_nl;
  wire[1:0] r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nor_nl;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_nl;
  wire r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_2_nl;

  // Interconnect Declarations for Component Instantiations 
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0 = (mantissa[11:0])
      ^ (signext_12_1(~ (mantissa[12])));
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_2 =
      (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[9:8]==2'b11);
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_1 =
      (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[11:10]==2'b11);
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_14_2_sdt_1
      = (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[7:6]==2'b11);
  assign c_h_1_2 = r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_1
      & r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_2;
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_18_3_sdt_3
      = (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[5:4]==2'b11)
      & r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_14_2_sdt_1;
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_26_2_sdt_1
      = (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[3:2]==2'b11);
  assign c_h_1_4 = c_h_1_2 & r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_18_3_sdt_3;
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_32_4_sdt_4
      = (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[1:0]==2'b11)
      & r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_26_2_sdt_1 &
      c_h_1_4;
  assign all_same = r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_32_4_sdt_4;
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_or_1_nl
      = (c_h_1_2 & (~ r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_18_3_sdt_3))
      | r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_32_4_sdt_4;
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_nl = ~(r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_1
      & (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_14_2_sdt_1
      | (~ r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_6_2_sdt_2))
      & (r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_26_2_sdt_1
      | (~ c_h_1_4)));
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_2_nl = ~((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[11])
      & ((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[10:9]!=2'b10))
      & (~((~((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[7])
      & ((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[6:5]!=2'b10))))
      & c_h_1_2)) & (~((~((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[3])
      & ((r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_xor_11_0[2:1]!=2'b10))))
      & c_h_1_4)));
  assign r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nor_nl
      = ~(MUX_v_2_2_2(({r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_nl
      , r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nand_2_nl}), 2'b11,
      r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_wrs_c_32_4_sdt_4));
  assign rtn = {c_h_1_4 , r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_or_1_nl
      , r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_r_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_all_sign_1_nor_nl};

  function automatic [1:0] MUX_v_2_2_2;
    input [1:0] input_0;
    input [1:0] input_1;
    input  sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function automatic [11:0] signext_12_1;
    input  vector;
  begin
    signext_12_1= {{11{vector}}, vector};
  end
  endfunction

endmodule




//------> /eda/mentor/Siemens_EDA/Catapult_Synthesis_2023.1_2/Mgc_home/pkgs/siflibs/mgc_shift_br_beh_v5.v 
module mgc_shift_br_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
     if (signd_a)
     begin: SGNED
       assign z = fshr_s(a,s,a[width_a-1]);
     end
     else
     begin: UNSGNED
       assign z = fshr_s(a,s,1'b0);
     end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshr_u

   //Shift right - signed shift argument
   function [width_z-1:0] fshr_s;
     input [width_a-1:0] arg1;
     input [width_s-1:0] arg2;
     input sbit;
     begin
       if ( arg2[width_s-1] == 1'b0 )
       begin
         fshr_s = fshr_u(arg1, arg2, sbit);
       end
       else
       begin
         fshr_s = fshl_u_1({arg1, 1'b0},~arg2, sbit);
       end
     end
   endfunction 

endmodule

//------> ../td_ccore_solutions/leading_sign_18_1_1_0_7b2153b3b691fe1ab68d43c72c494a7b6845_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   ajh9498@hansolo.poly.edu
//  Generated date: Tue Apr 22 14:20:37 2025
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    leading_sign_18_1_1_0
// ------------------------------------------------------------------


module leading_sign_18_1_1_0 (
  mantissa, all_same, rtn
);
  input [17:0] mantissa;
  output all_same;
  output [4:0] rtn;


  // Interconnect Declarations
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_2;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_18_3_sdt_3;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_2;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_42_4_sdt_4;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_48_5_sdt_5;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_1;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_14_2_sdt_1;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_1;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_34_2_sdt_1;
  wire [16:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0;
  wire c_h_1_2;
  wire c_h_1_5;
  wire c_h_1_6;
  wire c_h_1_7;

  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_1_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_2_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_1_nl;

  // Interconnect Declarations for Component Instantiations 
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0
      = (mantissa[16:0]) ^ (signext_17_1(~ (mantissa[17])));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_2
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[14:13]==2'b11);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_1
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[16:15]==2'b11);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_14_2_sdt_1
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[12:11]==2'b11);
  assign c_h_1_2 = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_1
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_2;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_18_3_sdt_3
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[10:9]==2'b11)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_14_2_sdt_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_2
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[6:5]==2'b11);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_1
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[8:7]==2'b11);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_34_2_sdt_1
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[4:3]==2'b11);
  assign c_h_1_5 = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_1
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_2;
  assign c_h_1_6 = c_h_1_2 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_18_3_sdt_3;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_42_4_sdt_4
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[2:1]==2'b11)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_34_2_sdt_1
      & c_h_1_5;
  assign c_h_1_7 = c_h_1_6 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_42_4_sdt_4;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_48_5_sdt_5
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[0])
      & c_h_1_7;
  assign all_same = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_48_5_sdt_5;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl
      = c_h_1_6 & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_42_4_sdt_4);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_1_nl
      = c_h_1_2 & (c_h_1_5 | (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_18_3_sdt_3))
      & (~ c_h_1_7);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_2_nl
      = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_1
      & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_14_2_sdt_1
      | (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_6_2_sdt_2))
      & (~((~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_1
      & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_34_2_sdt_1
      | (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_26_2_sdt_2))))
      & c_h_1_6)) & (~ c_h_1_7);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_1_nl
      = ((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[16])
      & ((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[15:14]!=2'b10))
      & (~((~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[12])
      & ((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[11:10]!=2'b10))))
      & c_h_1_2)) & (~((~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[8])
      & ((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[7:6]!=2'b10))
      & (~((~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[4])
      & ((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_xor_16_0[3:2]!=2'b10))))
      & c_h_1_5)))) & c_h_1_6)) & (~ c_h_1_7)) | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_wrs_c_48_5_sdt_5;
  assign rtn = {c_h_1_7 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_1_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_2_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_1_nl};

  function automatic [16:0] signext_17_1;
    input  vector;
  begin
    signext_17_1= {{16{vector}}, vector};
  end
  endfunction

endmodule




//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2023.1_2/1049935 Production Release
//  HLS Date:       Sat Jun 10 10:53:51 PDT 2023
// 
//  Generated by:   ajh9498@hansolo.poly.edu
//  Generated date: Wed Apr 23 22:43:08 2025
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    fir_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module fir_core_core_fsm (
  clk, rst, fsm_output
);
  input clk;
  input rst;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;


  // FSM State Type Declaration for fir_core_core_fsm_1
  parameter
    main_C_0 = 7'd0,
    main_C_1 = 7'd1,
    main_C_2 = 7'd2,
    main_C_3 = 7'd3,
    main_C_4 = 7'd4,
    main_C_5 = 7'd5,
    main_C_6 = 7'd6,
    main_C_7 = 7'd7,
    main_C_8 = 7'd8,
    main_C_9 = 7'd9,
    main_C_10 = 7'd10,
    main_C_11 = 7'd11,
    main_C_12 = 7'd12,
    main_C_13 = 7'd13,
    main_C_14 = 7'd14,
    main_C_15 = 7'd15,
    main_C_16 = 7'd16,
    main_C_17 = 7'd17,
    main_C_18 = 7'd18,
    main_C_19 = 7'd19,
    main_C_20 = 7'd20,
    main_C_21 = 7'd21,
    main_C_22 = 7'd22,
    main_C_23 = 7'd23,
    main_C_24 = 7'd24,
    main_C_25 = 7'd25,
    main_C_26 = 7'd26,
    main_C_27 = 7'd27,
    main_C_28 = 7'd28,
    main_C_29 = 7'd29,
    main_C_30 = 7'd30,
    main_C_31 = 7'd31,
    main_C_32 = 7'd32,
    main_C_33 = 7'd33,
    main_C_34 = 7'd34,
    main_C_35 = 7'd35,
    main_C_36 = 7'd36,
    main_C_37 = 7'd37,
    main_C_38 = 7'd38,
    main_C_39 = 7'd39,
    main_C_40 = 7'd40,
    main_C_41 = 7'd41,
    main_C_42 = 7'd42,
    main_C_43 = 7'd43,
    main_C_44 = 7'd44,
    main_C_45 = 7'd45,
    main_C_46 = 7'd46,
    main_C_47 = 7'd47,
    main_C_48 = 7'd48,
    main_C_49 = 7'd49,
    main_C_50 = 7'd50,
    main_C_51 = 7'd51,
    main_C_52 = 7'd52,
    main_C_53 = 7'd53,
    main_C_54 = 7'd54,
    main_C_55 = 7'd55,
    main_C_56 = 7'd56,
    main_C_57 = 7'd57,
    main_C_58 = 7'd58,
    main_C_59 = 7'd59,
    main_C_60 = 7'd60,
    main_C_61 = 7'd61,
    main_C_62 = 7'd62,
    main_C_63 = 7'd63,
    main_C_64 = 7'd64,
    main_C_65 = 7'd65,
    main_C_66 = 7'd66;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : fir_core_core_fsm_1
    case (state_var)
      main_C_1 : begin
        fsm_output = 7'b0000001;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 7'b0000010;
        state_var_NS = main_C_3;
      end
      main_C_3 : begin
        fsm_output = 7'b0000011;
        state_var_NS = main_C_4;
      end
      main_C_4 : begin
        fsm_output = 7'b0000100;
        state_var_NS = main_C_5;
      end
      main_C_5 : begin
        fsm_output = 7'b0000101;
        state_var_NS = main_C_6;
      end
      main_C_6 : begin
        fsm_output = 7'b0000110;
        state_var_NS = main_C_7;
      end
      main_C_7 : begin
        fsm_output = 7'b0000111;
        state_var_NS = main_C_8;
      end
      main_C_8 : begin
        fsm_output = 7'b0001000;
        state_var_NS = main_C_9;
      end
      main_C_9 : begin
        fsm_output = 7'b0001001;
        state_var_NS = main_C_10;
      end
      main_C_10 : begin
        fsm_output = 7'b0001010;
        state_var_NS = main_C_11;
      end
      main_C_11 : begin
        fsm_output = 7'b0001011;
        state_var_NS = main_C_12;
      end
      main_C_12 : begin
        fsm_output = 7'b0001100;
        state_var_NS = main_C_13;
      end
      main_C_13 : begin
        fsm_output = 7'b0001101;
        state_var_NS = main_C_14;
      end
      main_C_14 : begin
        fsm_output = 7'b0001110;
        state_var_NS = main_C_15;
      end
      main_C_15 : begin
        fsm_output = 7'b0001111;
        state_var_NS = main_C_16;
      end
      main_C_16 : begin
        fsm_output = 7'b0010000;
        state_var_NS = main_C_17;
      end
      main_C_17 : begin
        fsm_output = 7'b0010001;
        state_var_NS = main_C_18;
      end
      main_C_18 : begin
        fsm_output = 7'b0010010;
        state_var_NS = main_C_19;
      end
      main_C_19 : begin
        fsm_output = 7'b0010011;
        state_var_NS = main_C_20;
      end
      main_C_20 : begin
        fsm_output = 7'b0010100;
        state_var_NS = main_C_21;
      end
      main_C_21 : begin
        fsm_output = 7'b0010101;
        state_var_NS = main_C_22;
      end
      main_C_22 : begin
        fsm_output = 7'b0010110;
        state_var_NS = main_C_23;
      end
      main_C_23 : begin
        fsm_output = 7'b0010111;
        state_var_NS = main_C_24;
      end
      main_C_24 : begin
        fsm_output = 7'b0011000;
        state_var_NS = main_C_25;
      end
      main_C_25 : begin
        fsm_output = 7'b0011001;
        state_var_NS = main_C_26;
      end
      main_C_26 : begin
        fsm_output = 7'b0011010;
        state_var_NS = main_C_27;
      end
      main_C_27 : begin
        fsm_output = 7'b0011011;
        state_var_NS = main_C_28;
      end
      main_C_28 : begin
        fsm_output = 7'b0011100;
        state_var_NS = main_C_29;
      end
      main_C_29 : begin
        fsm_output = 7'b0011101;
        state_var_NS = main_C_30;
      end
      main_C_30 : begin
        fsm_output = 7'b0011110;
        state_var_NS = main_C_31;
      end
      main_C_31 : begin
        fsm_output = 7'b0011111;
        state_var_NS = main_C_32;
      end
      main_C_32 : begin
        fsm_output = 7'b0100000;
        state_var_NS = main_C_33;
      end
      main_C_33 : begin
        fsm_output = 7'b0100001;
        state_var_NS = main_C_34;
      end
      main_C_34 : begin
        fsm_output = 7'b0100010;
        state_var_NS = main_C_35;
      end
      main_C_35 : begin
        fsm_output = 7'b0100011;
        state_var_NS = main_C_36;
      end
      main_C_36 : begin
        fsm_output = 7'b0100100;
        state_var_NS = main_C_37;
      end
      main_C_37 : begin
        fsm_output = 7'b0100101;
        state_var_NS = main_C_38;
      end
      main_C_38 : begin
        fsm_output = 7'b0100110;
        state_var_NS = main_C_39;
      end
      main_C_39 : begin
        fsm_output = 7'b0100111;
        state_var_NS = main_C_40;
      end
      main_C_40 : begin
        fsm_output = 7'b0101000;
        state_var_NS = main_C_41;
      end
      main_C_41 : begin
        fsm_output = 7'b0101001;
        state_var_NS = main_C_42;
      end
      main_C_42 : begin
        fsm_output = 7'b0101010;
        state_var_NS = main_C_43;
      end
      main_C_43 : begin
        fsm_output = 7'b0101011;
        state_var_NS = main_C_44;
      end
      main_C_44 : begin
        fsm_output = 7'b0101100;
        state_var_NS = main_C_45;
      end
      main_C_45 : begin
        fsm_output = 7'b0101101;
        state_var_NS = main_C_46;
      end
      main_C_46 : begin
        fsm_output = 7'b0101110;
        state_var_NS = main_C_47;
      end
      main_C_47 : begin
        fsm_output = 7'b0101111;
        state_var_NS = main_C_48;
      end
      main_C_48 : begin
        fsm_output = 7'b0110000;
        state_var_NS = main_C_49;
      end
      main_C_49 : begin
        fsm_output = 7'b0110001;
        state_var_NS = main_C_50;
      end
      main_C_50 : begin
        fsm_output = 7'b0110010;
        state_var_NS = main_C_51;
      end
      main_C_51 : begin
        fsm_output = 7'b0110011;
        state_var_NS = main_C_52;
      end
      main_C_52 : begin
        fsm_output = 7'b0110100;
        state_var_NS = main_C_53;
      end
      main_C_53 : begin
        fsm_output = 7'b0110101;
        state_var_NS = main_C_54;
      end
      main_C_54 : begin
        fsm_output = 7'b0110110;
        state_var_NS = main_C_55;
      end
      main_C_55 : begin
        fsm_output = 7'b0110111;
        state_var_NS = main_C_56;
      end
      main_C_56 : begin
        fsm_output = 7'b0111000;
        state_var_NS = main_C_57;
      end
      main_C_57 : begin
        fsm_output = 7'b0111001;
        state_var_NS = main_C_58;
      end
      main_C_58 : begin
        fsm_output = 7'b0111010;
        state_var_NS = main_C_59;
      end
      main_C_59 : begin
        fsm_output = 7'b0111011;
        state_var_NS = main_C_60;
      end
      main_C_60 : begin
        fsm_output = 7'b0111100;
        state_var_NS = main_C_61;
      end
      main_C_61 : begin
        fsm_output = 7'b0111101;
        state_var_NS = main_C_62;
      end
      main_C_62 : begin
        fsm_output = 7'b0111110;
        state_var_NS = main_C_63;
      end
      main_C_63 : begin
        fsm_output = 7'b0111111;
        state_var_NS = main_C_64;
      end
      main_C_64 : begin
        fsm_output = 7'b1000000;
        state_var_NS = main_C_65;
      end
      main_C_65 : begin
        fsm_output = 7'b1000001;
        state_var_NS = main_C_66;
      end
      main_C_66 : begin
        fsm_output = 7'b1000010;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 7'b0000000;
        state_var_NS = main_C_1;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    fir_core_wait_dp
// ------------------------------------------------------------------


module fir_core_wait_dp (
  clk, rst, MAC_1_leading_sign_18_1_1_0_cmp_all_same, MAC_1_leading_sign_18_1_1_0_cmp_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_1_all_same, MAC_1_leading_sign_18_1_1_0_cmp_1_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_2_all_same, MAC_1_leading_sign_18_1_1_0_cmp_2_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_3_all_same, MAC_1_leading_sign_18_1_1_0_cmp_3_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_4_all_same, MAC_1_leading_sign_18_1_1_0_cmp_4_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_5_all_same, MAC_1_leading_sign_18_1_1_0_cmp_5_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_6_all_same, MAC_1_leading_sign_18_1_1_0_cmp_6_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_7_all_same, MAC_1_leading_sign_18_1_1_0_cmp_7_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_8_all_same, MAC_1_leading_sign_18_1_1_0_cmp_8_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_9_all_same, MAC_1_leading_sign_18_1_1_0_cmp_9_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_10_all_same, MAC_1_leading_sign_18_1_1_0_cmp_10_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_11_all_same, MAC_1_leading_sign_18_1_1_0_cmp_11_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_12_all_same, MAC_1_leading_sign_18_1_1_0_cmp_12_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_13_all_same, MAC_1_leading_sign_18_1_1_0_cmp_13_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_14_all_same, MAC_1_leading_sign_18_1_1_0_cmp_14_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_15_all_same, MAC_1_leading_sign_18_1_1_0_cmp_15_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg,
      MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg, MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg
);
  input clk;
  input rst;
  input MAC_1_leading_sign_18_1_1_0_cmp_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_1_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_2_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_3_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_4_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_5_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_6_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_7_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_8_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_9_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_10_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_11_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_12_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_13_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_14_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn;
  input MAC_1_leading_sign_18_1_1_0_cmp_15_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn;
  output MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg;
  output MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg;
  output [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg;
  reg [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg;


  // Interconnect Declarations
  reg MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg_rneg;
  reg MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg_rneg;


  // Interconnect Declarations for Component Instantiations 
  assign MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg_rneg;
  assign MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg = ~ MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg_rneg;
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg <= 5'b00000;
      MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg_rneg <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg <= 5'b00000;
    end
    else begin
      MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_1_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_1_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_2_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_2_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_3_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_3_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_4_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_4_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_5_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_5_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_6_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_6_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_7_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_7_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_8_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_8_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_9_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_9_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_10_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_10_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_11_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_11_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_12_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_12_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_13_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_13_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_14_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_14_rtn;
      MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg_rneg <= ~ MAC_1_leading_sign_18_1_1_0_cmp_15_all_same;
      MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg <= MAC_1_leading_sign_18_1_1_0_cmp_15_rtn;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    fir_core
// ------------------------------------------------------------------


module fir_core (
  clk, rst, input_m_rsc_dat, input_m_triosy_lz, input_e_rsc_dat, input_e_triosy_lz,
      taps_m_rsc_dat, taps_m_triosy_lz, taps_e_rsc_dat, taps_e_triosy_lz, return_m_rsc_dat,
      return_m_triosy_lz, return_e_rsc_dat, return_e_triosy_lz, MAC_1_leading_sign_18_1_1_0_cmp_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_all_same, MAC_1_leading_sign_18_1_1_0_cmp_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_1_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_1_rtn, MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_2_all_same, MAC_1_leading_sign_18_1_1_0_cmp_2_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_3_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_3_rtn, MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_4_all_same, MAC_1_leading_sign_18_1_1_0_cmp_4_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_5_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_5_rtn, MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_6_all_same, MAC_1_leading_sign_18_1_1_0_cmp_6_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_7_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_7_rtn, MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_8_all_same, MAC_1_leading_sign_18_1_1_0_cmp_8_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_9_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_9_rtn, MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_10_all_same, MAC_1_leading_sign_18_1_1_0_cmp_10_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_11_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_11_rtn, MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_12_all_same, MAC_1_leading_sign_18_1_1_0_cmp_12_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_13_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_13_rtn, MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa,
      MAC_1_leading_sign_18_1_1_0_cmp_14_all_same, MAC_1_leading_sign_18_1_1_0_cmp_14_rtn,
      MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa, MAC_1_leading_sign_18_1_1_0_cmp_15_all_same,
      MAC_1_leading_sign_18_1_1_0_cmp_15_rtn
);
  input clk;
  input rst;
  input [10:0] input_m_rsc_dat;
  output input_m_triosy_lz;
  input [4:0] input_e_rsc_dat;
  output input_e_triosy_lz;
  input [175:0] taps_m_rsc_dat;
  output taps_m_triosy_lz;
  input [79:0] taps_e_rsc_dat;
  output taps_e_triosy_lz;
  output [10:0] return_m_rsc_dat;
  output return_m_triosy_lz;
  output [4:0] return_e_rsc_dat;
  output return_e_triosy_lz;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_1_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_2_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_3_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_4_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_5_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_6_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_7_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_8_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_9_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_10_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_11_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_12_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_13_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_14_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn;
  output [17:0] MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa;
  reg [17:0] MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa;
  input MAC_1_leading_sign_18_1_1_0_cmp_15_all_same;
  input [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn;


  // Interconnect Declarations
  wire [10:0] input_m_rsci_idat;
  wire [4:0] input_e_rsci_idat;
  wire [175:0] taps_m_rsci_idat;
  wire [79:0] taps_e_rsci_idat;
  reg [10:0] return_m_rsci_idat;
  reg [4:0] return_e_rsci_idat;
  wire MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg;
  wire MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg;
  wire [6:0] fsm_output;
  wire [5:0] MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [5:0] MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire MAC_3_result_operator_result_operator_nor_tmp;
  wire [5:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp;
  wire [5:0] MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp;
  wire [2:0] MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp;
  wire [2:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [2:0] MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire [3:0] nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp;
  wire not_tmp_25;
  wire mux_tmp_7;
  wire nor_tmp_6;
  wire mux_tmp_15;
  wire nor_tmp_9;
  wire nor_tmp_11;
  wire and_dcpl_6;
  wire and_dcpl_7;
  wire and_dcpl_8;
  wire mux_tmp_37;
  wire or_tmp_34;
  wire or_tmp_38;
  wire or_dcpl_25;
  wire or_dcpl_26;
  wire or_dcpl_27;
  wire or_dcpl_28;
  wire or_dcpl_30;
  wire or_dcpl_32;
  wire and_dcpl_26;
  wire and_dcpl_29;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire or_dcpl_36;
  wire mux_tmp_58;
  wire mux_tmp_60;
  wire mux_tmp_61;
  wire mux_tmp_62;
  wire mux_tmp_65;
  wire mux_tmp_66;
  wire mux_tmp_67;
  wire mux_tmp_69;
  wire or_tmp_44;
  wire or_tmp_46;
  wire mux_tmp_76;
  wire or_dcpl_41;
  wire or_dcpl_43;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire and_dcpl_59;
  wire and_dcpl_60;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire or_dcpl_49;
  wire or_dcpl_50;
  wire and_dcpl_64;
  wire and_dcpl_66;
  wire and_dcpl_67;
  wire and_dcpl_68;
  wire xor_dcpl_2;
  wire and_dcpl_70;
  wire nor_tmp_27;
  wire or_tmp_57;
  wire mux_tmp_85;
  wire or_tmp_59;
  wire mux_tmp_86;
  wire nor_tmp_28;
  wire mux_tmp_87;
  wire mux_tmp_89;
  wire mux_tmp_90;
  wire or_dcpl_57;
  wire or_dcpl_59;
  wire nor_tmp_29;
  wire and_dcpl_86;
  wire and_dcpl_89;
  wire and_dcpl_102;
  wire or_dcpl_70;
  wire and_dcpl_105;
  wire and_dcpl_106;
  wire and_dcpl_107;
  wire and_dcpl_116;
  wire and_dcpl_118;
  wire and_dcpl_119;
  wire and_dcpl_127;
  wire mux_tmp_104;
  wire mux_tmp_105;
  wire and_dcpl_189;
  wire mux_tmp_112;
  wire and_dcpl_217;
  wire and_dcpl_218;
  wire and_dcpl_227;
  wire and_dcpl_228;
  wire and_dcpl_232;
  wire and_dcpl_233;
  wire and_dcpl_237;
  wire and_dcpl_238;
  wire and_dcpl_242;
  wire and_dcpl_246;
  wire and_dcpl_250;
  wire or_dcpl_103;
  wire and_dcpl_280;
  wire or_dcpl_107;
  wire and_dcpl_285;
  wire and_dcpl_288;
  wire and_dcpl_306;
  wire and_dcpl_311;
  wire or_dcpl_114;
  wire and_dcpl_339;
  wire or_tmp_139;
  wire and_dcpl_371;
  wire and_dcpl_373;
  wire and_dcpl_375;
  wire and_dcpl_376;
  wire and_dcpl_378;
  wire and_dcpl_380;
  wire and_dcpl_382;
  wire and_dcpl_420;
  reg ac_float_cctor_operator_return_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva;
  reg ac_float_cctor_operator_return_9_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva;
  reg result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva;
  wire [10:0] MAC_ac_float_cctor_m_3_lpi_1_dfm_mx0w4;
  wire MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_3_lpi_1_dfm_1;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm;
  wire [5:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_1_lpi_1_dfm_1;
  wire MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_15_lpi_1_dfm_mx0w2;
  wire MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_14_lpi_1_dfm_mx0w2;
  wire MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_13_lpi_1_dfm_mx0w2;
  wire MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_12_lpi_1_dfm_mx0w2;
  wire MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_11_lpi_1_dfm_mx0w2;
  wire MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_10_lpi_1_dfm_mx0w2;
  wire MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [10:0] MAC_ac_float_cctor_m_9_lpi_1_dfm_mx0w1;
  wire MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_9_lpi_1_dfm_1;
  wire [10:0] MAC_ac_float_cctor_m_8_lpi_1_dfm_mx0w1;
  wire MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_8_lpi_1_dfm_1;
  wire [10:0] MAC_ac_float_cctor_m_7_lpi_1_dfm_mx0w1;
  wire MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_7_lpi_1_dfm_1;
  wire [10:0] MAC_ac_float_cctor_m_6_lpi_1_dfm_mx0w1;
  wire MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_6_lpi_1_dfm_1;
  wire [10:0] MAC_ac_float_cctor_m_5_lpi_1_dfm_mx0w1;
  wire MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_5_lpi_1_dfm_1;
  wire [10:0] MAC_ac_float_cctor_m_4_lpi_1_dfm_mx0w2;
  wire MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_4_lpi_1_dfm_1;
  wire MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva;
  reg MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva;
  reg MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva;
  reg MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva;
  reg MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva;
  reg MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva;
  reg MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva;
  reg MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva;
  reg MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva;
  reg MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva;
  reg MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva;
  reg MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva;
  reg MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva;
  reg MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva;
  reg MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  reg [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva;
  reg MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1;
  wire [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1;
  reg [10:0] delay_lane_m_14_sva;
  reg [10:0] delay_lane_m_13_sva;
  reg [10:0] delay_lane_m_12_sva;
  reg [10:0] delay_lane_m_11_sva;
  reg [10:0] delay_lane_m_10_sva;
  reg [10:0] delay_lane_m_9_sva;
  reg [10:0] delay_lane_m_8_sva;
  reg [10:0] delay_lane_m_7_sva;
  reg [10:0] delay_lane_m_6_sva;
  reg [10:0] delay_lane_m_5_sva;
  reg [10:0] delay_lane_m_4_sva;
  reg [10:0] delay_lane_m_3_sva;
  reg [10:0] delay_lane_m_1_sva;
  reg [10:0] delay_lane_m_0_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva;
  reg [2:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva;
  wire [3:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3;
  wire [5:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_3_lpi_1_dfm_1;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_3_lpi_1_dfm_mx0;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva;
  reg [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_9_lpi_1_dfm_mx0;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_8_lpi_1_dfm_mx0;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_7_lpi_1_dfm_mx0;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_6_lpi_1_dfm_mx0;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_5_lpi_1_dfm_mx0;
  wire [10:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_4_lpi_1_dfm_mx0;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1;
  wire [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1;
  wire [4:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0;
  wire [21:0] ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0;
  wire [6:0] MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_61_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_15_seb;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0;
  wire [6:0] MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_57_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_14_seb;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0;
  wire [6:0] MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_53_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_13_seb;
  wire and_78_ssc;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0;
  wire [6:0] MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_49_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_12_seb;
  wire and_77_ssc;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0;
  wire [6:0] MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_45_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_11_seb;
  wire and_76_ssc;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0;
  wire [6:0] MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_41_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_10_seb;
  wire and_75_ssc;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0;
  wire [6:0] MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [7:0] nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt;
  wire [6:0] MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire [7:0] nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_37_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_9_seb;
  wire and_74_ssc;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0;
  reg [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1;
  wire operator_13_2_true_AC_TRN_AC_WRAP_or_ssc;
  reg [3:0] operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_ssc;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_or_cse;
  wire or_160_cse;
  wire or_154_cse;
  wire or_155_cse;
  wire or_150_cse;
  wire or_146_cse;
  wire or_142_cse;
  wire nor_132_cse;
  wire or_165_cse;
  reg reg_return_e_triosy_obj_ld_cse;
  reg reg_taps_e_triosy_obj_ld_cse;
  wire or_4_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse;
  wire operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse;
  wire nor_162_cse;
  wire nor_159_cse;
  wire nor_155_cse;
  wire nor_152_cse;
  wire nor_149_cse;
  wire nor_146_cse;
  wire ac_float_cctor_ac_float_22_2_6_AC_TRN_or_1_cse;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_or_2_cse;
  wire nor_144_cse;
  wire nor_124_cse;
  wire nor_120_cse;
  wire nor_116_cse;
  wire nor_113_cse;
  wire nor_110_cse;
  wire nor_107_cse;
  wire nor_128_cse;
  wire and_461_cse;
  wire ac_float_cctor_ac_float_22_2_6_AC_TRN_or_ssc;
  reg [3:0] MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7;
  reg [6:0] MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0;
  reg MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5;
  wire mux_34_cse;
  wire or_tmp;
  wire nor_tmp_52;
  wire or_tmp_152;
  wire mux_tmp_239;
  wire mux_tmp_242;
  wire mux_tmp_245;
  wire mux_tmp_248;
  wire mux_tmp_251;
  wire mux_tmp_254;
  reg [6:0] MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0;
  reg [6:0] MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0;
  reg [6:0] MAC_ac_float_cctor_m_lpi_1_dfm_6_0;
  reg [6:0] MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0;
  wire or_301_tmp;
  wire and_369_m1c;
  wire and_374_m1c;
  wire and_376_m1c;
  wire and_379_m1c;
  wire and_381_m1c;
  wire and_383_m1c;
  wire and_385_m1c;
  wire and_387_m1c;
  wire and_388_m1c;
  wire and_389_m1c;
  wire and_390_m1c;
  wire and_391_m1c;
  wire and_392_m1c;
  wire and_393_m1c;
  wire mux_263_tmp;
  wire and_386_cse;
  wire and_509_cse;
  wire and_500_cse;
  wire and_495_cse;
  wire and_501_cse;
  wire and_496_cse;
  wire and_502_cse;
  wire and_497_cse;
  wire [5:0] MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [5:0] MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] nl_MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm;
  wire [6:0] MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm;
  wire [7:0] nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm;
  wire [12:0] MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [12:0] MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [11:0] MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm;
  wire [12:0] nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm;
  wire [11:0] MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm;
  wire [12:0] nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm;
  wire [21:0] MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [21:0] MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire [21:0] MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm;
  wire [12:0] MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm;
  wire and_dcpl_460;
  wire and_dcpl_461;
  wire and_dcpl_464;
  wire and_dcpl_467;
  wire [6:0] z_out;
  wire [5:0] z_out_1;
  wire [6:0] nl_z_out_1;
  wire and_dcpl_485;
  wire [10:0] z_out_2;
  wire and_dcpl_494;
  reg [10:0] delay_lane_m_2_sva;
  reg [4:0] delay_lane_e_7_sva;
  reg [4:0] delay_lane_e_8_sva;
  reg [4:0] delay_lane_e_6_sva;
  reg [4:0] delay_lane_e_9_sva;
  reg [4:0] delay_lane_e_5_sva;
  reg [4:0] delay_lane_e_10_sva;
  reg [4:0] delay_lane_e_4_sva;
  reg [4:0] delay_lane_e_11_sva;
  reg [4:0] delay_lane_e_3_sva;
  reg [4:0] delay_lane_e_12_sva;
  reg [4:0] delay_lane_e_2_sva;
  reg [4:0] delay_lane_e_13_sva;
  reg [4:0] delay_lane_e_1_sva;
  reg [4:0] delay_lane_e_14_sva;
  reg [4:0] delay_lane_e_0_sva;
  reg [6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva;
  wire [7:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva;
  reg [1:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva;
  reg MAC_1_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_3_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_4_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm;
  reg MAC_5_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm;
  reg MAC_6_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_7_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_8_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm;
  reg MAC_9_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg [3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm;
  reg MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_13_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_14_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_15_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  reg MAC_16_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  wire return_e_rsci_idat_mx0c1;
  wire [5:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1;
  wire [6:0] nl_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1;
  wire [11:0] operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3;
  wire operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c0;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c1;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c2;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c3;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c0;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c1;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_mx0c3;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16;
  wire [10:0] MAC_ac_float_cctor_m_1_lpi_1_dfm_1;
  wire [3:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0;
  reg [3:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0;
  wire [3:0] result_m_1_lpi_1_dfm_1_10_7;
  reg [3:0] MAC_ac_float_cctor_m_6_lpi_1_dfm_10_7;
  reg [3:0] MAC_ac_float_cctor_m_7_lpi_1_dfm_10_7;
  reg [6:0] MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0;
  reg [3:0] MAC_ac_float_cctor_m_8_lpi_1_dfm_10_7;
  reg [3:0] MAC_ac_float_cctor_m_9_lpi_1_dfm_10_7;
  reg [3:0] MAC_ac_float_cctor_m_lpi_1_dfm_10_7;
  reg MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5;
  reg [4:0] MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0;
  reg [3:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_10_7;
  wire leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_12;
  wire [3:0] leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_14;
  wire leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_13;
  wire [3:0] leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_15;
  wire [5:0] operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0;
  wire [6:0] nl_operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0;
  wire [6:0] operator_13_2_true_AC_TRN_AC_WRAP_conc_4_itm_6_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0;
  wire [5:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0;
  wire [6:0] nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0;
  reg ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1;
  reg [4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2;
  reg operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0;
  reg [1:0] operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1;
  reg [3:0] operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2;
  reg [7:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0;
  reg [3:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_or_ssc;
  wire or_272_ssc;
  wire [1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_2_lpi_1_dfm_1_5_4;
  wire MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_4;
  wire [3:0] MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_3_0;
  wire result_m_1_lpi_1_dfm_1_6;
  wire [1:0] result_m_1_lpi_1_dfm_1_5_4;
  wire [3:0] result_m_1_lpi_1_dfm_1_3_0;
  wire [5:0] MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt;
  wire [6:0] nl_MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt;
  reg result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_6;
  reg [1:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_5_4;
  wire and_216_ssc;
  wire and_221_ssc;
  wire and_223_ssc;
  wire and_227_ssc;
  wire and_232_ssc;
  wire and_237_ssc;
  wire and_242_ssc;
  wire and_246_ssc;
  wire and_250_ssc;
  wire and_254_ssc;
  wire and_258_ssc;
  wire and_261_ssc;
  wire and_264_ssc;
  wire and_267_ssc;
  wire and_270_ssc;
  wire and_273_ssc;
  wire and_276_ssc;
  wire and_279_ssc;
  wire and_499_cse;
  wire MAC_2_ac_float_cctor_operator_ac_float_cctor_operator_nor_cse;
  wire nor_cse;
  wire nor_215_cse;
  wire or_162_rgt;
  wire and_206_rgt;
  wire nor_80_rgt;
  wire or_156_rgt;
  wire and_202_rgt;
  wire nor_81_rgt;
  wire or_151_rgt;
  wire and_198_rgt;
  wire nor_82_rgt;
  wire or_147_rgt;
  wire and_194_rgt;
  wire nor_83_rgt;
  wire or_143_rgt;
  wire and_190_rgt;
  wire nor_84_rgt;
  wire or_207_rgt;
  wire and_285_rgt;
  wire and_50_rgt;
  wire or_168_rgt;
  wire and_210_rgt;
  wire nor_85_rgt;
  wire ac_float_cctor_ac_float_22_2_6_AC_TRN_and_1_cse;
  wire nor_89_cse;
  wire mux_77_itm;
  wire mux_289_itm;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_23_itm;
  wire MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  wire MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_itm_5_1;
  wire MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_itm_6_1;
  reg MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0;
  reg [3:0] MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1;
  wire and_494_cse;
  wire z_out_3_6;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_25_m1c;

  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_15_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_31_nl;
  wire MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_nl;
  wire MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_1_nl;
  wire MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_2_nl;
  wire mux_130_nl;
  wire mux_129_nl;
  wire mux_128_nl;
  wire nor_119_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_1_nl;
  wire mux_125_nl;
  wire mux_124_nl;
  wire mux_123_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_4_nl;
  wire mux_121_nl;
  wire mux_120_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_7_nl;
  wire mux_117_nl;
  wire mux_116_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_10_nl;
  wire mux_111_nl;
  wire mux_110_nl;
  wire mux_109_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_13_nl;
  wire MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_3_nl;
  wire MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_4_nl;
  wire MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_5_nl;
  wire mux_157_nl;
  wire mux_156_nl;
  wire mux_155_nl;
  wire nor_131_nl;
  wire nor_31_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_16_nl;
  wire mux_76_nl;
  wire mux_75_nl;
  wire or_89_nl;
  wire mux_74_nl;
  wire mux_73_nl;
  wire or_87_nl;
  wire or_85_nl;
  wire mux_134_nl;
  wire mux_133_nl;
  wire nor_123_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_19_nl;
  wire MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_1_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_2_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_3_nl;
  wire or_294_nl;
  wire and_507_nl;
  wire mux_262_nl;
  wire mux_261_nl;
  wire or_298_nl;
  wire mux_260_nl;
  wire mux_259_nl;
  wire mux_258_nl;
  wire mux_235_nl;
  wire mux_282_nl;
  wire mux_283_nl;
  wire mux_284_nl;
  wire mux_314_nl;
  wire and_498_nl;
  wire mux_230_nl;
  wire mux_229_nl;
  wire mux_272_nl;
  wire mux_273_nl;
  wire mux_274_nl;
  wire mux_288_nl;
  wire and_503_nl;
  wire MAC_2_r_ac_float_else_and_nl;
  wire MAC_2_r_ac_float_else_and_1_nl;
  wire[3:0] MAC_2_r_ac_float_else_and_2_nl;
  wire mux_224_nl;
  wire mux_223_nl;
  wire mux_222_nl;
  wire and_479_nl;
  wire mux_221_nl;
  wire and_480_nl;
  wire or_288_nl;
  wire mux_220_nl;
  wire mux_219_nl;
  wire and_481_nl;
  wire or_287_nl;
  wire mux_218_nl;
  wire and_482_nl;
  wire or_286_nl;
  wire mux_217_nl;
  wire mux_216_nl;
  wire mux_215_nl;
  wire and_483_nl;
  wire or_285_nl;
  wire mux_214_nl;
  wire nor_167_nl;
  wire or_283_nl;
  wire mux_213_nl;
  wire mux_212_nl;
  wire and_484_nl;
  wire or_282_nl;
  wire mux_211_nl;
  wire and_485_nl;
  wire or_281_nl;
  wire mux_313_nl;
  wire nand_40_nl;
  wire mux_312_nl;
  wire mux_311_nl;
  wire mux_310_nl;
  wire and_629_nl;
  wire mux_309_nl;
  wire nand_26_nl;
  wire nand_27_nl;
  wire mux_308_nl;
  wire mux_307_nl;
  wire nand_28_nl;
  wire nand_29_nl;
  wire mux_306_nl;
  wire nand_30_nl;
  wire nand_31_nl;
  wire mux_305_nl;
  wire mux_304_nl;
  wire mux_303_nl;
  wire nand_32_nl;
  wire nand_33_nl;
  wire mux_302_nl;
  wire nand_34_nl;
  wire nand_35_nl;
  wire mux_301_nl;
  wire mux_300_nl;
  wire nand_36_nl;
  wire nand_37_nl;
  wire mux_299_nl;
  wire nand_38_nl;
  wire nand_39_nl;
  wire nor_237_nl;
  wire mux_83_nl;
  wire nor_86_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_13_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_28_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_19_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_18_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_9_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_73_nl;
  wire mux_205_nl;
  wire nor_163_nl;
  wire mux_204_nl;
  wire nor_161_nl;
  wire or_266_nl;
  wire and_363_nl;
  wire mux_206_nl;
  wire mux_85_nl;
  wire mux_84_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_12_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_18_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_20_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_10_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_72_nl;
  wire mux_202_nl;
  wire mux_201_nl;
  wire mux_200_nl;
  wire nor_158_nl;
  wire or_258_nl;
  wire and_359_nl;
  wire mux_203_nl;
  wire or_264_nl;
  wire mux_87_nl;
  wire mux_86_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_11_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_17_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_20_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_22_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_11_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_71_nl;
  wire mux_197_nl;
  wire mux_196_nl;
  wire nor_156_nl;
  wire mux_195_nl;
  wire nor_154_nl;
  wire or_250_nl;
  wire and_355_nl;
  wire mux_199_nl;
  wire mux_198_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_12_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_10_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_16_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_24_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_12_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_70_nl;
  wire mux_193_nl;
  wire mux_192_nl;
  wire nor_151_nl;
  wire mux_191_nl;
  wire or_244_nl;
  wire and_351_nl;
  wire mux_194_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_9_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_24_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_15_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_26_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_13_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_69_nl;
  wire mux_189_nl;
  wire mux_188_nl;
  wire mux_187_nl;
  wire or_239_nl;
  wire and_347_nl;
  wire mux_190_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_8_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_14_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_28_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_14_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_67_nl;
  wire mux_185_nl;
  wire mux_184_nl;
  wire mux_183_nl;
  wire mux_182_nl;
  wire mux_181_nl;
  wire or_232_nl;
  wire and_343_nl;
  wire mux_186_nl;
  wire[2:0] MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire[3:0] nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire MAC_3_r_ac_float_else_and_nl;
  wire[4:0] MAC_3_r_ac_float_else_and_1_nl;
  wire mux_94_nl;
  wire[1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl;
  wire[1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_or_nl;
  wire[1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_7_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_16_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_30_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_15_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_nl;
  wire mux_96_nl;
  wire nor_75_nl;
  wire mux_95_nl;
  wire mux_179_nl;
  wire nor_77_nl;
  wire[6:0] MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_4_r_ac_float_else_and_nl;
  wire[4:0] MAC_4_r_ac_float_else_and_1_nl;
  wire[6:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_5_r_ac_float_else_and_nl;
  wire[4:0] MAC_5_r_ac_float_else_and_1_nl;
  wire[6:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_6_r_ac_float_else_and_nl;
  wire[4:0] MAC_6_r_ac_float_else_and_1_nl;
  wire[6:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_7_r_ac_float_else_and_nl;
  wire[4:0] MAC_7_r_ac_float_else_and_1_nl;
  wire[6:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_8_r_ac_float_else_and_nl;
  wire[4:0] MAC_8_r_ac_float_else_and_1_nl;
  wire[6:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire[7:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl;
  wire MAC_9_r_ac_float_else_and_nl;
  wire[4:0] MAC_9_r_ac_float_else_and_1_nl;
  wire MAC_3_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire and_108_nl;
  wire and_111_nl;
  wire and_114_nl;
  wire and_120_nl;
  wire and_123_nl;
  wire and_126_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_nand_nl;
  wire[3:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire[4:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire and_130_nl;
  wire and_133_nl;
  wire and_136_nl;
  wire MAC_11_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire MAC_12_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire MAC_13_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire[3:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire[4:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire nor_98_nl;
  wire and_142_nl;
  wire MAC_14_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire[3:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire[4:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire nor_99_nl;
  wire and_144_nl;
  wire MAC_15_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire and_147_nl;
  wire and_150_nl;
  wire and_153_nl;
  wire and_156_nl;
  wire and_159_nl;
  wire and_162_nl;
  wire and_165_nl;
  wire and_168_nl;
  wire and_171_nl;
  wire and_174_nl;
  wire and_177_nl;
  wire and_180_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_nl;
  wire MAC_9_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_nl;
  wire MAC_8_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_nl;
  wire MAC_7_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_nl;
  wire MAC_6_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_nl;
  wire MAC_5_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_nl;
  wire MAC_4_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_1_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nand_nl;
  wire[3:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire[4:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_1_nl;
  wire and_138_nl;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl;
  wire[10:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_nl;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e1_lt_e2_not_32_nl;
  wire[10:0] result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl;
  wire[1:0] MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire[2:0] nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire[1:0] MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire[2:0] nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl;
  wire MAC_10_r_ac_float_else_and_nl;
  wire[4:0] MAC_10_r_ac_float_else_and_1_nl;
  wire[1:0] MAC_11_r_ac_float_else_and_nl;
  wire[3:0] MAC_11_r_ac_float_else_and_1_nl;
  wire MAC_12_r_ac_float_else_and_nl;
  wire[4:0] MAC_12_r_ac_float_else_and_1_nl;
  wire MAC_13_r_ac_float_else_and_nl;
  wire[4:0] MAC_13_r_ac_float_else_and_1_nl;
  wire MAC_14_r_ac_float_else_and_nl;
  wire[4:0] MAC_14_r_ac_float_else_and_1_nl;
  wire MAC_15_r_ac_float_else_and_nl;
  wire[4:0] MAC_15_r_ac_float_else_and_1_nl;
  wire MAC_1_r_ac_float_else_and_nl;
  wire[4:0] MAC_1_r_ac_float_else_and_1_nl;
  wire MAC_16_r_ac_float_else_and_nl;
  wire[4:0] MAC_16_r_ac_float_else_and_1_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_31_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_34_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_35_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl;
  wire[6:0] MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_38_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_39_nl;
  wire[6:0] MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_42_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_43_nl;
  wire[6:0] MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_46_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_47_nl;
  wire[6:0] MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_50_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_51_nl;
  wire[6:0] MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_54_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_55_nl;
  wire[6:0] MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_58_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_59_nl;
  wire[6:0] MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl;
  wire[6:0] MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[7:0] nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl;
  wire[6:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_8_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_33_nl;
  wire[6:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_7_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_29_nl;
  wire[6:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_6_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl;
  wire[6:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_5_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl;
  wire[6:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_4_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl;
  wire[6:0] MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_3_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl;
  wire ac_float_cctor_assign_from_0_0_32_32_AC_TRN_AC_WRAP_if_3_not_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_2_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_3_nl;
  wire[5:0] MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl;
  wire[6:0] nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl;
  wire[6:0] MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_2_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_51_nl;
  wire[1:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_78_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_68_nl;
  wire[3:0] result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_79_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_69_nl;
  wire[6:0] MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl;
  wire[7:0] nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl;
  wire[5:0] MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire mux_31_nl;
  wire nor_55_nl;
  wire mux_26_nl;
  wire mux_71_nl;
  wire nor_58_nl;
  wire mux_91_nl;
  wire mux_104_nl;
  wire mux_103_nl;
  wire mux_102_nl;
  wire mux_6_nl;
  wire mux_100_nl;
  wire or_136_nl;
  wire mux_176_nl;
  wire mux_175_nl;
  wire mux_174_nl;
  wire nor_135_nl;
  wire mux_173_nl;
  wire nand_11_nl;
  wire nor_136_nl;
  wire mux_172_nl;
  wire mux_171_nl;
  wire nand_12_nl;
  wire nor_137_nl;
  wire mux_170_nl;
  wire nand_13_nl;
  wire nor_138_nl;
  wire mux_169_nl;
  wire mux_168_nl;
  wire mux_167_nl;
  wire nand_14_nl;
  wire nor_139_nl;
  wire mux_166_nl;
  wire or_292_nl;
  wire nor_140_nl;
  wire mux_165_nl;
  wire mux_164_nl;
  wire nand_15_nl;
  wire nor_141_nl;
  wire mux_163_nl;
  wire nand_16_nl;
  wire nor_142_nl;
  wire mux_241_nl;
  wire or_297_nl;
  wire or_296_nl;
  wire mux_244_nl;
  wire mux_243_nl;
  wire mux_240_nl;
  wire mux_247_nl;
  wire mux_246_nl;
  wire mux_275_nl;
  wire mux_239_nl;
  wire mux_315_nl;
  wire mux_250_nl;
  wire mux_249_nl;
  wire mux_226_nl;
  wire mux_293_nl;
  wire mux_238_nl;
  wire mux_232_nl;
  wire mux_316_nl;
  wire mux_253_nl;
  wire mux_252_nl;
  wire mux_227_nl;
  wire mux_267_nl;
  wire mux_295_nl;
  wire mux_237_nl;
  wire mux_233_nl;
  wire mux_277_nl;
  wire mux_317_nl;
  wire mux_256_nl;
  wire mux_255_nl;
  wire mux_228_nl;
  wire mux_269_nl;
  wire mux_270_nl;
  wire mux_297_nl;
  wire mux_236_nl;
  wire mux_234_nl;
  wire mux_279_nl;
  wire mux_280_nl;
  wire mux_287_nl;
  wire mux_138_nl;
  wire mux_137_nl;
  wire or_51_nl;
  wire nor_30_nl;
  wire mux_152_nl;
  wire mux_151_nl;
  wire mux_150_nl;
  wire and_226_nl;
  wire mux_149_nl;
  wire or_187_nl;
  wire or_186_nl;
  wire mux_148_nl;
  wire mux_147_nl;
  wire or_185_nl;
  wire or_184_nl;
  wire mux_146_nl;
  wire or_183_nl;
  wire or_182_nl;
  wire mux_145_nl;
  wire mux_144_nl;
  wire mux_143_nl;
  wire or_181_nl;
  wire or_180_nl;
  wire mux_142_nl;
  wire or_179_nl;
  wire or_178_nl;
  wire mux_141_nl;
  wire mux_140_nl;
  wire or_177_nl;
  wire or_176_nl;
  wire mux_139_nl;
  wire or_175_nl;
  wire or_174_nl;
  wire ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_mux1h_16_nl;
  wire[4:0] and_504_nl;
  wire[4:0] mux1h_1_nl;
  wire[4:0] MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[4:0] MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire[5:0] nl_MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl;
  wire and_367_nl;
  wire or_302_nl;
  wire mux_210_nl;
  wire nand_17_nl;
  wire or_279_nl;
  wire mux_209_nl;
  wire mux_208_nl;
  wire mux_207_nl;
  wire or_293_nl;
  wire nor_166_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_48_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_49_nl;
  wire and_372_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_50_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_51_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_52_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_53_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_54_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_55_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_56_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_57_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_58_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_59_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_60_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_61_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_62_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_63_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_64_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_65_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_66_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_67_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_68_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_69_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_70_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_71_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_72_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_73_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_74_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_75_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_76_nl;
  wire result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_77_nl;
  wire not_625_nl;
  wire[6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl;
  wire[6:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_nl;
  wire[6:0] MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[7:0] nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl;
  wire[6:0] MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_nl;
  wire[6:0] MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire[7:0] nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl;
  wire and_492_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_64_nl;
  wire[3:0] MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire[4:0] nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_nl;
  wire and_140_nl;
  wire result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_1_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_6_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_8_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl;
  wire[7:0] acc_nl;
  wire[8:0] nl_acc_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_5_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_6_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_7_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_8_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_mux_1_nl;
  wire and_637_nl;
  wire[7:0] acc_2_nl;
  wire[8:0] nl_acc_2_nl;
  wire[1:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_4_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_5_nl;
  wire[4:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_6_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_83_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_84_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_26_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_79_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_80_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_27_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_81_nl;
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_82_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [12:0] nl_MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , 1'b0};
  wire [12:0] nl_MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_1_nl;
  wire [4:0] nl_MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg[4]), MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_1_nl
      = MUX_v_4_2_2(operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2,
      (MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg[3:0]), MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_1_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_1_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_4_nl;
  wire [5:0] nl_MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_1_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_4_nl
      = MUX_v_4_2_2((MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva);
  assign nl_MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_1_nl
      , MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_4_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_27_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_28_nl;
  wire [4:0] nl_MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_27_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg[4]), MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_28_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg[3:0]), MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_27_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_28_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_30_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_31_nl;
  wire [4:0] nl_MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_30_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg[4]), MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_31_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg[3:0]), MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_30_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_31_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_33_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_34_nl;
  wire [4:0] nl_MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_33_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg[4]), MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_34_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg[3:0]), MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_33_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_34_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_36_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_37_nl;
  wire [4:0] nl_MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_36_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg[4]), MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_37_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg[3:0]), MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_36_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_37_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_39_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_40_nl;
  wire [4:0] nl_MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_39_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg[4]), MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_40_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg[3:0]), MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_39_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_40_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_42_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_43_nl;
  wire [4:0] nl_MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_42_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg[4]), MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_43_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg[3:0]), MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_42_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_43_nl};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_45_nl;
  wire[3:0] ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_46_nl;
  wire [4:0] nl_MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_45_nl
      = MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg[4]), MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_46_nl
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[3:0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg[3:0]), MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign nl_MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_45_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_46_nl};
  wire [11:0] nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_rshift_rg_a;
  assign nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_rshift_rg_a = {operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7
      , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1
      , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2 , 1'b0};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_3_nl;
  wire [5:0] nl_MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_3_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva;
  assign nl_MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_3_nl
      , MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_4_nl;
  wire [5:0] nl_MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_4_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva;
  assign nl_MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_4_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_5_nl;
  wire [5:0] nl_MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_5_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva;
  assign nl_MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_5_nl
      , MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_6_nl;
  wire [5:0] nl_MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_6_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva;
  assign nl_MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_6_nl
      , MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_7_nl;
  wire [5:0] nl_MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_7_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva;
  assign nl_MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_7_nl
      , MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_8_nl;
  wire [5:0] nl_MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_8_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1[0])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva;
  assign nl_MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_8_nl
      , MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm};
  wire [12:0] nl_MAC_1_leading_sign_13_1_1_0_rg_mantissa;
  assign nl_MAC_1_leading_sign_13_1_1_0_rg_mantissa = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , 1'b0};
  wire ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_2_nl;
  wire [5:0] nl_MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_2_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[1])
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva;
  assign nl_MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s = {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_and_2_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm};
  wire [4:0] nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg_s;
  assign nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg_s
      = {1'b0, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm};
  wire [12:0] nl_MAC_10_leading_sign_13_1_1_0_rg_mantissa;
  assign nl_MAC_10_leading_sign_13_1_1_0_rg_mantissa = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  wire [12:0] nl_MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a;
  assign nl_MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a = {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 , (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])};
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd11)) input_m_rsci (
      .dat(input_m_rsc_dat),
      .idat(input_m_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd5)) input_e_rsci (
      .dat(input_e_rsc_dat),
      .idat(input_e_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd176)) taps_m_rsci (
      .dat(taps_m_rsc_dat),
      .idat(taps_m_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd4),
  .width(32'sd80)) taps_e_rsci (
      .dat(taps_e_rsc_dat),
      .idat(taps_e_rsci_idat)
    );
  ccs_out_v1 #(.rscid(32'sd5),
  .width(32'sd11)) return_m_rsci (
      .idat(return_m_rsci_idat),
      .dat(return_m_rsc_dat)
    );
  ccs_out_v1 #(.rscid(32'sd6),
  .width(32'sd5)) return_e_rsci (
      .idat(return_e_rsci_idat),
      .dat(return_e_rsc_dat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) input_m_triosy_obj (
      .ld(reg_taps_e_triosy_obj_ld_cse),
      .lz(input_m_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) input_e_triosy_obj (
      .ld(reg_taps_e_triosy_obj_ld_cse),
      .lz(input_e_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) taps_m_triosy_obj (
      .ld(reg_taps_e_triosy_obj_ld_cse),
      .lz(taps_m_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) taps_e_triosy_obj (
      .ld(reg_taps_e_triosy_obj_ld_cse),
      .lz(taps_e_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) return_m_triosy_obj (
      .ld(reg_return_e_triosy_obj_ld_cse),
      .lz(return_m_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) return_e_triosy_obj (
      .ld(reg_return_e_triosy_obj_ld_cse),
      .lz(return_e_triosy_lz)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1),
      .z(MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva),
      .s(nl_MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1),
      .z(MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva),
      .s(nl_MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1),
      .z(MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva),
      .s(nl_MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1),
      .z(MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva),
      .s(nl_MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1),
      .z(MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva),
      .s(nl_MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1),
      .z(MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva),
      .s(nl_MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1),
      .z(MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva),
      .s(nl_MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1),
      .z(MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva),
      .s(nl_MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1),
      .z(MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva),
      .s(nl_MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[4:0]),
      .z(MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd12),
  .signd_a(32'sd1),
  .width_s(32'sd5),
  .width_z(32'sd12)) MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_rshift_rg (
      .a(nl_MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_rshift_rg_a[11:0]),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2),
      .z(operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva),
      .s(nl_MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm),
      .z(MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva),
      .s(nl_MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm),
      .z(MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva),
      .s(nl_MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva),
      .s(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0),
      .z(MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva),
      .s(nl_MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva),
      .s(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1),
      .z(MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva),
      .s(nl_MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm),
      .z(MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva),
      .s(nl_MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd22)) MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva),
      .s(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm),
      .z(MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  leading_sign_13_1_1_0  MAC_1_leading_sign_13_1_1_0_rg (
      .mantissa(nl_MAC_1_leading_sign_13_1_1_0_rg_mantissa[12:0]),
      .all_same(leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_12),
      .rtn(leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_14)
    );
  mgc_shift_l_v5 #(.width_a(32'sd22),
  .signd_a(32'sd0),
  .width_s(32'sd6),
  .width_z(32'sd22)) MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva),
      .s(nl_MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_rg_s[5:0]),
      .z(MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  mgc_shift_br_v5 #(.width_a(32'sd22),
  .signd_a(32'sd1),
  .width_s(32'sd5),
  .width_z(32'sd22)) MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg
      (
      .a(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva),
      .s(nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_rg_s[4:0]),
      .z(MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm)
    );
  leading_sign_13_1_1_0  MAC_10_leading_sign_13_1_1_0_rg (
      .mantissa(nl_MAC_10_leading_sign_13_1_1_0_rg_mantissa[12:0]),
      .all_same(leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_13),
      .rtn(leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_15)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg (
      .a(nl_MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_rg_a[12:0]),
      .s(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0),
      .z(MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm)
    );
  fir_core_wait_dp fir_core_wait_dp_inst (
      .clk(clk),
      .rst(rst),
      .MAC_1_leading_sign_18_1_1_0_cmp_all_same(MAC_1_leading_sign_18_1_1_0_cmp_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_rtn(MAC_1_leading_sign_18_1_1_0_cmp_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_all_same(MAC_1_leading_sign_18_1_1_0_cmp_1_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_rtn(MAC_1_leading_sign_18_1_1_0_cmp_1_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_all_same(MAC_1_leading_sign_18_1_1_0_cmp_2_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_rtn(MAC_1_leading_sign_18_1_1_0_cmp_2_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_all_same(MAC_1_leading_sign_18_1_1_0_cmp_3_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_rtn(MAC_1_leading_sign_18_1_1_0_cmp_3_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_all_same(MAC_1_leading_sign_18_1_1_0_cmp_4_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_rtn(MAC_1_leading_sign_18_1_1_0_cmp_4_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_all_same(MAC_1_leading_sign_18_1_1_0_cmp_5_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_rtn(MAC_1_leading_sign_18_1_1_0_cmp_5_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_all_same(MAC_1_leading_sign_18_1_1_0_cmp_6_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_rtn(MAC_1_leading_sign_18_1_1_0_cmp_6_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_all_same(MAC_1_leading_sign_18_1_1_0_cmp_7_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_rtn(MAC_1_leading_sign_18_1_1_0_cmp_7_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_all_same(MAC_1_leading_sign_18_1_1_0_cmp_8_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_rtn(MAC_1_leading_sign_18_1_1_0_cmp_8_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_all_same(MAC_1_leading_sign_18_1_1_0_cmp_9_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_rtn(MAC_1_leading_sign_18_1_1_0_cmp_9_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_all_same(MAC_1_leading_sign_18_1_1_0_cmp_10_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_rtn(MAC_1_leading_sign_18_1_1_0_cmp_10_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_all_same(MAC_1_leading_sign_18_1_1_0_cmp_11_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_rtn(MAC_1_leading_sign_18_1_1_0_cmp_11_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_all_same(MAC_1_leading_sign_18_1_1_0_cmp_12_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_rtn(MAC_1_leading_sign_18_1_1_0_cmp_12_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_all_same(MAC_1_leading_sign_18_1_1_0_cmp_13_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_rtn(MAC_1_leading_sign_18_1_1_0_cmp_13_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_all_same(MAC_1_leading_sign_18_1_1_0_cmp_14_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_rtn(MAC_1_leading_sign_18_1_1_0_cmp_14_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_all_same(MAC_1_leading_sign_18_1_1_0_cmp_15_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_rtn(MAC_1_leading_sign_18_1_1_0_cmp_15_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg(MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg(MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg)
    );
  fir_core_core_fsm fir_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output)
    );
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_or_cse = and_dcpl_39
      | and_dcpl_42;
  assign nor_120_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5);
  assign or_160_cse = nor_120_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6;
  assign nl_MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6({MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0
      , MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1})
      + conv_s2s_5_6(taps_e_rsci_idat[79:75]);
  assign MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign nor_119_nl = ~((fsm_output[4]) | mux_tmp_104);
  assign mux_128_nl = MUX_s_1_2_2(nor_119_nl, nor_tmp_11, fsm_output[2]);
  assign mux_129_nl = MUX_s_1_2_2(mux_128_nl, nor_tmp_6, fsm_output[3]);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, mux_tmp_58, or_160_cse);
  assign or_162_rgt = mux_130_nl | (fsm_output[6]);
  assign and_206_rgt = and_dcpl_189 & or_160_cse & and_dcpl_6;
  assign nor_80_rgt = ~(mux_tmp_58 | (fsm_output[6]));
  assign nor_116_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5);
  assign or_154_cse = nor_116_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6;
  assign or_155_cse = (fsm_output[3:2]!=2'b00);
  assign nl_MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_14_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[74:70]);
  assign MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_123_nl = MUX_s_1_2_2((~ mux_tmp_104), nor_tmp_9, fsm_output[4]);
  assign mux_124_nl = MUX_s_1_2_2(mux_123_nl, nor_tmp_6, or_155_cse);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, mux_tmp_60, or_154_cse);
  assign or_156_rgt = mux_125_nl | (fsm_output[6]);
  assign and_202_rgt = and_dcpl_189 & or_154_cse & and_dcpl_6;
  assign nor_81_rgt = ~(mux_tmp_60 | (fsm_output[6]));
  assign nor_113_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5);
  assign or_150_cse = nor_113_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6;
  assign nl_MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_13_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[69:65]);
  assign MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_120_nl = MUX_s_1_2_2(mux_tmp_112, mux_tmp_62, fsm_output[3]);
  assign mux_121_nl = MUX_s_1_2_2(mux_120_nl, mux_tmp_65, or_150_cse);
  assign or_151_rgt = mux_121_nl | (fsm_output[6]);
  assign and_198_rgt = and_dcpl_189 & or_150_cse & and_dcpl_6;
  assign nor_82_rgt = ~(mux_tmp_65 | (fsm_output[6]));
  assign nor_110_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5);
  assign or_146_cse = nor_110_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6;
  assign nl_MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_12_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[64:60]);
  assign MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_116_nl = MUX_s_1_2_2(mux_tmp_112, mux_tmp_66, fsm_output[3]);
  assign mux_117_nl = MUX_s_1_2_2(mux_116_nl, mux_tmp_67, or_146_cse);
  assign or_147_rgt = mux_117_nl | (fsm_output[6]);
  assign and_194_rgt = and_dcpl_189 & or_146_cse & and_dcpl_6;
  assign nor_83_rgt = ~(mux_tmp_67 | (fsm_output[6]));
  assign nor_107_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5);
  assign or_142_cse = nor_107_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6;
  assign nl_MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_11_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[59:55]);
  assign MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_109_nl = MUX_s_1_2_2(mux_tmp_105, mux_tmp_61, fsm_output[2]);
  assign mux_110_nl = MUX_s_1_2_2(mux_109_nl, (fsm_output[5]), fsm_output[3]);
  assign mux_111_nl = MUX_s_1_2_2(mux_110_nl, mux_tmp_69, or_142_cse);
  assign or_143_rgt = mux_111_nl | (fsm_output[6]);
  assign and_190_rgt = and_dcpl_189 & or_142_cse & and_dcpl_6;
  assign nor_84_rgt = ~(mux_tmp_69 | (fsm_output[6]));
  assign nor_132_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp[5:4]!=2'b00));
  assign nl_MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_1_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[14:10]);
  assign MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_156_nl = MUX_s_1_2_2((~ or_tmp_38), or_tmp_38, fsm_output[3]);
  assign nor_131_nl = ~((~((~ (fsm_output[2])) | (fsm_output[0]))) | (fsm_output[1]));
  assign mux_155_nl = MUX_s_1_2_2(nor_131_nl, or_tmp_38, fsm_output[3]);
  assign nor_31_nl = ~(nor_132_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp[6])
      | (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm));
  assign mux_157_nl = MUX_s_1_2_2(mux_156_nl, mux_155_nl, nor_31_nl);
  assign or_207_rgt = mux_157_nl | or_dcpl_103;
  assign and_285_rgt = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp[6])
      | nor_132_cse) & not_tmp_25 & and_dcpl_280 & and_dcpl_116;
  assign and_50_rgt = (or_tmp_38 ^ (fsm_output[3])) & and_dcpl_8;
  assign nor_128_cse = ~((operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1!=2'b00));
  assign and_461_cse = (fsm_output[1:0]==2'b11);
  assign nl_MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(delay_lane_e_0_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[9:5]);
  assign MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign or_89_nl = (fsm_output[0]) | (~((~((fsm_output[6:5]==2'b11))) & (fsm_output[1])));
  assign mux_75_nl = MUX_s_1_2_2(or_89_nl, or_tmp_44, fsm_output[4]);
  assign or_87_nl = (fsm_output[6]) | (~ or_tmp_46);
  assign or_85_nl = (fsm_output[6]) | (fsm_output[5]) | (fsm_output[1]);
  assign mux_73_nl = MUX_s_1_2_2(or_87_nl, or_85_nl, fsm_output[0]);
  assign mux_74_nl = MUX_s_1_2_2(mux_73_nl, or_tmp_44, fsm_output[4]);
  assign mux_76_nl = MUX_s_1_2_2(mux_75_nl, mux_74_nl, fsm_output[2]);
  assign mux_77_itm = MUX_s_1_2_2(mux_76_nl, or_tmp_44, fsm_output[3]);
  assign nor_124_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[4])
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5);
  assign or_165_cse = nor_124_cse | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6;
  assign nl_MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = conv_s2s_5_6(input_e_rsci_idat)
      + conv_s2s_5_6(taps_e_rsci_idat[4:0]);
  assign MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm = nl_MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5:0];
  assign mux_34_cse = MUX_s_1_2_2(nor_tmp_11, nor_tmp_6, fsm_output[2]);
  assign nor_123_nl = ~((fsm_output[2]) | (fsm_output[4]) | mux_tmp_104);
  assign mux_133_nl = MUX_s_1_2_2(nor_123_nl, mux_34_cse, fsm_output[3]);
  assign mux_134_nl = MUX_s_1_2_2(mux_133_nl, mux_tmp_76, or_165_cse);
  assign or_168_rgt = mux_134_nl | (fsm_output[6]);
  assign and_210_rgt = and_dcpl_189 & or_165_cse & and_dcpl_6;
  assign nor_85_rgt = ~(mux_tmp_76 | (fsm_output[6]));
  assign or_4_cse = (fsm_output[4:2]!=3'b000);
  assign and_369_m1c = and_dcpl_41 & and_dcpl_56;
  assign and_374_m1c = and_dcpl_41 & and_dcpl_371;
  assign and_376_m1c = and_dcpl_41 & and_dcpl_373;
  assign and_379_m1c = and_dcpl_41 & and_dcpl_376;
  assign and_381_m1c = and_dcpl_41 & and_dcpl_378;
  assign and_383_m1c = and_dcpl_41 & and_dcpl_380;
  assign and_385_m1c = and_dcpl_41 & and_dcpl_382;
  assign and_386_cse = and_dcpl_311 & and_dcpl_36;
  assign and_387_m1c = and_dcpl_311 & and_dcpl_56;
  assign and_388_m1c = and_dcpl_311 & and_dcpl_371;
  assign and_389_m1c = and_dcpl_311 & and_dcpl_373;
  assign and_390_m1c = and_dcpl_311 & and_dcpl_376;
  assign and_391_m1c = and_dcpl_311 & and_dcpl_378;
  assign and_392_m1c = and_dcpl_311 & and_dcpl_380;
  assign and_393_m1c = and_dcpl_311 & and_dcpl_382;
  assign and_500_cse = and_dcpl_373 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva;
  assign and_495_cse = and_dcpl_373 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm;
  assign and_501_cse = and_dcpl_371 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva;
  assign and_496_cse = and_dcpl_371 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva;
  assign and_502_cse = and_dcpl_376 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva;
  assign and_497_cse = and_dcpl_376 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm;
  assign and_499_cse = and_dcpl_378 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva;
  assign and_494_cse = and_dcpl_378 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm;
  assign or_294_nl = and_dcpl_41 | nor_tmp_52;
  assign and_507_nl = and_dcpl_382 & ac_float_cctor_operator_return_sva;
  assign mux_289_itm = MUX_s_1_2_2(or_294_nl, or_tmp, and_507_nl);
  assign or_298_nl = and_dcpl_56 | and_dcpl_376 | and_dcpl_371 | and_dcpl_373 | and_dcpl_378
      | and_dcpl_382;
  assign mux_261_nl = MUX_s_1_2_2(and_386_cse, or_tmp, or_298_nl);
  assign mux_262_nl = MUX_s_1_2_2(mux_tmp_254, mux_261_nl, MAC_3_result_operator_result_operator_nor_tmp);
  assign mux_314_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, and_494_cse);
  assign mux_284_nl = MUX_s_1_2_2(mux_314_nl, or_tmp, and_495_cse);
  assign mux_283_nl = MUX_s_1_2_2(mux_284_nl, or_tmp, and_496_cse);
  assign mux_282_nl = MUX_s_1_2_2(mux_283_nl, or_tmp, and_497_cse);
  assign and_498_nl = and_dcpl_56 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva;
  assign mux_235_nl = MUX_s_1_2_2(mux_282_nl, or_tmp, and_498_nl);
  assign mux_258_nl = MUX_s_1_2_2(mux_tmp_254, mux_235_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva);
  assign mux_288_nl = MUX_s_1_2_2(mux_289_itm, or_tmp, and_499_cse);
  assign mux_274_nl = MUX_s_1_2_2(mux_288_nl, or_tmp, and_500_cse);
  assign mux_273_nl = MUX_s_1_2_2(mux_274_nl, or_tmp, and_501_cse);
  assign mux_272_nl = MUX_s_1_2_2(mux_273_nl, or_tmp, and_502_cse);
  assign and_503_nl = and_dcpl_56 & ac_float_cctor_operator_return_9_sva;
  assign mux_229_nl = MUX_s_1_2_2(mux_272_nl, or_tmp, and_503_nl);
  assign mux_230_nl = MUX_s_1_2_2(mux_229_nl, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva);
  assign mux_259_nl = MUX_s_1_2_2(mux_258_nl, mux_230_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm);
  assign mux_260_nl = MUX_s_1_2_2(mux_259_nl, or_tmp, MAC_3_result_operator_result_operator_nor_tmp);
  assign mux_263_tmp = MUX_s_1_2_2(mux_262_nl, mux_260_nl, and_dcpl_380);
  assign MAC_2_r_ac_float_else_and_nl = MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_2_r_ac_float_else_and_1_nl = MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0
      & MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_2_r_ac_float_else_and_2_nl = MUX_v_4_2_2(4'b0000, MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1,
      MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm =
      conv_s2s_6_7({MAC_2_r_ac_float_else_and_nl , MAC_2_r_ac_float_else_and_1_nl
      , MAC_2_r_ac_float_else_and_2_nl}) + 7'b0000001;
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm = nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm[6:0];
  assign operator_13_2_true_AC_TRN_AC_WRAP_or_ssc = and_dcpl_39 | operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1
      | and_dcpl_70 | and_dcpl_66;
  assign and_479_nl = (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign and_480_nl = (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_288_nl = (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_221_nl = MUX_s_1_2_2(and_480_nl, or_288_nl, MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_222_nl = MUX_s_1_2_2(and_479_nl, mux_221_nl, fsm_output[2]);
  assign and_481_nl = (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_287_nl = (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_219_nl = MUX_s_1_2_2(and_481_nl, or_287_nl, MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign and_482_nl = (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_286_nl = (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_218_nl = MUX_s_1_2_2(and_482_nl, or_286_nl, MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_220_nl = MUX_s_1_2_2(mux_219_nl, mux_218_nl, fsm_output[2]);
  assign mux_223_nl = MUX_s_1_2_2(mux_222_nl, mux_220_nl, fsm_output[3]);
  assign and_483_nl = (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_285_nl = (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_215_nl = MUX_s_1_2_2(and_483_nl, or_285_nl, MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign nor_167_nl = ~((~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      | (fsm_output[5]));
  assign or_283_nl = (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[5]);
  assign mux_214_nl = MUX_s_1_2_2(nor_167_nl, or_283_nl, MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_216_nl = MUX_s_1_2_2(mux_215_nl, mux_214_nl, fsm_output[2]);
  assign and_484_nl = (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_282_nl = (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_212_nl = MUX_s_1_2_2(and_484_nl, or_282_nl, MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign and_485_nl = (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]);
  assign or_281_nl = (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5]));
  assign mux_211_nl = MUX_s_1_2_2(and_485_nl, or_281_nl, MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_213_nl = MUX_s_1_2_2(mux_212_nl, mux_211_nl, fsm_output[2]);
  assign mux_217_nl = MUX_s_1_2_2(mux_216_nl, mux_213_nl, fsm_output[3]);
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, mux_217_nl, fsm_output[4]);
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse = mux_224_nl & and_dcpl_288;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse = and_dcpl_41 & (~((MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_116;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse = and_dcpl_67 & and_dcpl_371;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse = and_dcpl_41 & (~((MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_227;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse = and_dcpl_67 & and_dcpl_373;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse = and_dcpl_41 & (~((MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_232;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse = and_dcpl_67 & and_dcpl_376;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse = and_dcpl_41 & (~ (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_dcpl_6 & and_dcpl_70;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse = and_dcpl_67 & and_dcpl_378;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse = and_dcpl_41 & (~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & (fsm_output[4]) & and_dcpl_116;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse = and_dcpl_67 & and_dcpl_380;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse = and_dcpl_41 & (fsm_output[4])
      & (~ (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_dcpl_227;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse = and_dcpl_67 & and_dcpl_382;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse = and_dcpl_41 & and_dcpl_306
      & (~ (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & (fsm_output[3]);
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse = and_dcpl_420 & and_dcpl_36;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse = and_dcpl_311 & (~((MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_6;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse = and_dcpl_420 & and_dcpl_56;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse = and_dcpl_311 & (~((MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_116;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse = and_dcpl_420 & and_dcpl_371;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse = and_dcpl_311 & (~((MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_227;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse = and_dcpl_420 & and_dcpl_373;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse = and_dcpl_311 & (~((MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[4]))) & and_dcpl_232;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse = and_dcpl_420 & and_dcpl_376;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse = and_dcpl_311 & (~ (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & (fsm_output[4]) & and_dcpl_6;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse = and_dcpl_420 & and_dcpl_378;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse = and_dcpl_311 & and_dcpl_306
      & (~((fsm_output[3]) | (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])));
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse = and_dcpl_420 & and_dcpl_380;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse = and_dcpl_311 & (~ (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & (fsm_output[4]) & and_dcpl_227;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse = and_dcpl_420 & and_dcpl_382;
  assign operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse = and_dcpl_311 & (~ (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & (fsm_output[4]) & and_dcpl_232;
  assign or_301_tmp = (and_dcpl_42 & (~ MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]))
      & ((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva[21]) | (~ MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm)
      | (~ MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg))) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
      & and_dcpl_61 & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[1])));
  assign nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg)}) + 7'b0000001;
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1);
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_37_ssc = ~(MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_9_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_7_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva[21]))
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm);
  assign nor_86_nl = ~((fsm_output[2]) | and_461_cse);
  assign mux_83_nl = MUX_s_1_2_2(nor_86_nl, and_dcpl_58, fsm_output[3]);
  assign and_74_ssc = (~ mux_83_nl) & and_dcpl_8;
  assign nor_162_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp[5:4]!=2'b00));
  assign nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg)}) + 7'b0000001;
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1);
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_41_ssc = ~(MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_10_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_6_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva[21]))
      & MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign mux_84_nl = MUX_s_1_2_2((~ and_461_cse), (fsm_output[1]), fsm_output[4]);
  assign mux_85_nl = MUX_s_1_2_2(mux_84_nl, (fsm_output[4]), or_155_cse);
  assign and_75_ssc = (~ mux_85_nl) & and_dcpl_7;
  assign nor_159_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp[5:4]!=2'b00));
  assign nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg)}) + 7'b0000001;
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1);
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_45_ssc = ~(MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_11_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_5_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva[21]))
      & MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign mux_86_nl = MUX_s_1_2_2((~ or_tmp_57), nor_tmp_27, fsm_output[2]);
  assign mux_87_nl = MUX_s_1_2_2(mux_86_nl, (fsm_output[4]), fsm_output[3]);
  assign and_76_ssc = (~ mux_87_nl) & and_dcpl_7;
  assign nor_155_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp[5:4]!=2'b00));
  assign nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1);
  assign MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_49_ssc = ~(MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_12_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_4_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva[21]))
      & MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign and_77_ssc = (~ mux_tmp_86) & and_dcpl_7;
  assign nor_152_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp[5:4]!=2'b00));
  assign nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg)}) + 7'b0000001;
  assign MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1);
  assign MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_53_ssc = ~(MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_13_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_3_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva[21]))
      & MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign and_78_ssc = (~ mux_tmp_87) & and_dcpl_7;
  assign nor_149_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp[5:4]!=2'b00));
  assign nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg)}) + 7'b0000001;
  assign MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1);
  assign MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_57_ssc = ~(MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_14_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_2_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva[21]))
      & MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign nor_146_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp[5:4]!=2'b00));
  assign nor_89_cse = ~((fsm_output[6]) | (fsm_output[4]) | (fsm_output[3]));
  assign nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0})
      + conv_s2s_6_7({1'b1 , (~ MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg)}) + 7'b0000001;
  assign MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt
      = nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:0];
  assign nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1);
  assign MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt
      = nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_61_ssc = ~(MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_15_seb
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_1_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva[21]))
      & MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign nor_144_cse = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5[0])
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[4]));
  assign ac_float_cctor_ac_float_22_2_6_AC_TRN_or_ssc = and_dcpl_86 | and_dcpl_61
      | and_dcpl_89;
  assign ac_float_cctor_ac_float_22_2_6_AC_TRN_or_1_cse = and_dcpl_86 | and_dcpl_61;
  assign ac_float_cctor_ac_float_22_2_6_AC_TRN_and_1_cse = ac_float_cctor_ac_float_22_2_6_AC_TRN_or_1_cse
      & (~ and_dcpl_42);
  assign MAC_2_ac_float_cctor_operator_ac_float_cctor_operator_nor_cse = ~((z_out_2!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_or_2_cse
      = and_dcpl_42 | and_dcpl_61;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_ssc = and_dcpl_42
      | and_dcpl_57 | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
      | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e1_lt_e2_not_32_nl = ~ MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_itm_5_1;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_nl
      = MUX_v_11_2_2(11'b00000000000, MAC_ac_float_cctor_m_1_lpi_1_dfm_1, result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e1_lt_e2_not_32_nl);
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl
      = MUX_v_11_2_2(11'b00000000000, MAC_ac_float_cctor_m_1_lpi_1_dfm_1, MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_itm_5_1);
  assign nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm = conv_s2u_11_12(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_nl)
      + conv_s2u_11_12(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl);
  assign MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm = nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[11:0];
  assign nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm = conv_s2u_11_12(operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3[11:1])
      + conv_s2u_11_12({result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_10_7
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_6 , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_5_4
      , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0});
  assign MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm = nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[11:0];
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0 = $signed((input_m_rsci_idat))
      * $signed((taps_m_rsci_idat[10:0]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0 = $signed(delay_lane_m_9_sva)
      * $signed((taps_m_rsci_idat[109:99]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0 = $signed(delay_lane_m_10_sva)
      * $signed((taps_m_rsci_idat[120:110]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0 = $signed(delay_lane_m_11_sva)
      * $signed((taps_m_rsci_idat[131:121]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0 = $signed(delay_lane_m_12_sva)
      * $signed((taps_m_rsci_idat[142:132]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0 = $signed(delay_lane_m_13_sva)
      * $signed((taps_m_rsci_idat[153:143]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0 = $signed(delay_lane_m_14_sva)
      * $signed((taps_m_rsci_idat[164:154]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0 = $signed(({MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7
      , MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0})) * $signed((taps_m_rsci_idat[175:165]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0 = $signed(delay_lane_m_0_sva)
      * $signed((taps_m_rsci_idat[21:11]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0 = $signed(delay_lane_m_3_sva)
      * $signed((taps_m_rsci_idat[43:33]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0 = $signed(delay_lane_m_4_sva)
      * $signed((taps_m_rsci_idat[54:44]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0 = $signed(delay_lane_m_5_sva)
      * $signed((taps_m_rsci_idat[65:55]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0 = $signed(delay_lane_m_6_sva)
      * $signed((taps_m_rsci_idat[76:66]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0 = $signed(delay_lane_m_7_sva)
      * $signed((taps_m_rsci_idat[87:77]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0 = $signed(delay_lane_m_8_sva)
      * $signed((taps_m_rsci_idat[98:88]));
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0 = $signed(delay_lane_m_1_sva)
      * $signed((taps_m_rsci_idat[32:22]));
  assign nl_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1 = conv_s2s_5_6({MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_4
      , MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_3_0}) + 6'b000001;
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1 = nl_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1[5:0];
  assign MAC_10_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1
      & MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_10_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2,
      MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1
      = conv_s2s_6_7({MAC_10_r_ac_float_else_and_nl , MAC_10_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1[6:0];
  assign MAC_11_r_ac_float_else_and_nl = MUX_v_2_2_2(2'b00, operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1,
      MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign MAC_11_r_ac_float_else_and_1_nl = MUX_v_4_2_2(4'b0000, operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2,
      MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1
      = conv_s2s_6_7({MAC_11_r_ac_float_else_and_nl , MAC_11_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1[6:0];
  assign MAC_12_r_ac_float_else_and_nl = MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_12_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1
      = conv_s2s_6_7({MAC_12_r_ac_float_else_and_nl , MAC_12_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1[6:0];
  assign MAC_13_r_ac_float_else_and_nl = MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_13_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_13_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_13_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1
      = conv_s2s_6_7({MAC_13_r_ac_float_else_and_nl , MAC_13_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1[6:0];
  assign MAC_14_r_ac_float_else_and_nl = MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_14_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_14_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_14_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1
      = conv_s2s_6_7({MAC_14_r_ac_float_else_and_nl , MAC_14_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1[6:0];
  assign MAC_15_r_ac_float_else_and_nl = MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_15_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_15_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_15_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1
      = conv_s2s_6_7({MAC_15_r_ac_float_else_and_nl , MAC_15_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1[6:0];
  assign MAC_1_r_ac_float_else_and_nl = MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_1_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_1_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_1_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1
      = conv_s2s_6_7({MAC_1_r_ac_float_else_and_nl , MAC_1_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1[6:0];
  assign nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[6:4])
      + 3'b001;
  assign MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign MAC_16_r_ac_float_else_and_nl = MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_16_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_16_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_16_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1 =
      conv_s2s_6_7({MAC_16_r_ac_float_else_and_nl , MAC_16_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1 = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_5_lpi_1_dfm_mx0[10]))
      & MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_5_lpi_1_dfm_mx0[10])
      & MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_5_lpi_1_dfm_mx0w1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_5_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_6_lpi_1_dfm_mx0[10]))
      & MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_6_lpi_1_dfm_mx0[10])
      & MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_6_lpi_1_dfm_mx0w1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_6_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_7_lpi_1_dfm_mx0[10]))
      & MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_7_lpi_1_dfm_mx0[10])
      & MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_7_lpi_1_dfm_mx0w1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_7_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_8_lpi_1_dfm_mx0[10]))
      & MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_31_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_8_lpi_1_dfm_mx0[10])
      & MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_8_lpi_1_dfm_mx0w1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_8_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_31_nl});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_34_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_9_lpi_1_dfm_mx0[10]))
      & MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_35_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_9_lpi_1_dfm_mx0[10])
      & MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_9_lpi_1_dfm_mx0w1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_9_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_34_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_35_nl});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_3_lpi_1_dfm_mx0[10]))
      & MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_3_lpi_1_dfm_mx0[10])
      & MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_3_lpi_1_dfm_mx0w4 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_3_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1
      =  -operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1[3:0];
  assign nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[1:0]))
      , (~ operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2)}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg)
      + 7'b0000001;
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg) + 7'b0000001;
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1
      , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[4])})
      + 3'b001;
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[3:0]))}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg)
      + 7'b0000001;
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[3:0]))}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg)
      + 7'b0000001;
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[3:0]))}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg)
      + 7'b0000001;
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[3:0]))}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg)
      + 7'b0000001;
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0]))
      , (~ (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[3:0]))}) + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg)
      + 7'b0000001;
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[6:4]) + 3'b001;
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp
      = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_38_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[10]))
      & MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_39_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[10])
      & MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_10_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_38_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_39_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_10_sva_1[3:0];
  assign nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_7_rtn_oreg) + 7'b0000001;
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_42_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[10]))
      & MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_43_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[10])
      & MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_11_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_42_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_43_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_11_sva_1[3:0];
  assign nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_6_rtn_oreg) + 7'b0000001;
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_46_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[10]))
      & MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_47_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[10])
      & MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_12_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_46_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_47_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_12_sva_1[3:0];
  assign nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_5_rtn_oreg) + 7'b0000001;
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_50_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[10]))
      & MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_51_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[10])
      & MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_13_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_50_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_51_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_13_sva_1[3:0];
  assign nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg) + 7'b0000001;
  assign MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_54_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[10]))
      & MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_55_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[10])
      & MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_14_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_54_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_55_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_14_sva_1[3:0];
  assign nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_3_rtn_oreg) + 7'b0000001;
  assign MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_58_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[10]))
      & MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_59_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[10])
      & MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_15_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_58_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_59_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_15_sva_1[3:0];
  assign nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_2_rtn_oreg) + 7'b0000001;
  assign MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_4_lpi_1_dfm_mx0[10]))
      & MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_4_lpi_1_dfm_mx0[10])
      & MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_4_lpi_1_dfm_mx0w2 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_4_lpi_1_dfm_mx0,
      11'b01111111111, 11'b10000000000, {(~ MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_sva_1[3:0];
  assign nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = ({1'b1 , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[1:0]))
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[3:0]))})
      + conv_u2s_5_7(MAC_1_leading_sign_18_1_1_0_cmp_1_rtn_oreg) + 7'b0000001;
  assign MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl
      = nl_MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl[6:0];
  assign MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      = readslicef_7_1_6(MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_nl);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3 = ~((result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_3_lpi_1_dfm_1[5:4]==2'b01));
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1
      =  -(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1
      = nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1[3:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_4_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_4_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_5_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_5_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_6_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_6_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_7_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_7_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_8_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_8_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_9_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_9_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1[1]);
  assign MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5[1])
      | nor_144_cse);
  assign MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6
      | nor_124_cse);
  assign MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6
      | nor_120_cse);
  assign MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6
      | nor_116_cse);
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6
      | nor_113_cse);
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6
      | nor_110_cse);
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6
      | nor_107_cse);
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0)
      , (~ MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1)})
      + 7'b0000001;
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_lpi_1_dfm_6_0 + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm);
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_8_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_33_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp
      = MUX1HOT_v_7_3_2(MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_8_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_33_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_9_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm);
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_9_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_9_lpi_1_dfm_1[5:4]!=2'b00))));
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)})
      + 7'b0000001;
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0 + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm);
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_7_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_29_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp
      = MUX1HOT_v_7_3_2(MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_7_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_29_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_8_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm);
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_8_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_8_lpi_1_dfm_1[5:4]!=2'b00))));
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)})
      + 7'b0000001;
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0 + conv_u2s_4_7(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1);
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_6_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp
      = MUX1HOT_v_7_3_2(MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_6_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_7_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm);
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_7_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_7_lpi_1_dfm_1[5:4]!=2'b00))));
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)})
      + 7'b0000001;
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0 + conv_u2s_4_7(result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0);
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_5_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp
      = MUX1HOT_v_7_3_2(MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_5_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_6_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm);
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_6_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_6_lpi_1_dfm_1[5:4]!=2'b00))));
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)})
      + 7'b0000001;
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0 + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm);
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_4_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp
      = MUX1HOT_v_7_3_2(MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_4_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_5_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm);
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_5_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_5_lpi_1_dfm_1[5:4]!=2'b00))));
  assign nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0 + conv_s2s_6_7({1'b1 , (~ MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)})
      + 7'b0000001;
  assign MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0 + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm);
  assign MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_3_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1[1]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp
      = MUX1HOT_v_7_3_2(MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_3_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1[1])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_4_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm);
  assign MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_4_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_4_lpi_1_dfm_1[5:4]!=2'b00))));
  assign or_272_ssc = nor_128_cse | operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0;
  assign MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_4 = (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1[0])
      & or_272_ssc;
  assign ac_float_cctor_assign_from_0_0_32_32_AC_TRN_AC_WRAP_if_3_not_nl = ~ or_272_ssc;
  assign MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_3_0 = MUX_v_4_2_2(operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2,
      4'b1111, ac_float_cctor_assign_from_0_0_32_32_AC_TRN_AC_WRAP_if_3_not_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_2_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10]))
      & MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_3_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10])
      & MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign MAC_ac_float_cctor_m_1_lpi_1_dfm_1 = MUX1HOT_v_11_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva,
      11'b01111111111, 11'b10000000000, {(~ MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1)
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_2_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_3_nl});
  assign nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl = conv_s2s_5_6({(~
      MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_4) , (~ MAC_ac_float_cctor_e_1_lpi_1_dfm_mx0_3_0)})
      + 6'b000001;
  assign MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl = nl_MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl[5:0];
  assign MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_itm_5_1 =
      readslicef_6_1_5(MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_nl);
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~(operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 | nor_128_cse);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_2_lpi_1_dfm_1_5_4
      = MUX_v_2_2_2(2'b00, operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1,
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp)
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_2_lpi_1_dfm_1_5_4!=2'b00))));
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_48_mx0
      = MUX_v_4_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm,
      MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_3_lpi_1_dfm_mx0
      = MUX_v_11_2_2((MAC_3_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]),
      (MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]);
  assign nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva + conv_s2s_6_7({1'b1
      , (~ MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0)}) +
      7'b0000001;
  assign MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm);
  assign MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_2_nl
      = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
      & (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp
      = MUX1HOT_v_7_3_2(MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      7'b1110000, MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_2_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_3_lpi_1_dfm_1
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_4_tmp,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm);
  assign MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1
      = ~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_3_lpi_1_dfm_1[6])
      | (~((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_3_lpi_1_dfm_1[5:4]!=2'b00))));
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_51_nl = ~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp;
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_1_lpi_1_dfm_1 = MUX_v_6_2_2(6'b000000,
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_51_nl);
  assign nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = conv_s2s_5_6(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      + conv_s2s_5_6({(~ MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0)
      , (~ MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1)})
      + 6'b000001;
  assign MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5:0];
  assign MAC_3_result_operator_result_operator_nor_tmp = ~((result_m_1_lpi_1_dfm_1_10_7!=4'b0000)
      | result_m_1_lpi_1_dfm_1_6 | (result_m_1_lpi_1_dfm_1_5_4!=2'b00) | (result_m_1_lpi_1_dfm_1_3_0!=4'b0000));
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc
      = ~((operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7[3]) | result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc = (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7[3])
      & (~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign result_m_1_lpi_1_dfm_1_10_7 = MUX1HOT_v_4_3_2(4'b0111, 4'b1000, operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7,
      {result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp});
  assign result_m_1_lpi_1_dfm_1_6 = (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0
      & (~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc)) | result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc;
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_68_nl = ~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc;
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_78_nl = MUX_v_2_2_2(2'b00,
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_68_nl);
  assign result_m_1_lpi_1_dfm_1_5_4 = MUX_v_2_2_2(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_78_nl,
      2'b11, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_69_nl = ~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_32_ssc;
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_79_nl = MUX_v_4_2_2(4'b0000,
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_not_69_nl);
  assign result_m_1_lpi_1_dfm_1_3_0 = MUX_v_4_2_2(result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_79_nl,
      4'b1111, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_16_ssc);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_3_lpi_1_dfm_1 = MUX_v_6_2_2(6'b000000,
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva);
  assign MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0);
  assign MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0);
  assign MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0);
  assign MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0);
  assign MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0);
  assign MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0);
  assign MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0);
  assign MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp = $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2)
      - $signed(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0);
  assign nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl
      = ({1'b1 , (~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva)
      , (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]))})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm)
      + 7'b0000001;
  assign MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl
      = nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl[6:0];
  assign MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_itm_6_1
      = readslicef_7_1_6(MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_nl);
  assign nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2})
      + conv_s2s_5_6({1'b1 , (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm)})
      + 6'b000001;
  assign MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[5:0];
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp
      = MUX_v_6_2_2(6'b110000, MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_1_itm_6_1);
  assign not_tmp_25 = ~((fsm_output[1]) | (fsm_output[5]));
  assign mux_tmp_7 = MUX_s_1_2_2(not_tmp_25, (fsm_output[5]), fsm_output[4]);
  assign nor_tmp_6 = (fsm_output[5:4]==2'b11);
  assign mux_tmp_15 = MUX_s_1_2_2(mux_tmp_7, nor_tmp_6, fsm_output[2]);
  assign nor_tmp_9 = (fsm_output[1]) & (fsm_output[5]);
  assign nor_tmp_11 = (fsm_output[4]) & (fsm_output[1]) & (fsm_output[5]);
  assign and_dcpl_6 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_7 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_8 = and_dcpl_7 & (~ (fsm_output[4]));
  assign mux_tmp_37 = MUX_s_1_2_2((~ (fsm_output[1])), (fsm_output[1]), fsm_output[0]);
  assign or_tmp_34 = (fsm_output[1:0]!=2'b00);
  assign or_tmp_38 = (fsm_output[2:1]!=2'b00);
  assign or_dcpl_25 = (fsm_output[4]) | (fsm_output[2]);
  assign or_dcpl_26 = or_dcpl_25 | (fsm_output[3]);
  assign or_dcpl_27 = (fsm_output[6]) | (fsm_output[0]);
  assign or_dcpl_28 = (fsm_output[1]) | (fsm_output[5]);
  assign or_dcpl_30 = or_dcpl_28 | or_dcpl_27 | or_dcpl_26;
  assign or_dcpl_32 = (~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      & (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[4])))
      | (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[5]);
  assign and_dcpl_26 = (fsm_output[0]) & (~ (fsm_output[4]));
  assign and_dcpl_29 = not_tmp_25 & (fsm_output[6]) & and_dcpl_26;
  assign and_dcpl_35 = ~((fsm_output[4]) | (fsm_output[2]));
  assign and_dcpl_36 = and_dcpl_35 & (~ (fsm_output[3]));
  assign and_dcpl_37 = ~((fsm_output[6]) | (fsm_output[0]));
  assign and_dcpl_38 = not_tmp_25 & and_dcpl_37;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_36;
  assign and_dcpl_40 = (fsm_output[1]) & (~ (fsm_output[5]));
  assign and_dcpl_41 = and_dcpl_40 & and_dcpl_37;
  assign and_dcpl_42 = and_dcpl_41 & and_dcpl_36;
  assign or_dcpl_36 = (fsm_output[6:5]!=2'b00);
  assign nor_55_nl = ~((fsm_output[4]) | (fsm_output[1]) | (fsm_output[5]));
  assign mux_31_nl = MUX_s_1_2_2(nor_55_nl, nor_tmp_11, fsm_output[2]);
  assign mux_tmp_58 = MUX_s_1_2_2(mux_31_nl, nor_tmp_6, fsm_output[3]);
  assign mux_26_nl = MUX_s_1_2_2(not_tmp_25, nor_tmp_9, fsm_output[4]);
  assign mux_tmp_60 = MUX_s_1_2_2(mux_26_nl, nor_tmp_6, or_155_cse);
  assign mux_tmp_61 = MUX_s_1_2_2(nor_tmp_9, (fsm_output[5]), fsm_output[4]);
  assign mux_tmp_62 = MUX_s_1_2_2(nor_tmp_6, mux_tmp_61, fsm_output[2]);
  assign mux_tmp_65 = MUX_s_1_2_2(mux_tmp_15, mux_tmp_62, fsm_output[3]);
  assign mux_tmp_66 = MUX_s_1_2_2(nor_tmp_9, (fsm_output[5]), or_dcpl_25);
  assign mux_tmp_67 = MUX_s_1_2_2(mux_tmp_15, mux_tmp_66, fsm_output[3]);
  assign mux_71_nl = MUX_s_1_2_2(mux_tmp_7, mux_tmp_61, fsm_output[2]);
  assign mux_tmp_69 = MUX_s_1_2_2(mux_71_nl, (fsm_output[5]), fsm_output[3]);
  assign or_tmp_44 = (fsm_output[0]) | (fsm_output[6]) | (~ (fsm_output[1]));
  assign or_tmp_46 = (~ (fsm_output[5])) | (fsm_output[1]);
  assign nor_58_nl = ~((fsm_output[2]) | (fsm_output[4]) | (fsm_output[1]) | (fsm_output[5]));
  assign mux_tmp_76 = MUX_s_1_2_2(nor_58_nl, mux_34_cse, fsm_output[3]);
  assign or_dcpl_41 = (~ (fsm_output[1])) | (fsm_output[5]);
  assign or_dcpl_43 = or_dcpl_41 | (~ (fsm_output[6])) | (fsm_output[0]) | or_dcpl_26;
  assign and_dcpl_55 = (~ (fsm_output[4])) & (fsm_output[2]);
  assign and_dcpl_56 = and_dcpl_55 & (~ (fsm_output[3]));
  assign and_dcpl_57 = and_dcpl_38 & and_dcpl_56;
  assign and_dcpl_58 = (fsm_output[2:1]==2'b11);
  assign and_dcpl_59 = (~ (fsm_output[6])) & (fsm_output[0]);
  assign and_dcpl_60 = and_dcpl_40 & and_dcpl_59;
  assign and_dcpl_61 = and_dcpl_60 & and_dcpl_36;
  assign and_dcpl_62 = ~((fsm_output[1:0]!=2'b00));
  assign or_dcpl_49 = (fsm_output[5:4]!=2'b00);
  assign or_dcpl_50 = or_dcpl_49 | (fsm_output[3:2]!=2'b00);
  assign and_dcpl_64 = (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_dcpl_66 = or_dcpl_50 & and_dcpl_64 & (fsm_output[0]);
  assign and_dcpl_67 = not_tmp_25 & and_dcpl_59;
  assign and_dcpl_68 = and_dcpl_67 & and_dcpl_36;
  assign xor_dcpl_2 = (fsm_output[1]) ^ (fsm_output[0]);
  assign and_dcpl_70 = or_dcpl_50 & (~ (fsm_output[6])) & xor_dcpl_2;
  assign nor_tmp_27 = (fsm_output[4]) & (fsm_output[1]);
  assign or_tmp_57 = (fsm_output[4]) | and_461_cse;
  assign mux_tmp_85 = MUX_s_1_2_2(nor_tmp_27, (fsm_output[4]), fsm_output[2]);
  assign or_tmp_59 = (fsm_output[2]) | (fsm_output[4]) | and_461_cse;
  assign mux_tmp_86 = MUX_s_1_2_2((~ or_tmp_59), mux_tmp_85, fsm_output[3]);
  assign nor_tmp_28 = (fsm_output[2]) & (fsm_output[4]) & (fsm_output[1]);
  assign mux_tmp_87 = MUX_s_1_2_2((~ or_tmp_59), nor_tmp_28, fsm_output[3]);
  assign mux_91_nl = MUX_s_1_2_2((~ (fsm_output[1])), (fsm_output[1]), fsm_output[5]);
  assign mux_tmp_89 = MUX_s_1_2_2(or_tmp_46, mux_91_nl, fsm_output[0]);
  assign mux_tmp_90 = MUX_s_1_2_2(mux_tmp_89, (fsm_output[5]), or_4_cse);
  assign or_dcpl_57 = (fsm_output[6]) | (~ (fsm_output[0]));
  assign or_dcpl_59 = or_dcpl_28 | or_dcpl_57 | or_dcpl_26;
  assign nor_tmp_29 = (fsm_output[2]) & (fsm_output[4]) & (fsm_output[5]) & (fsm_output[1]);
  assign and_dcpl_86 = and_dcpl_7 & xor_dcpl_2 & and_dcpl_36;
  assign and_dcpl_89 = and_dcpl_40 & (fsm_output[6]) & (~ (fsm_output[0])) & and_dcpl_36;
  assign and_dcpl_102 = and_dcpl_67 & and_dcpl_56;
  assign or_dcpl_70 = or_dcpl_41 | or_dcpl_27 | or_dcpl_26;
  assign and_dcpl_105 = ~((fsm_output[0]) | (fsm_output[4]));
  assign and_dcpl_106 = and_dcpl_40 & (~ (fsm_output[6]));
  assign and_dcpl_107 = and_dcpl_106 & and_dcpl_105;
  assign and_dcpl_116 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_118 = not_tmp_25 & (~ (fsm_output[6]));
  assign and_dcpl_119 = and_dcpl_118 & and_dcpl_105;
  assign mux_6_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[6]);
  assign mux_102_nl = MUX_s_1_2_2(mux_6_nl, (fsm_output[6]), fsm_output[4]);
  assign or_136_nl = (fsm_output[6:5]!=2'b01);
  assign mux_100_nl = MUX_s_1_2_2(or_136_nl, (fsm_output[6]), fsm_output[4]);
  assign mux_103_nl = MUX_s_1_2_2(mux_102_nl, mux_100_nl, fsm_output[2]);
  assign mux_104_nl = MUX_s_1_2_2(mux_103_nl, (fsm_output[6]), fsm_output[3]);
  assign and_dcpl_127 = (~ mux_104_nl) & and_dcpl_62;
  assign mux_tmp_104 = MUX_s_1_2_2(or_dcpl_28, (fsm_output[5]), fsm_output[0]);
  assign mux_tmp_105 = MUX_s_1_2_2((~ mux_tmp_104), (fsm_output[5]), fsm_output[4]);
  assign and_dcpl_189 = and_dcpl_106 & and_dcpl_26;
  assign mux_tmp_112 = MUX_s_1_2_2(mux_tmp_105, nor_tmp_6, fsm_output[2]);
  assign and_dcpl_217 = and_dcpl_37 & (~ (fsm_output[4]));
  assign and_dcpl_218 = and_dcpl_217 & and_dcpl_116;
  assign and_dcpl_227 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_228 = and_dcpl_217 & and_dcpl_227;
  assign and_dcpl_232 = (fsm_output[3:2]==2'b11);
  assign and_dcpl_233 = and_dcpl_217 & and_dcpl_232;
  assign and_dcpl_237 = and_dcpl_37 & (fsm_output[4]);
  assign and_dcpl_238 = and_dcpl_237 & and_dcpl_6;
  assign and_dcpl_242 = and_dcpl_237 & and_dcpl_116;
  assign and_dcpl_246 = and_dcpl_237 & and_dcpl_227;
  assign and_dcpl_250 = and_dcpl_237 & and_dcpl_232;
  assign or_dcpl_103 = or_dcpl_36 | (fsm_output[4]);
  assign and_dcpl_280 = and_dcpl_59 & (~ (fsm_output[4]));
  assign or_dcpl_107 = or_dcpl_49 | (fsm_output[3]);
  assign and_dcpl_285 = ~((fsm_output[1]) | (fsm_output[6]));
  assign and_dcpl_288 = and_dcpl_64 & (~ (fsm_output[0]));
  assign and_dcpl_306 = (fsm_output[4]) & (fsm_output[2]);
  assign and_dcpl_311 = nor_tmp_9 & and_dcpl_37;
  assign or_dcpl_114 = or_dcpl_41 | or_dcpl_57 | or_dcpl_26;
  assign and_dcpl_339 = and_dcpl_280 & and_dcpl_6;
  assign or_tmp_139 = (fsm_output[5:2]!=4'b0000);
  assign and_dcpl_371 = and_dcpl_35 & (fsm_output[3]);
  assign and_dcpl_373 = and_dcpl_55 & (fsm_output[3]);
  assign and_dcpl_375 = (fsm_output[4]) & (~ (fsm_output[2]));
  assign and_dcpl_376 = and_dcpl_375 & (~ (fsm_output[3]));
  assign and_dcpl_378 = and_dcpl_306 & (~ (fsm_output[3]));
  assign and_dcpl_380 = and_dcpl_375 & (fsm_output[3]);
  assign and_dcpl_382 = and_dcpl_306 & (fsm_output[3]);
  assign and_dcpl_420 = (~ or_tmp_46) & and_dcpl_59;
  assign return_e_rsci_idat_mx0c1 = and_dcpl_29 & and_dcpl_6 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      & (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[5:4]==2'b01);
  assign operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1 = and_dcpl_7 &
      or_tmp_34 & and_dcpl_36;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c0
      = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c1
      = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2])));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c2
      = and_dcpl_60 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c3
      = and_dcpl_60 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[1])));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c0
      = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c1
      = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2])));
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_mx0c3 = and_dcpl_285
      & (fsm_output[0]) & or_dcpl_107;
  assign nor_135_nl = ~((MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign nand_11_nl = ~((MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_136_nl = ~((MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_173_nl = MUX_s_1_2_2(nand_11_nl, nor_136_nl, MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_174_nl = MUX_s_1_2_2(nor_135_nl, mux_173_nl, fsm_output[2]);
  assign nand_12_nl = ~((MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_137_nl = ~((MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_171_nl = MUX_s_1_2_2(nand_12_nl, nor_137_nl, MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign nand_13_nl = ~((MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_138_nl = ~((MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_170_nl = MUX_s_1_2_2(nand_13_nl, nor_138_nl, MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_172_nl = MUX_s_1_2_2(mux_171_nl, mux_170_nl, fsm_output[2]);
  assign mux_175_nl = MUX_s_1_2_2(mux_174_nl, mux_172_nl, fsm_output[3]);
  assign nand_14_nl = ~((MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_139_nl = ~((MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_167_nl = MUX_s_1_2_2(nand_14_nl, nor_139_nl, MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign or_292_nl = (~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      | (fsm_output[5]);
  assign nor_140_nl = ~((MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (fsm_output[5]));
  assign mux_166_nl = MUX_s_1_2_2(or_292_nl, nor_140_nl, MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_168_nl = MUX_s_1_2_2(mux_167_nl, mux_166_nl, fsm_output[2]);
  assign nand_15_nl = ~((MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_141_nl = ~((MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_164_nl = MUX_s_1_2_2(nand_15_nl, nor_141_nl, MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign nand_16_nl = ~((MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[5]));
  assign nor_142_nl = ~((MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      | (~ (fsm_output[5])));
  assign mux_163_nl = MUX_s_1_2_2(nand_16_nl, nor_142_nl, MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign mux_165_nl = MUX_s_1_2_2(mux_164_nl, mux_163_nl, fsm_output[2]);
  assign mux_169_nl = MUX_s_1_2_2(mux_168_nl, mux_165_nl, fsm_output[3]);
  assign mux_176_nl = MUX_s_1_2_2(mux_175_nl, mux_169_nl, fsm_output[4]);
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
      = mux_176_nl & and_dcpl_288;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
      = and_dcpl_41 & (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_227;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
      = and_dcpl_41 & (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_232;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
      = and_dcpl_41 & (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[4]) & and_dcpl_6;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
      = and_dcpl_41 & (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[4]) & and_dcpl_116;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7
      = and_dcpl_41 & (fsm_output[4]) & (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_dcpl_227;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
      = and_dcpl_41 & and_dcpl_306 & (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[3]);
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
      = and_dcpl_311 & (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_6;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
      = and_dcpl_311 & (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_116;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
      = and_dcpl_311 & (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_227;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
      = and_dcpl_311 & (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ (fsm_output[4])) & and_dcpl_232;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
      = and_dcpl_311 & (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[4]) & and_dcpl_6;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
      = and_dcpl_311 & and_dcpl_306 & (~ (fsm_output[3])) & (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]);
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
      = and_dcpl_311 & (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[4]) & and_dcpl_227;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16
      = and_dcpl_311 & (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (fsm_output[4]) & and_dcpl_232;
  assign or_tmp = and_dcpl_41 | and_dcpl_311;
  assign nor_tmp_52 = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm
      & and_dcpl_36 & and_dcpl_311;
  assign or_tmp_152 = (and_dcpl_382 & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm
      & and_dcpl_41) | and_dcpl_311;
  assign and_509_cse = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm
      & and_dcpl_41;
  assign or_297_nl = and_509_cse | nor_tmp_52;
  assign or_296_nl = and_509_cse | and_dcpl_311;
  assign mux_241_nl = MUX_s_1_2_2(or_297_nl, or_296_nl, ac_float_cctor_operator_return_sva);
  assign mux_tmp_239 = MUX_s_1_2_2(nor_tmp_52, mux_241_nl, and_dcpl_382);
  assign mux_243_nl = MUX_s_1_2_2(mux_tmp_239, mux_289_itm, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm);
  assign mux_240_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm);
  assign mux_244_nl = MUX_s_1_2_2(mux_243_nl, mux_240_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva);
  assign mux_tmp_242 = MUX_s_1_2_2(mux_tmp_239, mux_244_nl, and_dcpl_378);
  assign mux_275_nl = MUX_s_1_2_2(mux_289_itm, or_tmp, and_499_cse);
  assign mux_246_nl = MUX_s_1_2_2(mux_tmp_242, mux_275_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm);
  assign mux_315_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, and_494_cse);
  assign mux_239_nl = MUX_s_1_2_2(mux_315_nl, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm);
  assign mux_247_nl = MUX_s_1_2_2(mux_246_nl, mux_239_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva);
  assign mux_tmp_245 = MUX_s_1_2_2(mux_tmp_242, mux_247_nl, and_dcpl_373);
  assign mux_293_nl = MUX_s_1_2_2(mux_289_itm, or_tmp, and_499_cse);
  assign mux_226_nl = MUX_s_1_2_2(mux_293_nl, or_tmp, and_500_cse);
  assign mux_249_nl = MUX_s_1_2_2(mux_tmp_245, mux_226_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva);
  assign mux_316_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, and_494_cse);
  assign mux_232_nl = MUX_s_1_2_2(mux_316_nl, or_tmp, and_495_cse);
  assign mux_238_nl = MUX_s_1_2_2(mux_232_nl, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva);
  assign mux_250_nl = MUX_s_1_2_2(mux_249_nl, mux_238_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva);
  assign mux_tmp_248 = MUX_s_1_2_2(mux_tmp_245, mux_250_nl, and_dcpl_371);
  assign mux_295_nl = MUX_s_1_2_2(mux_289_itm, or_tmp, and_499_cse);
  assign mux_267_nl = MUX_s_1_2_2(mux_295_nl, or_tmp, and_500_cse);
  assign mux_227_nl = MUX_s_1_2_2(mux_267_nl, or_tmp, and_501_cse);
  assign mux_252_nl = MUX_s_1_2_2(mux_tmp_248, mux_227_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm);
  assign mux_317_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, and_494_cse);
  assign mux_277_nl = MUX_s_1_2_2(mux_317_nl, or_tmp, and_495_cse);
  assign mux_233_nl = MUX_s_1_2_2(mux_277_nl, or_tmp, and_496_cse);
  assign mux_237_nl = MUX_s_1_2_2(mux_233_nl, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm);
  assign mux_253_nl = MUX_s_1_2_2(mux_252_nl, mux_237_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva);
  assign mux_tmp_251 = MUX_s_1_2_2(mux_tmp_248, mux_253_nl, and_dcpl_376);
  assign mux_297_nl = MUX_s_1_2_2(mux_289_itm, or_tmp, and_499_cse);
  assign mux_270_nl = MUX_s_1_2_2(mux_297_nl, or_tmp, and_500_cse);
  assign mux_269_nl = MUX_s_1_2_2(mux_270_nl, or_tmp, and_501_cse);
  assign mux_228_nl = MUX_s_1_2_2(mux_269_nl, or_tmp, and_502_cse);
  assign mux_255_nl = MUX_s_1_2_2(mux_tmp_251, mux_228_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva);
  assign mux_287_nl = MUX_s_1_2_2(or_tmp_152, or_tmp, and_494_cse);
  assign mux_280_nl = MUX_s_1_2_2(mux_287_nl, or_tmp, and_495_cse);
  assign mux_279_nl = MUX_s_1_2_2(mux_280_nl, or_tmp, and_496_cse);
  assign mux_234_nl = MUX_s_1_2_2(mux_279_nl, or_tmp, and_497_cse);
  assign mux_236_nl = MUX_s_1_2_2(mux_234_nl, or_tmp, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva);
  assign mux_256_nl = MUX_s_1_2_2(mux_255_nl, mux_236_nl, ac_float_cctor_operator_return_9_sva);
  assign mux_tmp_254 = MUX_s_1_2_2(mux_tmp_251, mux_256_nl, and_dcpl_56);
  assign nor_cse = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_460 = nor_cse & and_dcpl_7;
  assign and_dcpl_461 = and_dcpl_460 & (fsm_output[2:0]==3'b011);
  assign nor_215_cse = ~((fsm_output[2]) | (fsm_output[0]));
  assign and_dcpl_464 = and_dcpl_460 & nor_215_cse & (fsm_output[1]);
  assign and_dcpl_467 = and_dcpl_460 & (fsm_output[2:0]==3'b100);
  assign and_dcpl_485 = nor_cse & and_dcpl_7 & (fsm_output[2:0]==3'b100);
  assign and_dcpl_494 = nor_cse & and_dcpl_7 & nor_215_cse & (fsm_output[1]);
  assign and_216_ssc = and_dcpl_118 & (~(nor_128_cse | (fsm_output[0]))) & and_dcpl_56
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp & (~ operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0);
  assign and_221_ssc = (nor_128_cse | (~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp)
      | operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0) & not_tmp_25
      & and_dcpl_218;
  assign or_51_nl = (fsm_output[1:0]!=2'b01);
  assign nor_30_nl = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      | (~ (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])));
  assign mux_137_nl = MUX_s_1_2_2(or_51_nl, mux_tmp_37, nor_30_nl);
  assign mux_138_nl = MUX_s_1_2_2(mux_137_nl, mux_tmp_37, MAC_3_result_operator_result_operator_nor_tmp);
  assign and_223_ssc = (~ mux_138_nl) & and_dcpl_8 & and_dcpl_116;
  assign and_226_nl = (fsm_output[4]) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm
      | (~ (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])));
  assign or_187_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
      | (~ (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign or_186_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm
      | (~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_149_nl = MUX_s_1_2_2(or_187_nl, or_186_nl, fsm_output[4]);
  assign mux_150_nl = MUX_s_1_2_2(and_226_nl, mux_149_nl, fsm_output[2]);
  assign or_185_nl = (~ (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva;
  assign or_184_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm
      | (~ (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_147_nl = MUX_s_1_2_2(or_185_nl, or_184_nl, fsm_output[4]);
  assign or_183_nl = (~ (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm;
  assign or_182_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm
      | (~ (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_146_nl = MUX_s_1_2_2(or_183_nl, or_182_nl, fsm_output[4]);
  assign mux_148_nl = MUX_s_1_2_2(mux_147_nl, mux_146_nl, fsm_output[2]);
  assign mux_151_nl = MUX_s_1_2_2(mux_150_nl, mux_148_nl, fsm_output[3]);
  assign or_181_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm
      | (~ (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign or_180_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva
      | (~ (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_143_nl = MUX_s_1_2_2(or_181_nl, or_180_nl, fsm_output[4]);
  assign or_179_nl = ac_float_cctor_operator_return_9_sva | (~ (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign or_178_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva
      | (~ (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_142_nl = MUX_s_1_2_2(or_179_nl, or_178_nl, fsm_output[4]);
  assign mux_144_nl = MUX_s_1_2_2(mux_143_nl, mux_142_nl, fsm_output[2]);
  assign or_177_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva
      | (~ (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign or_176_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva
      | (~ (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_140_nl = MUX_s_1_2_2(or_177_nl, or_176_nl, fsm_output[4]);
  assign or_175_nl = (~ (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva;
  assign or_174_nl = ac_float_cctor_operator_return_sva | (~ (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]));
  assign mux_139_nl = MUX_s_1_2_2(or_175_nl, or_174_nl, fsm_output[4]);
  assign mux_141_nl = MUX_s_1_2_2(mux_140_nl, mux_139_nl, fsm_output[2]);
  assign mux_145_nl = MUX_s_1_2_2(mux_144_nl, mux_141_nl, fsm_output[3]);
  assign mux_152_nl = MUX_s_1_2_2(mux_151_nl, mux_145_nl, fsm_output[5]);
  assign and_227_ssc = mux_152_nl & and_dcpl_64 & (~((fsm_output[0]) | MAC_3_result_operator_result_operator_nor_tmp));
  assign and_232_ssc = (((MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_228;
  assign and_237_ssc = (((MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_233;
  assign and_242_ssc = (((MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_238;
  assign and_246_ssc = (((MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_242;
  assign and_250_ssc = (((MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_246;
  assign and_254_ssc = (((MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & and_dcpl_40 & and_dcpl_250;
  assign and_258_ssc = (((MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_217
      & and_dcpl_6;
  assign and_261_ssc = (((MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_operator_return_9_sva)) | MAC_3_result_operator_result_operator_nor_tmp)
      & nor_tmp_9 & and_dcpl_218;
  assign and_264_ssc = (((MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_228;
  assign and_267_ssc = (((MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_233;
  assign and_270_ssc = (((MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_238;
  assign and_273_ssc = (((MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_242;
  assign and_276_ssc = (((MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva))
      | MAC_3_result_operator_result_operator_nor_tmp) & nor_tmp_9 & and_dcpl_246;
  assign and_279_ssc = (((MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & (~ ac_float_cctor_operator_return_sva)) | MAC_3_result_operator_result_operator_nor_tmp)
      & nor_tmp_9 & and_dcpl_250;
  assign nl_MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt = conv_s2s_5_6(delay_lane_e_9_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[49:45]);
  assign MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt = nl_MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt[5:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_23_itm
      = ~(and_dcpl_42 | ((or_dcpl_50 ^ (fsm_output[6])) & and_dcpl_62));
  assign nl_operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0 = conv_s2s_5_6(delay_lane_e_10_sva)
      + conv_s2s_5_6(taps_e_rsci_idat[54:50]);
  assign operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0 = nl_operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0[5:0];
  assign nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = ({operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1
      , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2}) + conv_s2s_6_7({1'b1
      , (~ MAC_1_leading_sign_18_1_1_0_cmp_rtn_oreg)}) + 7'b0000001;
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl
      = nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl[6:0];
  assign nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = ({operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1
      , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2}) + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_1_sva_1);
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_nl
      = MUX_v_7_2_2(MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_nl,
      MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva[21]))
      & MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl
      = MUX_v_7_2_2(7'b0000000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_nl);
  assign nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2})
      + conv_u2s_4_7(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_2_sva_1);
  assign MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl
      = nl_MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl[6:0];
  assign and_492_nl = and_dcpl_42 & (~ or_301_tmp);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl = (~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[1])))
      & and_dcpl_61;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_64_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1[1])
      & and_dcpl_61;
  assign operator_13_2_true_AC_TRN_AC_WRAP_conc_4_itm_6_0 = MUX1HOT_v_7_5_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl,
      z_out, MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_nl,
      7'b1110000, {and_dcpl_68 , and_492_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_64_nl , or_301_tmp});
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0
      = conv_s2s_5_6(delay_lane_e_3_sva) + conv_s2s_5_6(taps_e_rsci_idat[19:15]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0[5:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0
      = conv_s2s_5_6(delay_lane_e_4_sva) + conv_s2s_5_6(taps_e_rsci_idat[24:20]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0[5:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0
      = conv_s2s_5_6(delay_lane_e_5_sva) + conv_s2s_5_6(taps_e_rsci_idat[29:25]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0[5:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0
      = conv_s2s_5_6(delay_lane_e_6_sva) + conv_s2s_5_6(taps_e_rsci_idat[34:30]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0[5:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0
      = conv_s2s_5_6(delay_lane_e_7_sva) + conv_s2s_5_6(taps_e_rsci_idat[39:35]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0[5:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0
      = conv_s2s_5_6(delay_lane_e_8_sva) + conv_s2s_5_6(taps_e_rsci_idat[44:40]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0 =
      nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0[5:0];
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_or_ssc = and_dcpl_42
      | and_dcpl_61 | and_dcpl_66;
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva <= 22'b0000000000000000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      return_e_rsci_idat <= 5'b00000;
    end
    else if ( (and_dcpl_29 & or_dcpl_32 & and_dcpl_6) | return_e_rsci_idat_mx0c1
        ) begin
      return_e_rsci_idat <= MUX_v_5_2_2((result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_3_lpi_1_dfm_1[4:0]),
          5'b01111, return_e_rsci_idat_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      return_m_rsci_idat <= 11'b00000000000;
    end
    else if ( ~(or_dcpl_28 | (~((fsm_output[6]) & (fsm_output[0]))) | or_dcpl_26)
        ) begin
      return_m_rsci_idat <= MUX1HOT_v_11_3_2(11'b01111111111, 11'b10000000000, (MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:2]),
          {result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_15_nl
          , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_31_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
      MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
      MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_or_cse
        ) begin
      MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= MUX_s_1_2_2(MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_nl,
          and_dcpl_42);
      MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= MUX_s_1_2_2(MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_1_nl,
          and_dcpl_42);
      MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= MUX_s_1_2_2(MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_2_nl,
          and_dcpl_42);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm
          <= ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0[3:0]!=4'b0000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_16_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_15_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_14_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_13_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_9_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_8_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_7_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_6_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_5_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_4_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_3_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= 1'b0;
      MAC_1_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= 1'b0;
      reg_return_e_triosy_obj_ld_cse <= 1'b0;
      reg_taps_e_triosy_obj_ld_cse <= 1'b0;
      MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa <= 18'b000000000000000000;
      MAC_1_leading_sign_18_1_1_0_cmp_mantissa <= 18'b000000000000000000;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm
          <= 4'b0000;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm
          <= 4'b0000;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm
          <= 4'b0000;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1
          <= 2'b00;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm
          <= 4'b0000;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1
          <= 2'b00;
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0 <=
          1'b0;
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1 <=
          4'b0000;
    end
    else begin
      MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_16_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0!=22'b0000000000000000000000);
      MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_15_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0!=22'b0000000000000000000000);
      MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_14_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0!=22'b0000000000000000000000);
      MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_13_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0!=22'b0000000000000000000000);
      MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= MUX_s_1_2_2(MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_3_nl,
          and_dcpl_42);
      MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= MUX_s_1_2_2(MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_4_nl,
          and_dcpl_42);
      MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= MUX_s_1_2_2(MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl,
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_5_nl,
          and_dcpl_42);
      MAC_9_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0!=22'b0000000000000000000000);
      MAC_8_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0!=22'b0000000000000000000000);
      MAC_7_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0!=22'b0000000000000000000000);
      MAC_6_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0!=22'b0000000000000000000000);
      MAC_5_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0!=22'b0000000000000000000000);
      MAC_4_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0!=22'b0000000000000000000000);
      MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_3_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0!=22'b0000000000000000000000);
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_2_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0!=22'b0000000000000000000000);
      MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5 <= MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[5];
      MAC_1_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm <= (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0!=22'b0000000000000000000000);
      reg_return_e_triosy_obj_ld_cse <= not_tmp_25 & (fsm_output[6]) & (fsm_output[0])
          & and_dcpl_36;
      reg_taps_e_triosy_obj_ld_cse <= ~ or_dcpl_30;
      MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_14_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_15_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_sva_mx0w0[21:4];
      MAC_1_leading_sign_18_1_1_0_cmp_mantissa <= ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_1_sva_mx0w0[21:4];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_28_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_12_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_24_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_6
          <= MUX_s_1_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1[6]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5
          <= MUX1HOT_s_1_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0[5]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1[5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl,
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5
          <= MUX_v_2_2_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1[6:5]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl,
          and_dcpl_42);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_10_itm
          <= MUX1HOT_v_4_6_2((MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[3:0]), (MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg[3:0]),
          (z_out_1[3:0]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[3:0]),
          (MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
          (z_out[3:0]), {and_108_nl , and_111_nl , and_114_nl , and_120_nl , and_123_nl
          , and_126_nl});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_4_sva_2_1
          <= MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_13_itm
          <= MUX1HOT_v_4_5_2((MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[3:0]), (MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg[3:0]),
          MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl,
          leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_14, leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_15,
          {and_130_nl , and_133_nl , and_136_nl , and_dcpl_57 , and_dcpl_127});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_5_sva_2_1
          <= MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_6_sva_2_1
          <= MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_7_sva_2_1
          <= MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_22_itm
          <= MUX1HOT_v_4_3_2((MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[3:0]), (MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg[3:0]),
          MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl,
          {nor_98_nl , and_142_nl , (MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_8_sva_2_1
          <= MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_25_itm
          <= MUX1HOT_v_4_3_2((MAC_ac_float_cctor_m_lpi_1_dfm_6_0[3:0]), (MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg[3:0]),
          MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl,
          {nor_99_nl , and_144_nl , (MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])});
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_9_sva_2_1
          <= MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0 <=
          MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl,
          (MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4]), mux_77_itm);
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1 <=
          MUX_v_4_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_nl,
          (MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[3:0]), mux_77_itm);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_162_rgt | and_206_rgt ) begin
      MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0,
          {(~ nor_80_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_1_nl
          , and_206_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_156_rgt | and_202_rgt ) begin
      MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0,
          {(~ nor_81_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_4_nl
          , and_202_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_151_rgt | and_198_rgt ) begin
      MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0,
          {(~ nor_82_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_7_nl
          , and_198_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_147_rgt | and_194_rgt ) begin
      MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0,
          {(~ nor_83_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_10_nl
          , and_194_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_143_rgt | and_190_rgt ) begin
      MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0,
          {(~ nor_84_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_13_nl
          , and_190_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_207_rgt | and_285_rgt ) begin
      MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_14_rtn_oreg, 5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_3_lpi_1_dfm_1[4:0]),
          {(~ and_50_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_16_nl
          , and_285_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= 5'b00000;
    end
    else if ( and_dcpl_42 | or_168_rgt | and_210_rgt ) begin
      MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0 <= MUX1HOT_v_5_4_2((MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm[4:0]),
          MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg, 5'b01111, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0,
          {(~ nor_85_rgt) , and_dcpl_42 , ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_19_nl
          , and_210_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_1_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_30 ) begin
      delay_lane_e_1_sva <= delay_lane_e_0_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_1_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      delay_lane_m_1_sva <= delay_lane_m_0_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_0_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_30 ) begin
      delay_lane_e_0_sva <= input_e_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_0_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      delay_lane_m_0_sva <= input_m_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_14_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_14_sva <= delay_lane_e_13_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_14_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_14_sva <= delay_lane_m_13_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_13_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_13_sva <= delay_lane_e_12_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_13_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_13_sva <= delay_lane_m_12_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_12_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_12_sva <= delay_lane_e_11_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_12_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_12_sva <= delay_lane_m_11_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_11_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_11_sva <= delay_lane_e_10_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_11_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_11_sva <= delay_lane_m_10_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_10_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_10_sva <= delay_lane_e_9_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_10_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_10_sva <= delay_lane_m_9_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_9_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_9_sva <= delay_lane_e_8_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_9_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_9_sva <= delay_lane_m_8_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_8_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_8_sva <= delay_lane_e_7_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_8_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_8_sva <= delay_lane_m_7_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_7_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_7_sva <= delay_lane_e_6_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_7_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_7_sva <= delay_lane_m_6_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_6_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_6_sva <= delay_lane_e_5_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_6_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_6_sva <= delay_lane_m_5_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_5_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_5_sva <= delay_lane_e_4_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_5_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_5_sva <= delay_lane_m_4_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_4_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_4_sva <= delay_lane_e_3_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_4_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_4_sva <= delay_lane_m_3_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_3_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_3_sva <= delay_lane_e_2_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_3_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_3_sva <= delay_lane_m_2_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_e_2_sva <= 5'b00000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_e_2_sva <= delay_lane_e_1_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      delay_lane_m_2_sva <= 11'b00000000000;
    end
    else if ( ~ or_dcpl_43 ) begin
      delay_lane_m_2_sva <= delay_lane_m_1_sva;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm
          <= 1'b0;
    end
    else if ( and_dcpl_39 | and_dcpl_42 | and_dcpl_57 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_12_itm
          <= MUX1HOT_s_1_5_2(MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl,
          (MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
          (MAC_1_leading_sign_18_1_1_0_cmp_12_rtn_oreg[4]), (MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
          (MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]),
          {and_dcpl_39 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_nl
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_1_nl
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_2_nl
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_3_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7 <= 4'b0000;
    end
    else if ( ~(mux_313_nl | (fsm_output[6])) ) begin
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_10_7 <= MUX1HOT_v_4_32_2((MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]),
          result_m_1_lpi_1_dfm_1_10_7, result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_10_7,
          (MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10:7]),
          (MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[10:7]),
          (MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7,
          (MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_6_lpi_1_dfm_10_7,
          (MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_7_lpi_1_dfm_10_7,
          (MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_8_lpi_1_dfm_10_7,
          (MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_9_lpi_1_dfm_10_7,
          (MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[10:7]),
          (MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[10:7]),
          (MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[10:7]),
          (MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[10:7]),
          (MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[10:7]),
          (MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[10:7]),
          (MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12:9]), MAC_ac_float_cctor_m_lpi_1_dfm_10_7,
          (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3[10:7]), {and_dcpl_102
          , operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse
          , and_dcpl_66});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~(mux_206_nl & and_74_ssc) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_105_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_4_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_73_nl
          , and_363_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~((~ mux_203_nl) & and_75_ssc) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_107_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_5_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_72_nl
          , and_359_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~((~ mux_199_nl) & and_76_ssc) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_109_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_20_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_6_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_71_nl
          , and_355_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~((~ mux_194_nl) & and_77_ssc) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_111_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_7_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_70_nl
          , and_351_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~((~ mux_190_nl) & and_78_ssc) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_113_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_8_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_69_nl
          , and_347_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( mux_186_nl | (fsm_output[6]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_5_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_conc_115_itm_5_0[4:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl,
          5'b01111, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_9_lpi_1_dfm_1[4:0]),
          {and_dcpl_39 , and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_67_nl
          , and_343_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva
          <= 3'b000;
    end
    else if ( and_dcpl_68 | and_dcpl_57 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva
          <= MUX_v_3_2_2(MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl,
          MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp,
          and_dcpl_57);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva
          <= 3'b000;
    end
    else if ( ~ or_dcpl_59 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva
          <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva <= 7'b0000000;
    end
    else if ( ~(mux_94_nl & (~ (fsm_output[5])) & nor_89_cse) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva <= nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[6:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0
          <= 5'b00000;
    end
    else if ( ~((and_dcpl_189 & (nor_144_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_6_5[1]))
        & and_dcpl_6) | (~(mux_179_nl | (fsm_output[6])))) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0
          <= MUX1HOT_v_5_3_2((ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1[4:0]),
          ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_16_nl,
          5'b01111, {and_dcpl_68 , and_dcpl_42 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7 <= 4'b0000;
    end
    else if ( ac_float_cctor_ac_float_22_2_6_AC_TRN_or_ssc ) begin
      MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7 <= MUX_v_4_2_2((MAC_ac_float_cctor_m_5_lpi_1_dfm_mx0w1[10:7]),
          (delay_lane_m_14_sva[10:7]), and_dcpl_89);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0 <= 7'b0000000;
    end
    else if ( ac_float_cctor_ac_float_22_2_6_AC_TRN_or_ssc & (~ and_dcpl_42) ) begin
      MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0 <= MUX1HOT_v_7_3_2(MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (MAC_ac_float_cctor_m_5_lpi_1_dfm_mx0w1[6:0]), (delay_lane_m_14_sva[6:0]),
          {and_dcpl_86 , and_dcpl_61 , and_dcpl_89});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_ac_float_cctor_m_6_lpi_1_dfm_10_7 <= 4'b0000;
      MAC_ac_float_cctor_m_7_lpi_1_dfm_10_7 <= 4'b0000;
      MAC_ac_float_cctor_m_8_lpi_1_dfm_10_7 <= 4'b0000;
      MAC_ac_float_cctor_m_9_lpi_1_dfm_10_7 <= 4'b0000;
      MAC_ac_float_cctor_m_lpi_1_dfm_10_7 <= 4'b0000;
    end
    else if ( ac_float_cctor_ac_float_22_2_6_AC_TRN_or_1_cse ) begin
      MAC_ac_float_cctor_m_6_lpi_1_dfm_10_7 <= MAC_ac_float_cctor_m_6_lpi_1_dfm_mx0w1[10:7];
      MAC_ac_float_cctor_m_7_lpi_1_dfm_10_7 <= MAC_ac_float_cctor_m_7_lpi_1_dfm_mx0w1[10:7];
      MAC_ac_float_cctor_m_8_lpi_1_dfm_10_7 <= MAC_ac_float_cctor_m_8_lpi_1_dfm_mx0w1[10:7];
      MAC_ac_float_cctor_m_9_lpi_1_dfm_10_7 <= MAC_ac_float_cctor_m_9_lpi_1_dfm_mx0w1[10:7];
      MAC_ac_float_cctor_m_lpi_1_dfm_10_7 <= z_out_2[10:7];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0 <= 7'b0000000;
      MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0 <= 7'b0000000;
      MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0 <= 7'b0000000;
      MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0 <= 7'b0000000;
      MAC_ac_float_cctor_m_lpi_1_dfm_6_0 <= 7'b0000000;
    end
    else if ( ac_float_cctor_ac_float_22_2_6_AC_TRN_and_1_cse ) begin
      MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0 <= MUX_v_7_2_2(MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (MAC_ac_float_cctor_m_6_lpi_1_dfm_mx0w1[6:0]), and_dcpl_61);
      MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0 <= MUX_v_7_2_2(MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (MAC_ac_float_cctor_m_7_lpi_1_dfm_mx0w1[6:0]), and_dcpl_61);
      MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0 <= MUX_v_7_2_2(MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (MAC_ac_float_cctor_m_8_lpi_1_dfm_mx0w1[6:0]), and_dcpl_61);
      MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0 <= MUX_v_7_2_2(MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (MAC_ac_float_cctor_m_9_lpi_1_dfm_mx0w1[6:0]), and_dcpl_61);
      MAC_ac_float_cctor_m_lpi_1_dfm_6_0 <= MUX_v_7_2_2(MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl,
          (z_out_2[6:0]), and_dcpl_61);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva <= 11'b00000000000;
    end
    else if ( ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c0
        | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c1
        | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c2
        | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c3
        | and_dcpl_102 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva <= MUX1HOT_v_11_5_2((MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_1_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), (MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_2_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_3_lpi_1_dfm_mx0w4,
          {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c0
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c1
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c2
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva_mx0c3
          , and_dcpl_102});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
          <= 1'b0;
    end
    else if ( and_dcpl_42 | and_dcpl_57 | and_dcpl_102 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_2_sva
          <= MUX1HOT_s_1_3_2((~ MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          (~ z_out_3_6), MAC_3_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl,
          {and_dcpl_42 , and_dcpl_57 , and_dcpl_102});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1
          <= 2'b00;
    end
    else if ( ~ or_dcpl_70 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_2_sva_2_1
          <= MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2:1];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
          <= 1'b0;
    end
    else if ( and_dcpl_42 | and_dcpl_57 | and_dcpl_127 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva
          <= MUX1HOT_s_1_3_2((~ z_out_3_6), MAC_2_ac_float_cctor_operator_ac_float_cctor_operator_nor_cse,
          result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_nand_nl,
          {and_dcpl_42 , and_dcpl_57 , and_dcpl_127});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm
          <= 1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm
          <= 1'b0;
    end
    else if ( ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_or_2_cse
        ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_5_sva
          <= MUX_s_1_2_2((~ MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          MAC_11_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_6_sva
          <= MUX_s_1_2_2((~ MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          MAC_12_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_7_sva
          <= MUX_s_1_2_2((~ MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          MAC_13_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_8_sva
          <= MUX_s_1_2_2((~ MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          MAC_14_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_9_sva
          <= MUX_s_1_2_2((~ MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1),
          MAC_15_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_nl,
          MAC_9_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_nl,
          MAC_8_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_nl,
          MAC_7_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_nl,
          MAC_6_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_nl,
          MAC_5_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm
          <= MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_nl,
          MAC_4_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl, and_dcpl_61);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva <= 11'b00000000000;
    end
    else if ( (~((or_142_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva <= MUX1HOT_v_11_3_2((MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_10_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_10_lpi_1_dfm_mx0w2,
          {and_147_nl , and_150_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva <= 11'b00000000000;
    end
    else if ( (~((or_146_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva <= MUX1HOT_v_11_3_2((MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_11_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_11_lpi_1_dfm_mx0w2,
          {and_153_nl , and_156_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva <= 11'b00000000000;
    end
    else if ( (~((or_150_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva <= MUX1HOT_v_11_3_2((MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_12_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_12_lpi_1_dfm_mx0w2,
          {and_159_nl , and_162_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva <= 11'b00000000000;
    end
    else if ( (~((or_154_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva <= MUX1HOT_v_11_3_2((MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_13_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_13_lpi_1_dfm_mx0w2,
          {and_165_nl , and_168_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva <= 11'b00000000000;
    end
    else if ( (~((or_160_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva <= MUX1HOT_v_11_3_2((MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_14_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_14_lpi_1_dfm_mx0w2,
          {and_171_nl , and_174_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva <= 11'b00000000000;
    end
    else if ( (~((or_165_cse & (fsm_output[0])) | (fsm_output[2]))) & nor_89_cse
        & (~ (fsm_output[5])) & (fsm_output[1]) ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva <= MUX1HOT_v_11_3_2((MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_15_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_15_lpi_1_dfm_mx0w2,
          {and_177_nl , and_180_nl , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva <= 11'b00000000000;
    end
    else if ( ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c0
        | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c1
        | and_dcpl_61 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva <= MUX1HOT_v_11_3_2((MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_rshift_itm[21:11]),
          (MAC_16_operator_22_2_true_AC_TRN_AC_WRAP_lshift_itm[21:11]), MAC_ac_float_cctor_m_4_lpi_1_dfm_mx0w2,
          {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c0
          , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva_mx0c1
          , and_dcpl_61});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm
          <= 1'b0;
    end
    else if ( ~ or_dcpl_70 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_2_itm
          <= ~(MAC_1_leading_sign_18_1_1_0_cmp_14_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_3_sva[21]))
          & MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp <= 1'b0;
    end
    else if ( and_dcpl_42 | and_dcpl_57 | and_dcpl_102 | result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_mx0c3
        ) begin
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp <= MUX1HOT_s_1_4_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_1_nl,
          leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_12, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nand_nl,
          result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3, {and_dcpl_42
          , and_dcpl_57 , and_dcpl_102 , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_mx0c3});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_10_7 <=
          4'b0000;
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_6 <= 1'b0;
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_5_4 <= 2'b00;
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0 <= 4'b0000;
    end
    else if ( result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_ssc ) begin
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_10_7 <=
          MUX1HOT_v_4_16_2((z_out_2[10:7]), result_m_1_lpi_1_dfm_1_10_7, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[10:7]),
          MAC_ac_float_cctor_m_5_lpi_1_dfm_10_7, MAC_ac_float_cctor_m_6_lpi_1_dfm_10_7,
          MAC_ac_float_cctor_m_7_lpi_1_dfm_10_7, MAC_ac_float_cctor_m_8_lpi_1_dfm_10_7,
          MAC_ac_float_cctor_m_9_lpi_1_dfm_10_7, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[10:7]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[10:7]),
          MAC_ac_float_cctor_m_lpi_1_dfm_10_7, {and_dcpl_57 , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16});
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_6 <= MUX1HOT_s_1_16_2((z_out_2[6]),
          result_m_1_lpi_1_dfm_1_6, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[6]),
          (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[6]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[6]),
          (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[6]), (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[6]),
          (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[6]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[6]),
          (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[6]), {and_dcpl_57 , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16});
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_5_4 <= MUX1HOT_v_2_16_2((z_out_2[5:4]),
          result_m_1_lpi_1_dfm_1_5_4, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[5:4]),
          (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[5:4]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[5:4]),
          (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[5:4]), (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[5:4]),
          (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[5:4]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[5:4]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[5:4]),
          (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[5:4]), {and_dcpl_57 , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16});
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0 <= MUX1HOT_v_4_18_2((MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[3:0]),
          (MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg[3:0]), MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl,
          (z_out_2[3:0]), result_m_1_lpi_1_dfm_1_3_0, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[3:0]),
          (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[3:0]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[3:0]),
          (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[3:0]), (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[3:0]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[3:0]),
          (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[3:0]), {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_1_nl
          , and_138_nl , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl
          , and_dcpl_57 , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c2
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c3
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c4
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c5
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c6
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c8
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c9
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c10
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c11
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c12
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c13
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c14
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c15
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c16});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_operator_return_sva <= 1'b0;
    end
    else if ( ~ or_dcpl_114 ) begin
      ac_float_cctor_operator_return_sva <= MAC_2_ac_float_cctor_operator_ac_float_cctor_operator_nor_cse;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_operator_return_9_sva <= 1'b0;
    end
    else if ( ~ or_dcpl_114 ) begin
      ac_float_cctor_operator_return_9_sva <= ~((MAC_ac_float_cctor_m_10_lpi_1_dfm_mx0w2!=11'b00000000000));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva
          <= 2'b00;
    end
    else if ( and_dcpl_61 | and_dcpl_66 ) begin
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_1_sva
          <= MUX_v_2_2_2(MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl,
          MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl,
          and_dcpl_66);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0 <=
          1'b0;
    end
    else if ( ~ and_dcpl_42 ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0 <=
          MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm[6];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1 <=
          1'b0;
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2 <=
          5'b00000;
    end
    else if ( ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_23_itm
        ) begin
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1 <=
          MUX_s_1_2_2(ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_mux1h_16_nl,
          (MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm[5]),
          and_dcpl_68);
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2 <=
          MUX1HOT_v_5_5_2((MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt[4:0]),
          (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1[4:0]),
          (z_out_1[4:0]), (MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_itm[4:0]),
          and_504_nl, {and_dcpl_39 , and_dcpl_61 , and_dcpl_66 , and_dcpl_68 , and_dcpl_70});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 <= 1'b0;
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1 <= 2'b00;
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2 <= 4'b0000;
    end
    else if ( operator_13_2_true_AC_TRN_AC_WRAP_or_ssc ) begin
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_0 <= MUX1HOT_s_1_33_2((operator_13_2_true_AC_TRN_AC_WRAP_conc_4_itm_6_0[6]),
          (MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), result_m_1_lpi_1_dfm_1_6,
          result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_6, (MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]),
          (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[6]),
          (MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[6]),
          (MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[6]),
          (MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[6]),
          (MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[6]),
          (MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[6]),
          (MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[6]),
          (MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[6]),
          (MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[6]),
          (MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[6]),
          (MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[6]),
          (MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[6]),
          (MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[6]),
          (MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[8]), (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[6]),
          (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3[6]), {operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1
          , and_dcpl_102 , operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse
          , and_dcpl_66});
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_1 <= MUX1HOT_v_2_34_2((operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0[5:4]),
          (operator_13_2_true_AC_TRN_AC_WRAP_conc_4_itm_6_0[5:4]), (MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]),
          result_m_1_lpi_1_dfm_1_5_4, result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_5_4,
          (MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[5:4]),
          (MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[5:4]),
          (MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[5:4]),
          (MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[5:4]),
          (MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[5:4]),
          (MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[5:4]),
          (MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[5:4]),
          (MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[5:4]),
          (MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[5:4]),
          (MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[5:4]),
          (MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[5:4]),
          (MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[5:4]),
          (MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[5:4]),
          (MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[7:6]), (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[5:4]),
          (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3[5:4]), {and_dcpl_39
          , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1 , and_dcpl_102
          , operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse
          , and_dcpl_66});
      operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2 <= MUX1HOT_v_4_34_2((operator_13_2_true_AC_TRN_AC_WRAP_conc_2_itm_5_0[3:0]),
          (operator_13_2_true_AC_TRN_AC_WRAP_conc_4_itm_6_0[3:0]), (MAC_1_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]),
          result_m_1_lpi_1_dfm_1_3_0, result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_3_0,
          (MAC_2_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[3:0]),
          (MAC_3_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[3:0]),
          (MAC_4_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[3:0]),
          (MAC_5_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[3:0]),
          (MAC_6_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[3:0]),
          (MAC_7_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[3:0]),
          (MAC_8_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[3:0]),
          (MAC_9_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_10_sva[3:0]),
          (MAC_10_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_11_sva[3:0]),
          (MAC_11_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_12_sva[3:0]),
          (MAC_12_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_13_sva[3:0]),
          (MAC_13_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_14_sva[3:0]),
          (MAC_14_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_15_sva[3:0]),
          (MAC_15_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[5:2]), (MAC_ac_float_cctor_m_lpi_1_dfm_6_0[3:0]),
          (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_6_sva_mx0w3[3:0]), {and_dcpl_39
          , operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_mx0c1 , and_dcpl_102
          , operator_13_2_true_AC_TRN_AC_WRAP_and_1_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_2_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_3_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_4_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_5_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_6_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_7_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_8_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_9_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_10_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_11_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_12_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_13_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_14_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_15_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_16_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_17_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_18_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_19_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_20_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_21_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_22_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_23_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_24_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_25_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_26_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_27_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_28_cse
          , operator_13_2_true_AC_TRN_AC_WRAP_and_29_cse , operator_13_2_true_AC_TRN_AC_WRAP_and_30_cse
          , and_dcpl_66});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0 <= 8'b00000000;
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 <= 4'b0000;
    end
    else if ( result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_or_ssc ) begin
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_0 <= MUX_v_8_2_2((MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[11:4]),
          (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[11:4]),
          and_dcpl_66);
      result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_12_1_1_sva_rsp_1 <= MUX1HOT_v_4_5_2((MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[3:0]),
          (MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg[3:0]), MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl,
          (MAC_1_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[3:0]),
          (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_acc_itm[3:0]),
          {result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_nl , and_140_nl
          , result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_1_nl , and_dcpl_61
          , and_dcpl_66});
    end
  end
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nor_15_nl
      = ~((MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12]) | result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_31_nl = (MAC_16_operator_13_2_true_AC_TRN_AC_WRAP_lshift_itm[12])
      & (~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp_2_mx0w3);
  assign MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl
      = ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_13_sva_mx0w0[3:0]!=4'b0000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_nl
      = MUX_s_1_2_2((MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg[4]), z_out_3_6);
  assign MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl
      = ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0[3:0]!=4'b0000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_1_nl
      = MUX_s_1_2_2((MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg[4]), MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl
      = ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0[3:0]!=4'b0000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_2_nl
      = MUX_s_1_2_2((MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_10_rtn_oreg[4]), MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign MAC_12_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl = (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_12_sva_mx0w0!=22'b0000000000000000000000);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_3_nl
      = MUX_s_1_2_2((MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_15_rtn_oreg[4]), MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign MAC_11_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl = (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_11_sva_mx0w0!=22'b0000000000000000000000);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_4_nl
      = MUX_s_1_2_2((MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_9_rtn_oreg[4]), MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign MAC_10_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_nl = (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0!=22'b0000000000000000000000);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_l_qif_mux_5_nl
      = MUX_s_1_2_2((MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[0]),
      (MAC_1_leading_sign_18_1_1_0_cmp_11_rtn_oreg[4]), MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_13_nl = MUX_s_1_2_2((MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6]),
      (MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_9_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_13_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_37_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_9_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_19_nl = MUX_s_1_2_2((MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[5]),
      (MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_28_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_19_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_37_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_9_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_12_nl = MUX_s_1_2_2((MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6]),
      (MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_10_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_12_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_41_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_10_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_18_nl = MUX_s_1_2_2((MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[5]),
      (MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_27_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_18_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_41_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_10_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_11_nl = MUX_s_1_2_2((MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6]),
      (MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_11_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_11_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_45_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_11_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_17_nl = MUX_s_1_2_2((MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[5]),
      (MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_26_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_17_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_45_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_11_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_10_nl = MUX_s_1_2_2((z_out[6]),
      (MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_12_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_10_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_49_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_12_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_16_nl = MUX_s_1_2_2((z_out[5]),
      (MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_25_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_16_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_49_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_12_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_9_nl = MUX_s_1_2_2((MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6]),
      (MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_13_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_9_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_53_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_13_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_15_nl = MUX_s_1_2_2((MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[5]),
      (MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_24_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_15_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_53_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_13_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_8_nl = MUX_s_1_2_2((MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6]),
      (MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_14_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_8_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_57_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_14_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_14_nl = MUX_s_1_2_2((MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[5]),
      (MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_23_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_14_nl | ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_57_ssc)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_14_seb;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_7_nl = MUX_v_2_2_2((MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[6:5]),
      (MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[6:5]),
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_or_nl
      = MUX_v_2_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_7_nl,
      2'b11, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_61_ssc);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_15_nl
      = MUX_v_2_2_2(2'b00, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_or_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_15_seb);
  assign and_108_nl = and_dcpl_107 & and_dcpl_6 & (~((MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | z_out_3_6));
  assign and_111_nl = and_dcpl_107 & and_dcpl_6 & (~ (MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & z_out_3_6;
  assign and_114_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]);
  assign and_120_nl = and_dcpl_119 & and_dcpl_116 & (~((MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | z_out_3_6));
  assign and_123_nl = and_dcpl_119 & and_dcpl_116 & (~ (MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & z_out_3_6;
  assign and_126_nl = and_dcpl_38 & and_dcpl_55 & (~ (fsm_output[3])) & (MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]);
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      =  -(MAC_ac_float_cctor_m_6_lpi_1_dfm_6_0[3:0]);
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl[3:0];
  assign and_130_nl = and_dcpl_107 & and_dcpl_6 & (~((MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1));
  assign and_133_nl = and_dcpl_107 & and_dcpl_6 & (~ (MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  assign and_136_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]);
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      =  -(MAC_ac_float_cctor_m_9_lpi_1_dfm_6_0[3:0]);
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl[3:0];
  assign nor_98_nl = ~((MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign and_142_nl = (~ (MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      =  -(MAC_ac_float_cctor_m_lpi_1_dfm_6_0[3:0]);
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl[3:0];
  assign nor_99_nl = ~((MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1);
  assign and_144_nl = (~ (MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_6_nl
      = MUX1HOT_s_1_19_2((MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg[4]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_2_lpi_1_dfm_1_5_4[0]),
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[4]),
      (MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[4]),
      (MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]), (MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]),
      (MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]), (MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]),
      (MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]), (MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[4]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[4]),
      (delay_lane_e_14_sva[4]), {and_dcpl_42 , and_221_ssc , and_223_ssc , and_227_ssc
      , and_232_ssc , and_237_ssc , and_242_ssc , and_246_ssc , and_250_ssc , and_254_ssc
      , and_258_ssc , and_261_ssc , and_264_ssc , and_267_ssc , and_270_ssc , and_273_ssc
      , and_276_ssc , and_279_ssc , and_dcpl_89});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_and_nl
      = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_6_nl
      & (~ and_216_ssc);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl
      = MUX_v_4_2_2(4'b0000, operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2,
      result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_8_nl
      = MUX1HOT_v_4_19_2((MAC_1_leading_sign_18_1_1_0_cmp_8_rtn_oreg[3:0]), ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_30_nl,
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1, (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2[3:0]),
      (MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0[3:0]),
      (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0[3:0]),
      (MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (MAC_13_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (MAC_14_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (MAC_15_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (MAC_16_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]),
      (MAC_1_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0[3:0]), (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_lpi_1_dfm_4_0[3:0]),
      (delay_lane_e_14_sva[3:0]), {and_dcpl_42 , and_221_ssc , and_223_ssc , and_227_ssc
      , and_232_ssc , and_237_ssc , and_242_ssc , and_246_ssc , and_250_ssc , and_254_ssc
      , and_258_ssc , and_261_ssc , and_264_ssc , and_267_ssc , and_270_ssc , and_273_ssc
      , and_276_ssc , and_279_ssc , and_dcpl_89});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_or_nl
      = MUX_v_4_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_all_sign_1_mux1h_8_nl,
      4'b1111, and_216_ssc);
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_1_nl = or_162_rgt & nor_80_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_4_nl = or_156_rgt & nor_81_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_7_nl = or_151_rgt & nor_82_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_10_nl = or_147_rgt & nor_83_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_13_nl = or_143_rgt & nor_84_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_16_nl = or_207_rgt & and_50_rgt;
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_and_19_nl = or_168_rgt & nor_85_rgt;
  assign MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_nl
      = ~((ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_10_sva_mx0w0[3:0]!=4'b0000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_nl = (~
      MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      & and_dcpl_42;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_1_nl =
      MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      & and_dcpl_42;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_2_nl =
      (~ z_out_3_6) & and_dcpl_57;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_and_3_nl =
      z_out_3_6 & and_dcpl_57;
  assign and_629_nl = (fsm_output[5]) & (~((MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp));
  assign nand_26_nl = ~((MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_27_nl = ~((MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_309_nl = MUX_s_1_2_2(nand_26_nl, nand_27_nl, fsm_output[5]);
  assign mux_310_nl = MUX_s_1_2_2(and_629_nl, mux_309_nl, fsm_output[4]);
  assign nand_28_nl = ~((MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_29_nl = ~((MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_307_nl = MUX_s_1_2_2(nand_28_nl, nand_29_nl, fsm_output[5]);
  assign nand_30_nl = ~((MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_31_nl = ~((MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_306_nl = MUX_s_1_2_2(nand_30_nl, nand_31_nl, fsm_output[5]);
  assign mux_308_nl = MUX_s_1_2_2(mux_307_nl, mux_306_nl, fsm_output[4]);
  assign mux_311_nl = MUX_s_1_2_2(mux_310_nl, mux_308_nl, fsm_output[2]);
  assign nand_32_nl = ~((MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_33_nl = ~((MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_303_nl = MUX_s_1_2_2(nand_32_nl, nand_33_nl, fsm_output[5]);
  assign nand_34_nl = ~((MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_35_nl = ~((MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_302_nl = MUX_s_1_2_2(nand_34_nl, nand_35_nl, fsm_output[5]);
  assign mux_304_nl = MUX_s_1_2_2(mux_303_nl, mux_302_nl, fsm_output[4]);
  assign nand_36_nl = ~((MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_37_nl = ~((MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_300_nl = MUX_s_1_2_2(nand_36_nl, nand_37_nl, fsm_output[5]);
  assign nand_38_nl = ~((MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign nand_39_nl = ~((MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp);
  assign mux_299_nl = MUX_s_1_2_2(nand_38_nl, nand_39_nl, fsm_output[5]);
  assign mux_301_nl = MUX_s_1_2_2(mux_300_nl, mux_299_nl, fsm_output[4]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, mux_301_nl, fsm_output[2]);
  assign mux_312_nl = MUX_s_1_2_2(mux_311_nl, mux_305_nl, fsm_output[3]);
  assign nand_40_nl = ~((fsm_output[1]) & mux_312_nl);
  assign nor_237_nl = ~((fsm_output[5:2]!=4'b0000));
  assign mux_313_nl = MUX_s_1_2_2(nand_40_nl, nor_237_nl, fsm_output[0]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_9_nl
      = ~((~ MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_18_nl
      = MUX1HOT_v_5_3_2((MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_10_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_9_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_37_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_22_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_18_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_9_seb);
  assign nor_161_nl = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm
      | (~ and_461_cse));
  assign or_266_nl = nor_162_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp[6]);
  assign mux_204_nl = MUX_s_1_2_2(nor_161_nl, and_461_cse, or_266_nl);
  assign nor_163_nl = ~((fsm_output[2]) | mux_204_nl);
  assign mux_205_nl = MUX_s_1_2_2(nor_163_nl, and_dcpl_58, fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_73_nl = (mux_205_nl
      | or_dcpl_103) & and_74_ssc;
  assign and_363_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_6_tmp[6])
      | nor_162_cse) & and_dcpl_339 & and_74_ssc;
  assign mux_206_nl = MUX_s_1_2_2((fsm_output[2]), (~ and_dcpl_58), fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_10_nl
      = ~((~ MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_20_nl
      = MUX1HOT_v_5_3_2((MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_11_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_10_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_41_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_21_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_20_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_10_seb);
  assign nor_158_nl = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm
      | (~ and_461_cse));
  assign or_258_nl = nor_159_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp[6]);
  assign mux_200_nl = MUX_s_1_2_2(nor_158_nl, and_461_cse, or_258_nl);
  assign mux_201_nl = MUX_s_1_2_2((~ mux_200_nl), (fsm_output[1]), fsm_output[4]);
  assign mux_202_nl = MUX_s_1_2_2(mux_201_nl, (fsm_output[4]), or_155_cse);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_72_nl = (mux_202_nl
      | or_dcpl_36) & and_75_ssc;
  assign and_359_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_8_tmp[6])
      | nor_159_cse) & and_dcpl_339 & and_75_ssc;
  assign or_264_nl = (~ (fsm_output[4])) | (fsm_output[1]);
  assign mux_203_nl = MUX_s_1_2_2(or_264_nl, (fsm_output[4]), or_155_cse);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_11_nl
      = ~((~ MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_22_nl
      = MUX1HOT_v_5_3_2((MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_12_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_11_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_45_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_20_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_22_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_11_seb);
  assign nor_154_nl = ~(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm
      | (~ and_461_cse));
  assign or_250_nl = nor_155_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp[6]);
  assign mux_195_nl = MUX_s_1_2_2(nor_154_nl, and_461_cse, or_250_nl);
  assign nor_156_nl = ~((fsm_output[4]) | mux_195_nl);
  assign mux_196_nl = MUX_s_1_2_2(nor_156_nl, nor_tmp_27, fsm_output[2]);
  assign mux_197_nl = MUX_s_1_2_2(mux_196_nl, (fsm_output[4]), fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_71_nl = (mux_197_nl
      | or_dcpl_36) & and_76_ssc;
  assign and_355_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_10_tmp[6])
      | nor_155_cse) & and_dcpl_339 & and_76_ssc;
  assign mux_198_nl = MUX_s_1_2_2((~ (fsm_output[4])), nor_tmp_27, fsm_output[2]);
  assign mux_199_nl = MUX_s_1_2_2(mux_198_nl, (fsm_output[4]), fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_12_nl
      = ~((~ MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_24_nl
      = MUX1HOT_v_5_3_2((z_out[4:0]), 5'b10000, (MAC_13_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_12_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_49_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_19_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_24_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_12_seb);
  assign mux_191_nl = MUX_s_1_2_2(or_tmp_57, (fsm_output[4]), ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm);
  assign nor_151_nl = ~((fsm_output[2]) | mux_191_nl);
  assign mux_192_nl = MUX_s_1_2_2(nor_151_nl, mux_tmp_85, fsm_output[3]);
  assign or_244_nl = nor_152_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp[6]);
  assign mux_193_nl = MUX_s_1_2_2(mux_192_nl, mux_tmp_86, or_244_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_70_nl = (mux_193_nl
      | or_dcpl_36) & and_77_ssc;
  assign and_351_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_12_tmp[6])
      | nor_152_cse) & and_dcpl_339 & and_77_ssc;
  assign mux_194_nl = MUX_s_1_2_2(and_dcpl_35, mux_tmp_85, fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_13_nl
      = ~((~ MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_26_nl
      = MUX1HOT_v_5_3_2((MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_14_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_13_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_53_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_18_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_26_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_13_seb);
  assign mux_187_nl = MUX_s_1_2_2(or_tmp_59, or_dcpl_25, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm);
  assign mux_188_nl = MUX_s_1_2_2((~ mux_187_nl), nor_tmp_28, fsm_output[3]);
  assign or_239_nl = nor_149_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp[6]);
  assign mux_189_nl = MUX_s_1_2_2(mux_188_nl, mux_tmp_87, or_239_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_69_nl = (mux_189_nl
      | or_dcpl_36) & and_78_ssc;
  assign and_347_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_14_tmp[6])
      | nor_149_cse) & and_dcpl_339 & and_78_ssc;
  assign mux_190_nl = MUX_s_1_2_2(and_dcpl_35, nor_tmp_28, fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_14_nl
      = ~((~ MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_28_nl
      = MUX1HOT_v_5_3_2((MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_15_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_14_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_57_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_17_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_28_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_14_seb);
  assign mux_182_nl = MUX_s_1_2_2(mux_tmp_89, (fsm_output[5]), fsm_output[4]);
  assign mux_181_nl = MUX_s_1_2_2(or_tmp_46, (fsm_output[5]), fsm_output[4]);
  assign mux_183_nl = MUX_s_1_2_2(mux_182_nl, mux_181_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm);
  assign mux_184_nl = MUX_s_1_2_2(mux_183_nl, (fsm_output[5]), or_155_cse);
  assign or_232_nl = nor_146_cse | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp[6]);
  assign mux_185_nl = MUX_s_1_2_2(mux_184_nl, mux_tmp_90, or_232_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_67_nl = (mux_185_nl
      | (fsm_output[6])) & (~(mux_tmp_90 | (fsm_output[6])));
  assign and_343_nl = ((~ ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_itm)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_16_tmp[6])
      | nor_146_cse) & and_dcpl_40 & and_dcpl_339;
  assign mux_186_nl = MUX_s_1_2_2(or_tmp_46, (fsm_output[5]), or_4_cse);
  assign nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_1_sva_1[6:4])
      + 3'b001;
  assign MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = nl_MAC_1_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl[2:0];
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_10_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_11_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_12_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_13_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_14_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_15_sva_mx0w1[6:4])
      + 3'b001;
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva
      = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_sva_1[6:4])
      + 3'b001;
  assign MAC_3_r_ac_float_else_and_nl = MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_5
      & MAC_3_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_3_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_3_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva 
      = conv_s2s_6_7({MAC_3_r_ac_float_else_and_nl , MAC_3_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign mux_94_nl = MUX_s_1_2_2((fsm_output[1]), (~ or_tmp_34), fsm_output[2]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_15_nl
      = ~((~ MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1)
      | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2]));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_30_nl
      = MUX1HOT_v_5_3_2((MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_acc_sdt[4:0]),
      5'b10000, (MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_acc_sdt[4:0]),
      {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_15_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_61_ssc , (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_sva[2])});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_16_nl
      = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux1h_30_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_15_seb);
  assign mux_95_nl = MUX_s_1_2_2((fsm_output[5]), or_dcpl_28, fsm_output[0]);
  assign nor_75_nl = ~((fsm_output[2]) | (fsm_output[4]) | mux_95_nl);
  assign mux_96_nl = MUX_s_1_2_2(nor_75_nl, nor_tmp_29, fsm_output[3]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_nor_nl
      = ~(mux_96_nl | (fsm_output[6]));
  assign nor_77_nl = ~((fsm_output[2]) | (fsm_output[4]) | (fsm_output[5]));
  assign mux_179_nl = MUX_s_1_2_2(nor_77_nl, nor_tmp_29, fsm_output[3]);
  assign MAC_4_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_5
      & MAC_4_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_4_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_10_lpi_1_dfm_4_0,
      MAC_4_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_4_r_ac_float_else_and_nl , MAC_4_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_5_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_5
      & MAC_5_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_5_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_11_lpi_1_dfm_4_0,
      MAC_5_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_5_r_ac_float_else_and_nl , MAC_5_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_6_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_5
      & MAC_6_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_6_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_12_lpi_1_dfm_4_0,
      MAC_6_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_6_r_ac_float_else_and_nl , MAC_6_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_7_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5
      & MAC_7_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_7_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0,
      MAC_7_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_7_r_ac_float_else_and_nl , MAC_7_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_8_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_5
      & MAC_8_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_8_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_14_lpi_1_dfm_4_0,
      MAC_8_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_8_r_ac_float_else_and_nl , MAC_8_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_9_r_ac_float_else_and_nl = ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_5
      & MAC_9_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm;
  assign MAC_9_r_ac_float_else_and_1_nl = MUX_v_5_2_2(5'b00000, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_15_lpi_1_dfm_4_0,
      MAC_9_r_ac_float_else_r_ac_float_else_r_ac_float_else_or_itm);
  assign nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl =
      conv_s2s_6_7({MAC_9_r_ac_float_else_and_nl , MAC_9_r_ac_float_else_and_1_nl})
      + 7'b0000001;
  assign MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl = nl_MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_nl[6:0];
  assign MAC_3_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_3_lpi_1_dfm_mx0w4!=11'b00000000000));
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_if_nand_nl
      = ~(leading_sign_13_1_1_0_680f7e8f1e1ee1d0bfbb1629740d3a321b2d_13 & (~ (operator_13_2_true_AC_TRN_AC_WRAP_rshift_psp_10_sva_6_0_rsp_2[0])));
  assign MAC_11_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_11_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign MAC_12_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_12_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign MAC_13_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_13_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign MAC_14_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_14_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign MAC_15_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_15_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_8_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_8_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_9_sva[21]))
      & MAC_9_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_9_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_9_lpi_1_dfm_mx0w1!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_7_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_9_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_8_sva[21]))
      & MAC_8_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_8_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_8_lpi_1_dfm_mx0w1!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_6_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_10_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_7_sva[21]))
      & MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_7_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_7_lpi_1_dfm_mx0w1!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_5_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_11_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_6_sva[21]))
      & MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_6_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_6_lpi_1_dfm_mx0w1!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_4_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_12_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_5_sva[21]))
      & MAC_5_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_5_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_5_lpi_1_dfm_mx0w1!=11'b00000000000));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_3_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_13_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_4_sva[21]))
      & MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign MAC_4_ac_float_cctor_operator_ac_float_cctor_operator_nor_nl = ~((MAC_ac_float_cctor_m_4_lpi_1_dfm_mx0w2!=11'b00000000000));
  assign and_147_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2]);
  assign and_150_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_10_sva[2])));
  assign and_153_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2]);
  assign and_156_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_11_sva[2])));
  assign and_159_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2]);
  assign and_162_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_12_sva[2])));
  assign and_165_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2]);
  assign and_168_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_13_sva[2])));
  assign and_171_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2]);
  assign and_174_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_14_sva[2])));
  assign and_177_nl = and_dcpl_41 & and_dcpl_35 & (~ (fsm_output[3])) & (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2]);
  assign and_180_nl = and_dcpl_41 & and_dcpl_35 & (~((fsm_output[3]) | (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_psp_15_sva[2])));
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nand_1_nl
      = ~(MAC_1_leading_sign_18_1_1_0_cmp_15_all_same_oreg & (~ (ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_r_m_2_sva[21]))
      & MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_if_nor_itm);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_nand_nl
      = ~((result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_1_lpi_1_dfm_1[5:4]==2'b01));
  assign nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      =  -(MAC_ac_float_cctor_m_7_lpi_1_dfm_6_0[3:0]);
  assign MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      = nl_MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl[3:0];
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_or_1_nl = ((~((MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1))
      & and_dcpl_42) | result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_mux_11_itm_mx0c7;
  assign and_138_nl = (~ (MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      & and_dcpl_42;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_op_lshift_and_1_nl = (MAC_6_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      & and_dcpl_42;
  assign nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1[5:4])
      + 2'b01;
  assign MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = nl_MAC_1_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl[1:0];
  assign nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = (z_out_1[5:4]) + 2'b01;
  assign MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl
      = nl_MAC_2_result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_nl[1:0];
  assign ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_mux1h_16_nl = MUX1HOT_s_1_3_2((MAC_10_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_sdt[5]),
      (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_acc_psp_1_sva_mx0w1[5]), (z_out_1[5]),
      {and_dcpl_39 , and_dcpl_61 , and_dcpl_66});
  assign nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl = nl_MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign nl_MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl
      = (~ (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]))
      + 5'b00001;
  assign MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl =
      nl_MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl[4:0];
  assign and_367_nl = and_dcpl_118 & and_dcpl_26 & (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp
      | (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[5:4]!=2'b01))
      & and_dcpl_116;
  assign nand_17_nl = ~((fsm_output[1]) & or_tmp_139);
  assign or_293_nl = (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp &
      (fsm_output[2])) | (fsm_output[5:3]!=3'b000);
  assign nor_166_nl = ~((~ result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_unequal_tmp)
      | (fsm_output[5:2]!=4'b0001));
  assign mux_207_nl = MUX_s_1_2_2(or_293_nl, nor_166_nl, ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_4_sva);
  assign mux_208_nl = MUX_s_1_2_2(or_tmp_139, mux_207_nl, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[4]);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, or_tmp_139, result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_else_1_shift_l_mux_64_tmp[5]);
  assign or_279_nl = (fsm_output[1]) | (~ mux_209_nl);
  assign mux_210_nl = MUX_s_1_2_2(nand_17_nl, or_279_nl, fsm_output[0]);
  assign or_302_nl = mux_210_nl | (fsm_output[6]);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_48_nl = (~ (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_369_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_49_nl = (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_369_m1c & (~ mux_263_tmp);
  assign and_372_nl = or_dcpl_107 & and_dcpl_285 & or_dcpl_32 & (fsm_output[0]);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_50_nl = (~ (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_374_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_51_nl = (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_374_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_52_nl = (~ (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_376_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_53_nl = (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_376_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_54_nl = (~ (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_379_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_55_nl = (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_379_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_56_nl = (~ (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_381_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_57_nl = (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_381_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_58_nl = (~ (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_383_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_59_nl = (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_383_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_60_nl = (~ (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_385_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_61_nl = (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_385_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_62_nl = (~ (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_386_cse & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_63_nl = (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_386_cse & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_64_nl = (~ (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_387_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_65_nl = (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_387_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_66_nl = (~ (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_388_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_67_nl = (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_388_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_68_nl = (~ (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_389_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_69_nl = (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_389_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_70_nl = (~ (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_390_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_71_nl = (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_390_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_72_nl = (~ (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_391_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_73_nl = (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_391_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_74_nl = (~ (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_392_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_75_nl = (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_392_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_76_nl = (~ (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5]))
      & and_393_m1c & (~ mux_263_tmp);
  assign result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_77_nl = (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[5])
      & and_393_m1c & (~ mux_263_tmp);
  assign mux1h_1_nl = MUX1HOT_v_5_33_2((result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_1_lpi_1_dfm_1[4:0]),
      5'b01111, (MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_2_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_qr_5_0_3_lpi_1_dfm_1[4:0]),
      (MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_3_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_4_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_5_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_6_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_7_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_8_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]), MAC_9_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl,
      (MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_10_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_11_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_12_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_13_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_14_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_15_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, (MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_e_dif_acc_tmp[4:0]),
      MAC_16_result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_qelse_qif_acc_nl, {and_367_nl
      , or_302_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_48_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_49_nl
      , and_372_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_50_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_51_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_52_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_53_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_54_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_55_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_56_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_57_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_58_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_59_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_60_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_61_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_62_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_63_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_64_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_65_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_66_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_67_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_68_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_69_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_70_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_71_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_72_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_73_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_74_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_75_nl
      , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_76_nl , result_assign_from_n16_15_13_2_AC_TRN_AC_WRAP_and_77_nl});
  assign not_625_nl = ~ mux_263_tmp;
  assign and_504_nl = MUX_v_5_2_2(5'b00000, mux1h_1_nl, not_625_nl);
  assign nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      =  -(MAC_ac_float_cctor_m_8_lpi_1_dfm_6_0[3:0]);
  assign MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl
      = nl_MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_acc_nl[3:0];
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_nl = (~((MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      | MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1))
      & and_dcpl_42;
  assign and_140_nl = (~ (MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2]))
      & MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_acc_itm_6_1
      & and_dcpl_42;
  assign result_plus_minus_11_1_5_AC_TRN_11_1_5_AC_TRN_add_r_and_1_nl = (MAC_7_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[2])
      & and_dcpl_42;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_5_nl
      = MUX1HOT_s_1_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_0,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_6,
      (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[3])),
      {and_dcpl_461 , and_dcpl_464 , and_dcpl_467});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_6_nl
      = MUX1HOT_s_1_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_1,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_5,
      (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[3])),
      {and_dcpl_461 , and_dcpl_464 , and_dcpl_467});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_7_nl
      = MUX1HOT_v_5_3_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_2_sva_rsp_2,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_qr_6_0_13_lpi_1_dfm_4_0,
      (signext_5_4(~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[3:0]))),
      {and_dcpl_461 , and_dcpl_464 , and_dcpl_467});
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_8_nl
      = MUX1HOT_v_5_3_2((~ MAC_12_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0),
      (~ MAC_1_leading_sign_18_1_1_0_cmp_4_rtn_oreg), 5'b00001, {and_dcpl_461 , and_dcpl_464
      , and_dcpl_467});
  assign nl_acc_nl = ({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_5_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_6_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_7_nl
      , (~ and_dcpl_467)}) + conv_s2u_7_8({(~ and_dcpl_467) , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_qelse_mux1h_8_nl
      , 1'b1});
  assign acc_nl = nl_acc_nl[7:0];
  assign z_out = readslicef_8_7_1(acc_nl);
  assign and_637_nl = or_tmp_139 & (~ (fsm_output[6])) & (fsm_output[0]) & (fsm_output[1]);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_mux_1_nl
      = MUX_v_5_2_2((signext_5_4(~ (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[3:0]))),
      ({MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_0 ,
      MAC_2_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0_rsp_1}),
      and_637_nl);
  assign nl_z_out_1 = conv_s2u_5_6(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_1_shift_r_mux_1_nl)
      + 6'b000001;
  assign z_out_1 = nl_z_out_1[5:0];
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_4_nl
      = MUX_v_2_2_2((~ (MAC_3_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0])),
      (~ (MAC_4_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_actual_max_shift_left_acc_tmp[1:0])),
      and_dcpl_494);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_5_nl
      = MUX_v_4_2_2((~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_acc_psp_3_sva[3:0])),
      (~ (MAC_ac_float_cctor_m_5_lpi_1_dfm_6_0[3:0])), and_dcpl_494);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_6_nl
      = MUX_v_5_2_2(MAC_3_ac_float_11_1_5_AC_TRN_operator_11_1_5_AC_TRN_acc_1_itm_4_0,
      MAC_1_leading_sign_18_1_1_0_cmp_13_rtn_oreg, and_dcpl_494);
  assign nl_acc_2_nl = ({1'b1 , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_4_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_5_nl
      , 1'b1}) + conv_u2u_6_8({ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_else_1_shift_exponent_limited_mux_6_nl
      , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[7:0];
  assign z_out_3_6 = readslicef_8_1_7(acc_2_nl);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_25_m1c = MUX_s_1_2_2((~
      MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1),
      (~ MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1),
      and_dcpl_485);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_83_nl = (~ and_dcpl_485)
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_25_m1c;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_84_nl = and_dcpl_485
      & ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_25_m1c;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_79_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[10]))
      & MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_80_nl = (~ (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10]))
      & MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_26_nl = MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_79_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_80_nl, and_dcpl_485);
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_81_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva[10])
      & MAC_16_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_82_nl = (ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva[10])
      & MAC_2_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_if_3_nor_svs_1;
  assign ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_27_nl = MUX_s_1_2_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_81_nl,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_82_nl, and_dcpl_485);
  assign z_out_2 = MUX1HOT_v_11_4_2(ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_sva,
      ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_op2_21_11_1_sva, 11'b01111111111,
      11'b10000000000, {ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_83_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_and_84_nl , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_26_nl
      , ac_float_cctor_assign_from_n32_31_22_2_AC_TRN_AC_WRAP_mux_27_nl});

  function automatic  MUX1HOT_s_1_16_2;
    input  input_15;
    input  input_14;
    input  input_13;
    input  input_12;
    input  input_11;
    input  input_10;
    input  input_9;
    input  input_8;
    input  input_7;
    input  input_6;
    input  input_5;
    input  input_4;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [15:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    result = result | (input_4 & sel[4]);
    result = result | (input_5 & sel[5]);
    result = result | (input_6 & sel[6]);
    result = result | (input_7 & sel[7]);
    result = result | (input_8 & sel[8]);
    result = result | (input_9 & sel[9]);
    result = result | (input_10 & sel[10]);
    result = result | (input_11 & sel[11]);
    result = result | (input_12 & sel[12]);
    result = result | (input_13 & sel[13]);
    result = result | (input_14 & sel[14]);
    result = result | (input_15 & sel[15]);
    MUX1HOT_s_1_16_2 = result;
  end
  endfunction


  function automatic  MUX1HOT_s_1_19_2;
    input  input_18;
    input  input_17;
    input  input_16;
    input  input_15;
    input  input_14;
    input  input_13;
    input  input_12;
    input  input_11;
    input  input_10;
    input  input_9;
    input  input_8;
    input  input_7;
    input  input_6;
    input  input_5;
    input  input_4;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [18:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    result = result | (input_4 & sel[4]);
    result = result | (input_5 & sel[5]);
    result = result | (input_6 & sel[6]);
    result = result | (input_7 & sel[7]);
    result = result | (input_8 & sel[8]);
    result = result | (input_9 & sel[9]);
    result = result | (input_10 & sel[10]);
    result = result | (input_11 & sel[11]);
    result = result | (input_12 & sel[12]);
    result = result | (input_13 & sel[13]);
    result = result | (input_14 & sel[14]);
    result = result | (input_15 & sel[15]);
    result = result | (input_16 & sel[16]);
    result = result | (input_17 & sel[17]);
    result = result | (input_18 & sel[18]);
    MUX1HOT_s_1_19_2 = result;
  end
  endfunction


  function automatic  MUX1HOT_s_1_33_2;
    input  input_32;
    input  input_31;
    input  input_30;
    input  input_29;
    input  input_28;
    input  input_27;
    input  input_26;
    input  input_25;
    input  input_24;
    input  input_23;
    input  input_22;
    input  input_21;
    input  input_20;
    input  input_19;
    input  input_18;
    input  input_17;
    input  input_16;
    input  input_15;
    input  input_14;
    input  input_13;
    input  input_12;
    input  input_11;
    input  input_10;
    input  input_9;
    input  input_8;
    input  input_7;
    input  input_6;
    input  input_5;
    input  input_4;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [32:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    result = result | (input_4 & sel[4]);
    result = result | (input_5 & sel[5]);
    result = result | (input_6 & sel[6]);
    result = result | (input_7 & sel[7]);
    result = result | (input_8 & sel[8]);
    result = result | (input_9 & sel[9]);
    result = result | (input_10 & sel[10]);
    result = result | (input_11 & sel[11]);
    result = result | (input_12 & sel[12]);
    result = result | (input_13 & sel[13]);
    result = result | (input_14 & sel[14]);
    result = result | (input_15 & sel[15]);
    result = result | (input_16 & sel[16]);
    result = result | (input_17 & sel[17]);
    result = result | (input_18 & sel[18]);
    result = result | (input_19 & sel[19]);
    result = result | (input_20 & sel[20]);
    result = result | (input_21 & sel[21]);
    result = result | (input_22 & sel[22]);
    result = result | (input_23 & sel[23]);
    result = result | (input_24 & sel[24]);
    result = result | (input_25 & sel[25]);
    result = result | (input_26 & sel[26]);
    result = result | (input_27 & sel[27]);
    result = result | (input_28 & sel[28]);
    result = result | (input_29 & sel[29]);
    result = result | (input_30 & sel[30]);
    result = result | (input_31 & sel[31]);
    result = result | (input_32 & sel[32]);
    MUX1HOT_s_1_33_2 = result;
  end
  endfunction


  function automatic  MUX1HOT_s_1_3_2;
    input  input_2;
    input  input_1;
    input  input_0;
    input [2:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function automatic  MUX1HOT_s_1_4_2;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [3:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    MUX1HOT_s_1_4_2 = result;
  end
  endfunction


  function automatic  MUX1HOT_s_1_5_2;
    input  input_4;
    input  input_3;
    input  input_2;
    input  input_1;
    input  input_0;
    input [4:0] sel;
    reg  result;
  begin
    result = input_0 & sel[0];
    result = result | (input_1 & sel[1]);
    result = result | (input_2 & sel[2]);
    result = result | (input_3 & sel[3]);
    result = result | (input_4 & sel[4]);
    MUX1HOT_s_1_5_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_3_2;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [2:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | (input_1 & {11{sel[1]}});
    result = result | (input_2 & {11{sel[2]}});
    MUX1HOT_v_11_3_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_4_2;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [3:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | (input_1 & {11{sel[1]}});
    result = result | (input_2 & {11{sel[2]}});
    result = result | (input_3 & {11{sel[3]}});
    MUX1HOT_v_11_4_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_5_2;
    input [10:0] input_4;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [4:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | (input_1 & {11{sel[1]}});
    result = result | (input_2 & {11{sel[2]}});
    result = result | (input_3 & {11{sel[3]}});
    result = result | (input_4 & {11{sel[4]}});
    MUX1HOT_v_11_5_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_16_2;
    input [1:0] input_15;
    input [1:0] input_14;
    input [1:0] input_13;
    input [1:0] input_12;
    input [1:0] input_11;
    input [1:0] input_10;
    input [1:0] input_9;
    input [1:0] input_8;
    input [1:0] input_7;
    input [1:0] input_6;
    input [1:0] input_5;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [15:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | (input_1 & {2{sel[1]}});
    result = result | (input_2 & {2{sel[2]}});
    result = result | (input_3 & {2{sel[3]}});
    result = result | (input_4 & {2{sel[4]}});
    result = result | (input_5 & {2{sel[5]}});
    result = result | (input_6 & {2{sel[6]}});
    result = result | (input_7 & {2{sel[7]}});
    result = result | (input_8 & {2{sel[8]}});
    result = result | (input_9 & {2{sel[9]}});
    result = result | (input_10 & {2{sel[10]}});
    result = result | (input_11 & {2{sel[11]}});
    result = result | (input_12 & {2{sel[12]}});
    result = result | (input_13 & {2{sel[13]}});
    result = result | (input_14 & {2{sel[14]}});
    result = result | (input_15 & {2{sel[15]}});
    MUX1HOT_v_2_16_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_34_2;
    input [1:0] input_33;
    input [1:0] input_32;
    input [1:0] input_31;
    input [1:0] input_30;
    input [1:0] input_29;
    input [1:0] input_28;
    input [1:0] input_27;
    input [1:0] input_26;
    input [1:0] input_25;
    input [1:0] input_24;
    input [1:0] input_23;
    input [1:0] input_22;
    input [1:0] input_21;
    input [1:0] input_20;
    input [1:0] input_19;
    input [1:0] input_18;
    input [1:0] input_17;
    input [1:0] input_16;
    input [1:0] input_15;
    input [1:0] input_14;
    input [1:0] input_13;
    input [1:0] input_12;
    input [1:0] input_11;
    input [1:0] input_10;
    input [1:0] input_9;
    input [1:0] input_8;
    input [1:0] input_7;
    input [1:0] input_6;
    input [1:0] input_5;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [33:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | (input_1 & {2{sel[1]}});
    result = result | (input_2 & {2{sel[2]}});
    result = result | (input_3 & {2{sel[3]}});
    result = result | (input_4 & {2{sel[4]}});
    result = result | (input_5 & {2{sel[5]}});
    result = result | (input_6 & {2{sel[6]}});
    result = result | (input_7 & {2{sel[7]}});
    result = result | (input_8 & {2{sel[8]}});
    result = result | (input_9 & {2{sel[9]}});
    result = result | (input_10 & {2{sel[10]}});
    result = result | (input_11 & {2{sel[11]}});
    result = result | (input_12 & {2{sel[12]}});
    result = result | (input_13 & {2{sel[13]}});
    result = result | (input_14 & {2{sel[14]}});
    result = result | (input_15 & {2{sel[15]}});
    result = result | (input_16 & {2{sel[16]}});
    result = result | (input_17 & {2{sel[17]}});
    result = result | (input_18 & {2{sel[18]}});
    result = result | (input_19 & {2{sel[19]}});
    result = result | (input_20 & {2{sel[20]}});
    result = result | (input_21 & {2{sel[21]}});
    result = result | (input_22 & {2{sel[22]}});
    result = result | (input_23 & {2{sel[23]}});
    result = result | (input_24 & {2{sel[24]}});
    result = result | (input_25 & {2{sel[25]}});
    result = result | (input_26 & {2{sel[26]}});
    result = result | (input_27 & {2{sel[27]}});
    result = result | (input_28 & {2{sel[28]}});
    result = result | (input_29 & {2{sel[29]}});
    result = result | (input_30 & {2{sel[30]}});
    result = result | (input_31 & {2{sel[31]}});
    result = result | (input_32 & {2{sel[32]}});
    result = result | (input_33 & {2{sel[33]}});
    MUX1HOT_v_2_34_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_16_2;
    input [3:0] input_15;
    input [3:0] input_14;
    input [3:0] input_13;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [15:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    result = result | (input_6 & {4{sel[6]}});
    result = result | (input_7 & {4{sel[7]}});
    result = result | (input_8 & {4{sel[8]}});
    result = result | (input_9 & {4{sel[9]}});
    result = result | (input_10 & {4{sel[10]}});
    result = result | (input_11 & {4{sel[11]}});
    result = result | (input_12 & {4{sel[12]}});
    result = result | (input_13 & {4{sel[13]}});
    result = result | (input_14 & {4{sel[14]}});
    result = result | (input_15 & {4{sel[15]}});
    MUX1HOT_v_4_16_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_18_2;
    input [3:0] input_17;
    input [3:0] input_16;
    input [3:0] input_15;
    input [3:0] input_14;
    input [3:0] input_13;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [17:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    result = result | (input_6 & {4{sel[6]}});
    result = result | (input_7 & {4{sel[7]}});
    result = result | (input_8 & {4{sel[8]}});
    result = result | (input_9 & {4{sel[9]}});
    result = result | (input_10 & {4{sel[10]}});
    result = result | (input_11 & {4{sel[11]}});
    result = result | (input_12 & {4{sel[12]}});
    result = result | (input_13 & {4{sel[13]}});
    result = result | (input_14 & {4{sel[14]}});
    result = result | (input_15 & {4{sel[15]}});
    result = result | (input_16 & {4{sel[16]}});
    result = result | (input_17 & {4{sel[17]}});
    MUX1HOT_v_4_18_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_19_2;
    input [3:0] input_18;
    input [3:0] input_17;
    input [3:0] input_16;
    input [3:0] input_15;
    input [3:0] input_14;
    input [3:0] input_13;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [18:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    result = result | (input_6 & {4{sel[6]}});
    result = result | (input_7 & {4{sel[7]}});
    result = result | (input_8 & {4{sel[8]}});
    result = result | (input_9 & {4{sel[9]}});
    result = result | (input_10 & {4{sel[10]}});
    result = result | (input_11 & {4{sel[11]}});
    result = result | (input_12 & {4{sel[12]}});
    result = result | (input_13 & {4{sel[13]}});
    result = result | (input_14 & {4{sel[14]}});
    result = result | (input_15 & {4{sel[15]}});
    result = result | (input_16 & {4{sel[16]}});
    result = result | (input_17 & {4{sel[17]}});
    result = result | (input_18 & {4{sel[18]}});
    MUX1HOT_v_4_19_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_32_2;
    input [3:0] input_31;
    input [3:0] input_30;
    input [3:0] input_29;
    input [3:0] input_28;
    input [3:0] input_27;
    input [3:0] input_26;
    input [3:0] input_25;
    input [3:0] input_24;
    input [3:0] input_23;
    input [3:0] input_22;
    input [3:0] input_21;
    input [3:0] input_20;
    input [3:0] input_19;
    input [3:0] input_18;
    input [3:0] input_17;
    input [3:0] input_16;
    input [3:0] input_15;
    input [3:0] input_14;
    input [3:0] input_13;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [31:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    result = result | (input_6 & {4{sel[6]}});
    result = result | (input_7 & {4{sel[7]}});
    result = result | (input_8 & {4{sel[8]}});
    result = result | (input_9 & {4{sel[9]}});
    result = result | (input_10 & {4{sel[10]}});
    result = result | (input_11 & {4{sel[11]}});
    result = result | (input_12 & {4{sel[12]}});
    result = result | (input_13 & {4{sel[13]}});
    result = result | (input_14 & {4{sel[14]}});
    result = result | (input_15 & {4{sel[15]}});
    result = result | (input_16 & {4{sel[16]}});
    result = result | (input_17 & {4{sel[17]}});
    result = result | (input_18 & {4{sel[18]}});
    result = result | (input_19 & {4{sel[19]}});
    result = result | (input_20 & {4{sel[20]}});
    result = result | (input_21 & {4{sel[21]}});
    result = result | (input_22 & {4{sel[22]}});
    result = result | (input_23 & {4{sel[23]}});
    result = result | (input_24 & {4{sel[24]}});
    result = result | (input_25 & {4{sel[25]}});
    result = result | (input_26 & {4{sel[26]}});
    result = result | (input_27 & {4{sel[27]}});
    result = result | (input_28 & {4{sel[28]}});
    result = result | (input_29 & {4{sel[29]}});
    result = result | (input_30 & {4{sel[30]}});
    result = result | (input_31 & {4{sel[31]}});
    MUX1HOT_v_4_32_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_34_2;
    input [3:0] input_33;
    input [3:0] input_32;
    input [3:0] input_31;
    input [3:0] input_30;
    input [3:0] input_29;
    input [3:0] input_28;
    input [3:0] input_27;
    input [3:0] input_26;
    input [3:0] input_25;
    input [3:0] input_24;
    input [3:0] input_23;
    input [3:0] input_22;
    input [3:0] input_21;
    input [3:0] input_20;
    input [3:0] input_19;
    input [3:0] input_18;
    input [3:0] input_17;
    input [3:0] input_16;
    input [3:0] input_15;
    input [3:0] input_14;
    input [3:0] input_13;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [33:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    result = result | (input_6 & {4{sel[6]}});
    result = result | (input_7 & {4{sel[7]}});
    result = result | (input_8 & {4{sel[8]}});
    result = result | (input_9 & {4{sel[9]}});
    result = result | (input_10 & {4{sel[10]}});
    result = result | (input_11 & {4{sel[11]}});
    result = result | (input_12 & {4{sel[12]}});
    result = result | (input_13 & {4{sel[13]}});
    result = result | (input_14 & {4{sel[14]}});
    result = result | (input_15 & {4{sel[15]}});
    result = result | (input_16 & {4{sel[16]}});
    result = result | (input_17 & {4{sel[17]}});
    result = result | (input_18 & {4{sel[18]}});
    result = result | (input_19 & {4{sel[19]}});
    result = result | (input_20 & {4{sel[20]}});
    result = result | (input_21 & {4{sel[21]}});
    result = result | (input_22 & {4{sel[22]}});
    result = result | (input_23 & {4{sel[23]}});
    result = result | (input_24 & {4{sel[24]}});
    result = result | (input_25 & {4{sel[25]}});
    result = result | (input_26 & {4{sel[26]}});
    result = result | (input_27 & {4{sel[27]}});
    result = result | (input_28 & {4{sel[28]}});
    result = result | (input_29 & {4{sel[29]}});
    result = result | (input_30 & {4{sel[30]}});
    result = result | (input_31 & {4{sel[31]}});
    result = result | (input_32 & {4{sel[32]}});
    result = result | (input_33 & {4{sel[33]}});
    MUX1HOT_v_4_34_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_3_2;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [2:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    MUX1HOT_v_4_3_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_5_2;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [4:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    MUX1HOT_v_4_5_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_6_2;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [5:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | (input_1 & {4{sel[1]}});
    result = result | (input_2 & {4{sel[2]}});
    result = result | (input_3 & {4{sel[3]}});
    result = result | (input_4 & {4{sel[4]}});
    result = result | (input_5 & {4{sel[5]}});
    MUX1HOT_v_4_6_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_33_2;
    input [4:0] input_32;
    input [4:0] input_31;
    input [4:0] input_30;
    input [4:0] input_29;
    input [4:0] input_28;
    input [4:0] input_27;
    input [4:0] input_26;
    input [4:0] input_25;
    input [4:0] input_24;
    input [4:0] input_23;
    input [4:0] input_22;
    input [4:0] input_21;
    input [4:0] input_20;
    input [4:0] input_19;
    input [4:0] input_18;
    input [4:0] input_17;
    input [4:0] input_16;
    input [4:0] input_15;
    input [4:0] input_14;
    input [4:0] input_13;
    input [4:0] input_12;
    input [4:0] input_11;
    input [4:0] input_10;
    input [4:0] input_9;
    input [4:0] input_8;
    input [4:0] input_7;
    input [4:0] input_6;
    input [4:0] input_5;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [32:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    result = result | (input_3 & {5{sel[3]}});
    result = result | (input_4 & {5{sel[4]}});
    result = result | (input_5 & {5{sel[5]}});
    result = result | (input_6 & {5{sel[6]}});
    result = result | (input_7 & {5{sel[7]}});
    result = result | (input_8 & {5{sel[8]}});
    result = result | (input_9 & {5{sel[9]}});
    result = result | (input_10 & {5{sel[10]}});
    result = result | (input_11 & {5{sel[11]}});
    result = result | (input_12 & {5{sel[12]}});
    result = result | (input_13 & {5{sel[13]}});
    result = result | (input_14 & {5{sel[14]}});
    result = result | (input_15 & {5{sel[15]}});
    result = result | (input_16 & {5{sel[16]}});
    result = result | (input_17 & {5{sel[17]}});
    result = result | (input_18 & {5{sel[18]}});
    result = result | (input_19 & {5{sel[19]}});
    result = result | (input_20 & {5{sel[20]}});
    result = result | (input_21 & {5{sel[21]}});
    result = result | (input_22 & {5{sel[22]}});
    result = result | (input_23 & {5{sel[23]}});
    result = result | (input_24 & {5{sel[24]}});
    result = result | (input_25 & {5{sel[25]}});
    result = result | (input_26 & {5{sel[26]}});
    result = result | (input_27 & {5{sel[27]}});
    result = result | (input_28 & {5{sel[28]}});
    result = result | (input_29 & {5{sel[29]}});
    result = result | (input_30 & {5{sel[30]}});
    result = result | (input_31 & {5{sel[31]}});
    result = result | (input_32 & {5{sel[32]}});
    MUX1HOT_v_5_33_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_3_2;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [2:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    MUX1HOT_v_5_3_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_4_2;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [3:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    result = result | (input_3 & {5{sel[3]}});
    MUX1HOT_v_5_4_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_5_2;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [4:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | (input_1 & {5{sel[1]}});
    result = result | (input_2 & {5{sel[2]}});
    result = result | (input_3 & {5{sel[3]}});
    result = result | (input_4 & {5{sel[4]}});
    MUX1HOT_v_5_5_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_3_2;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [2:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | (input_1 & {7{sel[1]}});
    result = result | (input_2 & {7{sel[2]}});
    MUX1HOT_v_7_3_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_5_2;
    input [6:0] input_4;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [4:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | (input_1 & {7{sel[1]}});
    result = result | (input_2 & {7{sel[2]}});
    result = result | (input_3 & {7{sel[3]}});
    result = result | (input_4 & {7{sel[4]}});
    MUX1HOT_v_7_5_2 = result;
  end
  endfunction


  function automatic  MUX_s_1_2_2;
    input  input_0;
    input  input_1;
    input  sel;
    reg  result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [10:0] MUX_v_11_2_2;
    input [10:0] input_0;
    input [10:0] input_1;
    input  sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function automatic [1:0] MUX_v_2_2_2;
    input [1:0] input_0;
    input [1:0] input_1;
    input  sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input  sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function automatic [3:0] MUX_v_4_2_2;
    input [3:0] input_0;
    input [3:0] input_1;
    input  sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function automatic [4:0] MUX_v_5_2_2;
    input [4:0] input_0;
    input [4:0] input_1;
    input  sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction


  function automatic [5:0] MUX_v_6_2_2;
    input [5:0] input_0;
    input [5:0] input_1;
    input  sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function automatic [6:0] MUX_v_7_2_2;
    input [6:0] input_0;
    input [6:0] input_1;
    input  sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_2_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input  sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_6_1_5;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 5;
    readslicef_6_1_5 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_7_1_6;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_7_1_6 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_8_1_7;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 7;
    readslicef_8_1_7 = tmp[0:0];
  end
  endfunction


  function automatic [6:0] readslicef_8_7_1;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_8_7_1 = tmp[6:0];
  end
  endfunction


  function automatic [4:0] signext_5_4;
    input [3:0] vector;
  begin
    signext_5_4= {{1{vector[3]}}, vector};
  end
  endfunction


  function automatic [5:0] conv_s2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_s2s_5_6 = {vector[4], vector};
  end
  endfunction


  function automatic [6:0] conv_s2s_6_7 ;
    input [5:0]  vector ;
  begin
    conv_s2s_6_7 = {vector[5], vector};
  end
  endfunction


  function automatic [5:0] conv_s2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_s2u_5_6 = {vector[4], vector};
  end
  endfunction


  function automatic [7:0] conv_s2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_s2u_7_8 = {vector[6], vector};
  end
  endfunction


  function automatic [11:0] conv_s2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_s2u_11_12 = {vector[10], vector};
  end
  endfunction


  function automatic [6:0] conv_u2s_4_7 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_7 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [6:0] conv_u2s_5_7 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_7 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [7:0] conv_u2u_6_8 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_8 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    fir
// ------------------------------------------------------------------


module fir (
  clk, rst, input_m_rsc_dat, input_m_triosy_lz, input_e_rsc_dat, input_e_triosy_lz,
      taps_m_rsc_dat, taps_m_triosy_lz, taps_e_rsc_dat, taps_e_triosy_lz, return_m_rsc_dat,
      return_m_triosy_lz, return_e_rsc_dat, return_e_triosy_lz
);
  input clk;
  input rst;
  input [10:0] input_m_rsc_dat;
  output input_m_triosy_lz;
  input [4:0] input_e_rsc_dat;
  output input_e_triosy_lz;
  input [175:0] taps_m_rsc_dat;
  output taps_m_triosy_lz;
  input [79:0] taps_e_rsc_dat;
  output taps_e_triosy_lz;
  output [10:0] return_m_rsc_dat;
  output return_m_triosy_lz;
  output [4:0] return_e_rsc_dat;
  output return_e_triosy_lz;


  // Interconnect Declarations
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_1_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_1_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_2_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_2_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_3_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_3_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_4_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_4_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_5_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_5_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_6_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_6_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_7_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_7_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_8_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_8_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_9_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_9_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_10_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_10_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_11_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_11_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_12_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_12_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_13_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_13_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_14_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_14_rtn;
  wire [17:0] MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa;
  wire MAC_1_leading_sign_18_1_1_0_cmp_15_all_same;
  wire [4:0] MAC_1_leading_sign_18_1_1_0_cmp_15_rtn;


  // Interconnect Declarations for Component Instantiations 
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_1 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_1_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_1_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_2 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_2_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_2_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_3 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_3_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_3_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_4 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_4_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_4_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_5 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_5_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_5_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_6 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_6_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_6_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_7 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_7_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_7_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_8 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_8_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_8_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_9 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_9_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_9_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_10 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_10_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_10_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_11 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_11_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_11_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_12 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_12_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_12_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_13 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_13_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_13_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_14 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_14_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_14_rtn)
    );
  leading_sign_18_1_1_0  MAC_1_leading_sign_18_1_1_0_cmp_15 (
      .mantissa(MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa),
      .all_same(MAC_1_leading_sign_18_1_1_0_cmp_15_all_same),
      .rtn(MAC_1_leading_sign_18_1_1_0_cmp_15_rtn)
    );
  fir_core fir_core_inst (
      .clk(clk),
      .rst(rst),
      .input_m_rsc_dat(input_m_rsc_dat),
      .input_m_triosy_lz(input_m_triosy_lz),
      .input_e_rsc_dat(input_e_rsc_dat),
      .input_e_triosy_lz(input_e_triosy_lz),
      .taps_m_rsc_dat(taps_m_rsc_dat),
      .taps_m_triosy_lz(taps_m_triosy_lz),
      .taps_e_rsc_dat(taps_e_rsc_dat),
      .taps_e_triosy_lz(taps_e_triosy_lz),
      .return_m_rsc_dat(return_m_rsc_dat),
      .return_m_triosy_lz(return_m_triosy_lz),
      .return_e_rsc_dat(return_e_rsc_dat),
      .return_e_triosy_lz(return_e_triosy_lz),
      .MAC_1_leading_sign_18_1_1_0_cmp_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_all_same(MAC_1_leading_sign_18_1_1_0_cmp_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_rtn(MAC_1_leading_sign_18_1_1_0_cmp_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_1_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_all_same(MAC_1_leading_sign_18_1_1_0_cmp_1_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_1_rtn(MAC_1_leading_sign_18_1_1_0_cmp_1_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_2_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_all_same(MAC_1_leading_sign_18_1_1_0_cmp_2_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_2_rtn(MAC_1_leading_sign_18_1_1_0_cmp_2_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_3_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_all_same(MAC_1_leading_sign_18_1_1_0_cmp_3_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_3_rtn(MAC_1_leading_sign_18_1_1_0_cmp_3_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_4_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_all_same(MAC_1_leading_sign_18_1_1_0_cmp_4_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_4_rtn(MAC_1_leading_sign_18_1_1_0_cmp_4_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_5_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_all_same(MAC_1_leading_sign_18_1_1_0_cmp_5_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_5_rtn(MAC_1_leading_sign_18_1_1_0_cmp_5_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_6_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_all_same(MAC_1_leading_sign_18_1_1_0_cmp_6_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_6_rtn(MAC_1_leading_sign_18_1_1_0_cmp_6_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_7_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_all_same(MAC_1_leading_sign_18_1_1_0_cmp_7_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_7_rtn(MAC_1_leading_sign_18_1_1_0_cmp_7_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_8_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_all_same(MAC_1_leading_sign_18_1_1_0_cmp_8_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_8_rtn(MAC_1_leading_sign_18_1_1_0_cmp_8_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_9_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_all_same(MAC_1_leading_sign_18_1_1_0_cmp_9_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_9_rtn(MAC_1_leading_sign_18_1_1_0_cmp_9_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_10_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_all_same(MAC_1_leading_sign_18_1_1_0_cmp_10_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_10_rtn(MAC_1_leading_sign_18_1_1_0_cmp_10_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_11_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_all_same(MAC_1_leading_sign_18_1_1_0_cmp_11_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_11_rtn(MAC_1_leading_sign_18_1_1_0_cmp_11_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_12_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_all_same(MAC_1_leading_sign_18_1_1_0_cmp_12_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_12_rtn(MAC_1_leading_sign_18_1_1_0_cmp_12_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_13_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_all_same(MAC_1_leading_sign_18_1_1_0_cmp_13_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_13_rtn(MAC_1_leading_sign_18_1_1_0_cmp_13_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_14_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_all_same(MAC_1_leading_sign_18_1_1_0_cmp_14_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_14_rtn(MAC_1_leading_sign_18_1_1_0_cmp_14_rtn),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa(MAC_1_leading_sign_18_1_1_0_cmp_15_mantissa),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_all_same(MAC_1_leading_sign_18_1_1_0_cmp_15_all_same),
      .MAC_1_leading_sign_18_1_1_0_cmp_15_rtn(MAC_1_leading_sign_18_1_1_0_cmp_15_rtn)
    );
endmodule



