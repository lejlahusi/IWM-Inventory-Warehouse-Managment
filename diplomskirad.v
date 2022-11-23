module diplomskirad(input clk,
output reg[7:0] diode, 
output reg led,
output wire m1,
output wire m2, 
output wire m3, 
output wire m4, 
output wire ena,
output wire enb,
output wire servo,
input RxD,
input RXD2,
input lt1,
input lt2,
input lt3);

//UART_RX variables
wire RxD_data_ready;
wire [7:0] RxD_data;

//.........................

//UART_RX2 variables
wire RxD2_data_ready;
wire [7:0] RxD2_data;

reg [7:0] storage=0;
reg [7:0] position=0;

reg [29:0] counter=30'd0;

reg [29:0] cntl1=30'd0;

reg [29:0] cntbottom=30'd250000000;
reg [29:0] cnttop=30'd500000000;
reg [29:0] cnt3=30'd0;
reg [29:0] cnt4=30'd0;
reg [29:0] cnt5=30'd0;

reg [29:0] cnt7=30'd0;
reg [29:0] cnt8=30'd0;
reg [29:0] cnt9=30'd0;

reg [29:0] cnt11=30'd0;
reg [29:0] cnt12=30'd0;
reg [29:0] cnt13=30'd0;


//.........................

//DC Motors variables


motori(clk,ena,enb);
uartrx(clk,RxD,RxD_data_ready,RxD_data);
uartrx2(clk,RxD2,RxD2_data_ready,RxD2_data);
servo(clk,RxD_data,servo);
//followline(clk,lt1,lt2,lt3,m1,m2,m3,m4,ena,enb);



always @(posedge clk)
begin

if(RxD_data>0 &&RxD_data<17)
begin 
position=RxD_data;
/*position[0]=RxD_data[0];
position[1]=RxD_data[1];
position[2]=RxD_data[2];
position[3]=RxD_data[3];
position[4]=RxD_data[4];
position[5]=RxD_data[5];
position[6]=RxD_data[6];
position[7]=RxD_data[7];*/
diode[0]<=RxD_data[0];
diode[1]<=RxD_data[1];
diode[2]<=RxD_data[2];
diode[3]<=RxD_data[3];
diode[4]<=RxD_data[4];
diode[5]<=RxD_data[5];
diode[6]<=RxD_data[6];
diode[7]<=RxD_data[7];

end
if (RxD2_data)//>102 && RxD2_data<114)
begin 
storage=RxD2_data;
led=1;
/*storage[0]=RxD_data[0];
storage[1]=RxD_data[1];
storage[2]=RxD_data[2];
storage[3]=RxD_data[3];
storage[4]=RxD_data[4];
storage[5]=RxD_data[5];
storage[6]=RxD_data[6];
storage[7]=RxD_data[7];*/
diode[0]<=RxD2_data[0];
diode[1]<=RxD2_data[1];
diode[2]<=RxD2_data[2];
diode[3]<=RxD2_data[3];
diode[4]<=RxD2_data[4];
diode[5]<=RxD2_data[5];
diode[6]<=RxD2_data[6];
diode[7]<=RxD2_data[7];

end

if(storage)
//||(RxD2_data[0]==0 &&RxD2_data[1]==1&&RxD2_data[2]==0&&RxD2_data[3]==0)
//||(RxD2_data[0]==1 &&RxD2_data[1]==1&&RxD2_data[2]==0&&RxD2_data[3]==0)
//)
begin
/*diode[0]<=1;
diode[1]<=1;
diode[2]<=1;
diode[3]<=1;
diode[4]<=1;
diode[5]<=1;
diode[6]<=1;
diode[7]<=1;*/
/*diode[0]<=RxD_data[0];
diode[1]<=RxD_data[1];
diode[2]<=RxD_data[2];
diode[3]<=RxD_data[3];
diode[4]<=RxD_data[4];
diode[5]<=RxD_data[5];
diode[6]<=RxD_data[6];
diode[7]<=RxD_data[7];*/


if(position==1)
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4);
end

