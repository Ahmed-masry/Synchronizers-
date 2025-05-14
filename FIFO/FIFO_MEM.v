module FIFO_MEM 
#(parameter width = 8 , depth = 8 , addr_width = $clog2(depth))(
input wire                          w_clk,
input wire                          full, winc,
input wire  [addr_width - 1: 0 ]    r_addr, w_addr,
input wire  [width - 1: 0 ]         w_data, 
output wire [width - 1: 0 ]         r_data 

);
//internal wires
wire  wclken = winc & (~full);

//register file
reg [width - 1: 0] fifo_mem [ 0 : depth -  1 ];

//code
always @(posedge w_clk)
begin
    if (wclken) begin
        fifo_mem [w_addr] <= w_data;
    end    
end

assign r_data = fifo_mem[r_addr];

endmodule