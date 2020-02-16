% An example of proper reading of an image
close all;clear all
[X,map] = imread('pastaarboriobasmati.JPG');

% Strictly, should check to see if map is empty and act accordingly
figure(1);imagesc(X);

[H,S,V] = rgb2hsv(X); % Convert colour space

figure(2);
subplot(1,3,1);hist(H(:),100);title('Hue');
subplot(1,3,2);hist(S(:),100);title('Sat');        
subplot(1,3,3);hist(V(:),100);title('Value');

% Note that the hue has a little bump to the right
% of the big bump that corresponds to background
riceandrisotto = (V>0.6)&(S<0.3);
figure(3);imagesc(riceandrisotto);colormap(gray(128));
L_RandR = bwlabel(riceandrisotto);
Regions_RandR = regionprops(L_RandR);

% For each of the regions, we can check the area, and determine
% size of the grain.  Would also be interesting to see if we
% can distinguish rice grains ....
Valid_RandR = [];j=0;
for i=1:length(Regions_RandR)
    if Regions_RandR(i).Area>50 % This is set heuristically
        j=j+1;
        Valid_RandR=[Valid_RandR,Regions_RandR(i)];
    end
end
NumberObjects = j;

figure(1);imagesc(X);hold on
for i=1:NumberObjects
    plot(Valid_RandR(i).Centroid(1),Valid_RandR(i).Centroid(2),'x');
end
hold off;

% Now, get areas into one array
Areas_RandR = cat(1,Valid_RandR(:).Area);
[N,H]=hist(Areas_RandR,20);

figure(4); bar(H,N);

% Instance of Area > 5000 seems to be 1
% Let's eliminate it for the time being
% Note: the RHS expression below is an example
% of logical indexing in Matlab.
ValidAreas=Areas_RandR(Areas_RandR<5000);


[N,H]=hist(Areas_RandR,10);
figure(5); bar(H,N);

% There does not seem to be a *clear* pair of peaks here
% corresponding to rice-grain types.  There do, however, seem to be 
% peaks at between 200 and 250 and at 500 pixels

% Now, let's go back to the original
% area information and relabel those that 
% contain less 375 pixels (=(250+500)/2)
% as one type of rice grain and those over
% as being the other:
Basmati_Indices = find(Areas_RandR<375);
Risotto_Indices = find((Areas_RandR>375) & (Areas_RandR<5000));

% Note on use of find() - not very efficient, but very readable
% in terms of debugging/understanding code.

imagesc(X);
for i =1:length(Basmati_Indices)
    h=rectangle('Position',Valid_RandR(Basmati_Indices(i)).BoundingBox);
    set(h,'EdgeColor','r');
end

for i =1:length(Risotto_Indices)
    h=rectangle('Position',Valid_RandR(Risotto_Indices(i)).BoundingBox);
    set(h,'EdgeColor','b');
end

% You should note that the first and zero order moments
% are *not* sufficient to distinguish the rice grains from
% the risotto reliably.  Play around with the parameters in this script
% to see if area helps distinguish the grain type. 
% Second order moments, which SHOULD be different for
% both grains (risotto grains are less elongated), should be tried next -
% this would allow one to use a combination of area and "shape" to
% distinguish rice grains

% Using the script supplied for demonstrating moment calculations,
% try to improve the labelling of rice and risotto in the final
% labelled result