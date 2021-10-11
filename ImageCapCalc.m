function maxSize = ImageCapCalc(imAddr)

    % This Function Calculates the
    % Possible Capacity of the Image to Take Txt

    im = imread(imAddr);                % Read Img

    % 8bit Vals into 3bit
    maxSize = floor((numel(im) - 3) * 3 / 8);
end