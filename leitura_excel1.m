function [energy, energy_density, extensaoBC, stressesAA] = leitura_excel1(n)
    
if n==4
    energy_tab = readtable('FEM_Decente/TensaoYZ/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoYZ/energy_density.csv');
    extensaoYZ_tab = readtable('FEM_Decente/TensaoYZ/extensaoYZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoYZ/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoBC = table2array(extensaoYZ_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==5
    energy_tab = readtable('FEM_Decente/TensaoXZ/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoXZ/energy_density.csv');
    extensaoZX_tab = readtable('FEM_Decente/TensaoXZ/extensaoXZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoXZ/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoBC = table2array(extensaoZX_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==6
    energy_tab = readtable('FEM_Decente/TensaoXY/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoXY/energy_density.csv');
    extensaoXY_tab = readtable('FEM_Decente/TensaoXY/extensaoXY.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoXY/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoBC = table2array(extensaoXY_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));

end