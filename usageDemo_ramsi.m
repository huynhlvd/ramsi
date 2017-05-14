% Demo of using ramsi.m for RAMSI
% Matlab code by Huynh Van Luong, Email: huynh.luong@fau.de
% Oct. 6, 2015
% Copyright (c) 2015, Huynh Van Luong, Email: huynh.luong@fau.de
% Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
% All rights reserved.
% 
%% Initialization 
% A  - m x n measurement matrix 
n = 1000;
m = 370;
A = randn(m,n);
% Supports of ||x - zj||_0 = sj
s0 = 128;
s1 = 256; 
s2 = 256;
s3 = 256;
S = [s1 s2 s2]; 
J = size(S,2);

%% Generating x
ranDat = [randn(s0,1); zeros(n - s0,1)];
perm = randperm(n);
x = ranDat(perm);
%% Generating zj = Z(:,j)
Z = zeros(n,J);
for j = 1:J
    ran = [randn(S(j),1); zeros(n - S(j),1)];
    ran = ran(perm);
    Z(:,j) = x + ran; % Positions of non-zeros of x and zj are coincided 
end

%% Running one RAMSI demo
% Input: observation b with m measurements, projection matrix A, side information Z
% Output: recovered source x_hat

b = A*x;
x_hat = ramsi(A, b, Z);
fprintf('Recovered error: %4.8f \n', norm(x_hat - x,2)/(norm(x,2)));


