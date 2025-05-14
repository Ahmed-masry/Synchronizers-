vlib work
vlog -sv Double_ff_sync.sv ASYNC_FIFO_TOP.v FIFO_MEM.v FIFO_RD.v FIFO_WR.v                                                                                                            

vsim -voptargs=+accs work.ASYNC_FIFO_TOP_TB
add wave *
run -all