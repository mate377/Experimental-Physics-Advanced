%clear all
%close all
%costanti fisiche
m=9.1094*10^(-31) ;%massa elettrone
k=1.3806*10^(-23);%costante boltzman
h=6.6260*10^(-34) ;%costatnte planlk
q=1.6021*10^(-19) ;%elctric charge
e0=8.8542*10^(-12);% permaeabilit� del vuoto
%dati sperimentali
alpha= 10/1700;  %(espansione termica relativa tungsteno
%dobbiamo stimarare la resitenza del filamento, per farlo ne misuriamo l e
%dim

l=1.90*10^-2; %lunghezza filamento interno cm
dl=0.5*10^-2;
dim=205*10^-6;  %diametro filo (sia interno che esterno(filo sciolto su cui facciamo misure))metri
ddim=5*10^-6;

%misure filamento esterno(filamento campione)

r4w=0.84; %resitenza a 4 fili ohm
dr4w=0.01; 
l4w=0.43; %lunghezza filamento campione 4 fili metri
dl4w=0.01; %

%ro=r4w*(pi*(dim/2)^2)/l4w; %resistivit�

[ro,dro]=Sco1ro(r4w,dr4w,dim,ddim,l4w,dl4w);
%errrho = sqrt(((pi*(dim/2)^2)/l4w)^2*dr4w^2 + (r4w*(pi*dim/(2*l4w)))^2*ddim^2
%+ (r4w*(pi*(dim/2)^2)/l4w^2)^2*dl4w^2) %errore su ro calcolato a mano

%[ro,dro]= Sco-1-ro(r4w,dr4w,dim,ddim,l4w,dl4w)
%ho i dati per calcolare filamento

rfil=ro*l/(pi*(dim/2)^2);
[rfil,drfil]=Sco1fil(ro,dro,l,dl,dim,ddim);
%errR=sqrt((l/(pi*(dim/2)^2))^2*dro^2 + (ro/(pi*(dim/2)^2))^2*dl^2 +
%(8*ro*l/(pi*(dim)^3))^2*ddim^2)   %errore su rfilamento calcolata a mano

%adesso attiviamo la valvola,la pressione raggiuinta e di 1.4*10^-5 mbar

%misuriamo la resitenza totale del filamento e dei fili che portanano
%corrente al filamento, poi calcoleremo la resitenza dei fili (rwire) sottraendo
%rwire=rtot-rfil

rtot=0.254; %omh
drtot=0.001;
rwire=rtot-rfil;
drwire=drfil;
% 
% T=[800:50:3000];
% a=4*pi*m*q*(k^2/h^3)   % Costasnte di proporzionalit� 
% j=a.*(T^2)exp(/k*T) %


%verifichiamo la legge di child(teniamo fissa la caduta di potenziale sul filamento,
%cambiamo il potenziale tra catodo e anodo

%voltaggio filamento 2.675 +-0.001V,Ampere filamento 4.005 Av

rt1fil=2.675/4.005-rwire;
drt1fil=drfil;
%supponendo che la resistivit� sia stata misurata a 300k
%rifl/R300=alpha*dT
T1=rt1fil/(rfil*alpha)+300;
Va=[3.5,         5.1,  7.0  8.3,     9.5         10.2,       11.0,       13.0,  30.0, 50.0];%volt
DVa=0.1*ones(size(Va));
Ic=[0.000077, 0.000130, 0.000200, 0.000230, 0.000239, 0.000242, 0.000243 0.000250, 0.000261, 0.000271];%ampere
dIc=0.000001*ones(size(Va));



%seconda serie (2.476 volt- 3,806 ampere)

rt2fil=2.476/3.806-rwire;
T2=rt2fil/(rfil*alpha)+300;
Va2=[1.0,      1.5,       2.0         2.5,      3.0,     3.5,  4.0 ,4.5        5.1,      7.0  8.3,     9.5         ];
DVa2=0.1*ones(size(Va2));
Ic2=[0.000006, 0.000014 , 0.000021, 0.000030, 0.000036, 0.000041,    0.000045,0.000046,0.000045 0.000047, 0.000048, 0.000049];
dIc2=1*ones(size(Va2))/10^6;
%scatter(Va2,Ic2)
%terza serie (2.572-3.9)

rt3fil=2.572/3.9-rwire;
T3=rt3fil/(rfil*alpha)+300;  %temperatura stimata
Va3=[0 0.5    1      1.5    2      2.5    3.0   3.5    4    4.7    5.1   5.5     6      10.8   16    26    38.5  50.0];
DVa3=0.1*ones(size(Va3));
Ic3=[0 0.003  0.009  0.017  0.028  0.038  0.05  0.062 0.076 0.093  0.100   0.104 0.104  0.112  0.115 0.118 0.122 0.124]./1000;
dIc3=0.1*ones(size(Va3))./10^6;
%quarta serie (2.378-3.71)
rt4fil=2.378/3.71-rwire;
T4=rt4fil/(rfil*alpha)+300
Va4=[0 0.4 0.9 1.3 1.7 2.6  3.2   3.8 4.1   4.6  5.1   8.9  13.2 23.3  33.3 50.6   ];
DVa4=0.1*ones(size(Va4));
Ic4=[0 1.2 3.6 7  10.8 17.8 19.5  20  20.2  20.5 20.8  21.8 22.3 23    23.5 24.1  ]./10^6;
dIc4=0.1*ones(size(Va4))./10^6;


% hold on
% plot(Va,Ic,'+k','MarkerSize',12)
% plot(Va2,Ic2,'+g','MarkerSize',12)
% plot(Va3,Ic3,'+b','MarkerSize',12)
% plot(Va4,Ic4,'+r','MarkerSize',12)
% %ordine in funzione della temperatura T1>T3>T2>T4 ordine confermato dai
% %calcoli
% hold on

% herrorbar(Va,Ic,DVa,dIc)
% herrorbar(Va2,Ic2,DVa2,dIc2)
% herrorbar(Va3,Ic3,DVa3,dIc3)
% herrorbar(Va4,Ic4,DVa4,dIc4)
