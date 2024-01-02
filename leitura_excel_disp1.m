function [energy, energy_density, extensaoBC, stressesAA] = leitura_excel_disp1(n)
    
if n==4
    M = readmatrix('Final_Disp/DispYZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,14);
    stressesAA = M(:,8);
elseif n==5
    M = readmatrix('Final_Disp/DispXZ/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,15);
    stressesAA = M(:,9);
elseif n==6
    M = readmatrix('Final_Disp/DispXY/Total.xlsx', 'Sheet', 'Folha1', 'Range', 'A4:R144862');
    
    energy = M(:,16);
    energy_density = M(:,17);
    extensaoBC = M(:,13);
    stressesAA = M(:,7);
end