/* arachne-pnr 0.1+20180513git5d830dd (git sha1 5d830dd, g++ 9.3.0-6ubuntu1 -O2 -fdebug-prefix-map=/build/arachne-pnr-AaC6iz/arachne-pnr-0.1+20180513git5d830dd=. -fstack-protector-strong -O2 -DNDEBUG) */
module top(input SW1, input SW2, input SW3, input SW4, output LED1, output LED2, output LED3, output LED4);
  wire SW1$2;
  wire SW2$2;
  wire SW3$2;
  wire SW4$2;
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst0 (
    .PACKAGE_PIN(LED1),
    .D_OUT_0(SW1$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst1 (
    .PACKAGE_PIN(LED2),
    .D_OUT_0(SW2$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst2 (
    .PACKAGE_PIN(LED3),
    .D_OUT_0(SW3$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst3 (
    .PACKAGE_PIN(LED4),
    .D_OUT_0(SW4$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst4 (
    .PACKAGE_PIN(SW1),
    .D_IN_0(SW1$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst5 (
    .PACKAGE_PIN(SW2),
    .D_IN_0(SW2$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst6 (
    .PACKAGE_PIN(SW3),
    .D_IN_0(SW3$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst7 (
    .PACKAGE_PIN(SW4),
    .D_IN_0(SW4$2)
  );
endmodule
