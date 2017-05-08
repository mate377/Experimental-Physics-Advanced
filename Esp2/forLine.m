function c=forLine(A,B,xs,xe)
    c{2}=[];
    c{1}=[xs.val xe.val];
    tmp=A+B*c{1};
    c{2}=[tmp.val];
end