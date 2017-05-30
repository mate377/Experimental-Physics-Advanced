%% import dei dati
% organizzo tutti i dati in due strutture:
% 'sf' contiene i dati così come sono stati presi, mentre
% 's' contiene i dato con fondo sottratto
% 'maxsf' contiene i massimi delle serie col fondo, mi servono per
%       tracciare le linee come ad esempio i 511Kev

clear all;
close all;
sf=struct('sodio',load('sodio22.TKA'),'cobalto',load('cobalto60.TKA'),...
    'cesio',load('cesio137.TKA'),'bario',load('bario133.TKA'),...
    'fondo',load('fondo.TKA'));
% s contiene i dati col fondo sottratto
fn=fieldnames(sf);
s=struct;
for i=1:length(fn)-1
    s=setfield(s,fn{i},getfield(sf,fn{i})-sf.fondo);
end

maxsf=zeros(5,1);
for i=1:length(fn)
    maxsf(i)=max(getfield(sf,fn{i}));
end

% Qui volevo aggiungere a tutti i dati 1 in modo che il log non dia
% problemi.
for i=1:5
    sf=setfield(sf,fn{i},getfield(sf,fn{i})+1);
end

for i=1:4
    s=setfield(s,fn{i},getfield(s,fn{i})+1);
end


%% calibrazione
% 'ch' è il vettore contenente i canali
% 'E' contiene invece le energie
% la legge che mappa ch su E viene estratta tramite fit. spline sembra il
% miglior tipo di fit.

ch=1:2^12;
calib.x=[1204 2909 3300]'; % se si vogliono aggiungere altri punti per la calibrazione
calib.y=[511  1274 1505]'; % metterli in calib.x e calib.y. Si può anche cambiare il
ft=fittype('a*x+b');    % tipo di fit in tal caso. calib.x contiene i canali
f=fit(calib.x, calib.y, 'SmoothingSpline');% mentre calib.y le energie
E=f(ch);
% plot mappatura dell'energia sui canali
figure;
plot(ch,E);
title('map Energy to channel');
xlabel('Channel');
ylabel('Energy');

%% Variable for select log or semilogy plot
% L'idea è questa: se linea=1 nei plot ci sarà la linea dei 511Kev,
% altrimenti no.
LINE=1;
annihilation=511;
linep=@(k) line([annihilation annihilation],[1 maxsf(k)],'Color','red'); 
typeofplot='semilogy';
%typeofplot='norm';

G.msize=3; % definisce la dimensione dei marker

%% Plotta solo una sorgente
N=3; % agendo su N seleziono quale grafico plottare. 5 è il fondo.
close all; 
% E=ch; % temp for calibration. Per quando voglio mappare ch -> E

if (N<1||N>5)
    error('N tra 1 e 5 please!');
end

% prima figura col fondo
figure;
if strcmp(typeofplot,'norm')
    plot(E,getfield(sf,fn{N}),'.k','MarkerSize',G.msize);
    hold on;
    plot(E,sf.fondo,'.r','MarkerSize',G.msize);
    if LINE 
        linep(i);
    end
elseif strcmp(typeofplot,'semilogy')
    semilogy(E,getfield(sf,fn{N}),'.k','MarkerSize',G.msize);
    hold on;
    semilogy(E,sf.fondo,'.r','MarkerSize',G.msize);
    if LINE
        linep(i);
    end
else
    error('Set a type of plot in the "typeofplot" variable!');
end
title(sprintf('%s & fondo',fn{N}));
xlabel('Energy [MeV]');
ylabel('# counts');
grid on;
hold off;

% e seconda senza fondo
figure;
if strcmp(typeofplot,'norm')
    plot(E,getfield(s,fn{N}),'.k','MarkerSize',G.msize);
    hold on;
    if LINE
        linep(i);
    end
elseif strcmp(typeofplot,'semilogy')
    semilogy(E,getfield(s,fn{N}),'.k','MarkerSize',G.msize);
    hold on;
    if LINE
        linep(i);
    end
else
    error('Set a type of plot in the "typeofplot" variable!');
end
title(sprintf('%s - fondo',fn{N}));
xlabel('Energy [MeV]');
ylabel('# counts');
grid on;
hold off;

%% tutti e 4 con fondo e plot anche del fondo
close all;
figure;
for i=1:4
    subplot(2,2,i)
    if strcmp(typeofplot,'norm')
        plot(E,getfield(sf,fn{i}),'.k','MarkerSize',G.msize);
        hold on;
        plot(E,sf.fondo,'.r','MarkerSize',G.msize);
        if LINE
            linep(i);
        end
    elseif strcmp(typeofplot,'semilogy')
        semilogy(E,getfield(sf,fn{i}),'.k','MarkerSize',G.msize);
        hold on;
        semilogy(E,sf.fondo,'.r','MarkerSize',G.msize);
        if LINE
            linep(i);
        end
    else
        error('Set a type of plot in the "typeofplot" variable!');
    end
    title(sprintf('%s & fondo',fn{i}));
    xlabel('Energy [MeV]');
    ylabel('# counts');
    hold off;
end

%% tutti e 4 senza fondo
close all;
figure;
for i=1:4
    subplot(2,2,i)
    if strcmp(typeofplot,'norm')
        plot(E,getfield(s,fn{i}),'.k','MarkerSize',G.msize);
        hold on;
        if LINE
            linep(i);
        end
    elseif strcmp(typeofplot,'semilogy')
        semilogy(E,getfield(s,fn{i}),'.k','MarkerSize',G.msize);
        hold on;
        if LINE
            linep(i);
        end
    else
        error('Set a type of plot in the "typeofplot" variable!');
    end
    title(sprintf('%s - fondo',fn{i}));
    xlabel('Energy [MeV]');
    ylabel('# counts');
    hold off;
end

%% vita della sorgente
%tempo di dimezzamento
V.thalf=5.27145;
%attivit� al momento della fabbricazione
V.N0=403300;
%attivit� misurata
V.N=61000;
%efficienza geometrica
V.eg=(2.54*3)^2/(16*(25)^2);
%attivit� stimata il 28/04/17
V.Nt=V.N/(0.18*V.eg*1000);
%TEMPO Trascorso
V.T=-V.thalf*log(V.Nt/V.N0)/log(2); % anni
V.mesi=0.7*365;

%% Risoluzione
% calcolo la risoluzione trovando la larghezza della gaussiana di un picco.
% Qui ho preso il sodio perchè è quello più bello. Fa anche un plot del fit
% per assicurarsi che il risultato sia decente.

R.int=2750:3050;
R.para=log(sf.sodio(R.int));
R.E=E(R.int);
R.ft=fittype('-a*(x-b)^2+c');
R.fit=fit(R.E,R.para,R.ft,'StartPoint',[1.4/(60^2) 1280 9]);
% log(gauss) ~ -(x^2)/(2*sigma^2), so sigma=sqrt(1/(2*a)), but I need
% 2*sigma which is the width of the gaussian.
% Or I can use FWHM = 2.3548*sigma
R.larg=sqrt(2/R.fit.a);
R.FWHM=sqrt(1/(2*R.fit.a))*2.3548;
%R.ris=R.larg/R.fit.b;
R.ris=R.FWHM/R.fit.b;
R.s=sprintf('la risoluzione del detector è circa %.2f%%', R.ris*100);
disp(R.s);

% plot
close all;
figure;
plot(R.E,R.para,'.k');
hold on;
plot(R.E,R.fit(R.E),'r');
xlabel('Energy [MeV]');
ylabel('log(# counts)');
title('fit parabola per trovare sigma');
grid on;
hold off;

%% close all
close all;