function output_struct = size_threshold(regions_struct,lower_threshold_area, upper_threshold_area)
%size_threshold takes in a threshold value for the pixel area of a pea and
%removes elements deemed too small to be peas

l = length(cat(1,regions_struct.Area)); %Defines the number of elements in the struct

%Loop to determine which elements to delete from the pea regions
%Start from top down as removing elements changes indexes
for i = l:-1:1
    if(regions_struct(i).Area < lower_threshold_area) %delete element if not having met threshold
        regions_struct(i) = [];
    else if(regions_struct(i).Area > upper_threshold_area)
        regions_struct(i) = [];
    end
    
end

output_struct = regions_struct;

end

