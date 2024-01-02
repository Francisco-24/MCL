function [energy, energy_density, extensaoBC, stressesAA] = leitura_excel1(n)
    
if n==4
    M = readmatrix('Final_Tensao/New/TensaoYZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,14);
    stressesAA = M(:,8);
elseif n==5
    M = readmatrix('Final_Tensao/New/TensaoXZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,15);
    stressesAA = M(:,9);
elseif n==6
    M = readmatrix('Final_Tensao/New/TensaoXY/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,13);
    stressesAA = M(:,7);
end