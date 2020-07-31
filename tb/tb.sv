
module tb ();
    
    logic clk = 1'b0;
    logic rstn = 1'b0;
    
    logic [127:0] plainTextData = 128'h0;
    logic         plainTextData_valid = 1'b0;
    logic [127:0] key = 128'h0;
    
    logic [127:0] cipherData;
    logic         cipherData_valid;
    

    initial begin
        rstn = 1'b0;
        #(1us) rstn = 1'b1;
        run_test;
        $stop;
    end
    
    always #(4167ps) clk = ~clk;
    
    
    
    
    aes128_enc dut(
                        .clk_i        ( clk                   ),
                        .rstn_i       ( rstn                  ),
                                
                        .data_i       ( plainTextData         ),
                        .key_i        ( key                   ),
                        .valid_i      ( plainTextData_valid   ),
                                
            
                        .data_o       ( cipherData            ),
                        .valid_o      ( cipherData_valid      )
                                
                    );
    
    
    task run_test;
        repeat (10) @(posedge clk);
        plainTextData = 128'h000102030405060708090a0b0c0d0e0f;//{$urandom, $urandom, $urandom, $urandom};
        key  = 128'h00112233445566778899aabbccddeeff;
        plainTextData_valid = 1'b1;
        @(posedge clk);
        plainTextData = 128'h0;
        key  = 128'h0;
        plainTextData_valid = 1'b0;
        wait(cipherData_valid);
        #100ns;
    endtask

endmodule