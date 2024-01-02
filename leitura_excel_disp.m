function [energy, energy_density, stressesXX, stressesYY, stressesZZ, extensaoAA] = leitura_excel_disp(n)

if n==1
    M = readmatrix('Final_Disp/DispX/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    stressesXX = M(:,4);
    stressesYY = M(:,5);
    stressesZZ = M(:,6);
    extensaoAA = M(:,10);

elseif n==2
M = readmatrix('Final_Disp/DispY/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    stressesXX = M(:,4);
    stressesYY = M(:,5);
    stressesZZ = M(:,6);
    extensaoAA = M(:,11);

elseif n==3
M = readmatrix('Final_Disp/DispZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');

    energy = M(:,16);
    energy_density = M(:,17);
    stressesXX = M(:,4);
    stressesYY = M(:,5);
    stressesZZ = M(:,6);
    extensaoAA = M(:,12);

end