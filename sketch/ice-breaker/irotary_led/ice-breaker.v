/* arachne-pnr 0.1+20180513git5d830dd (git sha1 5d830dd, g++ 9.3.0-6ubuntu1 -O2 -fdebug-prefix-map=/build/arachne-pnr-AaC6iz/arachne-pnr-0.1+20180513git5d830dd=. -fstack-protector-strong -O2 -DNDEBUG) */
module top(input CLK, input P1B1, input P1B2, input P1B3, input P1B4, output P1A1, output P1A2, output P1A3, output P1A4, output LED_RED_N, output LED_GRN_N, output LED_BLU_N);
  wire \$abc$898$auto$alumacc.cc:474:replace_alu$139.BB[3] ;
  wire \$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$731 ;
  wire \$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$768 ;
  wire \$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$713 ;
  wire \$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$752 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$820 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$824 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$828 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$832 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$836 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$840 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$844 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$848 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$852 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$856 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$860 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$864 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$868 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$872 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$876 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$880 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$884 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$888 ;
  wire \$abc$898$auto$ice40_ffinit.cc:141:execute$892 ;
  wire \$abc$898$auto$opt_reduce.cc:132:opt_mux$106 ;
  wire \$abc$898$auto$simplemap.cc:168:logic_reduce$468 ;
  wire \$abc$898$auto$simplemap.cc:309:simplemap_lut$215[0]_new_ ;
  wire $abc$898$new_n121_;
  wire $abc$898$new_n123_;
  wire $abc$898$new_n124_;
  wire $abc$898$new_n125_;
  wire $abc$898$new_n126_;
  wire $abc$898$new_n134_;
  wire $abc$898$new_n156_;
  wire $abc$898$new_n159_;
  wire \$abc$898$techmap$techmap\m_ire.$procmux$76.$and$/usr/bin/../share/yosys/techmap.v:434$457_Y[1]_new_ ;
  wire \$abc$898$techmap$techmap\m_ire.$procmux$79.$ternary$/usr/bin/../share/yosys/techmap.v:445$437_Y[0]_new_inv_ ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[0] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[10] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[11] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[12] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[13] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[14] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[15] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[2] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[3] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[4] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[5] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[6] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[7] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[8] ;
  wire \$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[9] ;
  wire \$auto$alumacc.cc:474:replace_alu$139.C[2] ;
  wire \$auto$alumacc.cc:474:replace_alu$139.C[3] ;
  wire \$auto$alumacc.cc:474:replace_alu$142.C[2] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[10] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[11] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[12] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[13] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[14] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[15] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[2] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[3] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[4] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[5] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[6] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[7] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[8] ;
  wire \$auto$alumacc.cc:474:replace_alu$145.C[9] ;
  wire $false = 0;
  wire $true = 1;
  wire CLK$2;
  wire LED_BLU_N$2;
  wire LED_BLU_N$2$2;
  wire LED_GRN_N$2;
  wire LED_RED_N$2;
  wire P1A1$2;
  wire P1A2$2;
  wire P1A3$2;
  wire P1A4$2;
  wire P1A4$2$2;
  wire P1B1$2;
  wire P1B3$2;
  wire P1B4$2;
  wire \m_db.rv_cnt[0] ;
  wire \m_db.rv_cnt[0]$2 ;
  wire \m_db.rv_cnt[10] ;
  wire \m_db.rv_cnt[11] ;
  wire \m_db.rv_cnt[12] ;
  wire \m_db.rv_cnt[13] ;
  wire \m_db.rv_cnt[14] ;
  wire \m_db.rv_cnt[15] ;
  wire \m_db.rv_cnt[1] ;
  wire \m_db.rv_cnt[2] ;
  wire \m_db.rv_cnt[3] ;
  wire \m_db.rv_cnt[4] ;
  wire \m_db.rv_cnt[5] ;
  wire \m_db.rv_cnt[6] ;
  wire \m_db.rv_cnt[7] ;
  wire \m_db.rv_cnt[8] ;
  wire \m_db.rv_cnt[9] ;
  wire \m_db.rv_output ;
  wire \m_db.w_cnt_full ;
  wire \m_ire.r_cnt ;
  wire \m_ire.r_cnt_cw ;
  wire \m_sync_chain.rvv_chain[0] ;
  wire \m_sync_chain.rvv_chain[1] ;
  wire r_button_sync_deb;
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst0 (
    .PACKAGE_PIN(CLK),
    .D_IN_0(CLK$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst1 (
    .PACKAGE_PIN(LED_BLU_N),
    .D_OUT_0(LED_BLU_N$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst2 (
    .PACKAGE_PIN(LED_GRN_N),
    .D_OUT_0(LED_GRN_N$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst3 (
    .PACKAGE_PIN(LED_RED_N),
    .D_OUT_0(LED_RED_N$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst4 (
    .PACKAGE_PIN(P1A1),
    .D_OUT_0(P1A1$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst5 (
    .PACKAGE_PIN(P1A2),
    .D_OUT_0(P1A2$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst6 (
    .PACKAGE_PIN(P1A3),
    .D_OUT_0(P1A3$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst7 (
    .PACKAGE_PIN(P1A4),
    .D_OUT_0(P1A4$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst8 (
    .PACKAGE_PIN(P1B1),
    .D_IN_0(P1B1$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst9 (
    .PACKAGE_PIN(P1B2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst10 (
    .PACKAGE_PIN(P1B3),
    .D_IN_0(P1B3$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst11 (
    .PACKAGE_PIN(P1B4),
    .D_IN_0(P1B4$2)
  );
  (* src="top.v:34|../../../lib/io/SyncChain.v:43|/usr/bin/../share/yosys/ice40/cells_map.v:2" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b10)
  ) $inst12 (
    .I0(P1B4$2),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\m_sync_chain.rvv_chain[0] )
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|top.v:41|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b0110011010011001)
  ) $inst13 (
    .I0($false),
    .I1(P1A4$2),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\m_ire.r_cnt ),
    .SR($false),
    .O(P1A4$2)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b01)
  ) $inst14 (
    .I0(P1A3$2),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$713 ),
    .SR($false),
    .O(P1A3$2)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|top.v:41|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst15 (
    .I0($false),
    .I1(P1A2$2),
    .I2(\$abc$898$auto$alumacc.cc:474:replace_alu$139.BB[3] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$139.C[2] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$139.C[2] ),
    .CLK(CLK$2),
    .CEN(\m_ire.r_cnt ),
    .SR($false),
    .O(P1A2$2),
    .COUT(\$auto$alumacc.cc:474:replace_alu$139.C[3] )
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|top.v:41|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst16 (
    .I0($false),
    .I1(P1A1$2),
    .I2(\$abc$898$auto$alumacc.cc:474:replace_alu$139.BB[3] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$139.C[3] ),
    .CLK(CLK$2),
    .CEN(\m_ire.r_cnt ),
    .SR($false),
    .O(P1A1$2)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:2" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b10)
  ) $inst17 (
    .I0(\m_db.rv_output ),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(r_button_sync_deb)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|top.v:43|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b0101101010100101)
  ) $inst18 (
    .I0($false),
    .I1($false),
    .I2(LED_BLU_N$2),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$731 ),
    .SR($false),
    .O(LED_BLU_N$2)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b01)
  ) $inst19 (
    .I0(LED_GRN_N$2),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$752 ),
    .SR($false),
    .O(LED_GRN_N$2)
  );
  (* src="top.v:38|/usr/bin/../share/yosys/ice40/cells_map.v:8|top.v:43|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst20 (
    .I0($false),
    .I1($false),
    .I2(LED_RED_N$2),
    .I3(\$auto$alumacc.cc:474:replace_alu$142.C[2] ),
    .CLK(CLK$2),
    .CEN(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$731 ),
    .SR($false),
    .O(LED_RED_N$2)
  );
  (* src="top.v:34|../../../lib/io/SyncChain.v:37|/usr/bin/../share/yosys/ice40/cells_map.v:2" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b10)
  ) $inst21 (
    .I0(\m_sync_chain.rvv_chain[0] ),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\m_sync_chain.rvv_chain[1] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:8" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b10)
  ) $inst22 (
    .I0(\m_sync_chain.rvv_chain[1] ),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\m_db.w_cnt_full ),
    .SR($false),
    .O(\m_db.rv_output )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst23 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[0] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$880 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:8|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst24 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$836 ),
    .I3($false),
    .CLK(CLK$2),
    .CEN(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$768 ),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$836 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst25 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[2] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$832 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst26 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[3] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$844 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst27 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[4] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$840 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst28 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[5] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$828 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst29 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[6] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$848 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst30 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[7] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$884 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst31 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[8] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$852 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst32 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[9] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$856 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst33 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[10] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$860 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst34 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[11] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$864 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst35 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[12] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$868 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst36 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[13] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$872 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst37 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[14] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$876 )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:28|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b10011111)
  ) $inst38 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[15] ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$888 )
  );
  (* src="top.v:36|../../../lib/driver/IRotaryEncoder.v:65|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b1111111101000000)
  ) $inst39 (
    .I0(\$abc$898$auto$simplemap.cc:168:logic_reduce$468 ),
    .I1(\$abc$898$auto$simplemap.cc:309:simplemap_lut$215[0]_new_ ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .I3($abc$898$new_n134_),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\m_ire.r_cnt_cw )
  );
  (* src="top.v:36|../../../lib/driver/IRotaryEncoder.v:65|/usr/bin/../share/yosys/ice40/cells_map.v:2" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(2'b10)
  ) $inst40 (
    .I0(\$abc$898$auto$opt_reduce.cc:132:opt_mux$106 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR(\$abc$898$auto$simplemap.cc:168:logic_reduce$468 ),
    .O(\m_ire.r_cnt )
  );
  (* src="top.v:36|../../../lib/driver/IRotaryEncoder.v:65|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(8'b00000111)
  ) $inst41 (
    .I0(P1B1$2),
    .I1($abc$898$new_n156_),
    .I2(\$abc$898$techmap$techmap\m_ire.$procmux$76.$and$/usr/bin/../share/yosys/techmap.v:434$457_Y[1]_new_ ),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 )
  );
  (* src="top.v:36|../../../lib/driver/IRotaryEncoder.v:65|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:44" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(4'b0100)
  ) $inst42 (
    .I0(\$abc$898$techmap$techmap\m_ire.$procmux$76.$and$/usr/bin/../share/yosys/techmap.v:434$457_Y[1]_new_ ),
    .I1($abc$898$new_n121_),
    .I2($false),
    .I3($false),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 )
  );
  (* src="top.v:36|../../../lib/driver/IRotaryEncoder.v:65|/usr/bin/../share/yosys/ice40/cells_map.v:2|/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .DFF_ENABLE(1'b1), 
    .LUT_INIT(16'b1111000000010001)
  ) $inst43 (
    .I0(P1B3$2),
    .I1(P1B1$2),
    .I2($abc$898$new_n159_),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .CLK(CLK$2),
    .CEN($true),
    .SR($false),
    .O(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:44" *)
  ICESTORM_LC #(
    .LUT_INIT(4'b0001)
  ) $inst44 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 ),
    .I2($false),
    .I3($false),
    .O(\$abc$898$auto$simplemap.cc:309:simplemap_lut$215[0]_new_ )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .LUT_INIT(8'b00010000)
  ) $inst45 (
    .I0(\$abc$898$techmap$techmap\m_ire.$procmux$79.$ternary$/usr/bin/../share/yosys/techmap.v:445$437_Y[0]_new_inv_ ),
    .I1(P1B1$2),
    .I2(P1B3$2),
    .I3($false),
    .O(\$abc$898$techmap$techmap\m_ire.$procmux$76.$and$/usr/bin/../share/yosys/techmap.v:434$457_Y[1]_new_ )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .LUT_INIT(8'b10110000)
  ) $inst46 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 ),
    .I3($false),
    .O(\$abc$898$techmap$techmap\m_ire.$procmux$79.$ternary$/usr/bin/../share/yosys/techmap.v:445$437_Y[0]_new_inv_ )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0101011101110101)
  ) $inst47 (
    .I0(P1B1$2),
    .I1(\$abc$898$auto$simplemap.cc:309:simplemap_lut$215[0]_new_ ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .I3(P1B3$2),
    .O($abc$898$new_n121_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b1000000000000000)
  ) $inst48 (
    .I0($abc$898$new_n123_),
    .I1($abc$898$new_n124_),
    .I2($abc$898$new_n125_),
    .I3($abc$898$new_n126_),
    .O(\m_db.w_cnt_full )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0000000000000001)
  ) $inst49 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$844 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$848 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$852 ),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$856 ),
    .O($abc$898$new_n123_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0000000000000001)
  ) $inst50 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$828 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$832 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$836 ),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$840 ),
    .O($abc$898$new_n124_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0000000000000001)
  ) $inst51 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$876 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$880 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$884 ),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$888 ),
    .O($abc$898$new_n125_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0000000000000001)
  ) $inst52 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$860 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$864 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$868 ),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$872 ),
    .O($abc$898$new_n126_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .LUT_INIT(8'b00010100)
  ) $inst53 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 ),
    .I3($false),
    .O(\$abc$898$auto$opt_reduce.cc:132:opt_mux$106 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .LUT_INIT(8'b10010000)
  ) $inst54 (
    .I0(P1A4$2),
    .I1(\m_ire.r_cnt_cw ),
    .I2(\m_ire.r_cnt ),
    .I3($false),
    .O(\$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$713 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:44" *)
  ICESTORM_LC #(
    .LUT_INIT(4'b0100)
  ) $inst55 (
    .I0(r_button_sync_deb),
    .I1(\m_db.rv_output ),
    .I2($false),
    .I3($false),
    .O(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$731 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:44" *)
  ICESTORM_LC #(
    .LUT_INIT(4'b1000)
  ) $inst56 (
    .I0(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$731 ),
    .I1(LED_BLU_N$2),
    .I2($false),
    .I3($false),
    .O(\$abc$898$auto$dff2dffe.cc:175:make_patterns_logic$752 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:48" *)
  ICESTORM_LC #(
    .LUT_INIT(8'b10011111)
  ) $inst57 (
    .I0(\m_db.rv_output ),
    .I1(\m_sync_chain.rvv_chain[1] ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$880 ),
    .I3($false),
    .O(\$abc$898$auto$dff2dffe.cc:158:make_patterns_logic$768 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:44" *)
  ICESTORM_LC #(
    .LUT_INIT(4'b1110)
  ) $inst58 (
    .I0(P1B3$2),
    .I1(P1B1$2),
    .I2($false),
    .I3($false),
    .O(\$abc$898$auto$simplemap.cc:168:logic_reduce$468 )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0000101100000000)
  ) $inst59 (
    .I0(\$abc$898$auto$simplemap.cc:168:logic_reduce$468 ),
    .I1(\$abc$898$auto$opt_reduce.cc:132:opt_mux$106 ),
    .I2(\m_ire.r_cnt ),
    .I3(\m_ire.r_cnt_cw ),
    .O($abc$898$new_n134_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst60 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$828 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[5] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst61 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$832 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[2] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst62 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$836 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[1] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst63 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$840 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[4] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst64 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$844 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[3] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst65 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$848 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[6] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst66 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$852 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[8] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst67 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$856 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[9] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst68 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$860 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[10] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst69 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$864 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[11] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst70 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$868 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[12] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst71 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$872 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[13] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst72 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$876 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[14] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst73 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$880 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[0] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst74 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$884 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[7] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst75 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$888 ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\m_db.rv_cnt[15] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:40" *)
  ICESTORM_LC #(
    .LUT_INIT(2'b01)
  ) $inst76 (
    .I0(\m_ire.r_cnt_cw ),
    .I1($false),
    .I2($false),
    .I3($false),
    .O(\$abc$898$auto$alumacc.cc:474:replace_alu$139.BB[3] )
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b1101010111101011)
  ) $inst77 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$820 ),
    .I1(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 ),
    .I2(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 ),
    .I3(P1B3$2),
    .O($abc$898$new_n156_)
  );
  (* src="/usr/bin/../share/yosys/ice40/cells_map.v:52" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0100111111111011)
  ) $inst78 (
    .I0(\$abc$898$auto$ice40_ffinit.cc:141:execute$824 ),
    .I1(P1B1$2),
    .I2(P1B3$2),
    .I3(\$abc$898$auto$ice40_ffinit.cc:141:execute$892 ),
    .O($abc$898$new_n159_)
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0101101010100101)
  ) $inst79 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[0] ),
    .I3($false),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[0] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst80 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[10] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[10] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[10] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[10] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[11] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst81 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[11] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[11] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[11] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[11] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[12] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst82 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[12] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[12] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[12] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[12] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[13] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst83 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[13] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[13] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[13] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[13] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[14] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst84 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[14] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[14] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[14] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[14] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[15] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .LUT_INIT(16'b0110100110010110)
  ) $inst85 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[15] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[15] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[15] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst86 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[2] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[2] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[2] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[2] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[3] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst87 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[3] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[3] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[3] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[3] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[4] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst88 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[4] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[4] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[4] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[4] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[5] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst89 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[5] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[5] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[5] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[5] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[6] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst90 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[6] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[6] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[6] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[6] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[7] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst91 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[7] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[7] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[7] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[7] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[8] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst92 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[8] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[8] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[8] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[8] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[9] )
  );
  (* src="top.v:35|../../../lib/io/Debouncer.v:29|/usr/bin/../share/yosys/ice40/arith_map.v:53" *)
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1), 
    .LUT_INIT(16'b0110100110010110)
  ) $inst93 (
    .I0($false),
    .I1($false),
    .I2(\m_db.rv_cnt[9] ),
    .I3(\$auto$alumacc.cc:474:replace_alu$145.C[9] ),
    .CIN(\$auto$alumacc.cc:474:replace_alu$145.C[9] ),
    .O(\$abc$898$techmap\m_db.$add$../../../lib/io/Debouncer.v:29$32_Y[9] ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[10] )
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst94 (
    .I0($false),
    .I1(P1A4$2),
    .I2($false),
    .I3($false),
    .CIN($true),
    .COUT(P1A4$2$2)
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst95 (
    .I1(P1A3$2),
    .I2(\$abc$898$auto$alumacc.cc:474:replace_alu$139.BB[3] ),
    .CIN(P1A4$2$2),
    .COUT(\$auto$alumacc.cc:474:replace_alu$139.C[2] )
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst96 (
    .I0($false),
    .I1(LED_BLU_N$2),
    .I2($false),
    .I3($false),
    .CIN($true),
    .COUT(LED_BLU_N$2$2)
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst97 (
    .I1($false),
    .I2(LED_GRN_N$2),
    .CIN(LED_BLU_N$2$2),
    .COUT(\$auto$alumacc.cc:474:replace_alu$142.C[2] )
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst98 (
    .I0($false),
    .I1(\m_db.rv_cnt[0] ),
    .I2($false),
    .I3($false),
    .CIN($true),
    .COUT(\m_db.rv_cnt[0]$2 )
  );
  ICESTORM_LC #(
    .CARRY_ENABLE(1'b1)
  ) $inst99 (
    .I1($false),
    .I2(\m_db.rv_cnt[1] ),
    .CIN(\m_db.rv_cnt[0]$2 ),
    .COUT(\$auto$alumacc.cc:474:replace_alu$145.C[2] )
  );
endmodule
