% Head
fid = fopen('head.128','r');
[x,npels] = fread(fid,[128,128],'uchar');
x = x';
fclose(fid);

imagesc(x);colormap(gray(128));

Fx = fft2(x);

whos Fx  % Note the size and nature of the Fx
%%%%

%%%%
% Inverse fft
xdash = ifft2(Fx); % 

whos xdash % Note that on different versions of Matlab, result will have a different type
           % The result *should* be real, floating point; on pre 2011
           % versions of Matlab, the result will be complex, but with a
           % very tiny (1e-15 or so!) imaginary part
          
imagesc(xdash)% OR imagesc(real(xdash));

%  Computing difference image
d = x - xdash; % Or x - real(xdash) for pre-2011 versions of Matlab

imagesc(d);  % Looks strange, but examine the values - should be VERY small, if not zero

%%

% To visualise basis images (for example)
B = zeros(16,16);

% set ONE coefficient to 1
B(5,10) = 1;

basisimage = ifft2(fftshift(B)); % IFFT shift is only used becaue I 
                     % like to have low rates of oscillation in the middle
                     % of 2D DFT space - also, it is sort of conventional
                     % Will also work without ifftshift, but the result
                     % will be a different basis image
subplot(1,2,1);imagesc(real(basisimage));colormap(gray);title('Real part')
subplot(1,2,2);imagesc(imag(basisimage));colormap(gray);title('Imag Part');

%% Now for the Energy Compaction Stuff
% Remember that from Part 1, Fx is our Fourier domain
% representation.  Let's try the sort command on a bunch of 
% values in a matrix (using the help command as well !)
[v,idx] = sort([ 2 4 1; 3 1 6; 1 9 2]) % Random-ish values in matrix

% SORT IS SORTING COUMN BY COLUMN.  NOT WHAT WE WANT.
% Instead, try this: 
M = [ 2 4 1; 3 1 6; 1 9 2] % Assign to an array;

[v,idx] = sort(M(:))

% So now the values are sorted in increasing order;
[v,idx] = sort(M(:),'descend') % Values are sorted in decreasing order


% Now, we can simply loop over the values 100 at a time
% Moving to the real Fourier space of the head image
Fx = fft2(x);

[v,idx] = sort(abs(Fx(:)),'descend');
Chunks = 200;

sFx = zeros(size(Fx));
Nits = length(Fx(:))/Chunks;

figure;
subplot(1,2,1);imagesc(x);colormap(gray);

for i = 1:Nits
    sFx(idx((i-1)*Chunks+1:i*Chunks)) = Fx(idx((i-1)*Chunks+1:i*Chunks));
    ydash = ifft2(sFx);
    subplot(1,2,2);imagesc(real(ydash));colormap(gray);
    title([num2str(i*Chunks/length(Fx(:))),' of coefficients.']);
    pause(0.5);
    d = double(x) - real(ydash);
    err(i) = sqrt(mean(d(:).^2)/mean(x(:).^2));
end

figure
plot(err);xlabel('iteration')
ylabel('Fractional error (RMS) (Crude)');

