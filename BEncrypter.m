function BEncrypter(String, imAddr)

    % This Function Encryptes the Image and Putting
    % Txt in the Image!

    im = imread(imAddr);        % Read Img

    % Get out if Txt is Larger than Possible Cap
    maxSize = ImageCapCalc(imAddr);
    if length(String) > maxSize
        error("Usage:<Str> tooooo Long! Max Length: %s", maxSize)
    end

    Coded = StringCoder(String);            % Encrypte the Img

    im = im - rem(im, 8);                   % Get last 3bits Empty

    % Encrypted Txt into Desired Format
    Coded = Coded';
    Coded = [Coded(:); zeros(3 - rem(numel(Coded), 3), 1)];
    Coded = reshape(Coded, [3, numel(Coded)/3])';
    Coded = bi2de(Coded);

    % Embed String Size in Img
    StrSize = de2bi(length(String));
    StrSize = [StrSize, zeros(1, 24 - numel(StrSize))];
    StrSize = reshape(StrSize, [8, 3])';

    Size = bi2de(StrSize);

    Code = [Size(:); Coded(:)];
    Code = [Code; zeros(numel(im) - numel(Code), 1)];
    Code = reshape(Code, size(im));

    im(1:3, 1, 1) = [0, 0, 0];
    im = im + uint8(Code);

    % Save Img into 'Lovely.png'
    imwrite(im, 'Lovely.png')

end


function Coded = StringCoder(Str)

    % This Function Encryptes the Text into Length*8

    StrSize = length(Str);              % Str Length
    Coded = zeros(StrSize, 8);          % PreAllocate Memory

    list = double(Str) - 32;            % Remove Alias of 32
    list = fliplr(de2bi(list));         % Dec into Bin

    InvIndicator = randi([0, 1], [StrSize, 1]);     % Inverse or not?

    % Do the Inversion
    for i = 1:StrSize(1)
        if InvIndicator(i)
            list(i, 3:end) = fliplr(list(i, 3:end));
        end
        Coded(i, :) = [list(i, 1:2), InvIndicator(i), list(i, 3:end)];
    end

end