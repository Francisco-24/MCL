clc
clear all
close all

%% Condição Fronteira Tensão XX 

syms Ex Ey Ex vxy vyx vxz vzx vyz vzy

%%%%%%%%%%% sigma xx aplicado %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesXX] = leitura_excel(1);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
stressesXX_med = sum(stressesXX.*element_volume)/Volume_RVE;

sigma_xx = 1;

eq1 = extensaoXX_med == sigma_xx/Ex;
eq2 = extensaoYY_med == -sigma_xx*vxy/Ex;
eq3 = extensaoZZ_med == -sigma_xx*vxz/Ex;

equations = [eq1, eq2, eq3];
solution = solve(equations, [Ex,vxy,vxz]);
disp(solution);

Ex = double(solution.Ex);
vxy = double(solution.vxy);
vxz = double(solution.vxz);

%%%%%%%%%%% sigma yy aplicado %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesYY] = leitura_excel(2);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
stressesYY_med = sum(stressesYY.*element_volume)/Volume_RVE;

sigma_yy = 1;

eq1 = extensaoXX_med == -sigma_yy*vyx/Ey;
eq2 = extensaoYY_med == sigma_yy/Ey;
eq3 = extensaoZZ_med == -sigma_yy*vyz/Ey;

equations = [eq1, eq2, eq3];
solution = solve(equations, [Ex,vxy,vxz]);
disp(solution);

Ey = double(solution.Ey);
vyx = double(solution.vyx);
vyz = double(solution.vyz);

%%%%%%%%%%% sigma zz aplicado %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesZZ] = leitura_excel(3);
% 
% element_volume = energy./energy_density;
% Volume_RVE = sum(element_volume);
% energy_RVE = sum(energy);
% extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
% extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
% extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
% stressesZZ_med = sum(stressesZZ.*element_volume)/Volume_RVE;
% 
% sigma_zz = 1;
% 
% eq1 = extensaoXX_med == -sigma_zz*vzx/Ez;
% eq2 = extensaoYY_med == -sigma_zz*vzy/Ez;
% eq3 = extensaoZZ_med == sigma_zz/Ez;
% 
% equations = [eq1, eq2, eq3];
% solution = solve(equations, [Ex,vxy,vxz]);
% disp(solution);
% 
% Ez = double(solution.Ez);
% vzx = double(solution.vzx);
% vzy = double(solution.vzy);


% C11 = energy_RVE*2/Volume_RVE
% Exx_energy = 1/C11*10^-3

