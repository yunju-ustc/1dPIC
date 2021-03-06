function charge(particle,field,prm)
% Calculate the charge on the grid from particles

%  global nxp1 nxp2
%  global q
%  global rho0

p = particle; % reference to the particle obj

% prm.rho0 = -sum(obj.q(1:obj.ns) .* obj.np(1:obj.ns)) / obj.nx *ones(obj.nxp2,1);
% Field.rho = zeros(prm.nxp2,1);
field.rho = prm.rho0; 

n2 = 0;
for k=1:prm.ns
   n1 = n2;
   n2 = n1 + prm.np(k);
   for m = (n1+1):n2
      i  = floor(p.x(m) + 2.0);  
      i1 = i + 1;
      s2 = (p.x(m)+ 2.0 - i)*prm.q(k);    %分到右侧网格点的电荷量
      s1 = prm.q(k) - s2;                 %分配到左侧网格点的电荷量
      field.rho(i ) = field.rho(i ) + s1; %累加分配到左侧网格的电荷量
      field.rho(i1) = field.rho(i1) + s2; %累加分配到右侧网格的电荷量
   end
end

%？
field.rho(2) = field.rho(2) + field.rho(prm.nxp2) - prm.rho0(2);%?
field.rho(1) = field.rho(prm.nxp1);
field.rho(prm.nxp2) = field.rho(2);


end
