module ASYNC_FIFO_TOP 
#(parameter width = 8 , depth = 8,addr_width = $clog2(depth))(
    input wire i_w_clk, i_r_clk,
    input wire i_w_rstn, i_r_rstn,
    input wire i_w_inc, i_r_inc,
    input wire [width - 1 : 0] i_w_data,
    output wire o_full, o_empty,
    output wire [width - 1 : 0] o_r_data
);

    wire [addr_width-1:0] w_addr, r_addr;
    wire [addr_width:0] rptr, wptr;
    wire [addr_width:0] rq2_rptr, rq2_wptr;
    //
    //wire [width-1:0] i_w_data_sync;

    //localparam addr_width = $clog2(depth);

    Double_ff_sync #(.width (addr_width + 1) ) sync_w2r (
        .clk(i_r_clk),
        .rst(i_r_rstn),
        .data_in(wptr),
        .data_sync(rq2_wptr)
    );

    Double_ff_sync #(.width (addr_width + 1) ) sync_r2w (
        .clk        (i_w_clk),
        .rst        (i_w_rstn),
        .data_in    (rptr ),
        .data_sync  (rq2_rptr)
    );

    FIFO_MEM #( .width(width), .depth(depth)) fifo_mem (
        .i_w_clk(i_w_clk),
        .o_full(o_full),
        .i_w_inc(i_w_inc),
        .r_addr(r_addr),
        .w_addr(w_addr),
        .i_w_data(i_w_data),
        .o_r_data(o_r_data)
    );

    FIFO_RD #(.depth(depth) ) fifo_rd (
        .i_r_clk(i_r_clk),
        .i_r_rstn(i_r_rstn),
        .i_r_inc(i_r_inc),
        .rq2_wptr(rq2_wptr),
        .r_addr(r_addr),
        .rptr(rptr),
        .o_empty(o_empty)
    );

    FIFO_WR #( .depth(depth) ) fifo_wr (
        .i_w_clk(i_w_clk),
        .i_w_rstn(i_w_rstn),
        .i_w_inc(i_w_inc),
        .rq2_rptr(rq2_rptr),
        .w_addr(w_addr),
        .wptr(wptr),
        .o_full(o_full)
    );

endmodule
