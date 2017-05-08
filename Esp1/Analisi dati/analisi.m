clear;
%% MISURE PRELIMINARI

m=9.1094*10^(-31) ;%massa elettrone
k=1.3806*10^(-23);%costante boltzman
h=6.6260*10^(-34) ;%costatnte planlk
q=1.6021*10^(-19) ;%elctric charge
e0=8.8542*10^(-12);

l=1.90*10^-2; %lunghezza filamento1 m
dl=0.3*10^-2;
dim=205*10^-6; %diametro filamento1 m
ddim=5*10^-6;
lfa = 11.07/2*10^(-3); %distanza filamento anodo m
dlfa = 0.5*10^-3;
l2=20.69*10^(-3); %lunghezza filamento2 m
dl2=0.5*10^-3;

r4w=0.84; %resitenza a 4 fili ohm
dr4w=0.01; 
l4w=0.43; %lunghezza filamento campione 4 fili metri
dl4w=0.01; 

[ro,dro]=Sco1ro(r4w,dr4w,dim,ddim,l4w,dl4w); %resistività ohm m
[rfil,drfil]=Sco1fil(ro,dro,l,dl,dim,ddim); %resistenza filamento1 ohm
[rfil2,drfil2]=Sco1fil(ro,dro,l2,dl2,dim,ddim); %resistenza filamento2 ohm

rtot=0.254; %resistenza totale fili+filamento ohm
drtot=0.001;
rwire=rtot-rfil; %resistenza fili ohm
drwire=drfil;

%% SERIE DATI PRIMA SESSIONE
rt1fil=2.675/4.005-rwire;
drt1fil=drfil;
[T1r,dT1r] = Sco1tempr(rt1fil, drt1fil, rfil, drfil); %temperatura K
[T1, dT1] = Sco1temp(rt1fil, drt1fil, rfil, drfil);
Va=[3.5,         5.1,  7.0  8.3,     9.5         10.2,       11.0,       13.0,  30.0, 50.0];%volt
DVa=0.1*ones(size(Va));
Ic=[0.000077, 0.000130, 0.000200, 0.000230, 0.000239, 0.000242, 0.000243 0.000250, 0.000261, 0.000271];%ampere
dIc=0.000001*ones(size(Va));

rt2fil=2.476/3.806-rwire;
[T2r,dT2r] = Sco1tempr(rt2fil, drt1fil, rfil, drfil);
[T2, dT2] = Sco1temp(rt2fil, drt1fil, rfil, drfil);
Va2=[1.0,      1.5,       2.0         2.5,      3.0,     3.5,  4.0 ,4.5        5.1,      7.0  8.3,     9.5         ];
DVa2=0.1*ones(size(Va2));
Ic2=[0.000006, 0.000014 , 0.000021, 0.000030, 0.000036, 0.000041,    0.000045,0.000046,0.000045 0.000047, 0.000048, 0.000049];
dIc2=1*ones(size(Va2))/10^6;

rt3fil=2.572/3.9-rwire;
[T3r,dT3r] = Sco1tempr(rt3fil, drt1fil, rfil, drfil);
[T3, dT3] = Sco1temp(rt3fil, drt1fil, rfil, drfil);
Va3=[0.5    1      1.5    2      2.5    3.0   3.5    4    4.7    5.1   5.5     6      10.8   16    26    38.5  50.0];
DVa3=0.1*ones(size(Va3));
Ic3=[0.003  0.009  0.017  0.028  0.038  0.05  0.062 0.076 0.093  0.100   0.104 0.104  0.112  0.115 0.118 0.122 0.124]./1000;
dIc3=ones(size(Va3))./10^6;

rt4fil=2.378/3.71-rwire;
[T4r,dT4r] = Sco1tempr(rt4fil, drt1fil, rfil, drfil);
[T4, dT4] = Sco1temp(rt4fil, drt1fil, rfil, drfil);
Va4=[0.4 0.9 1.3 1.7 2.6  3.2   3.8 4.1   4.6  5.1   8.9  13.2 23.3  33.3 50.6   ];
DVa4=0.1*ones(size(Va4));
Ic4=[1.2 3.6 7  10.8 17.8 19.5  20  20.2  20.5 20.8  21.8 22.3 23    23.5 24.1  ]./10^6;
dIc4=ones(size(Va4))./10^6;

