clc
clear all
close all

%% Condição Fronteira Tensão XX 

syms Ex Ey Ez vxy vyx vxz vzx vyz vzy

%% Sigma x Aplicado
[energy, energy_density, stressesXX, stressesYY, stressesZZ, extensaoXX] = leitura_excel2(1);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
stressesXX_med_XX = sum(stressesXX.*element_volume)/Volume_RVE;
stressesYY_med_XX = sum(stressesYY.*element_volume)/Volume_RVE;
stressesZZ_med_XX = sum(stressesZZ.*element_volume)/Volume_RVE;
extensaoXX_med = sum(extensaoXX.*element_volume)/Volume_RVE;

%% Sigma y Aplicado
[energy, energy_density, stressesXX, stressesYY, stressesZZ, extensaoYY] = leitura_excel2(2);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
stressesXX_med_YY = sum(stressesXX.*element_volume)/Volume_RVE;
stressesYY_med_YY = sum(stressesYY.*element_volume)/Volume_RVE;
stressesZZ_med_YY = sum(stressesZZ.*element_volume)/Volume_RVE;
extensaoYY_med = sum(extensaoYY.*element_volume)/Volume_RVE;

%% Sigma z Aplicado
[energy, energy_density, stressesXX, stressesYY, stressesZZ, extensaoZZ] = leitura_excel2(3);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
stressesXX_med_ZZ = sum(stressesXX.*element_volume)/Volume_RVE;
stressesYY_med_ZZ = sum(stressesYY.*element_volume)/Volume_RVE;
stressesZZ_med_ZZ = sum(stressesZZ.*element_volume)/Volume_RVE;
extensaoZZ_med = sum(extensaoZZ.*element_volume)/Volume_RVE;

%% Cálculos

extensao_xx = 1;
extensao_yy = 1;
extensao_zz = 1;

eq1 = stressesXX_med_XX == (1-vyz*vzy)/(Ey*Ez*delta)*extensao_xx;
eq2 = stressesXX_med_YY == (vyx + vzx*vyz)/(Ey*Ez*delta)*extensao_yy;
eq3 = stressesXX_med_ZZ == (vzx + vyx*vzy)/(Ey*Ez*delta)*extensao_zz;
eq4 = stressesYY_med_XX == (vxy + vxz*vzy)/(Ez*Ex*delta)*extensao_xx; 
eq5 = stressesYY_med_YY == (1-vzx*vxz)/(Ez*Ex*delta)*extensao_yy;
eq6 = stressesYY_med_ZZ == (vzy + vzx*vxy)/(Ez*Ex*delta)*extensao_zz;
eq7 = stressesZZ_med_XX == (vxz + vxy*vyz)/(Ex*Ey*delta)*extensao_xx;
eq8 = stressesZZ_med_YY == (vyz + vzx*vyx)/(Ex*Ey*delta)*extensao_yy;
eq9 = stressesZZ_med_ZZ == (1-vyx*vxy)/(Ex*Ey*delta)*extensao_zz;
eq10 = delta == (1-vxy*vyx - vyz*vzy - vzx*vxz - 2*vxy*vyz*vzx)/(Ex*Ey*Ez);

equations = [eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10];
solution = solve(equations, [Ex,Ey,Ez,vxy,vyx,vxz,vzx,vyz,vzy,delta]);
disp(solution);

Ex = double(solution.Ex)*10^-3;
Ey = double(solution.Ey)*10^-3;
Ez = double(solution.Ez)*10^-3;
vxy = double(solution.vxy);
vyx = double(solution.vyx);
vxz = double(solution.vxz);
vzx = double(solution.vzx);
vyz = double(solution.vyz);
vzy = double(solution.vzy);

%% Sigma yz Aplicado
[energy, energy_density, extensaoYZ, stressesYZ] = leitura_excel1(4);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoYZ_med = sum(extensaoYZ.*element_volume)/Volume_RVE;
stressesYZ_med = sum(stressesYZ.*element_volume)/Volume_RVE;

extensao_yz = 1;

Gyz = stressesYZ_med/(2*extensao_yz)*10^-3;

%% Sigma zx Aplicado
[energy, energy_density, extensaoZX, stressesZX] = leitura_excel1(5);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoZX_med = sum(extensaoZX.*element_volume)/Volume_RVE;
stressesZX_med = sum(stressesZX.*element_volume)/Volume_RVE;

extensao_zx = 1;

Gzx = stressesZX_med/(2*extensao_zx)*10^-3;

%% Sigma xy Aplicado
[energy, energy_density, extensaoXY, stressesXY] = leitura_excel1(6);

element_volume = energy./energy_density;
Volume_RVE = sum(element_volume);
energy_RVE = sum(energy);
extensaoXY_med = sum(extensaoXY.*element_volume)/Volume_RVE;
stressesXY_med = sum(stressesXY.*element_volume)/Volume_RVE;

extensao_xy = 1;
Gxy = stressesXY_med/(2*extensao_xy)*10^-3;

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

% %Sigma x e sigma y aplicado
% energy_tab = readtable('FEM_Decente/TensaoXeY/energy.csv');
% energy_density_tab = readtable('FEM_Decente/TensaoXeY/energy_density.csv');
% energy = table2array(energy_tab(:,2));
% energy_density = table2array(energy_density_tab(:,2));
% element_volume = energy./energy_density;
% Volume_RVE = sum(element_volume);
% energy_RVE = sum(energy);
% 
% S12 = (energy_RVE*2/Volume_RVE - S11 - S22)/2;
% 
% %Sigma x e sigma z aplicado
% energy_tab = readtable('FEM_Decente/TensaoXeZ/energy.csv');
% energy_density_tab = readtable('FEM_Decente/TensaoXeZ/energy_density.csv');
% energy = table2array(energy_tab(:,2));
% energy_density = table2array(energy_density_tab(:,2));
% element_volume = energy./energy_density;
% Volume_RVE = sum(element_volume);
% energy_RVE = sum(energy);
% 
% S13 = (energy_RVE*2/Volume_RVE - S11 - S33)/2;
% 
% %Sigma y e sigma z aplicado
% energy_tab = readtable('FEM_Decente/TensaoYeZ/energy.csv');
% energy_density_tab = readtable('FEM_Decente/TensaoYeZ/energy_density.csv');
% energy = table2array(energy_tab(:,2));
% energy_density = table2array(energy_density_tab(:,2));
% element_volume = energy./energy_density;
% Volume_RVE = sum(element_volume);
% energy_RVE = sum(energy);
% 
% S23 = (energy_RVE*2/Volume_RVE - S22 - S33)/2;
% 
% Ex_energy = 1/S11*10^-3
% Ey_energy = 1/S22*10^-3
% Ez_energy = 1/S33*10^-3
% Gyz_energy = 1/(2*S44)*10^-3
% Gzx_energy = 1/(2*S55)*10^-3
% Gxy_energy = 1/(2*S66)*10^-3
% vyx_energy = -S12*Ey_energy
% vxy_energy = -S21*Ex_energy
% vzx_energy = -S13*Ez_energy
% vxz_energy = -S31*Ex_energy
% vzy_energy = -S23*Ez_energy
% vyz_energy = -S32*Ey_energy
% 
% 
% 
