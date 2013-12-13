function dist = dist_logeuc( X, Y )
%DIST_LOGEUC Summary of this function goes here
%   Detailed explanation goes here

    %perform eigen decomposition
    [Vx Dx] = eig(X);
    % Take the logarithm along the diagonal of Dx
    lDx = diag(log(diag(Dx)));
    % Form the covar matrix in log-euclidian space
    Lx = Vx * lDx * Vx';

    %perform eigen decomposition
    [Vy Dy] = eig(Y);
    % Take the logarithm along the diagonal of Dy
    lDy = diag(log(diag(Dy)));
    % Form the covar matrix in log-euclidian space
    Ly = Vy * lDy * Vy';
    
    [Nx Ny] = size(Ly);
    
    %Find the euclidian norm (distance)
    dist = sum(sum(abs(Lx.^2 - Ly.^2)))/(Ny*Nx);

end

