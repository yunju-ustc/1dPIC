%*************伪随机数************%
rng('default');
rng(1);

global flag_exit
flag_exit=0

%*************读取参数************%
prm = Parameters

%********renormalization*********%
[prm,ren] = renorm(prm);

%-- initialization --
[hdiag,output] = diagnostics_init(prm);
particle = Particle(prm);
field = Field(prm);
%prm = initial(prm, hdiag);

position(particle,prm);
if prm.iex  %control parameter for electrostatic option
   charge(particle, field, prm);
   poisson(field, prm);
end

%************main loop***********%
jtime=0;
jdiag=1;

%-- Diagnostics at initial time --
hdiag=diagnostics(hdiag,particle,field,output,prm,jtime,jdiag,ren);
if prm.nplot == 0  %nplot: number of output
   return
end

% Time advance loop
for jtime = 1:prm.ntime  %？时间间隔dt和总时间步数的选择
    if prm.iex==2  %iex=2静电；iex=1电磁
        rvelocity(particle, field, prm);
        position(particle, prm);
        position(particle, prm);  %？两次位置变化？？
        charge(particle, field, prm);
        poisson(field, prm);
    else
        bfield(field,prm);
        rvelocity(particle, field, prm);

    end
end


