function filtered_image = neighborhood_average_filter(image)
    % Get the size of the input image
    [rows, cols, depth] = size(image);

    % Initialize the output filtered image
    if depth == 1
        % Grayscale image
        filtered_image = zeros(rows - 2, cols - 2);
    else
        % RGB image
        filtered_image = zeros(rows - 2, cols - 2, depth);
    end

    % Loop through each channel (1 for grayscale, 3 for RGB)
    for c = 1:depth
        % Select the appropriate channel (or entire grayscale image)
        if depth == 1
            channel = image;
        else
            channel = image(:, :, c);
        end

        % Process the current channel
        for i = 2:rows-1
            for j = 2:cols-1
                % Get the 3x3 neighborhood
                neighborhood = channel(i-1:i+1, j-1:j+1);

                % Compute the average value
                avg_value = sum(neighborhood(:)) / 9;

                % Assign the result to the output image
                if depth == 1
                    filtered_image(i-1, j-1) = avg_value; % Grayscale
                else
                    filtered_image(i-1, j-1, c) = avg_value; % RGB
                end
            end
        end
    end

    % Convert the output to uint8
    filtered_image = uint8(filtered_image);
end
