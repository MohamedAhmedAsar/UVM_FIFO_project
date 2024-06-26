import uvm_pkg::*;
`include "uvm_macros.svh"
import FIFO_test_pkg::*;
module TOP;

    bit clk;
    always #5 clk=~clk;

    FIFO_if intf(clk);

    FIFO dut(intf);

    bind FIFO Assertions assertions(intf,dut.count,dut.wr_ptr,dut.rd_ptr);
    

    initial begin
        uvm_config_db#(virtual FIFO_if)::set(null, "uvm_test_top", "INTF", intf);

        run_test("FIFO_test");
    end

endmodule