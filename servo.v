module servo(input clk,input wire[7:0] RxD_data,output reg servo);
//Deklaracija varijabli
reg[25:0] brojac; //Brojač
reg[25:0] impuls; //Vrijednost gornje granice u zavisnosti od
//pritiska na taster
reg[25:0] izlaz; //Pomoćni registar za izlaz na servo motor

reg [7:0] storage=0;
reg [7:0] position=0;
//Provjera stanja odgovarajućih tastera, te generisanje signala servo motora
//PWM SERVO
initial impuls=25'd50000;
always @(posedge clk)
begin
if( brojac<impuls) //Generisanje impulsa
begin
izlaz<=25'b1;
brojac<=brojac+25'd1;
end
else if( brojac >= impuls && brojac < impuls+25'd1000000) //Pauza 20ms
begin
brojac<=brojac+25'd1;
izlaz<=25'b0;
end
else //Resetovanje brojača
begin
brojac<=25'd0;
end
end


always@( posedge clk )
begin
if(RxD_data>0 &&RxD_data<17)
begin 
//position=RxD_data;
position[0]=RxD_data[0];
position[1]=RxD_data[1];
position[2]=RxD_data[2];
position[3]=RxD_data[3];
position[4]=RxD_data[4];
position[5]=RxD_data[5];
position[6]=RxD_data[6];
position[7]=RxD_data[7];

end
else if (RxD_data>102 && RxD_data<114)
begin 
//storage=RxD_data;
storage[0]=RxD_data[0];
storage[1]=RxD_data[1];
storage[2]=RxD_data[2];
storage[3]=RxD_data[3];
storage[4]=RxD_data[4];
storage[5]=RxD_data[5];
storage[6]=RxD_data[6];
storage[7]=RxD_data[7];

end
if((storage==103 && position==3)||(storage==104 && position==4)||(storage==105 && position==5)||
  (storage==107 && position==7)||(storage==108 && position==8)||(storage==109 && position==9) ||
  (storage==111 && position==11)||(storage==112 && position==12)||(storage==113 && position==13))
begin
impuls<=25'd35000;//0.7ms
servo<=izlaz; //Impuls sirine 1.3ms
end
else 
impuls<=25'd110000;//Impuls sirine 2.2mm
servo<=izlaz;
begin

end
end




endmodule
