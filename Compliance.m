clc
clear all
close all

%% Condição Fronteira Tensão XX 

syms Ex Ey Ez vxy vyx vxz vzx vyz vzy

%% Sigma x Aplicado
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

Ex = double(solution.Ex)*10^-3;
vxy = double(solution.vxy);
vxz = double(solution.vxz);

S11 = energy_RVE*2/Volume_RVE;

%% Sigma y Aplicado
[energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesYY] = leitura_excel(2);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
stressesYY_med = sum(stressesYY.*element_volume)/Volume_RVE;

sigma_yy = 1;

eq4 = extensaoXX_med == -sigma_yy*vyx/Ey;
eq5 = extensaoYY_med == sigma_yy/Ey;
eq6 = extensaoZZ_med == -sigma_yy*vyz/Ey;

equations = [eq4, eq5, eq6];
solution = solve(equations, [Ey,vyx,vyz]);
disp(solution);

Ey = double(solution.Ey)*10^-3;
vyx = double(solution.vyx);
vyz = double(solution.vyz);

S22 = energy_RVE*2/Volume_RVE;

%% Sigma z Aplicado
[energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesZZ] = leitura_excel(3);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;
stressesZZ_med = sum(stressesZZ.*element_volume)/Volume_RVE;

sigma_zz = 1;

eq7 = extensaoXX_med == -sigma_zz*vzx/Ez;
eq8 = extensaoYY_med == -sigma_zz*vzy/Ez;
eq9 = extensaoZZ_med == sigma_zz/Ez;

equations = [eq7, eq8, eq9];
solution = solve(equations, [Ez,vzx,vzy]);
disp(solution);

Ez = double(solution.Ez)*10^-3;
vzx = double(solution.vzx);
vzy = double(solution.vzy);

S33 = energy_RVE*2/Volume_RVE;

%% Sigma yz Aplicado
[energy, energy_density, extensaoYZ, stressesYZ] = leitura_excel1(4);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoYZ_med = sum(extensaoYZ.*element_volume)/Volume_RVE;
stressesYZ_med = sum(stressesYZ.*element_volume)/Volume_RVE;

sigma_yz = 1;
Gyz = sigma_yz/(2*extensaoYZ_med)*10^-3;

S44 = energy_RVE*2/Volume_RVE;

%% Sigma zx Aplicado
[energy, energy_density, extensaoZX, stressesZX] = leitura_excel1(5);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoZX_med = sum(extensaoZX.*element_volume)/Volume_RVE;
stressesZX_med = sum(stressesZX.*element_volume)/Volume_RVE;

sigma_zx = 1;
Gzx = sigma_zx/(2*extensaoZX_med)*10^-3;

S55 = energy_RVE*2/Volume_RVE

%% Sigma xy Aplicado
[energy, energy_density, extensaoXY, stressesXY] = leitura_excel1(6);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXY_med = sum(extensaoXY.*element_volume)/Volume_RVE;
stressesXY_med = sum(stressesXY.*element_volume)/Volume_RVE;

sigma_xy = 1;
Gxy = sigma_xy/(2*extensaoXY_med)*10^-3;

S66 = energy_RVE*2/Volume_RVE;

%% Valores
Ex
Ey
Ez
vxy
vyx
vxz
vzx
vyz
vzy
Gxy
Gzx
Gyz

%% Método da Energia

%Sigma x e sigma y aplicado
energy_tab = readtable('FEM_Decente/TensaoXeY/energy.csv');
energy_density_tab = readtable('FEM_Decente/TensaoXeY/energy_density.csv');
energy = table2array(energy_tab(:,2));
energy_density = table2array(energy_density_tab(:,2));
element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);

S12 = (energy_RVE*2/Volume_RVE - S11 - S22)/2;

%Sigma x e sigma z aplicado
energy_tab = readtable('FEM_Decente/TensaoXeZ/energy.csv');
energy_density_tab = readtable('FEM_Decente/TensaoXeZ/energy_density.csv');
energy = table2array(energy_tab(:,2));
energy_density = table2array(energy_density_tab(:,2));
element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);

S13 = (energy_RVE*2/Volume_RVE - S11 - S33)/2;

%Sigma y e sigma z aplicado
energy_tab = readtable('FEM_Decente/TensaoYeZ/energy.csv');
energy_density_tab = readtable('FEM_Decente/TensaoYeZ/energy_density.csv');
energy = table2array(energy_tab(:,2));
energy_density = table2array(energy_density_tab(:,2));
element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);

S23 = (energy_RVE*2/Volume_RVE - S22 - S33)/2;

Ex_energy = 1/S11*10^-3
Ey_energy = 1/S22*10^-3
Ez_energy = 1/S33*10^-3
Gyz_energy = 1/(2*S44)*10^-3
Gzx_energy = 1/(2*S55)*10^-3
Gxy_energy = 1/(2*S66)*10^-3
vyx_energy = -S12*Ey_energy
vxy_energy = -S21*Ex_energy
vzx_energy = -S13*Ez_energy
vxz_energy = -S31*Ex_energy
vzy_energy = -S23*Ez_energy
vyz_energy = -S32*Ey_energy



