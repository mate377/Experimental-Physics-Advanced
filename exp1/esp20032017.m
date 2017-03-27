%% Script seconda parte
% Lo script definisce tre variabili: lfil, lfa, lfc, descrizione e' sotto
% Le misure sono in quattro strutture:
%   p (prima) contiene Ii vs Pcam per aria
%   s (seconda) contiene (Ie/Ii) vs Va per azoto
%   t (terza) contiene Ii vs Pcam per elio
%   q (quarta) contiene (Ie/Ii) vs Va per elio
% Contengono inoltre gli altri parametri tenuti costanti

% dato il potenziale del collettore come riferimento:
% La griglia è a potenziale Vc+Va
% Il filamento è tenuto a un capo a potenziale Vc+Vf e all'altro a Vc
% If è la corrnte nel filamento
% Ie la corrente elettronica racoolta dalla griglia, misurata dall'amper.
% Ii la corrente ionica raccolta dal collettore, misurata dall'elettrometro
%% pezzi
% misure in mm, l'incertezza e' quella del calibro
lfil=md(20.69,1);  % lunghezza filamento 
lfa=md(11.07,2)/2; % distanza filamento anodo
lfc=md(26.10,2)/2; % distanza filamento collettore

%% Ii vs Pcam, prima serie
p.Va=md(40.3,0.1); % potenziale anodo (V)
p.Ie=md(500,10); % micro ampere
p.Vf=md(2.807,0.001); % Volt
p.If=md(4.156,0.001); % Amp 
p.Vc=md(4.61,0.001); %Volt collettore 

% mbar nA
p.Pcam=md([6.0E-6 1.2E-5 3.8E-5 7.0E-5 1.0E-4],0.1E-6); % mBar
p.Ii=md([13.4 20.4 41.7 72.6 77.6],0.1); %  nano amp

%% other data as precedent
s.Pcam=md(5.5E-5,1E-6); % mBar
s.Vf=p.Vf; % Volt
s.If=md(4.154,0.001); % Amp
s.Vc=p.Vc; % Volt

s.Va=md([0 2.5 5 7.5 10 15 17.5 20 22.5 25 30 35 40 50 60 70 80 90 100],0.1); % Volt
s.Ie=md([2.9 38 116 190 206 215 219 224 228 232 240 245 251 261 280 300 316 333 350],1); % micro
s.Ie=s.Ie*1000; % porto in nano ampere
s.Ii=md([0.0 0.1 0.2 0.3 0.2 1 1.9 3.4 6.6 10.9 23.6 38.3 54.6 87.2 118 145 169.9 191 210],0.1); % nano amp

s.ratioI=s.Ii./s.Ie;
%% 
t.Va=md(40.3,0.1); % potenziale anodo (V)
t.Ie=md(589,10); %micro ampere
t.Vf=md(2.808,0.001); % Volt
t.If=md(4.160,0.001); % Amp 
t.Vc=md(4.61,0.001); %Volt collettore 

t.Pcam=md(1.0E-04*[0.0500    0.0700    0.0900    0.2000    0.5000    0.8000    1.0000],0.1E-6); % mbar
t.Ii=md([13.5000   16.0000   18.4000   29.7000   51.0000   69.6000   78.0000],0.1); % nano ampere

%% 6E-5 press
% sono uguali ai 
q.Vf=p.Vf; % Volt
q.If=p.If; % Amp
q.Vc=p.Vc; % Volt

% dato che la pressione in camera è variata un po' durante la misura, qui è
% un vettore e non uno scalare
q.Pcam=md([6.0E-5 6.0E-5 6.0E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.5E-5 5.0E-5 5.0E-5 5.0E-5 5.0E-5 5.0E-5 5.0E-5],1E-6); % mBar
q.Va=md([0 2.5 5.0 7.5 10.0 15.0 17.5 20.0 22.5 25.0 30.0 35.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0],0.1); %Volt
q.Ie=md([3 42 125 213 270 285 290 295 300 305 313 321 329 339 356 371 390 411 426],1); % micro amp
q.Ie=q.Ie*1000; % porto in nano ampere
q.Ii=md([0 0 0 0 0 0 1.5 3.0 5.4 9.3 20.0 34.4 50.5 82.0 114.0 142.0 167.0 190.0 209.0],0.1); % nano ampere

%%
%[11:14]
points=[11:14];
ft=fittype('a*x+b');%('linearinterp');
s.fit=fit([s.Va(points).val]',[s.ratioI(points).val]',ft);
q.fit=fit([q.Va(points).val]',[q.ratioI(points).val]',ft);
s.Eion=-s.fit.b/s.fit.a; % e volt
q.Eion=-q.fit.b/q.fit.a; % e volt

% 1eV == 'ev2km'* KJ/mol, ovvero moltiplicand gli eV per ev2km ottengo il
% valore in KJ/mol
ev2km=96.485; % (KJ/mol)/eV

s.EionK=s.Eion*ev2km;
q.EionK=q.Eion*ev2km;

% attenzione che si vuole N2, non N. e' 1503 KJ/mol, che converto in ev
% per l'He si trova gia in eV. Se si avvia la sezione stampa una bella
% tabella. Per il N2 e' molto fuori.
fprintf('valori in eV');
fprintf('\n%10s %10s %10s','gas','ottenuta','rif');
fprintf('\n%10s %10g %10g','N2',s.Eion,1503/ev2km);
fprintf('\n%10s %10g %10g\n','He',q.Eion,24.587);
%yfit=fit(x,y,f,'StartPoint',[10, 5]) %'Lower', [8, pi], 'Upper', [15, 6*pi]);% 'Normalize', 'on')

%% grafici
q.ratioI=q.Ii./q.Ie;
plot([q.Va.val],[q.ratioI.val],'r+');
grid on;
hold on;
plot([s.Va.val],[s.ratioI.val],'+k');
% plot del fit
p2=[5:17];
plot([s.Va(p2).val],s.fit([s.Va(p2).val]),'-k');
plot([q.Va(p2).val],q.fit([q.Va(p2).val]),'-r');
hold off;
