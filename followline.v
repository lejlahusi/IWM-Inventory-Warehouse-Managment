module followline(input clk, input lt1,input lt2,input lt3,output reg in1,output reg in2,output reg in3,output reg in4,output wire ena,output wire enb);


motori(clk,ena,enb);
always @ (posedge clk)
begin
if(lt2)
begin
move_f(in1,in2,in3,in4);
end
else if(lt1)
begin
move_right(in1,in2,in3,in4);
end
else if(lt3)
begin 
move_left(in1,in2,in3,in4);
end
else if(lt1&&lt2&&lt3)
begin 
stop(in1,in2,in3,in4);
end


end


task move_left;
output in1,in2,in3,in4;
begin
in1<=1'b1;
in2<=1'b0;
in3<=1'b1;
in4<=1'b0;
end
endtask
task move_right;
output in1,in2,in3,in4;
begin
in1<=1'b0;
in2<=1'b1;
in3<=1'b0;
in4<=1'b1;
end
endtask

task move_f;
output in1,in2,in3,in4;
begin
in1<=1'b1;
in2<=1'b0;
in3<=1'b0;
in4<=1'b1;
end
endtask

task stop;
output in1,in2,in3,in4;
begin
in1<=1'b1;
in2<=1'b1;
in3<=1'b1;
in4<=1'b1;
end
endtask


endmodule 