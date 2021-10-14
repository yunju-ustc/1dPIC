function poisson(field, prm)
    % Calculate Ex from Poisson equation

    f = field; % reference to the Field obj
    
    %X2=2:129
    f.ex(prm.X2) = f.ex(prm.X2-1) + f.rho(prm.X2);%half-integer

    ex0 = sum(f.ex(prm.X2))/prm.nx      %所有网格点的平均电场强度
    f.ex(prm.X2) = f.ex(prm.X2) - ex0;  %half-integer->full-integer
    %***泊松方程边界条件（设计的很巧妙）****%
    f.ex(1) = f.ex(prm.nxp1);           %计算的起点,至关重要
    f.ex(prm.nxp2) = f.ex(2);           %对称边界条件 nxp2=nx+2
end
