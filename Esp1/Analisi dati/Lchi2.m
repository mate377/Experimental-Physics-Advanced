%gli input, in ordine, sono: dato ascissa, errore su dato ascissa, dato
%ordinata, errore dato ordinata, dati dalla posizione l alla m che si vogliono fittare,
%numero n di iterazioni (trasferimento su dati y dell'errore su x).
function [o1, o2, o3, o4, o5] = Lchi2(x, dx, y, dy, l, m, n)

x1 = x(l:m);
dx1 = dx(l:m);
y1 = y(l:m);
dy1 = dy(l:m);

dyt = dy1;

for k=1:n
w = dyt.^(-1);
B = (sum(w)*sum(w.*x1.*y1) - sum(w.*y1)*sum(w.*x1))/(sum(w)*sum(w.*(x1.^2)) - (sum(w.*x1))^2);
dyt = sqrt(dyt.^2 + (B*dx1).^2);
end

A = (sum(w.*(x1.^2))*sum(w.*y1) - sum(w.*x1)*sum(w.*x1.*y1))/(sum(w)*sum(w.*(x1.^2)) - (sum(w.*x1))^2);
dA = sqrt(sum(w.*(x1.^2))/(sum(w)*sum(w.*(x1.^2)) - (sum(w.*x1))^2));
dB = sqrt(sum(w)/(sum(w)*sum(w.*(x1.^2)) - (sum(w.*x1))^2));
chi = sum(((y1 - A*ones(1, length(y1))-B*x1).^2)./(dyt.^2));
o1 = A;
o2 = dA;
o3 = B;
o4 = dB;
o5 = chi;
end