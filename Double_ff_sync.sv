module Double_ff_sync 
#(parameter width = 4) (
    input wire                  clk , rst,
    input wire [width - 1:0]    data_in ,
    output reg [width - 1:0]    data_sync  
);
    reg [width - 1 : 0] meta_ff;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            meta_ff     <= 'b0;
            data_sync   <= 'b0;
        end else begin
            meta_ff     <= data_in;
            data_sync   <= meta_ff;
        end 
    end
endmodule