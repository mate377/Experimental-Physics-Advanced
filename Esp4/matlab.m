clear all;
close all;
sodio=load('sodio22.TKA');
fondo=load('fondo.TKA');
cobalto=load('cobalto60.TKA');
cesio=load('cesio137.TKA');
bario=load('bario133.TKA');

%tolgo il fondo
sodiof=sodio-fondo;
cobaltof=cobalto-fondo;
cesiof=cesio-fondo;
bariof=bario-fondo;

% calibrazione
ch=1:2^12;
calib.x=[1204 2909]';
calib.y=[511  1274]';
ft=fittype('a*x');
f=fit(calib.x, calib.y, ft);% 'poly1')
E=f(ch);



