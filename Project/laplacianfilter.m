% function laplacian = laplacianfilter(img)
% %UNTITLED12 Summary of this function goes here
% %   Detailed explanation goes here
% % % Read the grayscale image
% % img = imread('peppers.png');
% % img = double(img);
% % 
% % % Define the Laplacian kernel manually
% % laplacianKernel = [0 -1 0; -1 4 -1; 0 -1 0];
% % 
% % % Apply the Laplacian filter using convolution
% % filteredImg = conv2(img, laplacianKernel, 'same');
% % 
% % % Display the original and filtered images
% % subplot(1, 2, 1);
% % imshow(uint8(img));
% % title('Original Image');
% % 
% % subplot(1, 2, 2);
% % imshow(uint8(filteredImg));
% % title('Laplacian Filter (Manual)');
% 
% end
% 
function laplacian = laplacianfilter(img)
    % LAPACIANFILTER Applies Laplacian filter to grayscale or RGB images
    % Inputs:
    %   img - grayscale or RGB image
    % Outputs:
    %   laplacian - Laplacian filtered image
    
    % Convert image to double for computation
%     img = imread('peppers.png');
    img = double(img);
    
    % Define the Laplacian kernel manually
    laplacianKernel = [0 -1 0; -1 4 -1; 0 -1 0];
    
    % Check if the image is grayscale or RGB
    [rows, cols, channels] = size(img);
    laplacian = zeros(size(img)); % Initialize output image
    
    if channels == 1
        % Grayscale image: apply the filter directly
        laplacian = conv2(img, laplacianKernel, 'same');
    else
        % RGB image: process each channel independently
        for c = 1:channels
            laplacian(:, :, c) = conv2(img(:, :, c), laplacianKernel, 'same');
        end
    end
    
    % Convert result back to uint8 for display
    laplacian = uint8(laplacian);
    
    % Display the original and filtered images
%     figure;
%     subplot(1, 2, 1);
%     imshow(uint8(img));
%     title('Original Image');
%     
%     subplot(1, 2, 2);
%     imshow(laplacian);
%     title('Laplacian Filter (Manual)');
end
