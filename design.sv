`include "synchronizer.v"
`include "wptr_handler.v"
`include "rptr_handler.v"
`include "fifo_mem.v"

module asynchronous_fifo #(parameter DEPTH=8, DATA_WIDTH=8) (
  input wclk, wrst_n,
  input rclk, rrst_n,
  input w_en, r_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg full, empty
);
  
  parameter PTR_WIDTH = $clog2(DEPTH);
  
  
  reg [PTR_WIDTH:0]b_wptr,g_wptr;
  reg [PTR_WIDTH:0]b_wptr_next,g_wptr_next;
  reg [PTR_WIDTH:0]b_rptr,g_rptr;
  reg [PTR_WIDTH:0]g_rptr_sync,g_wptr_sync;
  
 
  wire [PTR_WIDTH-1:0] waddr, raddr;
// Synchronize read pointer into write clock domain
synchronizer #(PTR_WIDTH) sync_wptr (wclk, wrst_n, g_rptr, g_rptr_sync);

// Synchronize write pointer into read clock domain
synchronizer #(PTR_WIDTH) sync_rptr (rclk, rrst_n, g_wptr, g_wptr_sync);
 wptr_handler #(PTR_WIDTH) wptr_h (w_en, wclk, wrst_n, g_rptr_sync, b_wptr, g_wptr, full);
    rptr_handler #(PTR_WIDTH) rptr_h (r_en, rclk, rrst_n, g_wptr_sync, b_rptr, g_rptr, empty);
  fifo_mem fifom (w_en, wclk,r_en,rclk,data_in, b_wptr, b_rptr,data_out, full, empty);

endmodule
