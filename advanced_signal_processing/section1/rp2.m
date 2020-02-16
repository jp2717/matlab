function v=rp2(M,N)
%rp2, generates second stochastic process
    Ar=rand(M,1)*ones(1,N);
    Mr=rand(M,1)*ones(1,N);
    v=(rand(M,N)-0.5).*Mr+Ar;
end

