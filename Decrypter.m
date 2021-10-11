clear
close all
clc

%% Start

% Get Img input
imAddr = input('Enter Image Directory:\n', 's');

String = BDecrypter(imAddr);
disp(String)