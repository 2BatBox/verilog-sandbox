`define assert_pass begin \
		$display("\033[1;32mPASS\033[0m"); \
        $finish; \
	end

`define assert_fail begin \
		$display("\033[1;31mFAIL\033[0m"); \
        $finish; \
	end

`define assert_eq(signal, value) begin \
		if ((signal) !== (value)) begin \
			$display("%s:%d Module '%m' : ASSERTION FAILED signal != value", `__FILE__, `__LINE__); \
			$display("\033[1;31mFAIL\033[0m"); \
			$finish; \
		end \
	end

`define assert_neq(signal, value) begin \
		if ((signal) === (value)) begin \
			$display("%s:%d Module '%m' : ASSERTION FAILED signal == value", `__FILE__, `__LINE__); \
			$display("\033[1;31mFAIL\033[0m"); \
			$finish; \
		end \
	end

`define assert(exp) begin \
		if (!(exp)) begin \
			$display("%s:%d Module '%m' : ASSERTION FAILED exp == 0", `__FILE__, `__LINE__); \
			$display("\033[1;31mFAIL\033[0m"); \
			$finish; \
		end \
	end

