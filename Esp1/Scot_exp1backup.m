%costanti fisiche
m=9.1094*10^(-31) ;%massa elettrone
k=1.3806*10^(-23);%costante boltzman
h=6.6260*10^(-34) ;%costatnte planlk
q=1.6021*10^(-19) ;%elctric charge
e0=8.8542*10^(-12);% permaeabilità del vuoto
%dati sperimentali

%dobbiamo stimarare la resitenza del filamento, per farlo ne misuriamo l e
%dim

l=1.90*10^-2; %lunghezza filamto interno cm
dl=0.5;
dim=205*10^-6;  %diametro filo (sia interno che esterno(filo sciolto su cui facciamo misure))metri
ddim=5*10^-6;

%misure filamento esterno(filamento campione)

r4w=0.84; %resitenza a 4 fili ohm
dr4w=0.01; 
l4w=0.43; %lunghezza filamento campione 4 fili metri
dl4w=0.01; %

ro=r4w*(pi*(dim/2)^2)/l4w %reisitività

%ho i dati per calcolare rfilamento

rfil=ro*l/(pi*(dim/2)^2)


%adesso attiviamo la valvola,la pressione raggiuinta e di 1.4*10^-5 mbar

%misuriamo la resitenza totale del filamento e dei fili che portanano
%corrente al filamento, poi calcoleremo la resitenza dei fili (rwire) sottraendo
%rwire=rtot-rfil

rtot=0.254; %omh
drtot=0.001;

% 
% T=[800:50:3000];
% a=4*pi*m*q*(k^2/h^3)   % Costasnte di proporzionalità 
% j=a.*(T^2)exp(/k*T) %


%verifichiamo la legge di child(teniamo fissa la caduta di potenziale sul filamento,
%cambiamo il potenziale tra catodo e anodo

%voltaggio filamento 2.675 +-0.001V,Ampere filamento 4.005 Av
Va=[3.5,         5.1,  7.0  8.3,     9.5         10.2,       11.0,       13.0,  30.0, 50.0];%volt
%DVa=[];
Ic=[0.000077, 0.000130, 0.000200, 0.000230, 0.000239, 0.000242, 0.000243 0.000250, 0.000261, 0.000271];%ampere
%dIc=[];



%seconda serie (2.476 volt- 3,806 ampere)

Va2=[1.0,      1.5,       2.0         2.5,      3.0,     3.5,  4.0 ,4.5        5.1,      7.0  8.3,     9.5         ]

Ic2=[0.000006, 0.000014 , 0.000021, 0.000030, 0.000036, 0.000041,    0.000045,0.000046,0.000045 0.000047, 0.000048, 0.000049]

%scatter(Va2,Ic2)
%terza serie (2.572-3.9)

Va3=[0 0.5    1      1.5    2      2.5    3.0   3.5    4    4.7    5.1   5.5     6      10.8   16    26    38.5  50.0]
Ic3=[0 0.003  0.009  0.017  0.028  0.038  0.05  0.062 0.076 0.093  0.100   0.104 0.104  0.112  0.115 0.118 0.122 0.124]./1000

%quarta serie (2.378-3.71)
Va4=[0 0.4 0.9 1.3 1.7 2.6  3.2   3.8 4.1   4.6  5.1   8.9  13.2 23.3  33.3 50.6   ]
Ic4=[0 1.2 3.6 7  10.8 17.8 19.5  20  20.2  20.5 20.8  21.8 22.3 23    23.5 24.1  ]./10^6

loglog(Va4,Ic4)


