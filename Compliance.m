clc
clear all
close all

%% Condição Fronteira Tensão XX 
[energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesXX] = leitura_excel();

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
stressesXX_med = sum(stressesXX.*element_volume)/Volume_RVE;

syms Ex Ey Ex vxy vyx vxz vzx vyz vzy

% sigma xx aplicado

sigma_xx = 1;

eq1 = extensaoXX_med == sigma_xx/Ex;
eq2 = extensaoYY_med == -sigma_xx*vxy/Ex;
eq3 = extensaoZZ_med == -sigma_xx*vxz/Ex;

equations = [eq1, eq2, eq3];
solution = solve(equations, [Ex,vxy,vxz]);
disp(solution);

C11 = energy_RVE*2/Volume_RVE
Exx_energy = 1/C11*10^-3