if(storage==8'd103||storage==8'd104||storage==8'd105)
begin


if(position==15)
begin
move_left(m1,m2,m3,m4);
//cnt(cntl1,cntl1);
end

if(storage==8'd103)
begin
	if(position==3)
	begin
		if (cnt3<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt3>cntbottom && cnt3<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt3>=cnttop)
		begin 
		cnt3=0;
		end
	cnt3=cnt3+1;
	end
	else if((position==4) || (position==5))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==8'd104)
begin
	if(position==4)
	begin 
//stop(m1,m2,m3,m4);
//cnt(cnt2,cntbottom,cnttop,cnt2);
		if (cnt4<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt4>cntbottom && cnt4<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt4>=cnttop)
		begin 
		cnt4=0;
		end
	cnt4=cnt4+1;
	end
	else if((position==3) || (position==5))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==105)
begin
	if (position==5)
	begin
		if (cnt5<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt5>cntbottom && cnt5<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt5>=cnttop)
		begin 
		cnt5=0;
		end
	cnt5=cnt5+1;
	end
else if((position==3) ||(position==4))
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4); 
end
end



end



end
else if(storage==107||storage==108||storage==109)
begin 
	if (position==15)
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4);
	end
	if(position==6)
	begin
	move_left(m1,m2,m3,m4);
	end

	if(storage==8'd107)
begin
	if(position==7)
	begin
		if (cnt7<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt7>cntbottom && cnt7<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt7>=cnttop)
		begin 
		cnt7=0;
		end
	cnt7=cnt7+1;
	end
	else if((position==8) || (position==9))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==8'd108)
begin
	if(position==8)
	begin 
//stop(m1,m2,m3,m4);
//cnt(cnt2,cntbottom,cnttop,cnt2);
		if (cnt8<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt8>cntbottom && cnt8<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt8>=cnttop)
		begin 
		cnt8=0;
		end
	cnt8=cnt8+1;
	end
	else if((position==7) || (position==9))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==109)
begin
	if (position==9)
	begin
		if (cnt9<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt9>cntbottom && cnt9<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt9>=cnttop)
		begin 
		cnt9=0;
		end
	cnt9=cnt9+1;
	end
else if((position==7) ||(position==8))
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4); 
end
end


else if (storage==111||storage==112||storage==113)
begin 

	if (position==15 || position==6)
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4);
	end
	if(position==10)
	begin
	move_left(m1,m2,m3,m4);
	end

	if(storage==8'd111)
begin
	if(position==11)
	begin
		if (cnt11<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt11>cntbottom && cnt11<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt11>=cnttop)
		begin 
		cnt11=0;
		end
	cnt11=cnt11+1;
	end
	else if((position==12) || (position==13))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==8'd112)
begin
	if(position==12)
	begin 
//stop(m1,m2,m3,m4);
//cnt(cnt2,cntbottom,cnttop,cnt2);
		if (cnt12<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt12>cntbottom && cnt12<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt12>=cnttop)
		begin 
		cnt12=0;
		end
	cnt12=cnt12+1;
	end
	else if((position==111) || (position==113))
	begin 
	line(lt1,lt2,lt3,m1,m2,m3,m4); 
	end
end

else if(storage==113)
begin
	if (position==13)
	begin
		if (cnt13<cntbottom)
		begin
		stop(m1,m2,m3,m4);
		end
		else if(cnt13>cntbottom && cnt13<cnttop)
		begin 
		line(lt1,lt2,lt3,m1,m2,m3,m4); 
		end
		else if(cnt13>=cnttop)
		begin 
		cnt13=0;
		end
	cnt13=cnt13+1;
	end	
else if((position==11) ||(position==12))
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4); 
end

end

end





end



else if(storage==0)
begin 
stop(m1,m2,m3,m4);
end

if(position==14)
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4);
end

if(position==16)
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4);
cnt3=0;
cnt4=0;
cnt5=0;


cnt7=0;
cnt8=0;
cnt9=0;

cnt11=0;
cnt12=0;
cnt13=0;
storage=0;
end


end
//assign position=0;

task counterleft;
input cntleft;
output cntleftoutput;
begin 
if (cntleft<50000000)
begin 
move_left(m1,m2,m3,m4);
end
else if(cntleft>50000000&&cntleft<205000000)
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4);
end
else if (cntleft>205000000)
begin 
cntleftoutput=0;
end
cntleftoutput=cntleftoutput+1;
end
endtask

task cnt; 
input counter,bottomlimit,upperlimit;
output count;
begin
if (counter<bottomlimit)
begin
stop(m1,m2,m3,m4);
end
else if(counter>bottomlimit &&counter<upperlimit)
begin 
line(lt1,lt2,lt3,m1,m2,m3,m4); 
end
else if(counter>=upperlimit)
begin 
count=0;
end
count=count+1;

end 
endtask

task line;
input lt1,lt2,lt3;
output in1,in2,in3,in4;
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
endtask


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



