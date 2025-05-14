`timescale 1ns/1ps

module ASYNC_FIFO_TOP_TB;

    parameter CLK_PERIOD2 = 25;
    parameter CLK_PERIOD1 = 10;
    parameter width = 8;
    parameter depth = 8;
    integer  i;
    reg w_clk, r_clk, w_rst, r_rst;
    reg winc, rinc;
    reg [width-1:0] w_data;
    wire [width-1:0] r_data;
    wire full, empty;

    ASYNC_FIFO_TOP #(width, depth) dut (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .w_rst(w_rst),
        .r_rst(r_rst),
        .winc(winc),
        .rinc(rinc),
        .w_data(w_data),
        .full(full),
        .empty(empty),
        .r_data(r_data)
    );

    // Clock generation
    always #(CLK_PERIOD1/2) w_clk = ~w_clk;
    always #(CLK_PERIOD2/2) r_clk = ~r_clk;

    initial begin
        // Initialize signals
        w_clk = 0;
        r_clk = 0;
        w_rst = 1;
        r_rst = 1;
        winc = 0;
        rinc = 0;
        w_data = 0;

        // Reset the design
        #10;
        w_rst = 0;
        r_rst = 0;
        #10;
        w_rst = 1;
        r_rst = 1;

        // Write some data into the FIFO
       /* winc = 1;
        w_data = 8'hA1;
        #10;
        w_data = 8'hB2;
        #10;
        w_data = 8'hC3;
        #10;
        w_data = 8'hD4;
        #10;
        winc = 0;

        // Read the data from the FIFO
        rinc = 1;
        #20;
        rinc = 0;

        #100;
*/
        for (i = 1 ; i< 40 ; i = i + 1 ) begin
            winc = 1;
            rinc = 1;
            w_data = i;
            #10;
            
        end
         for (i = 1 ; i< 40 ; i = i + 1 ) begin
            winc = 1;
            rinc = 0;
            w_data = i;
            #10;
            
        end
         for (i = 1 ; i< 40 ; i = i + 1 ) begin
            winc = 0;
            rinc = 1;
            w_data = i;
            #10;
            
        end
        //h the simulation
        $stop;
    end

   
endmodule
