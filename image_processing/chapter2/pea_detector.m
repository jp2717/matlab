function pea_detector(image,BoundingBox,centroids)
%rect_adder takes as input the array containing rectangle information
%adds it to the original image
hold on;
l = length(BoundingBox);    %Number of rectangles to draw/peas in the image
imagesc(image);

%Loop that adds each rectangle, one by one
for i = 1:l
    
    h = rectangle('Position',BoundingBox(i,:));%Adds a rectangle for each pea
    set(h,'EdgeColor',[0 1 0]);
    plot(centroids(i,1),centroids(i,2),'X');    %Adds X to the centre of each pea
    
end
hold off;
    
end