%dati presi la seconda sessione
Vg5 = 2.8;
dVg5 = 0.001; 
Ig5 = 4.166;
rt5fil=Vg5/Ig5-rwire;
[T5r,dT5r] = Sco1tempr(rt5fil, drt1fil, rfil2, drfil2);
[T5, dT5] = Sco1temp(rt5fil, drt1fil, rfil2, drfil2);
Va5 = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22.5, 25, 30, 35, 40, 45, 50];
DVa5 = 0.1*ones(size(Va5));
Ic5 = [3.3, 11, 20, 31, 45, 61.8, 78.7, 98.5, 118, 141, 166, 190, 214, 238, 265, 288, 313, 339, 364, 392, 444, 499, 545, 592, 633, 664, 690, 702, 710, 717, 730, 740, 755, 762, 761, 782, 791].*10^(-6);
dIc5 = ones(size(Ic5))./10^6;

%% LEGGE DI CHILD

%I=8/9*srqt(2*q/m)*pi*e0*l/lfa*Va^(3/2)	%dist= distanzanza fil-anodo
[coeffc, dcoeffc] = Sco1child(l, dl, lfa, dlfa);

%% fit di matlab        da scartare secondo me
f = fittype('a*x^(b)', 'independent', 'x', 'coefficients', {'a', 'b'});

myfit1 = fit(Va',Ic',f, 'Exclude', Va > 8);        %escludo le tensioni troppo alte per cui non vale child
myfit2 = fit(Va2',Ic2',f, 'Exclude', Va2 > 3);
myfit3 = fit(Va3',Ic3',f, 'Exclude', Va3 > 4);
myfit4 = fit(Va4',Ic4',f, 'Exclude', Va4 > 1.7);

figure(1),
errorbar(Va, Ic, dIc, '.k')
hold on;
herrorbar(Va,Ic,DVa/2,DVa/2, '.k')
plot(myfit1, '-.k');

errorbar(Va2,Ic2, dIc2, '.g')
herrorbar(Va2,Ic2,DVa2/2,DVa2/2, '.g')
plot(myfit2, '-.g');

errorbar(Va3, Ic3, dIc3, '.b')
herrorbar(Va3,Ic3,DVa3/2,DVa3/2, '.b')
plot(myfit3, '-.b');

errorbar(Va4, Ic4, dIc4, '.r')
herrorbar(Va4,Ic4,DVa4/2,DVa4/2, '.r')
plot(myfit4, '-.r');

axis([0 50 0 0.4*10^(-3)]);  %cambiate pure il range, l'ho messo così per vedere meglio le tensioni basse
xlabel('V_a (V)');
ylabel('I_a (A)');

hold off;

%% regressione lineare a mano dopo aver linearizzato Y = A + B*X -> ln(I_e) =
%A + B*ln(V_a) ci aspettiamo che B = 3/2
[lVa, dlVa] = Sco1log(Va, DVa);
[lVa2, dlVa2] = Sco1log(Va2, DVa2);
[lVa3, dlVa3] = Sco1log(Va3, DVa3);
[lVa4, dlVa4] = Sco1log(Va4, DVa4);
[lVa5, dlVa5] = Sco1log(Va5, DVa5);

[lIc, dlIc] = Sco1log(Ic, dIc);
[lIc2, dlIc2] = Sco1log(Ic2, dIc2);
[lIc3, dlIc3] = Sco1log(Ic3, dIc3);
[lIc4, dlIc4] = Sco1log(Ic4, dIc4);
[lIc5, dlIc5] = Sco1log(Ic5, dIc5);

[A1, dA1, B1, dB1, chi1] = Lchi2(lVa, dlVa, lIc, dlIc, 1, 4, 3);
[A2, dA2, B2, dB2, chi2] = Lchi2(lVa2, dlVa2, lIc2, dlIc2, 1, 4, 3);
[A3, dA3, B3, dB3, chi3] = Lchi2(lVa3, dlVa3, lIc3, dlIc3, 1, 8, 3);
[A4, dA4, B4, dB4, chi4] = Lchi2(lVa4, dlVa4, lIc4, dlIc4, 1, 4, 3);
[A5, dA5, B5, dB5, chi5] = Lchi2(lVa5, dlVa5, lIc5, dlIc5, 1, 20, 3);

[co1, dco1] = Sco1exp(A1, dA1);
[co2, dco2] = Sco1exp(A2, dA2);
[co3, dco3] = Sco1exp(A3, dA3);
[co4, dco4] = Sco1exp(A4, dA4);
[co5, dco5] = Sco1exp(A5, dA5);

syms x 

figure(2),
errorbar(lVa,lIc, dlIc, dlIc, dlVa, dlVa,'.k', 'CapSize', 0);
hold on,

errorbar(lVa2,lIc2, dlIc2, dlIc2, dlVa2,dlVa2, '.g','CapSize', 0 );

errorbar(lVa3,lIc3, dlIc3, dlIc3,dlVa3,dlVa3, '.b', 'CapSize', 0);

errorbar(lVa4,lIc4, dlIc4, dlIc4, dlVa4,dlVa4, '.r', 'CapSize', 0);

