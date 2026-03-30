module router_top ( input clock,
                    input resetn,
                    input read_enb_0,
                    input read_enb_1,
                    input read_enb_2,
                    input [7:0] data_in,
                    input pkt_valid,
                    output [7:0] data_out_0,
                    output [7:0] data_out_1,
                    output [7:0] data_out_2,
                    output valid_out_0,
                    output valid_out_1,
                    output valid_out_2,
                    output error,
                    output busy);

// internal wires
wire [2:0] write_enb;
wire [7:0] dout;


//without declaring the wires here we can directly use it in the port declaration, that is known as implicit declaration.
router_fifo FIFO_0 (// input ports
                    .clock      (clock),
                    .resetn     (resetn),
                    .write_enb  (write_enb[0]),
                    .soft_reset (soft_reset_0),
                    .read_enb   (read_enb_0),
                    .data_in    (dout),
                    .lfd_state  (lfd_state),

                    //output ports
                    .empty      (empty_0),
                    .full       (full_0),
                    .data_out   (data_out_0));

router_fifo FIFO_1 (// input ports
                    .clock      (clock),
                    .resetn     (resetn),
                    .write_enb  (write_enb[1]),
                    .soft_reset (soft_reset_1),
                    .read_enb   (read_enb_1),
                    .data_in    (dout),
                    .lfd_state  (lfd_state),

                    //output ports
                    .empty      (empty_1),
                    .full       (full_1),
                    .data_out   (data_out_1));

router_fifo FIFO_2 (// input ports
                    .clock      (clock),
                    .resetn     (resetn),
                    .write_enb  (write_enb[2]),
                    .soft_reset (soft_reset_2),
                    .read_enb   (read_enb_2),
                    .data_in    (dout),
                    .lfd_state  (lfd_state),

                    //output ports
                    .empty      (empty_2),
                    .full       (full_2),
                    .data_out   (data_out_2));

router_fsm FSM (//input ports
                .clock          (clock),
                .resetn         (resetn),
                .pkt_valid      (pkt_valid),
                .data_in        (data_in[1:0]),
                .parity_done    (parity_done),
                .fifo_full      (fifo_full),
                .soft_reset_0   (soft_reset_0),
                .soft_reset_1   (soft_reset_1),
                .soft_reset_2   (soft_reset_2),
                .low_pkt_valid  (low_pkt_valid),
                .fifo_empty_0   (empty_0),
                .fifo_empty_1   (empty_1),
                .fifo_empty_2   (empty_2),

                //output ports
                .busy           (busy),
                .detect_addr    (detect_addr),
                .ld_state       (ld_state),
                .laf_state      (laf_state),
                .full_state     (full_state),
                .write_enb_reg  (write_enb_reg),
                .rst_int_reg    (rst_int_reg),
                .lfd_state      (lfd_state));

router_sync SYNCHRONISER (  // input ports
                            .clock          (clock),
                            .resetn         (resetn),
                            .detect_addr    (detect_addr),
                            .write_enb_reg  (write_enb_reg),
                            .data_in        (data_in[1:0]),
                            .read_enb_0     (read_enb_0),
                            .read_enb_1     (read_enb_1),
                            .read_enb_2     (read_enb_2),
                            .empty_0        (empty_0),
                            .empty_1        (empty_1),
                            .empty_2        (empty_2),
                            .full_0         (full_0),
                            .full_1         (full_1),
                            .full_2         (full_2),

                            //output ports
                            .write_enb      (write_enb),
                            .fifo_full      (fifo_full),
                            .soft_reset_0   (soft_reset_0),
                            .soft_reset_1   (soft_reset_1),
                            .soft_reset_2   (soft_reset_2),
                            .valid_out_0    (valid_out_0),
                            .valid_out_1    (valid_out_1),
                            .valid_out_2    (valid_out_2));


router_reg REGISTER (  //input ports
                        .clock      (clock),
                        .resetn     (resetn),
                        .pkt_valid  (pkt_valid),
                        .data_in    (data_in),
                        .fifo_full  (fifo_full),
                        .rst_int_reg(rst_int_reg),
                        .detect_addr(detect_addr),
                        .ld_state   (ld_state),
                        .laf_state  (laf_state),
                        .full_state (full_state),
                        .lfd_state  (lfd_state),
                        // output ports
                        .parity_done    (parity_done),
                        .low_pkt_valid  (low_pkt_valid),
                        .err            (error),
                        .dout           (dout)); 
endmodule