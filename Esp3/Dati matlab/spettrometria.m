close all
load workspacescotoni.mat
% p1=plot(Etilene,iEtano,'g');
% hold on
% grid on
% p2=plot(Etilene,iEtilene,'b');
% p3=plot(Metano,iMetano,'r');
% p4=plot(gas3,igas3,'k');


%dati importati
x=iMetano;
y=iEtano;
z=iEtilene;
%coefficienti del fit ottenuti da noi
a=1/18.8;
b=1/1.49;
c=0.3317;
%nostro fit
w=a*x+b*y+c*z;

%sottraiamo il contributo del Metano, il coefficiente a è stato calcolato
%in excel
j=igas3-a*x

%sottraiamo il contributo di Metano ed Etano, Coefficienti calcolati in
%excel
jj=igas3-a*x-b*y;
c=jj(897)/iEtilene(897);
tot=a+b+c;
pMetano=a/tot;
pEtano=b/tot;
PEtilene=c/tot;

%dati teorici
aa=0.1025;
bb=0.5164;
cc=0.3811;

fig1=figure();
ww=aa*x+bb*y+cc*z;
%Il vettore Etilene è comune a tutti i gas, nostro fit
plot(Etilene,w,'g');
hold on
plot(Etilene,igas3, 'k');
title('Fit con coefficienti non rinormalizzati')

fig2=figure();
%Il confronto con i valori teorici
%d=ww(500)/igas3(500);
%è sbagliato fare il rapporto, le pression parziali devono già venire corrette
plot(Etilene,ww,'r');
hold on
plot(Etilene,igas3,'k');
title('Fit con percentuali teoriche')

fig3=figure();
%Il confronto con i valori teorici
%d=ww(500)/igas3(500);
%è sbagliato fare il rapporto, le pression parziali devono già venire corrette
w3=(a/tot)*x+(b/tot)*y+(c/tot)*z;
plot(Etilene,w3,'b');
hold on
plot(Etilene,igas3,'k');

title('Fit con coefficienti rinormalizzati (percentuale pressione parziale)')


