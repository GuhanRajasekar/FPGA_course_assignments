module output_mapping(
input signed [19:0] x, 
input signed [19:0] y,
input [2:0] quadrant_loc,
output reg signed [19:0] x_res,
output reg signed [19:0] y_res
    );
    always@(*)
    begin
        
//        if (quadrant_loc == 3'd1)
//        begin
//            x_res = x;
//            y_res = y;
//        end
//        else 
        if (quadrant_loc == 3'd2)
        begin
            x_res = -y;
            y_res = x;
        end
        else if (quadrant_loc == 3'd3)
        begin
            x_res = -x;
            y_res = -y;
        end
//        else if (quadrant_loc == 3'd4)
//        begin
//            x_res = x;
//            y_res = y;
//        end
        else // including both 1st and 4th quadrant
        begin
            x_res = x;
            y_res = y;
        end
        
    end
    
endmodule
