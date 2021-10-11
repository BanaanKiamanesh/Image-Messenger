clear
close all
clc

%% Start

% Get Img input
imAddr = input('Enter Image Directory:\n', 's');

% Input Properites Help
maxSize = ImageCapCalc(imAddr);
disp('Enter Your Message Considering:')
disp(['     Max In Length Can be: ' num2str(maxSize)])

String = input('\n', 's');          % Get Input Text

BEncrypter(String, imAddr);         % Do it!