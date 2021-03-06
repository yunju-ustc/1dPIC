function poisson(field, prm)
    % Calculate Ex from Poisson equation

    f = field; % reference to the Field obj
    
    %X2=2:129
    f.ex(prm.X2) = f.ex(prm.X2-1) + f.rho(prm.X2);%定义真空介电常数等于1

    ex0 = sum(f.ex(prm.X2))/prm.nx      %所有网格点的平均电场强度
    f.ex(prm.X2) = f.ex(prm.X2) - ex0;  %？归一化？？
    f.ex(1) = f.ex(prm.nxp1);           %对称边界条件 nxp1=nx+1
    f.ex(prm.nxp2) = f.ex(2);           %对称边界条件 nxp2=nx+2
end
