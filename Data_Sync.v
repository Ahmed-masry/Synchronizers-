 module Data_Sync
 #(parameter width = 8 , num_stage = 4)(
input wire clk, rst  ,
input wire bus_en ,
input wire [width -1:0] unsync_bus,
output reg [width - 1:0] sync_bus,
output reg en_pulse
 );

reg [num_stage - 1 :0]multi_ff ;
reg multi_ff_out;
wire pulse_gen_out;
wire comb_sync_bus;
always @(posedge clk ,negedge rst) begin
    if (!rst) begin
        multi_ff <= 'b0;
        multi_ff_out<= 'b0;
        sync_bus <= 'b0;
    end else begin
        multi_ff <= {bus_en,multi_ff[num_stage- 1:1]};
        multi_ff_out <= multi_ff[0];
        en_pulse <= pulse_gen_out;
        sync_bus <= comb_sync_bus; 
    end
end

assign pulse_gen_out = (!multi_ff_out) & (multi_ff[0]);
assign comb_sync_bus = (pulse_gen_out)? unsync_bus:sync_bus;

endmodule