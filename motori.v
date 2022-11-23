module motori(input clk,output reg ena,output reg enb);
reg[40:0] i;
reg[25:0] brojac; //Brojač
reg[45:0] impuls; //Vrijednost gornje granice u zavisnosti od
//reg[25:0] izlaz;
//650 000
initial impuls<=45'd450000;
always @(posedge clk) 
begin
if( brojac<impuls ) //Generisanje impulsa
begin
//izlaz<=1'b1;
ena<=1'b1;
enb<=1'b1;
brojac<=brojac+25'd1;
end
else if( brojac >= impuls && brojac < impuls+25'd1000000) //Pauza 20ms
begin
brojac<=brojac+25'd1;
//izlaz<=1'b0;
ena<=1'b0;
enb<=1'b0;
end
else //Resetovanje brojača
begin
brojac<=25'd0;
end
end




endmodule
