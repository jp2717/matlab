%% Image Processing: Tutorial 3 %%

                                    %% Task 1 %%
                         
                                    clear all; clc; close all;
                                    
% Part 1
F = [1 2; 3 4];         %Original tiny image
B = 0.5 * [1 1 1 -1; ...
            1 1 1 -1; ...
            1 1 1 -1; ...
            -1 -1 -1 1];

V00 = sum(F.*B(1:2,1:2),'all');
V01 = sum(F.*B(1:2,3:4),'all');
V10 = sum(F.*B(3:4,1:2),'all');
V11 = sum(F.*B(3:4,3:4),'all');
V = [V00 V01; V10 V11];             %Coefficients obtained from transform

%Carrying out same procedure for coefficient matrix, new coefficients will
%be called Pij

P00 = sum(V.*B(1:2,1:2),'all');
P01 = sum(V.*B(1:2,3:4),'all');
P10 = sum(V.*B(3:4,1:2),'all');
P11 = sum(V.*B(3:4,3:4),'all');
P = [P00 P01; P10 P11];         %Identical to original matrix, F!!

%Therefore <V,B> = F = inv(vij) = (A^T).V.A, given that the basis set is orthogonal and
%complete

% For a square, separable transform, we need approx 4*N^3 operations, thus
% for a non-separable image transfomration we would need a similar number
% of operations

                        %% Task 2 %%
                        

fid=fopen('head.128','r'); % Opens file for reading
[x,npels]=fread(fid,[128,128],'uchar'); % Reads data values
% into matrix x with 128 rows,
% and 128 columns
x=x'; % Matlab reads in arrays with a different index order [Ctd...]
% to that of ?C? File was created using C, so transpose matrix
fclose(fid); % Close the file handle
%whos
figure(1);imagesc(x);   %normal image

x = double(x);
x_ft1 = fft2(x);    %Exact same size as the original image
x_ft2 = fft2(fftshift(x));  %Exact same size as original image
figure(2); imagesc(abs(x_ft1)); colorbar;
%Significant coefficients are more present around the very top of the image
%and some at the bottom of the image, representing high frequencies along
%the vertical direction
figure(3); imagesc(abs(x_ft2)); colorbar;    %Not exactly sure on the effect of the command yet

x_dash = ifft2(x_ft1);    %Recovering the image
x_dash2 = ifft2(x_ft2);
figure(4); imagesc(x_dash); title('Without shift');
figure(5); imagesc(x_dash2); title('With shift');   %Real funky, literally breaks the image apart and separates them

%Difference between the images
SSE = sum((x - x_dash).^2,'all')/(128*128); %Relatively insignificant error


%%Visualising the basis image

empty_f = zeros(16,16); %Technically a fourier space image
empty_f(5, 10) = 1;
img_gen = ifft2(fftshift(empty_f));
figure(6); imagesc(real(img_gen)); colormap(gray(64)); title('Real Part');
figure(7); imagesc(imag(img_gen)); colormap(gray(64)); title('Imaginary Part');

%Confirming orthogonality
orthog = sum(real(img_gen).*imag(img_gen),'all');

%COME BACK TO THIS SECTION LATER

%Energy Compaction Property

x_ft1_v = [];   %Made into on M*N vector
for i = 1:128
    x_ft1_v = [x_ft1_v x_ft1(i,:)];
    
end


%Fiding the top x component indices and the respective images
indices = [];
x_ft1_v_temp = x_ft1_v;
mov_array = zeros(128,128,1,20);
err = [];

for top_comp = 100:100:2000
    for i = 1:top_comp
        [Y, I] = max(x_ft1_v_temp);
        row = floor(I/128) + 1;
        col = I - (row - 1)*128;
        indices = [indices; row col];
        x_ft1_v_temp(I) = 0;
    end
    
    x_ft1_cut = zeros(128,128);

    for i = 1:128
        for j = 1:128
            for m = 1:top_comp
                if(indices(m,1) == i)
                    if(indices(m,2) == j)
                        x_ft1_cut(i,j) = x_ft1(i,j);
                    end
                end
            end
        end
    end
     %Turning output arrays into grayscale with 64 levels and adding image into our array
     X = abs(ifft2(x_ft1_cut));
     min_x = min(X,[],'all');
     max_x = max(X,[],'all');
     X = round(224.*(X - min_x)./max_x) + 1; %normalized and placed into the correct grayscale
     curr_err = sum((x-X).^2,'all')/(128*128);
     err = [err curr_err];
     
    mov_array(:,:,1,(top_comp/100)) = X;    %4-D argument is what the movie command requires
end

M = immovie(mov_array,gray(224));
figure(8); axis([0 128 0 128]);         %Ask about squished image!!!
movie(M,5,10);  %PLaying movie

figure(9); plot([100:100:2000], err); xlabel('Number of Recovered Components');
ylabel('SSE');


                                    %% Task 3 %%

clear all; close all;
circle = zeros(129,129);
center = 65;
radius = 25;

for i = 1:129
    for j = 1:129
        if (((i - center)^2 + (j - center)^2)^0.5 < radius)   %If enclosed by a circle of our chosen radius
            circle(i,j) = 1;
        end
        
    end
end

figure(1);imagesc(circle.*64); colormap(gray(64));

[ca,ch,cv,cd] = dwt2(circle,'haar','mode','sym');
figure(2);imagesc(ca);
figure(3); imagesc(ch);
figure(4); imagesc(cv);
figure(5); imagesc(cd);

