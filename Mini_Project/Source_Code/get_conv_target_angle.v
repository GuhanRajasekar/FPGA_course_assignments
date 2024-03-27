module get_conv_target_angle(
input signed [19:0] target_angle,
output reg signed [19:0] target_angle_conv,
output reg [2:0] quadrant_loc
    );
    
    always@(*)
    begin
        
//        if ((target_angle > {16'd0,4'd0}) && (target_angle <= {16'd90,4'd0}))
//            begin
//                target_angle_conv = target_angle;
//                quadrant_loc = 3'd1;
//            end
            
//        else 
        if ((target_angle >{16'd90,4'd0}) && (target_angle <= {16'd180,4'd0}))
            begin
                target_angle_conv = target_angle - {16'd90,4'd0};
                quadrant_loc = 3'd2;
            end
            
        else if ((target_angle >{16'd180,4'd0}) && (target_angle <= {16'd270,4'd0}))
            begin
                target_angle_conv = target_angle - {16'd180,4'd0};
                quadrant_loc = 3'd3;
            end
        
        else if ((target_angle > {16'd270,4'd0}) && (target_angle <= {16'd360,4'd0}))
            begin
                target_angle_conv = target_angle - {16'd360,4'd0};
                quadrant_loc = 3'd4;
            end
        else
            begin
                target_angle_conv = target_angle;
                quadrant_loc = 3'd1;
            end 
        
    end
    
endmodule
