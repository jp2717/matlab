%% -- Image Processing: Tutorial 2 -- %%

clc; clear all; 

% reading in the image of peas

[X,map] = imread('croppedpeasondesk.jpg');  %RGB image
image(X);
%whos;

                            %% Task 1 %%
G = rgb2gray(X);
figure(1);imagesc(G); colormap(gray(256)); % imagesc is like
%image , but scales the values in X to %the range of the colourmap;
G = double(G); % hist needs a double type to work
g = G(:); % G(:) converts the 2D matrix into a 1D
% array; also could use reshape command
%hist(g) ; % Note the number of bins, which is 10;
figure(2); hist(g,100); % Note the histogram now; what is the
% difference

% Trying out different threshold values
% counter = 0;
% for T = 160:10:200
%     gbin = (G > T); % For whatever threshold T you decide on
%     figure(3 + counter);imagesc(gbin);
%     counter = counter + 1;
% end

% There are no suitable threshold values in this scenario

% Converting into x,y,z
R =double(X(:,:,1)); 
G =double(X(:,:,2)); 
B = double(X(:,:,3));
D = R + G + B;

x = R./D;
y = G./D;
z = B./D;

BIGGEST = max([x(:);y(:);z(:)]);% read carefully!
SMALLEST = min([x(:);y(:);z(:)]);

% Because we have done a floating point calculation, the values that
isx = 1+round(255*(x - SMALLEST)/(BIGGEST - SMALLEST));
isy = 1+round(255*(y - SMALLEST)/(BIGGEST - SMALLEST));
isz = 1+round(255*(z - SMALLEST)/(BIGGEST - SMALLEST));

%%PLotting the new image
% figure(3); imagesc(isx);
% figure(4); imagesc(isy);
% figure(5); imagesc(isz);

% %Plotting histograms of new coordinates
% figure(3); hist(isx,100); %101 seems like a clear threshold (BEST SEPARATION)
% figure(4); hist(isy,100); %103 seems like a clear threshold
% figure(5); hist(isz,100); %106 seems like a clear threshold

%Looks good!
gbin = (isy > 110);
figure(3); imagesc(gbin);


                            %% Task 2 %%
% Using bwlabel command

L = bwlabel(gbin,4);
range = max(max(L(:,:)));   %123 regions/peas
figure(4);imagesc(L);colorbar;  % shows different peas as different colors

% Using regionprops command
Regions = regionprops(L);

%123 objects have been found

%Finding mean pea areas and extracting struct data
pea_areas = cat(1,Regions.Area);
est_mean_area = mean(pea_areas);
est_stdev_areas = std(pea_areas);

%Determining area_size threshold and removing specks that are not peas
figure(5);hist(pea_areas,100); %from hist, threshold is about 256, very distinct peaks(small)
figure(6);histogram(pea_areas,10);%Threshold seems to be sufficient at approx area = 1400 (big)

Regions = size_threshold(Regions,256,1400);

%Interpreting BoundingBox and Centroid
b_box = cat(1,Regions.BoundingBox);
centroids = cat(1,Regions.Centroid);

%For now, assuming that BoundingBox fields match the fields of
%rectangle('Position',[lowerx lowery,width,height])

% Drawing rectangles around detected peas!!
figure(7);
pea_detector(X,b_box,centroids);

%% Task 3 %%

% size_threshold already removes small and bundles of peas, now we can split regions

box_areas = b_box(:,3).*b_box(:,4); %base times height
max_box = [0,1];    %keeps track of area and index of that area

for i = 1:length(box_areas)
    
    if(box_areas(i) > max_box(1))   %if larger than current max
        max_box(1) = box_areas(i);
        max_box(2) = i;
    end
    
end

Regions_plaything = Regions;    %Where I will keep a constant box_size
for i = 1:length(box_areas)
    Regions_plaything(i).BoundingBox(3) = Regions_plaything(3).BoundingBox(3);
    Regions_plaything(i).BoundingBox(4) = Regions_plaything(3).BoundingBox(4);
end

%Removing peas too close to the walls (box cannot encompass it)
centroids = cat(1,Regions_plaything.Centroid);
b_box = cat(1,Regions_plaything.BoundingBox);

removed_count = 0;
for i = length(box_areas):-1:1
    if(centroids(i,1) <= b_box(i,3)/2)
        Regions_plaything(i) = [];
        removed_count = removed_count + 1;
    elseif(centroids(i,2) <= b_box(i,4)/2)
            Regions_plaything(i) = [];
            removed_count = removed_count + 1;
    elseif( 512 - centroids(i,1) <= b_box(i,3)/2)
        Regions_plaything(i) = [];
        removed_count = removed_count + 1;
    elseif( 512 - centroids(i,2) <= b_box(i,4)/2)
        Regions_plaything(i) = [];
        removed_count = removed_count + 1;
    end
    
end

%Extracting pixels of each pea into 4D array
img_array = zeros(b_box(3,4),b_box(3,3),3,length(box_areas) - removed_count);

for i = 1:length(box_areas)-removed_count
    
    extracted_pea = pea_extract(X,Regions_plaything,i);
    
    img_array(:,:,:,i) = extracted_pea;
    
end

%Normalising image array
for i = 1:length(box_areas) - removed_count
    img_array(:,:,:,i) = img_array(:,:,:,i)./max(max(img_array(:,:,:,i)));
end

%%
%Checking if peas were correctly extracted
[m,n,o,p] = size(img_array);
Plotcols = 10; % This is kind of set arbitrarily
Plotrows = ceil(p/Plotcols); % Relative to # of peas
for i = 1:p % ?o?, not zero
subplot(Plotrows,Plotcols,i);
imagesc(img_array(:,:,:,i));
axis off;
end;

%MEAN PEA!!
mean_pea = zeros(b_box(3,4),b_box(3,3),3);
for i = 1:b_box(3,4)
    for j = 1:b_box(3,3)
        for n = 1:3
            mean_pea(i,j,n) = mean(img_array(i,j,n,:));
            
        end
    end
end

figure(1);imagesc(mean_pea);
    
