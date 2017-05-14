% Demo of using nl1Bound.m for computing measurement guarantees for RAMSI
% Matlab code by Huynh Van Luong, Email: huynh.luong@fau.de
% Mar. , 2016
% Copyright (c) 2016, Huynh Van Luong, Email: huynh.luong@fau.de
% Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
% All rights reserved.
% 
%% Initialization 
n = 1000;

% Supports of ||x - zj||_0 = sj
s0 = 128;
sj = 50;
s1 = sj; 
s2 = sj;
s3 = sj;
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

%% Running one nl1Bound demo
% Input: source x and side information Z
% Output: measurement bound m_nl1
m_nl1 = nl1Bound(x, Z);
fprintf('Measurement bound: %d \n', m_nl1);



