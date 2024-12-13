function medfilter = medgray(noisy)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
    filter_size = 3; % Define the size of the median filter
    pad_size = floor(filter_size / 2); % Padding for 3x3 filter is 1

    % Step 1: Pad the grayscale image with zeros
    padded_img = padarray(noisy, [pad_size pad_size], 0, 'both'); % Zero-padding

    % Step 2: Initialize the output image (same size as the original)
    medfilter = zeros(size(noisy));

    % Step 3: Apply the median filter (without using the built-in median function)
    for i = 1:size(noisy, 1) % Loop over rows of the original image
        for j = 1:size(noisy, 2) % Loop over columns of the original image
            % Step 3a: Extract the 3x3 neighborhood around pixel (i,j)
            neighborhood = padded_img(i:i + filter_size - 1, j:j + filter_size - 1);

            % Step 3b: Sort the values in the neighborhood to find the median
            neighborhood_vector = neighborhood(:); % Flatten the 3x3 block into a vector
            sorted_values = sort(neighborhood_vector); % Sort the vector

            % Step 3c: Find the median (middle element in the sorted vector)
            median_value = sorted_values(5); % The 5th element is the median in a sorted 3x3 block

            % Step 3d: Assign the median value to the corresponding pixel
            medfilter(i, j) = median_value;
        end
    end

    % Step 4: Convert the filtered image back to uint8 (image format)
    medfilter = uint8(medfilter);

%     Step 5: Display the filtered image in the axes
%     axes(handles.axes4); 
%     imshow(medfilter, []);
%     title('Median Filtered Image');


end

