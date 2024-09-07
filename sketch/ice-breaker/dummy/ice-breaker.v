/* arachne-pnr 0.1+20180513git5d830dd (git sha1 5d830dd, g++ 9.3.0-6ubuntu1 -O2 -fdebug-prefix-map=/build/arachne-pnr-AaC6iz/arachne-pnr-0.1+20180513git5d830dd=. -fstack-protector-strong -O2 -DNDEBUG) */
module top(input BTN1, output LED1);
  wire BTN1$2;
  SB_IO #(
    .PIN_TYPE(6'b000001)
  ) $inst0 (
    .PACKAGE_PIN(BTN1),
    .D_IN_0(BTN1$2)
  );
  SB_IO #(
    .PIN_TYPE(6'b011001)
  ) $inst1 (
    .PACKAGE_PIN(LED1),
    .D_OUT_0(BTN1$2)
  );
endmodule
