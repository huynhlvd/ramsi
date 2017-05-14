function [x_hat] = ramsi(A, b, Zin)
% Matlab code by Huynh Van Luong
% Oct. 6, 2015
% Copyright (c) 2015, Huynh Van Luong, Email: huynh.luong@fau.de
% Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
% All rights reserved.
% 
% RAMSI minimizes a convex problem
%   min {1/2||Ax - b||_2^2 + lambda*sum(||Wj*(x - zj)||_1)}
%    x                               j 
%
% FUNCTION:
%   [x_hat] = ramsi(A, b, zj)
%
% INPUTS:
%   A   - m x n measurement matrix 
%   b   - m x 1 vector of observations/data 
%   Zin - n x J matrix or (J) vectors zj = Zin(:,j) of multiple side information 
%
% OUTPUT:
%   x_hat - n x 1 vector of recovered source 
%
% PUBLICATION: Huynh Van Luong, J. Seiler, A. Kaup, and S. Forchhammer, "A Reconstruction
%       Algorithm with Multiple Side Information for Distributed Compression of Sparse Sources," 
%       in Data Compression Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.
%
% REFERENCE CODE: SolveFISTA.m (http://people.eecs.berkeley.edu/~yang/software/l1benchmark) 
%
%% Input optional parameters:
    t0 = tic;
    STOPPING_SPARSE_SUPPORT = 1;
    STOPPING_OBJECTIVE_VALUE = 2;
    STOPPING_SUBGRADIENT = 3;
    STOPPING_DEFAULT = STOPPING_OBJECTIVE_VALUE;
    stoppingCriterion = STOPPING_DEFAULT;
    maxIter = 5000; % maximum number of iterations
    tolerance = 1e-10; % tolerance for stopping criterion.

    
%% Initializing optimization variables
    n = size(A, 2);
    t_k = 1; 
    
    invA = pinv(A);
    G = invA*A;
    L0 = max(eig(G));% default 1
    nIter = 0;
    c = invA*b;
    lambda0 = 0.5*L0*norm(c,inf);
    eta = 0.95;
    
    lambda_bar = 1e-5;
    % xk = zeros(n,1); % default
    xk = A\b; % initialized 
    lambda = lambda0;
    L = L0;

%% Input SIs
    J = size(Zin,2) + 1;
    Z = zeros(n,J);
    Z(:,1) = zeros(n,1); % Adding z0 as SI of conventional norm-1 term
    Z(:,2:end) = Zin;

%% Loop step k >= 1
    timeSteps = nan(1,maxIter);

    keep_going = 1;
    nz_x = (abs(xk) > eps*10);
    Wk = zeros(n,J); % Weights on source
    Wk(:,1) = ones(size(xk,1),1); % Weights on source
    for j = 2:J
        Wk(:,j) = zeros(size(xk,1),1); % Weights on SIs
    end

    f = 0.5*norm(b - A*xk)^2 + lambda_bar*sumNorm1(Wk, xk, Z); 
    xkm1 = xk;
    epsi = 1e-5;
    uk = xk;
    Wkp1 = Wk;
    % Starting loop, which is based on SolveFISTA.m
    while keep_going && (nIter < maxIter)
        nIter = nIter + 1;    
        temp = G*uk - c; % gradient of f at uk  

        gk = uk - (1/L)*temp;

        xk = softMSI(gk, lambda, L, Wk, Z);

        timeSteps(nIter) = toc(t0);
        
        switch stoppingCriterion
            case STOPPING_SUBGRADIENT
                sk = L*(uk - xk) + G*(xk - uk);
                keep_going = norm(sk) > tolerance*L*max(1, norm(xk));
                
            case STOPPING_SPARSE_SUPPORT
                % compute the stopping criterion based on the change
                % of the number of non-zero components of the estimate
                nz_x_prev = nz_x;
                nz_x = (abs(xk) > eps*10);
                num_nz_x = sum(nz_x(:));
                num_changes_active = (sum(nz_x(:) ~= nz_x_prev(:)));
                if num_nz_x >= 1
                    criterionActiveSet = num_changes_active/num_nz_x;
                    keep_going = (criterionActiveSet > tolerance);
                end
                
            case STOPPING_OBJECTIVE_VALUE
                % compute the stopping criterion based on the relative
                % variation of the objective function.
                prev_f = f;
                f = 0.5*norm(b - A*xk)^2 + lambda_bar * sumNorm1(Wk, xk, Z);
                criterionObjective = abs(f - prev_f)/(prev_f);
                keep_going =  (criterionObjective > tolerance);

            otherwise
                error('Please define stopping criterion.');
        end   
        lambda = max(eta*lambda, lambda_bar);   

        % Weight updating
        for j = 1:J   
            denom = zeros(size(xk,1),1);     
            for i = 1:J
                denom = denom + (epsi + abs(xk - Z(:,j)))./(epsi+abs(xk - Z(:,i)));
            end
            Wkp1(:,j) = 1./(denom);
        end 

        % Updating values for the next iteration
        t_kp1 = 0.5*(1 + sqrt(1 + 4*t_k*t_k));          
        ukp1 = xk + ((t_k - 1)/t_kp1)*(xk - xkm1);  
        
        % Next iteration   
        xkm1 = xk;

        Wk = Wkp1;        

        uk = ukp1;
        t_k = t_kp1;
    end
    
%% Output
    x_hat = xk;

end
%% ------------------------------------------ -----------------------------
% From this, here are some supported subfunctions
% ------------------------------------------------------------------------

%% Soft thresholding function for multiple side information 
function y = softMSI(x, lambda, L, Wk, Z)
    A0 = -1e+20 + zeros(size(x,1),1);
    A0 = [A0, Z, A0 + 2e+20];
    [A, I] = sort(A0,2); % Rearranging values at a given index
    W0 = [zeros(size(x,1),1), Wk, zeros(size(x,1),1)];
    W = W0;
    
    for i = 1:size(x,1)
        w = W0(i,:);
        W(i,:) = w(I(i,:)); % Rearranging weights accordingly 
    end
    y = proxMat(x, A, W, lambda, L); % Proximal function
end
%% Proximal function for softMSI
function [u] = proxMat(x, A, W, lambda, L)
    J = size(A,2) - 3;
    S = zeros(size(x,1),size(A,2) - 1);
    P = zeros(size(x,1),2*size(A,2) - 2);
    for m = 1:size(A,2) - 1
       for j = 2:J + 2
           S(:,m) = S(:,m) + W(:,j)*((-1)^(m - 2 < j - 2));       
       end
       S(:,m) = S(:,m)*(lambda/L);
       P(:,2*m - 1) = A(:,m) + S(:,m);
       P(:,2*m) = A(:,m + 1) + S(:,m);
    end
    XX = 0*P;
    
    for j = 1:2*(size(A,2) - 1)
        XX(:,j) = XX(:,j) + x;
    end
    NN = sign(P - XX);
    SNN = NN; 
    UM = SNN;
 
    for j = 2:2*(size(A,2) - 1)
        SNN(:,j) = NN(:,j-1) + NN(:,j);
    end    
    II = (SNN >= 0) .* (SNN <= 1);
    
    for j = 1:2*(size(A,2) - 1)
        if (mod(j,2) == 0)
            UM(:,j) = x - S(:,(j/2));
        else
            UM(:,j) = A(:,floor(j/2) + 1);
        end
    end      
    UM = II .* UM;
    u = sum(UM,2);
end

%% Calculating sum of norm1: sum(norm(wkj.*(xk - zj),1));
function [norm1Sum] = sumNorm1(Wk, xk, Z)
    norm1Sum = 0;
    for j = 1:size(Z,2)
        norm1Sum = norm1Sum + norm(Wk(:,j).*(xk - Z(:,j)),1);
    end
end