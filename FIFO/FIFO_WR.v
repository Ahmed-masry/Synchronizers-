module FIFO_WR #(
    parameter depth = 8 , addr_width = $clog2(depth)) 
(
    input  wire w_clk, w_rst,//
    input  wire winc ,       //
    input  wire [addr_width : 0]rq2_rptr ,
    output wire [addr_width - 1 : 0]w_addr ,
    output wire [addr_width : 0]wptr, 
    output wire full

);

    //internal wires
    reg [addr_width:0]binary_wptr ;
    wire[addr_width : 0]gray_wptr ;
    wire [addr_width : 0]binary_rq2_rptr;


    always @(posedge w_clk, negedge w_rst ) begin
        if (!w_rst) begin
            binary_wptr  <= 'b0;
        end else if( winc && (!full) ) begin
            binary_wptr <= binary_wptr + 1;
        end
    end


    //binary to gray converter
    assign gray_wptr = (binary_wptr >> 1) ^ binary_wptr ;
    //gray to binary converter  
  //  assign binary_rq2_rptr = (rq2_rptr >> 1) ^ rq2_rptr ;
    //write ptr
    assign wptr  = gray_wptr ;

    //full flag
    assign full = ( rq2_rptr[addr_width] != (wptr[addr_width])) && ((rq2_rptr[addr_width-1]) != (wptr[addr_width-1]) )&& ((rq2_rptr[addr_width -2:0]) == (wptr[addr_width-2:0]) );


 
    assign w_addr = binary_wptr[addr_width - 1 : 0];




endmodule









