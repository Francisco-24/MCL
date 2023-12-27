function [energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesAA] = leitura_excel(n)
    
if n==1
    energy_tab = readtable('FEM_Decente/TensaoX/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoX/energy_density.csv');
    extensaoXX_tab = readtable('FEM_Decente/TensaoX/extensaoXX.csv');
    extensaoYY_tab = readtable('FEM_Decente/TensaoX/extensaoYY.csv');
    extensaoZZ_tab = readtable('FEM_Decente/TensaoX/extensaoZZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoX/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoXX = table2array(extensaoXX_tab(:,2));
    extensaoYY = table2array(extensaoYY_tab(:,2));
    extensaoZZ = table2array(extensaoZZ_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==2
    energy_tab = readtable('FEM_Decente/TensaoY/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoY/energy_density.csv');
    extensaoXX_tab = readtable('FEM_Decente/TensaoY/extensaoXX.csv');
    extensaoYY_tab = readtable('FEM_Decente/TensaoY/extensaoYY.csv');
    extensaoZZ_tab = readtable('FEM_Decente/TensaoY/extensaoZZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoY/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoXX = table2array(extensaoXX_tab(:,2));
    extensaoYY = table2array(extensaoYY_tab(:,2));
    extensaoZZ = table2array(extensaoZZ_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==3
    energy_tab = readtable('FEM_Decente/TensaoZ/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoZ/energy_density.csv');
    extensaoXX_tab = readtable('FEM_Decente/TensaoZ/extensaoXX.csv');
    extensaoYY_tab = readtable('FEM_Decente/TensaoZ/extensaoYY.csv');
    extensaoZZ_tab = readtable('FEM_Decente/TensaoZ/extensaoZZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoZ/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoXX = table2array(extensaoXX_tab(:,2));
    extensaoYY = table2array(extensaoYY_tab(:,2));
    extensaoZZ = table2array(extensaoZZ_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==4
    energy_tab = readtable('FEM_Decente/TensaoYZ/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoYZ/energy_density.csv');
    extensaoYZ_tab = readtable('FEM_Decente/TensaoYZ/extensaoYZ.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoYZ/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoYZ = table2array(extensaoYZ_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==5
    energy_tab = readtable('FEM_Decente/TensaoZX/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoZX/energy_density.csv');
    extensaoZX_tab = readtable('FEM_Decente/TensaoZX/extensaoZX.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoZX/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoZX = table2array(extensaoZX_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));
elseif n==6
    energy_tab = readtable('FEM_Decente/TensaoXY/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoXY/energy_density.csv');
    extensaoXY_tab = readtable('FEM_Decente/TensaoXY/extensaoXY.csv');
    stressesAA_tab = readtable('FEM_Decente/TensaoXY/stressesAA.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoXY = table2array(extensaoXY_tab(:,2));
    stressesAA = table2array(stressesAA_tab(:,2));



end