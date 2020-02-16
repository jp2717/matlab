%% This is a solution script for GTAs

% First, we look at the very first part of this practical - loading an
% image which is just stored as a file of bytes on disk, with NO
% specification of the geometry of the file. This is a deliberate
% exercise to get students realising that thepurpose of an image file
% format is to convey information about how the data are organised
% In modern parlance, we refer to the process of writing an image
% to dosk as serialization (appaling term), and the reverse process
% as de-serialization (from disk as a sequence of bytes into a 
% two-dimensional array).

fid=fopen('head.128','r'); 
[x,npels]=fread(fid,[128,128],'uchar'); 
x=x';  
fclose(fid); 

% Display image
image(x);

% Illustrate the mapping between pixel value and pixel appearance
% (colormap)
colorbar; 
%%%


%% Making a colourmap, from scratch.
% We want to first make a grey-scale colourmap containing 256 different
% shades of gray. Since each red, green and blue value is represented with
% 8 bits, there will be only 8 possible grey scale values (since we have
% the constraint that R = G = B for grey scale



% We will look at two ways of making the same colourmap
% First, we will do this the way you might use a traditional
% programming language (like C) to loop over all elements of a 
% colourmap structure, assigning elements to the RGB channels for each row
% of the colourmap. This may be easier for some students to grasp
% Then, we'll do it the "vectorized" way, using Matlab's
% vector/matrix assignment syntax

% Number of desired colourmap entries is 256
% Assume values go from 0 to 1 in equal increments
% The size of each step will be 1/255.  Make sure students get this
% right (i.e. delta = 1/(256-1)), because we start from 0
NSteps = 256;
delta = 1/(NSteps-1);

for Channel = 1:3
    for n = 1:256
        greymap1(n,Channel) = (n-1)*delta;
    end
end

figure;
image(x);colormap(greymap1);

% Now, do this the vectorized way

% Since the values go from 0 to 1, it is useful to make a 
% ramp that goes up in intensity
ramp = 0:delta:1;
greymap2(:,1) = ramp';
greymap2(:,2) = ramp';
greymap2(:,3) = ramp';

% Or, you could use this:
graymap2 = repmat(ramp',1,3); % Look up the repmat syntax

figure;
image(x);colormap(greymap1);
%%%
pause;

%% We are now going to load an image that is stored with a colourmap
%% Loading an image with the imread() command
close all;
X = imread('trees.tif'); % DANGEROUS!!!

image(X); colormap(gray(126)); colorbar % NOT RIGHT, BUT SEEMS TO WORK
title('WRONG!!!','FontSize',20);

% By assuming we know that each pixel corresponds to  a linearly
% scaled intensity, we are NOT rendering the image as the "artist"
% intended.

% We SHOULD use this:
[X,map] = imread('trees.tif');

% Use tthe whos command to see whether map is empty or not
whos map

% Also a good idea to use:
whos X

% Why?  For the answer, see the NEXT section on true colour images

% You will see that 'map' is NOT empty; let's use this, and
% see what we get:
figure;
image(X);colormap(map);colorbar; % As the artist intended
title('RIGHT!!!','FontSize',20);

% NOTE: increasing pixel index value does NOT necessarily correspond to 
% increased intensity; that is why assuming a linear colormap is 
% wrong, even if you were to display the image as a grey-scale image

pause;
%% Now, we move onto an image filw which HAS NO COLOURMAP
%  instead, it consists of all three colour planes stored
%  within the file.
close all;
[X,map] = imread('lily.tif'); % Note - also a tif file....

% but check out whos for X and for map

whos map

% and
whos X

% If you don't understand the point of this, talk to a demonstrator!!!

% So, we can display this image as a true-colour image
image(X);

% Note that the class of this variable is uint8, so only integer values
% can be represented. Those values will HAVE to go between 0 and 255
% i.e. unit8 = 8 bits, so we can represent numbers from 0 to 255. No higher.

% To display each of the individual channels, we can use
subplot(1,3,1);image(X(:,:,1));axis square; axis off
subplot(1,3,2);image(X(:,:,2));axis square; axis off
subplot(1,3,3);image(X(:,:,3));axis square; axis off
colormap(gray(256));

% NOTES:
% Note that the pinkish-red dots are nearly INVISIBLE on the red channel!
% If you don't less than a 256 element colormap, you get saturation
% More than 256 elements on the colormap does not necessarily work well
% - depends on display hardware and software support
% Note that the dots are visible as dark spots on the green and blue
% channels!
%
% Now, we'll calculate the trichromatic coefficients (Normalised RGB 
% channels)
%
% It is convenient to extract the channels first...
R = X(:,:,1);G = X(:,:,2); B = X(:,:,3);

% Now, the trichromatic coefficient calculation
% This comes from lecture notes; 
% MUST use ./ which is the elementwise division operator
% MUST convert to double precision
% Since denominator is the same, compute this separately

D = double(R) + double(G) + double(B); 

x = double(R)./D; % NOT just a / or you will get nonsense!

y = double(G)./D;

z = double(B)./D;

% What are the biggest and smallest values in 
% this calculation?

BIGGEST = max([x(:);y(:);z(:)]);% read carefully!
SMALLEST = min([x(:);y(:);z(:)]);

% Because we have done a floating point calculation, the values that
% we have are no longer suitable to use as indices into a colourmap!!
% Indices MUST be non-zero integer numbers. So, we need to scale these
% values so we can make use of a 256 scale (or whatever) colour map.

% The right scaling is to map the smallest value onto element 1, and
% the largest onto element 1. To achieve this, use the following:
isx = 1+round(255*(x - SMALLEST)/(BIGGEST - SMALLEST));
isy = 1+round(255*(y - SMALLEST)/(BIGGEST - SMALLEST));
isz = 1+round(255*(z - SMALLEST)/(BIGGEST - SMALLEST));

figure;
subplot(1,3,1);image(isx);axis square; axis off
subplot(1,3,2);image(isy);axis square; axis off
subplot(1,3,3);image(isz);axis square; axis off
colormap(gray(256));

% Note the difference in the appearance of the RED channel;
% We can see the PERCEPTUAL colour difference that we see with
% our eyes in the full colour image is better reflected in
% normalised RGB space. 