errorbar(lVa5,lIc5, dlIc5, dlIc5, dlVa5,dlVa5, '.y','CapSize', 0 );

legend('2406 K', '2318 K', '2363 K', '2269 K', '2238 K');

f1(x) = A1 + B1*x;
fplot(f1(x), '-.k');


f2(x) = A2 + B2*x;
fplot(f2(x), '-.g');


f3(x) = A3 + B3*x;
fplot(f3(x), '-.b');


f4(x) = A4 + B4*x;
fplot(f4(x), '-.r');


f5(x) = A5 + B5*x;
fplot(f5(x), '-.y');

axis([-1 4 -15 -7]);
xlabel('ln(V_a)');      %unità di misura arbitrarie
ylabel('ln(I_e)');

hold off;

[lcoeffc, ldcoeffc] = Sco1log(coeffc, dcoeffc);

%% LEGGE RICHARDSON

a=4*pi*m*q*(k^2/h^3);   %costante di proporzionalità
%j=a*(T^2)exp(W/k*T)    %W energia di estrazione

%potenziale griglia fisso, cambiamo T
P = 2.7*10^(-6); 
Vg = 50;
Vf = [2 2.2 2.1 2.05 2.08 2.120 2.160 2.3 2.25 2.301 2.350 2.4 2.5 2.6 2.7 2.8 2.9 3];
dVf = ones(1, length(Vf))*0.1;
If = [3.333 3.546 3.435 3.383 3.420 3.465 3.509 3.663 3.605 3.655 3.7 3.76 3.875 3.97 4.067 4.164 4.262 4.356];
Ia = [0.1 3 1.1 0.7 1 1.5 2.2 8.8 5.6 8.9 14 22.8 60 148 347 743 1436 2535].*10^(-6);
dIa = 0.1*ones(1, length(Ia))*10^(-6);

rt6fil=Vf./If-rwire*ones(1, length(Vf));
drt6fil = 0.0101*ones(1, length(Vf));
[Tf, dTf] = Sco1tempr(rt6fil, drt6fil, rfil2, drfil2);




syms x;

dTf2 = sqrt((2.*Tf).^2.*(dTf).^2);
d1Tf = sqrt(Tf.^(-4).*(dTf).^2);
[ord, dord] = Sco1logf(Ia, dIa, Tf.^2, dTf2);
[Ari, dAri, Bri, dBri, chiri] = Lchi2(Tf.^(-1), d1Tf, ord, dord, 1, 18, 3);
fri(x) = Ari + Bri*x;

figure(5),
errorbar(Tf.^(-1), ord, dord, dord, d1Tf, d1Tf, '.b', 'CapSize', 0);
hold on,
fplot(fri(x), '-.b');
axis([0.0003 0.0007 -34 -20]);
xlabel('1/T (1/K)');      %unità di misura arbitrarie
ylabel('ln(I_e/T^2)');

hold off;

[sup, dsup] = Sco1sup(dim/2, ddim*1/2, l2, dl2);
[cors, dcors] = Sco1exp(Ari, dAri);
cor = cors/sup;
dcor = sqrt((1/sup)^2*dcors^2 + (1/sup^2)^2*dsup^2);
W = Bri*k;
WeV = W*(6.242*10^(18));
dWeV = k*6.242*10^(18)*dBri;

%Richardson corretto con l'esponenziale della radice del campo elettrico (ho usato la serie di dati 5, quella presa la seconda sessione)
%E = Vf./lfa*log(dim/(2*lfa));
%[E, dE] = Sco1E(Vf, dVf, lfa, dlfa, dim, ddim);

[E, dE] = Sco1E(Va5, DVa5, lfa, dlfa, dim, ddim);
[sE, dsE] = Sco1sqrt(-E, dE);
[Are, dAre, Bre, dBre, chire] = Lchi2(sE, dsE, lIc5, dlIc5, 31, 37, 3);
espA = -Bre*T5r;
despA = sqrt((T5r)^2*dBre^2 + (Bre)^2*dT5r);

syms x;
fre(x) = Are + Bre*x;

figure(3),
errorbar(-E, Ic5, dIc5, '.y');
hold on,
herrorbar(-E, Ic5, dE, dE, '.y');
hold off;

figure(4),
errorbar(sE, lIc5, dlIc5, '.b');
hold on,
herrorbar(sE, lIc5, dsE, dsE, '.b');
fplot(fre(x), '-.b')
hold off;

fexp(x) = cors*x^2*exp(Bri/x);
figure(6)
errorbar(Tf, Ia, dIa, dIa, dTf, dTf, '.r', 'CapSize', 0);
hold on,
fplot(fexp(x), '.-r')
hold off;