module FIFO_RD #(
    parameter depth = 8 , addr_width = $clog2(depth)) 
(
    //inputs
    input wire                      r_clk, r_rst,
    input wire                      rinc ,
    input wire [addr_width : 0]     rq2_wptr ,

    //outputs
    output wire [addr_width - 1 : 0]r_addr ,
    output wire [addr_width : 0]rptr, 
    output wire empty

);
    
    //internal wires
    reg [addr_width : 0] binary_rptr;
    wire[addr_width : 0] gray_rptr  ;
    wire [addr_width : 0]binary_rq2_wptr;



    //behaviral code
    always @(posedge r_clk, negedge r_rst ) begin
        if (!r_rst) begin
            binary_rptr  <= 'b0;
        end else if( rinc && (!empty) ) begin
            binary_rptr <= binary_rptr + 1;
        end
    end


    //converting binary to gray
    assign gray_rptr = (binary_rptr >> 1) ^ binary_rptr ;

    //gray to binary converter  
    // assign binary_rq2_wptr = (rq2_wptr >> 1) ^ rq2_wptr ;
    //read ptr
    assign rptr  = gray_rptr ;
    
    //empty flag
    assign empty = (rptr == rq2_wptr);


    //read address of fifo
    assign r_addr = binary_rptr[addr_width - 1 : 0];
   
endmodule