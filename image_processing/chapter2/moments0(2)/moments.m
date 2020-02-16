[x,map]=imread('rice.png');

% map is empty in this version of matlab...
map = gray(256);

imagesc(x);colormap(map);colorbar;
disp('Press any key');
pause;

%create binary image;
b = x>140;
imagesc(b);

% For explicit calculation of moments, do this...
[n,m]=meshgrid(1:size(x,2),1:size(x,1));
% which generates the coordinate system for the 
% calculations.

% Generate Labelled image
L = bwlabel(b);
disp('Press any key');

pause;

% Let's take the 51st connected component and find it's centroid
R51 = (L==51);

M00 = sum(R51(:));

M10 = sum(sum(m.*R51));  % M10 calculated here
M01 = sum(sum(n.*R51));  % M01 calculated here

mbar = M10/M00; nbar = M01/M00;
imagesc(R51); hold on;
plot(nbar,mbar,'x');
pause;

% Second order central moments next

mu20 = sum(sum((m-mbar).^2.*R51));
mu11 = sum(sum((m-mbar).*(n-nbar).*R51));
mu02 = sum(sum((n-nbar).^2.*R51));
thetaradians = pi/2+0.5*atan(mu11/(mu20-mu02));

CovR51 = [mu20 mu11; mu11 mu02];  % Build second order central moment matrix

[V,D]=eig(CovR51);

%Eigenvalues are along the diagnoal of
%D (which has 0  values off the diagonal).  If we take:
d = diag(D);
%... we get the eigenvalues into a vector, already
% sorted from smallest to largest.

% The eigenvectors are contained in the columns of
% V, so V(:,1) has the eigenvector corresponding to d(1)
% and V(:,2) has the eigenvector corresponding to d(2)

%Let's add a depiction of the principal eigenvector
% Eigenvectors will have a length of 1 (normalised)
% so, let's scale them up by the corresponding eigenvalue 
% Factor of 15 does not alter direction, only length
% for visualisation purposes.
quiver(nbar,mbar,sqrt(d(2))*V(2,2)/15,sqrt(d(2))*V(1,2)/15,4);
hold off;
