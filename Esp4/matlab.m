%% import dei dati
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

for i=1:5
    sf=setfield(sf,fn{i},getfield(sf,fn{i})+1);
end

for i=1:4
    s=setfield(s,fn{i},getfield(s,fn{i})+1);
end


%% calibrazione
ch=1:2^12;
calib.x=[1204 2909]'; % se si vogliono aggiungere altri punti per la calibrazione
calib.y=[511  1274]'; % metterli in calib.x e calib.y. Si può anche cambiare il
ft=fittype('a*x');    % tipo di fit in tal caso.
f=fit(calib.x, calib.y, ft);% 'poly1')
E=f(ch);

%% mappatura dell'energia sui canali
figure;
plot(ch,E);
title('map Energy to channel');
xlabel('Channel');
ylabel('Energy');

%% Variable for select log or semilogy plot
LINE=0;
annihilation=511;
linep=@(k) line([annihilation annihilation],[1 maxsf(k)]); 
typeofplot='semilogy';
%typeofplot='norm';

%% Plotta solo una sorgente
N=1;
close all;

if (N<1||N>5)
    error('N tra 1 e 5 please!');
end

% prima figura col fondo
figure;
hold on;
if strcmp(typeofplot,'norm')
    plot(E,getfield(sf,fn{N}),'.k');
    plot(E,sf.fondo,'.r');
    if LINE 
        linep(i);
    end
elseif strcmp(typeofplot,'semilogy')
    semilogy(E,getfield(sf,fn{N}),'.k');
    semilogy(E,sf.fondo,'.r');
    if LINE
        linep(i);
    end
else
    error('Set a type of plot in the "typeofplot" variable!');
end
title(sprintf('%s & fondo',fn{N}));
xlabel('Energy [MeV]');
ylabel('# counts');
hold off;

% e seconda senza fondo
figure;
hold on;
if strcmp(typeofplot,'norm')
    plot(E,getfield(s,fn{N}),'.k');
    if LINE
        linep(i);
    end
elseif strcmp(typeofplot,'semilogy')
    semilogy(E,getfield(s,fn{N}),'.k');
    if LINE
        linep(i);
    end
else
    error('Set a type of plot in the "typeofplot" variable!');
end
title(sprintf('%s - fondo',fn{N}));
xlabel('Energy [MeV]');
ylabel('# counts');
hold off;

%% tutti e 4 con fondo e plot anche del fondo
close all;
figure;
for i=1:4
    subplot(2,2,i)
    hold on;
    if strcmp(typeofplot,'norm')
        plot(E,getfield(sf,fn{i}),'.k');
        plot(E,sf.fondo,'.r');
        if LINE
            linep(i);
        end
    elseif strcmp(typeofplot,'semilogy')
        semilogy(E,getfield(sf,fn{i}),'.k');
        semilogy(E,sf.fondo,'.r');
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
    hold on;
    if strcmp(typeofplot,'norm')
        plot(E,getfield(s,fn{i}),'.k');
        if LINE
            linep(i);
        end
    elseif strcmp(typeofplot,'semilogy')
        semilogy(E,getfield(s,fn{i}),'.k');
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

