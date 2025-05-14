module RST_Synchronizer
 #(
    parameter num_stage = 4
) (
    input wire clk, rst,
    output wire sync_rst
);
    reg [num_stage - 1 :0 ] multi_ff ;
always @(posedge clk ,negedge rst) begin
    if (!rst) begin
        multi_ff <= 'b0;
    end else begin
        multi_ff <= {1'b1,multi_ff[num_stage- 1:1]}; 
    end
end

assign sync_rst = multi_ff[0];
endmodule