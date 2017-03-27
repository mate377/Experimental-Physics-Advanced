clear;

%% MISURE PRELIMINARI
m=9.1094*10^(-31); %massa elettrone
k=1.3806*10^(-23);%costante boltzman
h=6.6260*10^(-34) ;%costatnte planlk
q=1.6021*10^(-19) ;%elctric charge
e0=8.8542*10^(-12);

lf=md(1.90*10^-2,0.5*10^-2); %lunghezza filamento1 m
dim=md(205*10^-6,5*10^-6); %diametro filamento1 m

r4w=md(0.84,0.01); %resitenza a 4 fili ohm
l4w=md(0.43,0.01); %lunghezza filamento campione 4 fili metri

syms R d l;
Rho=symfun(R*pi*(d/2)^2/l,[R d l]);
rho=md.exprInc(Rho,[r4w dim l4w]); % da confrontare con tungsteno
% exprInc fa anche vettori? check!

syms srho;
Rfil=symfun(srho*l/(pi*(d/2)^2),[srho d l]);
rfil=md.exprInc(Rfil,[rho dim lf]);

rtot=md(0.254,0.001); %resistenza totale fili+filamento ohm
rwire=rtot-rfil; %resistenza fili ohm

%% SERIE DATI PRIMA SESSIONE

% preparo le due funzioni simboliche
syms rt r
STr=symfun(1700/9*rt/r+1000/9,[rt r]);  % per T(n)r
ST=symfun(rt/(r*0.0059)+300,[rt r]);    % per T(n)


rt1fil=2.675/4.005-rwire;
T1r=md.exprInc(STr,[rt1fil rfil]); % temperatura K
T1=md.exprInc(ST,[rt1fil rfil]);

rt2fil=2.476/3.806-rwire;
T2r=md.exprInc(STr,[rt2fil rfil]); % temperatura K
T2=md.exprInc(ST,[rt2fil rfil]);

rt3fil=2.572/3.9-rwire;
T3r=md.exprInc(STr,[rt3fil rfil]); % temperatura K
T3=md.exprInc(ST,[rt3fil rfil]);

rt4fil=2.378/3.71-rwire;
T4r=md.exprInc(STr,[rt4fil rfil]); % temperatura K
T4=md.exprInc(ST,[rt4fil rfil]);


%Va in Volt, Ic in ampere
Va1=md([3.5,         5.1,  7.0  8.3,     9.5         10.2,       11.0,       13.0,  30.0, 50.0],0.1);
Ic1=md([0.000077, 0.000130, 0.000200, 0.000230, 0.000239, 0.000242, 0.000243 0.000250, 0.000261, 0.000271],10^-6);
Va2=md([1.0,      1.5,       2.0         2.5,      3.0,     3.5,  4.0 ,4.5        5.1,      7.0  8.3,     9.5 ],0.1);
Ic2=md([0.000006, 0.000014 , 0.000021, 0.000030, 0.000036, 0.000041,    0.000045,0.000046,0.000045 0.000047, 0.000048, 0.000049],10^-6);
Va3=md([0.5    1      1.5    2      2.5    3.0   3.5    4    4.7    5.1   5.5     6      10.8   16    26    38.5  50.0],0.1);
Ic3=md([0.003  0.009  0.017  0.028  0.038  0.05  0.062 0.076 0.093  0.100   0.104 0.104  0.112  0.115 0.118 0.122 0.124]./1000,10^-6);
Va4=md([0.4 0.9 1.3 1.7 2.6  3.2   3.8 4.1   4.6  5.1   8.9  13.2 23.3  33.3 50.6   ],0.1);
Ic4=md([1.2 3.6 7  10.8 17.8 19.5  20  20.2  20.5 20.8  21.8 22.3 23    23.5 24.1  ]./10^6,10^-6);

%% nuova serie
ns.P=md(2.7*10^(-6),0.1*10^-6); %mbar
ns.Vg=md(50,0.1); %Volt
% richardson
ns.r.vf=md([2 2.2 2.1 2.05 2.08 2.120 2.160 2.3 2.25 2.301 2.350 2.4 2.5 2.6 2.7 2.8 2.9 3],0.001);
ns.r.If=md([3.333 3.546 3.435 3.383 3.420 3.465 3.509 3.663 3.605 3.655 3.7 3.76 3.875 3.97 4.067 4.164 4.262 4.356],0.01);
ns.r.Ia=md([0 3 1.1 0.7 1 1.5 2.2 8.8 5.6 8.9 14 22.8 60 148 347 743 1436 2535].*10^-6,1*10^-6);

%child 
ns.c.Vf1 = md(2.8,0.001); 
ns.c.If1 = md(4.166,0.001);

ns.c.Va1 = md([0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22.5, 25, 30, 35, 40, 45, 50],0.1);
ns.c.Ie1 = md([3.3, 11, 20, 31, 45, 61.8, 78.7, 98.5, 118, 141, 166, 190, 214, 238, 265, 288, 313, 339, 364, 392, 444, 499, 545, 592, 633, 664, 690, 702, 710, 717, 730, 740, 755, 762, 761, 782, 791].*10^(-6),0.1*10^-6);
md.errorbar(ns.c.Va1,ns.c.Ie1,'+k','CapSize',0);
