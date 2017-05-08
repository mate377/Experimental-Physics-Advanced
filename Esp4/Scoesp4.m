%tempo di dimezzamento
thalf=5.27145;
%attività al momento della fabbricazione
N0=403300
%attività misurata
N=61000;
%efficienza geometrica
eg=(2.54*3)^2/(16*(25)^2);
%attività stimata il 28/04/17
Nt=N/(0.18*0.0058*1000);
%TEMPO Trascoros
T=-thalf*log(Nt/N0)/log(2)
mesi=0.7*365;
