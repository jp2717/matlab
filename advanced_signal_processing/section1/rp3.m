function v=rp3(M,N)
%rp3, generates the third stochastic process
    a=0.5;
    m=3;
    v=(rand(M,N)-0.5)*m + a;
end

