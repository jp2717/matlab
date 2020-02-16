function img = pea_extract(original_img,Regions,pea_num)
%pea_extract: Takes in already pre-edited arrays and builds the image file
% from the information in regions and the original image, choosing which pea with pea_num
%Image will have the size according to the input dimensions present in
%'Regions'

b_box = Regions(pea_num).BoundingBox;
centroid = Regions(pea_num).Centroid;

%img = zeros(round(b_box(3)),round(b_box(4)),3);   %width and height respectively

lower_x = round(centroid(1) - b_box(3)/2);
lower_y = round(centroid(2) - b_box(4)/2);
width = round(b_box(3));
height = round(b_box(4));

img = original_img(lower_y:lower_y + height - 1,lower_x:lower_x + width - 1, :);    %number of rows is y and number of rows of collumns is x 
size(img)


% for i = 1:round(b_box(3))   %from min x coordinate
%     for j = 1:round(b_box(4))   %from min y coordinate
%         
%         img(i,j,:) = original_img(i+lower_x,j+lower_y,:);   %extracting image information
%         
%     end
%end


end

