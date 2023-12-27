function [energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesXX] = leitura_excel()
    
    energy_tab = readtable('FEM_Decente/TensaoX/energy.csv');
    energy_density_tab = readtable('FEM_Decente/TensaoX/energy_density.csv');
    extensaoXX_tab = readtable('FEM_Decente/TensaoX/extensaoXX.csv');
    extensaoYY_tab = readtable('FEM_Decente/TensaoX/extensaoYY.csv');
    extensaoZZ_tab = readtable('FEM_Decente/TensaoX/extensaoZZ.csv');
    stressesXX_tab = readtable('FEM_Decente/TensaoX/stressesXX.csv');

    energy = table2array(energy_tab(:,2));
    energy_density = table2array(energy_density_tab(:,2));
    extensaoXX = table2array(extensaoXX_tab(:,2));
    extensaoYY = table2array(extensaoYY_tab(:,2));
    extensaoZZ = table2array(extensaoZZ_tab(:,2));
    stressesXX = table2array(stressesXX_tab(:,2));

end