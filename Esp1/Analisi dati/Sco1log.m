%la funzione prende in ingresso i dati con relativa incertezza fino a un
%massimo di sei dati, i dati nella serie dato-incertezza-dato-incertezza.
%Il numero massimo di dati � 6, possono essere inseriti anche meno dati.
%!!!Bisogna scrivere la funzione fisica di cui si vuole calcolare l'incertezza
%all'interno della funzione stessa!! I valori calcolati vengono plottati a
%schermo

function [out1, out2]=Sco1log(y1,dy1,y2,dy2,y3,dy3,y4,dy4,y5,dy5,y6,dy6,varargin)
%vengono passati i vettori di dati con relativa incertezza
syms f df x1 x2 x3 x4 x5 x6 dx1 dx2 dx3 dx4 dx5 dx6

f=log(x1);

if ~exist('dy2', 'var') % controlla se esistono pi� variabili
    dy2 = 0*ones(size(y1));
end

if ~exist('y2', 'var')
    y2 = 0* ones(size(y1));
end

if ~exist('dy3', 'var') % controlla se esistono pi� variabili
    dy3 = 0*ones(size(y1));
end

if ~exist('y3', 'var')
    y3 = 0* ones(size(y1));
end

if ~exist('dy4', 'var') % controlla se esistono pi� variabili
    dy4 = 0*ones(size(y1));
end

if ~exist('y4', 'var')
    y4 = 0* ones(size(y1));
end

if ~exist('dy5', 'var') % controlla se esistono pi� variabili
    dy5 = 0*ones(size(y1));
end

if ~exist('y5', 'var')
    y5 = 0* ones(size(y1));
end

if ~exist('dy6', 'var') % controlla se esistono pi� variabili
    dy6 = 0*ones(size(y1));
end

if ~exist('y6', 'var')
    y6 = 0* ones(size(y1));
end


dx1=diff(f,x1); % calcola le derivate
dx2=diff(f,x2);
dx3=diff(f,x3);
dx4=diff(f,x4);
dx5=diff(f,x5);
dx6=diff(f,x6);

Diffx1=subs(dx1,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6}); % calcolo il valore numerico delle derivate sostituendo i dati sperimentali
Diffx2=subs(dx2,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6});
Diffx3=subs(dx3,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6});
Diffx4=subs(dx4,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6});
Diffx5=subs(dx5,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6});
Diffx6=subs(dx6,{x1 x2 x3 x4 x5 x6},{y1,y2,y3,y4,y5,y6});



DF1=sqrt((Diffx1.*dy1).^2+(Diffx2.*dy2).^2+(Diffx3.*dy3).^2+(Diffx4.*dy4).^2+(Diffx5.*dy5).^2+(Diffx6.*dy6).^2);  % calcolo l'incertrezza su F come da definizione di prodi(le derivate sono gia nmumeriche, le incertezze si)


F1=subs (f,{x1 x2 x3 x4 x5 x6},{y1 y2 y3 y4 y5 y6}); % calcolo i valori finali di f

out1=double(F1);
out2=double(DF1);


end