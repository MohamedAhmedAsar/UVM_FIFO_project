package FIFO_driver_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import FIFO_seq_item_pkg::*;

    class FIFO_driver extends uvm_driver #(FIFO_seq_item);
        `uvm_component_utils(FIFO_driver)

        virtual FIFO_if fifo_vif;
        FIFO_seq_item stim_seq_item;

        function new(string name = "FIFO_driver" , uvm_component parent = null);
            super.new(name,parent);
        endfunction


        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stim_seq_item = FIFO_seq_item::type_id::create("stim_seq_item");
                seq_item_port.get_next_item(stim_seq_item);
                fifo_vif.data_in=stim_seq_item.data_in;
                fifo_vif.wr_en=stim_seq_item.wr_en;
                fifo_vif.rd_en=stim_seq_item.rd_en;
                fifo_vif.rst_n=stim_seq_item.rst_n;
                @(negedge fifo_vif.clk);
                seq_item_port.item_done();
                `uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
            end
        endtask
    endclass
    
endpackage