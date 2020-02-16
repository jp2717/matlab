function dx = odefunT5(t,x,n)
dx = [x(2) ; -x(1)-n.*x(2)];
end