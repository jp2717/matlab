%% -- Image Processing: Tutorial 1 -- %%

clear all;
clc;

%% Part 1.2

fid=fopen('head.128','r'); % Opens file for reading
[x,npels]=fread(fid,[128,128],'uchar'); % Reads data values
% into matrix x with 128 rows,
% and 128 columns
x=x'; % Matlab reads in arrays with a different index order [Ctd...]
% to that of ?C? File was created using C, so transpose matrix
fclose(fid); % Close the file handle
%whos

figure(1);image(x);    %%Displays image coded by x
colorbar;     %Presents a colorbar relating color to intensities

%% Part 1.3

tutorial_img_display(2,x,gray(64)); %64 element grayscale for colormap
map = gray(64);
whos;

%% Part 1.4: Creating my own colormap for grayscale images

mymap = [ [0:(1/255):1]' [0:(1/255):1]' [0:(1/255):1]'];
tutorial_img_display(3, x, mymap);  %% Creates a similar grayscale image as before
% except that in this case, the same values do not generate enough
% intensity
tutorial_img_display(4, x, [ [0:(1/15):1]' [0:(1/15):1]' [0:(1/15):1]' ]);  % Very poor quantisation
tutorial_img_display(5, x, [ [0:(1/43):1]' [0:(1/43):1]' [0:(1/43):1]' ]);

%% Part 1.5: Creating a colormap for color images

clear; close all; % Close all windows, and clear all variables
[X,map] = imread('trees.tif');

image(X); % Display the image?
colormap(map); % with its colormap (as read from the TIFF file)

%Each pixel has 8 bytes, I expected 3!

%% Part 1.6: True Color (RGB) images (no color maps)
clear; close all; % Close all windows, and clear all variables
[X,map] = imread('lily.tif');

column_ramp = [0:1/255:1]';% Create column of values running from 0 to 1
% The next 3 lines create three colourmaps, intended for displaying the
% red green and blue components separately.
redmap = [column_ramp,zeros(256,1),zeros(256,1)];   % Makes pinkish red dots be nearly invisble!
greenmap = [zeros(256,1),column_ramp,zeros(256,1)];
bluemap = [zeros(256,1),zeros(256,1),column_ramp];

% Below, display the three image planes in 3 separate windows
figure(1); colormap(redmap);image(X(:,:,1)); colorbar;
figure(2); colormap(greenmap);image(X(:,:,2)); colorbar;
figure(3); colormap(bluemap);image(X(:,:,3)); colorbar
tutorial_img_display(4, X(:, :, 1), gray(256)); %Greyscale image for displaying red component

% Changing coordinates
R =double(X(:,:,1)); 
G =double(X(:,:,2)); 
B = double(X(:,:,3));

% new nRGB (xyz coordinates)
x = (R./(R+G+B));
y = (G./(R+G+B));
z = (B./(R+G+B));

x_norm = zeros(186,230,3);
for i = 1:186
    for j = 1:230
        x_norm(i,j,:) = [x(i,j) y(i,j) z(i,j)];
    end
end

BIGGEST = max([x(:);y(:);z(:)]);% read carefully!
SMALLEST = min([x(:);y(:);z(:)]);

%Length for which the map was normalised by
l = length(column_ramp);

% Below, display the three image planes in 3 separate windows
figure(5); colormap(gray(256));image(round(x_norm(:,:,1)*l)); colorbar;
figure(6); colormap(gray(256));image(round(x_norm(:,:,2)*l)); colorbar;
figure(7); colormap(gray(256));image(round(x_norm(:,:,3)*l)); colorbar
figure(8);image(x_norm);
figure(9); image(X);

%% Part 1.7: DICOM 3.0 Images

clc;
info = dicominfo('US-PAL-8-10x-echo.dcm');
[X, map] = dicomread('US-PAL-8-10x-echo.dcm');
montage(X, map);

M=immovie(X,map);
data = M.cdata;
% dataR = data(:,:,1);
% dataG = data(:,:,2);
% dataB = data(:,:,3);

movie(M,3,10);

%% Part 1.8: Challenge

% Grayscale values are the ones that are either (0,0,0) or (1,1,1),

%%Testing the colors of a randomly generated image
img_test = ones(160,200,3);

for i = 1:160
    img_test(i,:,1) = i;
    
end
img_test = uint8(img_test);

image(img_test);

% After testing, I have realised that same R,G and B values lead to
% grayscale colors
logical_array = zeros(430,600,1);

%Looping over the pixel information of the image
for i = 1:430
    for j = 1:600
        if data(i,j,1) == data(i,j,2)   %IF R = G
            if data(i,j,1) == data(i,j,3)
                logical_array(i,j,:) = 1;
            end
        else
            logical_array(i,j,:) = 0;
        end
        
    end
end


