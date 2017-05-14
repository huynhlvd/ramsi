function [m_nl1] = nl1Bound(x, Zin)
% Matlab code by Huynh Van Luong
% Mar. 6, 2016
% Copyright (c) 2016, Huynh Van Luong, Email: huynh.luong@fau.de
% Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
% All rights reserved.
% 
% Computing the measurement bounds for the n-l1 minimization problem:
% 	minimize \sum ||Wj*(x - zj)||_1 subject to  Ax = b
% 	   x	   j
% 	where b: m x 1,  A: m x n,  x, zj: n x 1, Wj = diag(n), wij (\in Wj) > 0.                       j 
%
% FUNCTIONS:
%   [m_nl1] = nl1Bound(x, Zin)
%
% INPUTS:
%   x   - n x 1 vector of source
%   Zin - n x J matrix or (J) vectors zj = Zin(:,j) of multiple side information 
%
% OUTPUT:
%   m_nl1 - the measurement bound 
%%
% Immediate values
Z = Zin;
J = size(Z,2);
n = size(x,1);
absMat = zeros(n,J+1); % absolute matrix
sgnMat = zeros(n,J+1); % sign matrix
absMat(:,1) = abs(x);
sgnMat(:,1) = sign(x);
for i = 1:J
    absMat(:,i+1) = abs(x - Z(:,i));
    sgnMat(:,i+1) = sign(x - Z(:,i));
end
zMat = (absMat==0);
zcMat = sum(zMat,2);

% p
p = sum(zcMat == 0);

% \bar{a}_n-l1
eps = 1e-5;
aIdx =  find(zcMat==0);
a_nl1 = 0; 
for i = aIdx'
    a_nl1 = a_nl1 + (sum( ((1./(absMat(i,:) + eps)).*sgnMat(i,:))/sum(1./(absMat(i,:)+eps))))^2;
end

% Computing c_i
cIdx = find(((zcMat>0).*(zcMat<J+1)));
if isempty(cIdx)
    cIdx = 1;
    c(cIdx) = ones(cIdx);    
end
for i = cIdx'
    c(i) = zcMat(i)/(eps*sum(1./(absMat(i,:)+eps)));
end

if isempty(cIdx)
    s_nl1 = p;
    c_min = 1;
else
% \bar{s}_n-l1
    s_nl1 = p + sum( 1 - c(cIdx)); 

% min{c_i}
    c_min = min(c(cIdx)); 
end


% Kappa_n-l1
kap_nl1 = 2*min(c_min)/(sqrt(pi*log(n/s_nl1))*(2*c_min-1)); 

% Delta_n-l1
delta_nl1 = (kap_nl1 - 1)*(s_nl1 - p))

%% Computing the final bound
m_nl1 = ceil(2*a_nl1*log(n/s_nl1) + (7/5)*s_nl1 + delta_nl1 + 1;    

