function String = BDecrypter(imAddr)

    % This Function Decryptes the Image and gets backs
    % the Txt hidden in the Image!

    im = imread(imAddr);                    % Read Image

    % Extract Text Size
    SizeVector = im(1:3, 1, 1);
    Size = 0;
    for i = 1:numel(SizeVector)
        Size = Size + double(SizeVector(i)) * (256 ^ (i-1));
    end

    % Bring out the Txt Code from the Img
    Coded = rem(im ,8);
    Coded = Coded(:);
    Coded(1:3) = [];
    Coded = de2bi(Coded);
    Coded = permute(Coded, [2 1]);

    % Turn Coded Text into Needed Format
    Code = zeros(8, Size);
    for i = 1:numel(Code)
        Code(i) = Coded(i);
    end

    % Decode the Code
    Code = permute(Code, [2 1]);
    String = StringDecoder(Code);
end


function String = StringDecoder(Code)

    % This Function Decryptes the Coded Text out of Img
    for i = 1:size(Code, 1)
        if Code(i, 3)
            Code(i, 4:end) = fliplr(Code(i, 4:end));
        end
    end

    Code(:, 3) = [];
    Code = fliplr(Code);
    String = char(bi2de(Code)' + 32);

end