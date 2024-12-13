function sobel = sobel_detector(img)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    if size(img, 3) == 3
    sobel = rgb2gray(img);
    else
        sobel = img;
    end
    c = double(sobel);
    for i = 1 : size(c, 1)-2
        for j = 1:size(c, 2)-2
            gx = (1*c(i,j)+2*c(i, j+1)+1*c(i, j+2))-(1*c(i+2, j)+2*c(i+2, j+1)+1*c(i+2, j+2));
            gy = (1*c(i,j)+2*c(i+1, j)+1*c(i+2, j))-(1*c(i, j+2)+2*c(i+1, j+2)+1*c(i+2, j+2));
            sobel(i ,j) = sqrt(gx.^2 + gy.^2);
        end
    end

end

