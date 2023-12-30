function [energy, energy_density, extensaoXX, extensaoYY, extensaoZZ, stressesAA] = leitura_excel(n)

if n==1
    M = readmatrix('Final_Tensao/TensaoX/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    extensaoXX = M(:,10);
    extensaoYY = M(:,11);
    extensaoZZ = M(:,12);
    stressesAA = M(:,4);
elseif n==2
M = readmatrix('Final_Tensao/TensaoY/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    extensaoXX = M(:,10);
    extensaoYY = M(:,11);
    extensaoZZ = M(:,12);
    stressesAA = M(:,5);
elseif n==3
M = readmatrix('Final_Tensao/TensaoZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    extensaoXX = M(:,10);
    extensaoYY = M(:,11);
    extensaoZZ = M(:,12);
    stressesAA = M(:,6);
end